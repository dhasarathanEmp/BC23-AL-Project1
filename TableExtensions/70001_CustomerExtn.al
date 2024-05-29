tableextension 70001 CustomerExtn extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50001; Vehicle_Model_No; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Vin_No; Code[20])
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