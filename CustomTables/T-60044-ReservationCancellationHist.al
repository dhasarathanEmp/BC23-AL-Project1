table 60044 "Reservation Cancellation Hist."
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Reservation Cancelled On."; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Cancelled Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Reason Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Reservation Cancelled For"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Cancelled By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Reservation Cancelled From"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Reserved In"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

