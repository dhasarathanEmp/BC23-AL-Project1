table 60014 "NPR Log Lines"
{

    fields
    {
        field(1; "Document No."; Code[10])
        {
        }
        field(2; ItemNo; Code[20])
        {
        }
        field(3; "User Id"; Code[20])
        {
        }
        field(4; "User Name"; Text[100])
        {
        }
        field(5; "Imported Date & Time"; DateTime)
        {
        }
        field(6; "Exception Message"; Text[250])
        {
        }
        field(7; Status; Option)
        {
            OptionMembers = ,Error,Success;
        }
        field(8; "No."; Code[20])
        {
        }
        field(9; FileName; Text[80])
        {
        }
        field(10; InsertedCount; Integer)
        {
        }
        field(11; ModifiedCount; Integer)
        {
        }
        field(12; LineNo; Integer)
        {
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

