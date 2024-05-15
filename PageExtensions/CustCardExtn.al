pageextension 50110 CustPageExtn extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        modify("No.")
        {
            Editable = FALSE;
            AssistEdit = FALSE;
        }
        modify("Responsibility Center")
        {
            Editable = FALSE;
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    var
        myInt: Integer;
}