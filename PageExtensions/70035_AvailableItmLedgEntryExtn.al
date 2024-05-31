pageextension 70035 AvailableItmLedgEntryExtn extends "Available - Item Ledg. Entries"
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