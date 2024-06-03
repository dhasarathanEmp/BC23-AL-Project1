table 60033 "Invoice Packing List1"
{

    fields
    {
        field(1; No; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Case No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Purchase order No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Customer Serial No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Part No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "ALT Part No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Sap No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Document Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Sales Order No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Shipment No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Invoice No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Gross Weight KG"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "BOM Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
    }

    fieldgroups
    {
    }
}

