pageextension 70039 SalesOrderListExtn extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Sales Reservation Avail.")
        {
            action("Customer Wise Backorder Status")
            {
                Image = Report;
                RunObject = report "Cus Wise Back Order Details";
            }
            action("Back Orders Tracking")
            {
                Image = Report;
                RunObject = report "Back Orders Tracking";
            }
        }
    }

    var
        myInt: Integer;
}