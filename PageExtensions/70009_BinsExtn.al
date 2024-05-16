pageextension 70009 BinsExtn extends Bins
{
    layout
    {
        // Add changes to page layout here
        addafter(Dedicated)
        {
            field(Blocks; Rec.Blocks)
            {
                ApplicationArea = All;
            }
            field("Counter sale"; Rec."Counter sale")
            {
                ApplicationArea = All;
            }
            field("Temporary Delivery"; Rec."Temporary Delivery")
            {
                ApplicationArea = All;
            }
            field(Discrepancy; Rec.Discrepancy)
            {
                ApplicationArea = All;
            }
            field(DeadStocks; Rec.DeadStocks)
            {
                ApplicationArea = All;
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