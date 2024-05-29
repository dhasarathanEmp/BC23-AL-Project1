tableextension 70019 UserSetupExtn extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Counter_Batch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name WHERE(Counter_Batch = const(true));
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