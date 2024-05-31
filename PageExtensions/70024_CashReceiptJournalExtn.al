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
                Editable = ContactVisible;
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemJournalLine: Record "Item Journal Line";
                    VATPostingSetup: Record "VAT Posting Setup";
                begin
                    CLEAR("Cs.Amount");
                    CLEAR(Tax);
                    CLEAR(DiscountAmount);
                    CLEAR(TaxableAmount);
                    ItemJournalLine.RESET;
                    ItemJournalLine.SETRANGE(Contact, Rec."Contact No.");
                    ItemJournalLine.SETRANGE(Cash, FALSE);
                    ItemJournalLine.SETFILTER(Status, '=%1', ItemJournalLine.Status::" ");
                    IF PAGE.RUNMODAL(55001, ItemJournalLine) = ACTION::LookupOK THEN
                        Rec."Cs.Document No." := ItemJournalLine."Document No.";
                    ItemJournalLine.SETRANGE("Document No.", Rec."Cs.Document No.");
                    IF ItemJournalLine.FINDSET THEN
                        REPEAT
                            IF ItemJournalLine."Bin Code" = '' THEN
                                ERROR('Some Counter Sales Lines doesnt have Bin Code,Please fill before Payment');
                            "Cs.Amount" += ROUND(ItemJournalLine."Line AmountUP");
                            Rec.VALIDATE("Currency Code", ItemJournalLine."Currency Code");
                        UNTIL ItemJournalLine.NEXT = 0;
                    TaxableAmount := "Cs.Amount";
                    ItemJournalLine.SETRANGE("Document No.", Rec."Cs.Document No.");
                    IF ItemJournalLine.FINDFIRST THEN BEGIN
                        VATPostingSetup.RESET;
                        VATPostingSetup.SETRANGE("VAT Bus. Posting Group", ItemJournalLine."VAT Bus");
                        IF VATPostingSetup.FINDFIRST THEN
                            Tax := ROUND(TaxableAmount * VATPostingSetup."VAT %" / 100);
                    END;
                    MESSAGE('Total Value Of Counter Sales Line Amount %1', FORMAT(TaxableAmount + Tax));
                    Rec.VALIDATE(Amount, -(TaxableAmount + Tax));
                    Rec."CS Vat" := VATPostingSetup."VAT %";
                end;
            }
            field("Contact No."; Rec."Contact No.")
            {
                ApplicationArea = all;
                Editable = ContactVisible;
            }
            field("Contact Name"; Rec."Contact Name")
            {
                ApplicationArea = all;
                Editable = ContactVisible;
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
        modify("Applies-to Doc. Type")
        {
            Editable = ContactVisible1;
        }
        modify("Applies-to Doc. No.")
        {
            Editable = ContactVisible1;
        }
        modify(Amount)
        {
            Editable = ContactVisible1;
        }
        modify("Account No.")
        {
            trigger OnBeforeValidate()
            var
                ContBus: Record "Contact Business Relation";
                ContactRec: Record Contact;
            begin
                IF Rec."Contact No." <> '' THEN
                    Rec."Contact No." := '';
                IF Rec."Contact Name" <> '' THEN
                    Rec."Contact Name" := '';
                CLEAR(Rec.Amount);
                CLEAR(Rec."Amount (LCY)");
                GenJournalBatch.RESET;
                GenJournalBatch.SETRANGE(Name, SelectedBatchName);
                GenJournalBatch.SETRANGE("Cash Receipt Batch", TRUE);
                IF GenJournalBatch.FINDFIRST THEN BEGIN
                    ContBus.RESET;
                    ContBus.SETRANGE("No.", Rec."Account No.");
                    IF ContBus.FINDFIRST THEN BEGIN
                        ContactRec.RESET;
                        ContactRec.SETRANGE("Company No.", ContBus."Contact No.");
                        IF ContactRec.FINDFIRST THEN BEGIN
                            Rec."Contact No." := ContactRec."No.";
                            Rec."Contact Name" := ContactRec.Name;
                        END;
                    END;
                END;
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    var
        myInt: Integer;
        GenJournalBatch: Record "Gen. Journal Batch";
        ContactVisible: Boolean;
        ContactVisible1: Boolean;
        ExtnCashReciptJournal: Codeunit CashReceiptJournal;
        SelectedBatchName: Code[30];
        "Cs.Amount": Decimal;
        Tax: Decimal;
        DiscountAmount: Decimal;
        TaxableAmount: Decimal;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetFilter("Cash Receipt Batch", '<>%1', '');
        if UserSetup.FindFirst() then begin
            SelectedBatchName := UserSetup."Cash Receipt Batch";
        end;
        GenJournalBatch.RESET;
        GenJournalBatch.SETRANGE(Name, SelectedBatchName);
        GenJournalBatch.SetRange("Cash Receipt Batch", TRUE);
        IF GenJournalBatch.FINDFIRST THEN BEGIN
            ContactVisible := TRUE;
            ContactVisible1 := FALSE;
        END ELSE BEGIN
            ContactVisible := FALSE;
            ContactVisible1 := TRUE;
        END;
    end;

    trigger OnAfterGetRecord()
    begin
        GenJournalBatch.RESET;
        GenJournalBatch.SETRANGE(Name, SelectedBatchName);
        GenJournalBatch.SetRange("Cash Receipt Batch", TRUE);
        IF GenJournalBatch.FINDFIRST THEN BEGIN
            ContactVisible := TRUE;
            ContactVisible1 := FALSE;
        END ELSE BEGIN
            ContactVisible := FALSE;
            ContactVisible1 := TRUE;
        END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        GenJournalBatch.RESET;
        GenJournalBatch.SETRANGE(Name, SelectedBatchName);
        GenJournalBatch.SetRange("Cash Receipt Batch", TRUE);
        IF GenJournalBatch.FINDFIRST THEN BEGIN
            ContactVisible := TRUE;
            ContactVisible1 := FALSE;
        END ELSE BEGIN
            ContactVisible := FALSE;
            ContactVisible1 := TRUE;
        END;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        GenJournalBatch.RESET;
        GenJournalBatch.SETRANGE(Name, SelectedBatchName);
        GenJournalBatch.SetRange("Cash Receipt Batch", TRUE);
        IF GenJournalBatch.FINDFIRST THEN BEGIN
            ContactVisible := TRUE;
            ContactVisible1 := FALSE;
        END ELSE BEGIN
            ContactVisible := FALSE;
            ContactVisible1 := TRUE;
        END;
    end;
}