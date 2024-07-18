pageextension 70021 NavigationAreaExtn extends "Order Processor Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("Finance Charge Memos")
        {
            group("Counter Sales")
            {
                action("Open/New Counter Sales")
                {
                    RunObject = page "Counter Sales -Item Reclass.";
                    ApplicationArea = all;
                }
                action("Counter Sales History")
                {
                    RunObject = page "Cancelled CounterSales History";
                    ApplicationArea = all;
                }
            }
            group("Temporary Delivery Process")
            {
                action("Job Order List")
                {
                    RunObject = page "Job Order List";
                }
                action("Temporary Parts Delivery")
                {
                    RunObject = page "Temporary Parts Delivery";
                    ApplicationArea = all;
                }
                action("Temporary Delivery History")
                {
                    RunObject = page "Temporary Delivery History";
                    ApplicationArea = all;
                }
            }
        }
    }

    var
        myInt: Integer;
}