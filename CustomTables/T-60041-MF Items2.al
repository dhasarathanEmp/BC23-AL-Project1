table 60041 "MF Items2"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Retail Price(GBP)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Discount Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; UoM; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Discount Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Dealer Net Price(GBP)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

