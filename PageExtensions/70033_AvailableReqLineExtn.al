pageextension 70033 AvailableReqLineExtn extends "Available - Requisition Lines"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify("&Cancel Reservation")
        {
            Enabled = false;
        }
    }

    var
        myInt: Integer;
}