tableextension 70007 SecurityGroupExtn extends "Security Group Buffer"
{
    fields
    {
        field(50001; "Sales Post"; Boolean)//CUS006
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