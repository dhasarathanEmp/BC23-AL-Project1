page 55002 "Cancelled CounterSales History"
{
    // CUS016 09/06/18 addind Fields Vpn no(50006),Vehicle Plate No.(50007), Service item no(50008), Service item name(50009) using for report.

    Caption = 'Counter Sales History';
    DataCaptionFields = Contact;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Cancelled CounterSales History";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Date of Enquiry"; Rec."Date of Enquiry")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Bin Code"; Rec."Bin Code")
                {
                }
                field("<Required Quantity>"; Rec.Quantity)
                {
                    Caption = '<Required Quantity>';
                }
                field("Available Quantity"; Rec."Available Quantity")
                {
                    Caption = 'Available Quantity';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field("VAT Prod"; Rec."VAT Prod")
                {
                }
                field("Line Amount"; Rec."Line Amount")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Discount%"; Rec."Discount%")
                {
                }
                field(DiscountAmount; Rec.DiscountAmount)
                {
                }
                field("CashDocument No."; Rec."CashDocument No.")
                {
                }
                field("CR External Reference No."; Rec."CR External Reference No.")
                {
                }
                field(Contact; Rec.Contact)
                {
                }
                field("Contact Name"; Rec."Contact Name")
                {
                }
                field("Reason for Cancel"; Rec."Reason for Cancel")
                {
                }
                field("Entry No."; Rec."Entry No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Cash; Rec.Cash)
                {
                }
                field("VIN No."; Rec."VIN No.")
                {
                }
                field("Vehicle Model No."; Rec."Vehicle Model No.")
                {
                }
                field("Service Item No."; Rec."Service Item No.")
                {
                }
                field("Service Item Name"; Rec."Service Item Name")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Cash Receipt Jounal list ")
            {
                Image = "Report";
                Promoted = false;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                //RunObject = Report 50013;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE(Rec."Location Code", UserMgt.GetSalesFilter);
            Rec.FILTERGROUP(0);
        END;
    end;

    var
        location: Record Location;
        UserMgt: Codeunit "User Setup Management";
}

