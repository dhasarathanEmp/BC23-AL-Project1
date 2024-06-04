tableextension 70026 GeneralJournalBatchExtn extends "Gen. Journal Batch"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Cash Receipt Batch"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Responsibility Center"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
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