table 60012 "Daily Price Log Header"
{

    fields
    {
        field(1;UserName;Text[50])
        {
        }
        field(2;"CreationDate&Time";DateTime)
        {
        }
        field(3;Description;Text[100])
        {
        }
        field(4;Status;Option)
        {
            OptionMembers = ,Success,Error,Processing;
        }
        field(5;"Total No. of Items Updated";Integer)
        {
        }
        field(6;"User Id";Code[20])
        {
        }
        field(7;"Total No of Errors";Integer)
        {
        }
        field(8;"No.";Code[20])
        {
        }
        field(9;"Log Status";Option)
        {
            OptionMembers = " ",Daily,Semiannual,Peugeot,"Fg wilson";
        }
        field(10;"New Items Found";Integer)
        {
        }
        field(11;"Record Inserted";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Skipped Records";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Total No. Of Records";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Start Time";Time)
        {
            DataClassification = ToBeClassified;
        }
        field(15;"End Time";Time)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
        key(Key2;"User Id")
        {
        }
    }

    fieldgroups
    {
    }
}

