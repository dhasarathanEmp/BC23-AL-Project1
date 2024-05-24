pageextension 70012 SalesInvoicesSubForm extends "Sales Invoice Subform"
{
    layout
    {
        modify("Bin Code")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}