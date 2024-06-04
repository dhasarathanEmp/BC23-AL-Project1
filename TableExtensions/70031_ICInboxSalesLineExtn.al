tableextension 70031 ICInboxSalesLineExtn extends "IC Inbox Sales Line"
{
    fields
    {
        field(50014; "Customer Serial No"; Code[20])//EP9609
        {
            DataClassification = ToBeClassified;
            Description = 'CUS022';
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