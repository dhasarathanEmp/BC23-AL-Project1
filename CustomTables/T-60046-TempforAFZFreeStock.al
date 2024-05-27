table 60046 "Temp Table For AFZ Free Stock"
{

    fields
    {
        field(1;LineNo;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"For PO";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Item Number";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Item Description";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5;Quantity;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Un Reserved Free Stock";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Quantity to Cancel";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Expected Receipt Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"PO Serial No";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Part Type";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Dealer Net Price";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Doc Line No";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Order Multiple";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Vednor No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;LineNo)
        {
        }
    }

    fieldgroups
    {
    }
}

