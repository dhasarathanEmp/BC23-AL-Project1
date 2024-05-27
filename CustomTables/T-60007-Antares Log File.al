table 60007 "Antares Log File"
{

    fields
    {
        field(1; "Purchase Order No."; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Conversion Date &Time"; DateTime)
        {
        }
        field(4; "User Id"; Code[20])
        {
        }
        field(5; Status; Text[30])
        {
        }
        field(6; "Operator (User Name)"; Text[100])
        {
        }
        field(7; "Po Date"; Date)
        {
        }
        field(8; "Order Class"; Code[10])
        {
        }
        field(9; "Customer Code"; Code[40])
        {
        }
        field(10; "Customer Reference Number"; Text[40])
        {
        }
        field(11; "Antares Order Profile"; Code[10])
        {
        }
        field(12; "Acknowledgment Type"; Code[10])
        {
        }
        field(13; "Antares Order Entry"; Code[10])
        {
        }
        field(14; "Antares No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Antares No.")
        {
        }
        key(Key2; "Purchase Order No.")
        {
        }
    }

    fieldgroups
    {
    }
}

