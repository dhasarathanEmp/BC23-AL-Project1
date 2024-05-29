pageextension 70018 TransferLineExtn extends "Transfer Lines"
{
    layout
    {
        addafter("Item No.")
        {
            field("Ordered Part No."; Rec."Ordered Part No.")
            {

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}