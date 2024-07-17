page 55066 "Temporary Delivery History"
{
    // CUS016 09/06/18 addind Fields Vpn no(50006),Vehicle Plate No.(50007), Service item no(50008), Service item name(50009) using for report.

    Caption = 'Temporary Delivery History';
    DataCaptionFields = Field50005;
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
                field("Job Order No.";"Job Order No.")
                {
                }
                field("Document No.";"Document No.")
                {
                }
                field("Line No.";"Line No.")
                {
                }
                field("Date of Enquiry";"Date of Enquiry")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field(Description;Description)
                {
                }
                field("Location Code";"Location Code")
                {
                }
                field("Bin Code";"Bin Code")
                {
                }
                field("New Bin Code";"New Bin Code")
                {
                }
                field(Quantity;Quantity)
                {
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Unit Price";"Unit Price")
                {
                }
                field("Line Amount";"Line Amount")
                {
                }
                field("Discount%";"Discount%")
                {
                }
                field(DiscountAmount1;DiscountAmount1)
                {
                    Caption = 'Discount Amount';
                }
                field("Entry No.";"Entry No.")
                {
                }
                field("Job card No.";"Job card No.")
                {
                    Caption = 'Job card No';
                }
                field("Job Order Description";"Job Order Description")
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
          FilterGroup(2);
          SetRange("Location Code" ,UserMgt.GetSalesFilter);
          FilterGroup(0);
        end;
    end;

    var
        location: Record Location;
        UserMgt: Codeunit "User Setup Management";
}

