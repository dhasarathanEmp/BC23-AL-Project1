pageextension 70028 PostedSalesShipmentHeaderExtn extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
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