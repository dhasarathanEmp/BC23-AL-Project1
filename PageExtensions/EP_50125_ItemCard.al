pageextension 50125 EP_50125_ItemCard extends "Item Card"
{
    layout
    {
        addafter(Item)
        {
            group("NPR")
            {
                field("Replacement Part No."; Rec."Replacement Part Number")
                {

                }
                field("Parent Item Number"; Rec.ParentReplacementItem)
                {

                }
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