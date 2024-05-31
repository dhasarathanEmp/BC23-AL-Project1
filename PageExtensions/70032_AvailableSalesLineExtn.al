pageextension 70032 AvailableSalesLineExtn extends "Available - Sales Lines"
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