table 60002 "Semiannual Error Log Line"
{
    DataCaptionFields = No;
    LinkedObject = false;
    Permissions = TableData 60002 = rimd;

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "User Id"; Code[20])
        {
        }
        field(3; "Import Date & Time"; DateTime)
        {
        }
        field(4; "Exception Message"; Text[250])
        {
        }
        field(5; Status; Option)
        {
            OptionMembers = ,Success,Error,Processing;
        }
        field(6; "Item No."; Code[20])
        {
        }
        field(7; "Line No."; Integer)
        {
        }
        field(8; "New Items Line Find"; Integer)
        {
        }
        field(9; Modified; Integer)
        {
        }
        field(10; "User Name"; Text[100])
        {
        }
        field(11; "File Name"; Text[100])
        {
        }
        field(12; "Header No"; Code[20])
        {
        }
        field(13; "Log Status"; Option)
        {
            OptionMembers = " ",Semiannual,Nissan,MCFE,MF;
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
        key(Key2; "Header No")
        {
        }
    }

    fieldgroups
    {
    }
}

