table 60025 "Hose Assembly"
{

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "CreationDate&Time"; DateTime)
        {
        }
        field(3; Description; Text[100])
        {
        }
        field(4; Status; Option)
        {
            OptionMembers = ,Success,Error,Processing;
        }
        field(5; RecordInserted; Integer)
        {
        }
        field(6; "User Id"; Code[20])
        {
        }
        field(7; "Total No of Errors"; Integer)
        {
        }
        field(8; UserName; Text[50])
        {
        }
        field(13; "Deleted Count"; Integer)
        {
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

