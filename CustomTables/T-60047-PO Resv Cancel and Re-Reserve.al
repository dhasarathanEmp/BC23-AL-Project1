table 60047 "PO Resv Cancel and Re-Reserve"
{

    fields
    {
        field(1;"Line No";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Source Type";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Cancelled Qty";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Source ID";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Source Ref No";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Location Code";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Source Sub Type";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Item No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"PO Source Ref No";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Quantity Per";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"PO Number";Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

