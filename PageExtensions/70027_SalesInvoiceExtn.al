pageextension 70027 SalesInvoiceExtn extends "Sales Invoice"
{
    layout
    {
        addafter("Ship-to Contact")
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

    trigger OnOpenPage()
    begin

    end;
}