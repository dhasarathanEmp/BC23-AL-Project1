pageextension 70034 AvailablePurchLineExtn extends "Available - Purchase Lines"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify(CancelReservation)
        {
            Enabled = false;
        }
    }

    var
        myInt: Integer;
}