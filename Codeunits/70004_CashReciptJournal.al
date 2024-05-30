codeunit 70004 CashReceiptJournal
{
    [EventSubscriber(ObjectType::Page, Page::"Cash Receipt Journal", 'OnOnOpenPageOnBeforeTemplateSelection', '', true, true)]
    local procedure OnOnOpenPageOnBeforeTemplateSelection(var GenJournalLine: Record "Gen. Journal Line"; var JnlSelected: Boolean; CurrentJnlBatchName: Code[10]; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetFilter("Cash Receipt Batch", '<>%1', '');
        if UserSetup.FindFirst() then begin
            CurrentJnlBatchName := UserSetup."Cash Receipt Batch";
            JnlSelected := true;
        end;
    end;
}