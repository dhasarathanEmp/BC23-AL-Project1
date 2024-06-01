codeunit 70009 ItemJnlPost
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post", 'OnCodeOnAfterItemJnlPostBatchRun', '', true, true)]
    local procedure OnCodeOnAfterItemJnlPostBatchRun(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; SuppressCommit: Boolean)
    var
        ItemJournalBatch: Record "Item Journal Batch";
        TransferItemJournaltoService: Codeunit TransferItemJournaltoService;
    begin
        ItemJournalBatch.Reset();
        ItemJournalBatch.SetRange(Name, ItemJournalLine."Journal Batch Name");
        ItemJournalBatch.SetRange(Counter_Batch, true);
        if ItemJournalBatch.FindFirst() then
            TransferItemJournaltoService.TransferJournalLinesToCounter();
    end;

    var
        myInt: Integer;
}