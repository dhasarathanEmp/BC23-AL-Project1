table 60015 "Month Wise Back Order Values"
{

    fields
    {
        field(1; "Agency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Location; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Accounting Year"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Back Order Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Agency Code", Location, "Accounting Year", "Entry Date", Year)
        {
        }
    }

    fieldgroups
    {
    }
}

