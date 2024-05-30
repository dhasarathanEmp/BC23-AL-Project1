pageextension 70025 GeneralJournalBatchExtn extends "General Journal Batches"
{
    layout
    {
        // Add changes to page layout here
        addafter("Copy to Posted Jnl. Lines")
        {
            field("Cash Receipt Batch"; Rec."Cash Receipt Batch")
            {
                ApplicationArea = all;
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = all;
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