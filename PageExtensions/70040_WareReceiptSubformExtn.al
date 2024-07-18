// Added fields related Vendor Invoice Receipt validations
pageextension 70040 WhseReceiptSubformExtn extends "Whse. Receipt Subform"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Source Document")
        {
            field(Received; Rec.Received)
            {
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("Vendor Invoice Qty"; Rec."Vendor Invoice Qty")
            {
                ApplicationArea = All;
            }
        }
        addafter("Qty. per Unit of Measure")
        {
            field("Unit Cost"; Rec."Unit Price")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field(Excess; Rec.Excess)
            {
                ApplicationArea = All;
            }
            field("Serial No"; Rec."Serial No")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("HS Code"; Rec."HS Code")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}