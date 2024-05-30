pageextension 70024 CashReceiptJournalExtn extends "Cash Receipt Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Applies-to Doc. No.")
        {
            field("Cs.Document No."; Rec."Cs.Document No.")
            {
                ApplicationArea = all;
            }
            field("Contact No."; Rec."Contact No.")
            {
                ApplicationArea = all;
            }
            field("Contact Name"; Rec."Contact Name")
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

    trigger OnOpenPage()
    var
        myInt: Integer;
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        GenJournalBatch.RESET;
        GenJournalBatch.SETRANGE(Name, Rec.CurrentJnlBatchName);
        GenJournalBatch.SETRANGE(IsVisible, TRUE);
        IF GenJournalBatch.FINDFIRST THEN BEGIN
            ContactVisible := TRUE;
            ContactVisible1 := FALSE;
        END ELSE BEGIN
            ContactVisible := FALSE;
            ContactVisible1 := TRUE;
        END;
    end;
}