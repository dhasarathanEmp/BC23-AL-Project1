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
        modify(CurrentJnlBatchName)
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                GeneralJournalBatch: Record "Gen. Journal Batch";
                UserSetup: Record "User Setup";
                ResponsibilityCenter: Code[30];
            begin
                UserSetup.Reset();
                UserSetup.SetRange("User ID", UserId);
                UserSetup.SetFilter("Cash Receipt Batch", '<>%1', '');
                if UserSetup.FindFirst() then
                    ResponsibilityCenter := UserSetup."Cash Receipt Batch";
                GeneralJournalBatch.FilterGroup(2);
                GeneralJournalBatch.SetRange("Cash Receipt Batch", true);
                GeneralJournalBatch.SetRange("Responsibility Center", ResponsibilityCenter);
                GeneralJournalBatch.FilterGroup(0);
                if Page.RunModal(0, GeneralJournalBatch) = Action::LookupOK then begin

                end;
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;

    /*Utrigger OnOpenPage()
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
    end;*/
}