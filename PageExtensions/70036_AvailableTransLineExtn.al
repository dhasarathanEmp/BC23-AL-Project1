pageextension 70036 AvailableTransLineExtn extends "Available - Transfer Lines"
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