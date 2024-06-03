table 60035 "Inventory for Valuation"
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
        field(6; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Reserved Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Counter Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Dead Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Temp Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Inventory; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Cost Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "In-Transit Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "DN and DC"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Gross Weight (Kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Agency Code", Location, "Accounting Year", "Entry Date", Year, "Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

