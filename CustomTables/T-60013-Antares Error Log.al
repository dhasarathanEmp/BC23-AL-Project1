table 60013 "Antares Error Log"
{
    Permissions = TableData 60002=rimd;

    fields
    {
        field(1;"Document No.";Code[10])
        {
        }
        field(2;"Document Date";Date)
        {
        }
        field(3;"User Id";Code[20])
        {
        }
        field(4;"User Name";Text[100])
        {
        }
        field(5;"Convertion Date & Time";DateTime)
        {
        }
        field(6;"Exception Message";Text[250])
        {
        }
        field(7;Status;Option)
        {
            OptionMembers = ,Error,Success;
        }
        field(8;"No.";Code[10])
        {
        }
        field(9;"Line No.";Code[10])
        {
        }
        field(10;"Purchase Line No.";Integer)
        {
        }
        field(11;"Item No.";Code[20])
        {
        }
        field(12;"No. of Po Lines Created";Integer)
        {
        }
    }

    keys
    {
        key(Key1;"Line No.")
        {
        }
        key(Key2;"Document No.","No.")
        {
        }
    }

    fieldgroups
    {
    }
}

