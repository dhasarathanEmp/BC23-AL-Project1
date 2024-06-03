table 60034 "FOC Sales History"
{

    fields
    {
        field(1; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Default Price/Unit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Bin Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Remark; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Posting Date", "Document No", "Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

