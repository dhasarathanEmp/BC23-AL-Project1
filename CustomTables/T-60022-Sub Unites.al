table 60022 "Sub Unites"
{

    fields
    {
        field(1; "Currency Code"; Code[10])
        {
            TableRelation = Currency.Code;
        }
        field(2; "Sub Units"; Text[30])
        {
        }
        field(3; No; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No, "Sub Units", "Currency Code")
        {
        }
    }

    fieldgroups
    {
    }
}

