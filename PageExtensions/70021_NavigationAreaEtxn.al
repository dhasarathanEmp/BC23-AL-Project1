pageextension 70021 NavigationAreaExtn extends "Order Processor Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast("Posted Documents")
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

                }
            }
        }
    }

    var
        myInt: Integer;
}