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

    trigger OnOpenPage()
    begin
        SelectedBatchName := ExtnCashReciptJournal."Selected CR Batch Name"();
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
        SelectedBatchName := ExtnCashReciptJournal."Selected CR Batch Name"();
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
        SelectedBatchName := ExtnCashReciptJournal."Selected CR Batch Name"();
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
        SelectedBatchName := ExtnCashReciptJournal."Selected CR Batch Name"();
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