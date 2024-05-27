table 60045 "Req Link Maintainance"
{

    fields
    {
        field(1;"S.No";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Req Line No.";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Demand Source No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Demand Source Ref No.";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Demand Required Qty";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Item No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7;Description;Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"S.No")
        {
        }
    }

    fieldgroups
    {
    }
}

