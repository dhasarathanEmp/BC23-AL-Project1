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

    var
        myInt: Integer;
}