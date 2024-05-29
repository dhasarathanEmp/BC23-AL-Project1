tableextension 70020 ItemJournalBatch extends "Item Journal Batch"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Counter_Batch; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Responsibility_Center; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Location; Code[20])
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