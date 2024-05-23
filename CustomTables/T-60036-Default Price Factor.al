table 60036 "Default Price Factor"
{

    fields
    {
        field(1; "Agency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Default Price Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Assembly Charges in Dollars"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Agency Code")
        {
        }
    }

    fieldgroups
    {
    }
}

