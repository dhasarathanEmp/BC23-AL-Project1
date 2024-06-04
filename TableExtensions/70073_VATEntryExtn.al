tableextension 70073 VATEntryExtn extends "VAT Entry"
{
    fields
    {

        //Unsupported feature: Property Modification (Editable) on ""Document No."(Field 5)".

    }

    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 5)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CopyPostingGroupsFromGenJnlLine(GenJnlLine);
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    "Document No." := GenJnlLine."Document No.";
    "External Document No." := GenJnlLine."External Document No.";
    "Document Type" := GenJnlLine."Document Type";
    Type := GenJnlLine."Gen. Posting Type";
    #8..17
    "VAT Registration No." := GenJnlLine."VAT Registration No.";

    OnAfterCopyFromGenJnlLine(Rec,GenJnlLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    "Document No." := GenJnlLine."CR Document No.";
    #5..20
    */
    //end;
}

