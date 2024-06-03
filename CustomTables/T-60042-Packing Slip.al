table 60042 "Packing Slip"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Invoice No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Case No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "PO Number"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "PO Serial No"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Customer Ref No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Orderd Part No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Case Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Weight; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Bom Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No", "Invoice No")
        {
        }
    }

    fieldgroups
    {
    }
}

