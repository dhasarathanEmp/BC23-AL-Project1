tableextension 70045 VendLedgEntryExtn extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Sales,Service,Purchase;
        }
        field(50001; "Applied Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
        }
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 6)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Vendor No." := GenJnlLine."Account No.";
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    "Document Type" := GenJnlLine."Document Type";
    "Document No." := GenJnlLine."Document No.";
    "External Document No." := GenJnlLine."External Document No.";
    Description := GenJnlLine.Description;
    "Currency Code" := GenJnlLine."Currency Code";
    #9..37
    "Exported to Payment File" := GenJnlLine."Exported to Payment File";

    OnAfterCopyVendLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    "Document No." := GenJnlLine."CR Document No.";
    #6..40
    */
    //end;
}

