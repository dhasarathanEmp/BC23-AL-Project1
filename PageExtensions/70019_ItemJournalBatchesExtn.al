pageextension 70019 ItemJournalBatchedExtn extends "Item Journal Batches"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting No. Series")
        {
            field(Counter_Batch; Rec.Counter_Batch)
            {
                ApplicationArea = all;
            }
        }
        addafter(Counter_Batch)
        {
            field("Temporary Delivery"; Rec."Temporary Delivery")
            {
                ApplicationArea = all;
            }
            field(Responsibility_Center; Rec.Responsibility_Center)
            {
                ApplicationArea = all;
            }
            field(Location; Rec.Location)
            {
                ApplicationArea = all;
            }
            field("Journal Template Name"; Rec."Journal Template Name")
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