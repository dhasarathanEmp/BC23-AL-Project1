tableextension 70017 GeneralJournalLineExtn extends "Gen. Journal Line"
{
    fields
    {
        field(50005; Cs_Document_No; Code[30])
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