table 60027 "Customer parameter"
{

    fields
    {
        field(1; "Customer Creation"; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(2; "Customer NO"; Code[10])
        {
            DataClassification = ToBeClassified;
            InitValue = '1';
        }
    }

    keys
    {
        key(Key1; "Customer NO")
        {
        }
    }

    fieldgroups
    {
    }
}

