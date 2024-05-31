pageextension 70031 ReservationExtn extends Reservation
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify(CancelReservationCurrentLine)
        {
            Enabled = false;
        }
    }

    var
        myInt: Integer;
}