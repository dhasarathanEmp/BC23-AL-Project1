page 55066 "Temporary Delivery History"
{
    // CUS016 09/06/18 addind Fields Vpn no(50006),Vehicle Plate No.(50007), Service item no(50008), Service item name(50009) using for report.

    Caption = 'Temporary Delivery History';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Temporary Delivery History";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job Order No."; Rec."Job Order No.")
                {
                }
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
                field("New Bin Code"; Rec."New Bin Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field("Line Amount"; Rec."Line Amount")
                {
                }
                field("Discount%"; Rec."Discount%")
                {
                }
                field(DiscountAmount1; Rec.DiscountAmount1)
                {
                    Caption = 'Discount Amount';
                }
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Job card No."; Rec."Job card No.")
                {
                    Caption = 'Job card No';
                }
                field("Job Order Description"; Rec."Job Order Description")
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
                RunObject = Report "Cash Receipt Jornal list11";
            }
        }
    }

    trigger OnOpenPage()
    begin
        if UserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Location Code", UserMgt.GetSalesFilter);
            Rec.FilterGroup(0);
        end;
    end;

    var
        location: Record Location;
        UserMgt: Codeunit "User Setup Management";
}

