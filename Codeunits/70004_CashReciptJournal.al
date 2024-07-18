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
            CRBatchNameTemp := CurrentJnlBatchName;
        end else
            CurrentJnlBatchName := 'DEFAULT';
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCustLedgEntryInsert', '', true, true)]
    local procedure OnBeforeCustLedgEntryInsert(var CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; var NextEntryNo: Integer)
    var
        "Cs.Amount": Decimal;
        DiscountAmount: Decimal;
        TaxableAmount: Decimal;
        ItemJournalLine: Record "Item Journal Line";
        "CS.TotalAmount": Decimal;
        VATPostingSetup: Record "VAT Posting Setup";
        Customer: Record Customer;
        Tax: Decimal;
    begin
        CustLedgerEntry."Sales Type" := GenJournalLine."Sales Type";
        CustLedgerEntry."Applied Doc. No." := GenJournalLine."Applied Doc. No.";
        CustLedgerEntry."Responsibility Center" := GenJournalLine."Responsibility Center";
        CLEAR("Cs.Amount");
        CLEAR(DiscountAmount);
        CLEAR(TaxableAmount);
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Document No.", GenJournalLine."Cs.Document No.");
        ItemJournalLine.SETRANGE(Contact, GenJournalLine."Contact No.");
        ItemJournalLine.SETRANGE("Contact Name", GenJournalLine."Contact Name");
        ItemJournalLine.SETRANGE(Status, ItemJournalLine.Status::" ");
        ItemJournalLine.SETRANGE(Cash, FALSE);
        IF ItemJournalLine.FINDSET THEN
            REPEAT
                "Cs.Amount" += ROUND(ItemJournalLine."Line AmountUP");
            UNTIL ItemJournalLine.NEXT = 0;
        TaxableAmount := "Cs.Amount";
        ItemJournalLine.SETRANGE("Document No.", GenJournalLine."Cs.Document No.");
        IF ItemJournalLine.FINDFIRST THEN BEGIN
            VATPostingSetup.RESET;
            VATPostingSetup.SETRANGE("VAT Bus. Posting Group", ItemJournalLine."VAT Bus");
            IF VATPostingSetup.FINDFIRST THEN
                Tax := ROUND(TaxableAmount * VATPostingSetup."VAT %" / 100);
        END;
        "CS.TotalAmount" := -ROUND(TaxableAmount + Tax);
        IF "CS.TotalAmount" = GenJournalLine.Amount THEN BEGIN
            IF ItemJournalLine.FINDSET THEN
                REPEAT
                    IF ItemJournalLine.Quantity > 0 THEN BEGIN
                        ItemJournalLine."CustomerNo." := GenJournalLine."Account No.";
                        ItemJournalLine."Customer Name1" := GenJournalLine.Description;
                        ItemJournalLine.Cash := TRUE;
                        ItemJournalLine."CashDocument No." := GenJournalLine."Document No.";
                        ItemJournalLine."CR External Reference No." := GenJournalLine."External Document No.";
                        Customer.RESET;
                        Customer.SETRANGE("No.", GenJournalLine."Account No.");
                        IF Customer.FINDFIRST THEN BEGIN
                            ItemJournalLine."VIN No." := Customer."Vin No.";
                            ItemJournalLine."Vehicle Model No." := Customer."Vehicle Model  No.";
                        END;
                        ItemJournalLine.MODIFY;
                    END ELSE
                        ItemJournalLine.DELETE;
                UNTIL ItemJournalLine.NEXT = 0;
        END;
    end;

    procedure "Selected CR Batch Name"() CRBatchName: Code[30]
    begin
        CRBatchName := CRBatchName;
    end;

    var
        CRBatchNameTemp: Code[30];
}