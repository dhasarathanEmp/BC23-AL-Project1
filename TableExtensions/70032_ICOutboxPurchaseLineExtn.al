tableextension 70032 ICOutboxPurchaseLineExtn extends "IC Outbox Purchase Line"
{
    fields
    {
        // Add changes to table fields here
        field(50015; "Serial No"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EP9606';
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