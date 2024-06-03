table 60018 "Hose Assembly line"
{

    fields
    {
        field(1; "Document No."; Code[10])
        {
            Editable = false;
        }
        field(2; ItemNo; Code[20])
        {
            Editable = false;
        }
        field(3; "User Id"; Code[20])
        {
            Editable = false;
        }
        field(4; "User Name"; Text[100])
        {
            Editable = false;
        }
        field(5; "Imported Date & Time"; DateTime)
        {
            Editable = false;
        }
        field(6; "Exception Message"; Text[250])
        {
            Editable = false;
        }
        field(7; Status; Option)
        {
            Editable = false;
            OptionMembers = ,Error,Success;
        }
        field(8; "No."; Code[20])
        {
            Editable = false;
        }
        field(9; FileName; Text[80])
        {
            Editable = false;
        }
        field(10; InsertedCount; Integer)
        {
            Editable = false;
        }
        field(11; ModifiedCount; Integer)
        {
            Editable = false;
        }
        field(12; LineNo; Integer)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

