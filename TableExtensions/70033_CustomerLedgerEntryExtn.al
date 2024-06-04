tableextension 70033 CustomerLedgerEntryExtn extends "Cust. Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sales,Service,Purchase;
        }
        field(50001; "Applied Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Original Amount in YER"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 6)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Customer No." := GenJnlLine."Account No.";
    "Posting Date" := GenJnlLine."Posting Date";
    "Document Date" := GenJnlLine."Document Date";
    "Document Type" := GenJnlLine."Document Type";
    "Document No." := GenJnlLine."Document No.";
    "External Document No." := GenJnlLine."External Document No.";
    Description := GenJnlLine.Description;
    "Currency Code" := GenJnlLine."Currency Code";
    #9..37
    "Exported to Payment File" := GenJnlLine."Exported to Payment File";

    OnAfterCopyCustLedgerEntryFromGenJnlLine(Rec,GenJnlLine);
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
    var
        myInt: Integer;
}