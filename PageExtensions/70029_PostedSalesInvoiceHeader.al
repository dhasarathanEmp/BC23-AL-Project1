pageextension 70029 PostedSalesInvoiceHeader extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Your Reference")
        {
            field("Price Validate"; Rec."Price Validate")
            {

            }
            field("Delivery Terms"; Rec."Delivery Terms")
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