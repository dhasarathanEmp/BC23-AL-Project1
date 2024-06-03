table 60019 "Hose Assembly Header"
{

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "CreationDate&Time"; DateTime)
        {
            Editable = false;
        }
        field(3; Description; Text[100])
        {
            Editable = false;
        }
        field(4; Status; Option)
        {
            Editable = false;
            OptionMembers = ,Success,Error,Processing;
        }
        field(5; RecordInserted; Integer)
        {
            Editable = false;
        }
        field(6; "User Id"; Code[20])
        {
            Editable = false;
        }
        field(7; "Total No of Errors"; Integer)
        {
            Editable = false;
        }
        field(8; UserName; Text[50])
        {
            Editable = false;
        }
        field(13; "Deleted Count"; Integer)
        {
            Editable = false;
        }
        field(14; TotalItems; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; SkippedCount; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; EndTime; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "File Name"; Text[30])
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

