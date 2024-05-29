pageextension 70014 PurchaseOrderSubformExtn extends "Purchase Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Serial No"; Rec."Serial No")
            {

            }
        }
        addafter("Expected Receipt Date")
        {
            field("Part Type"; Rec."Part Type")
            {

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