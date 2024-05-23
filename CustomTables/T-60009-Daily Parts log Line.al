table 60009 "Daily Parts log Line"
{

    fields
    {
        field(1;No;Code[20])
        {
        }
        field(2;"User Id";Code[20])
        {
        }
        field(3;"Import Date & Time";DateTime)
        {
        }
        field(4;"Exception Message";Text[100])
        {
        }
        field(5;Status;Text[30])
        {
        }
        field(6;Inserted;Integer)
        {
        }
        field(7;Modified;Integer)
        {
        }
        field(8;"File Name";Text[100])
        {
        }
        field(9;"User Name";Text[50])
        {
        }
        field(10;"Item No.";Code[20])
        {
        }
        field(11;"Line No.";Integer)
        {
        }
        field(12;"Daily Header No";Code[20])
        {
        }
        field(13;"Log Status";Option)
        {
            OptionMembers = " ",Daily,Semiannual,Peugeot,"Fg wilson";
        }
    }

    keys
    {
        key(Key1;No)
        {
        }
    }

    fieldgroups
    {
    }
}

