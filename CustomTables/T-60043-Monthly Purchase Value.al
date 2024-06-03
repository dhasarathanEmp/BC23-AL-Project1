table 60043 "Monthly Purchase Value"
{

    fields
    {
        field(1; "Agency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Accounting Year"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Purchase Order Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Accounting Year", Year, "Entry Date", "Agency Code")
        {
        }
    }

    fieldgroups
    {
    }
}

