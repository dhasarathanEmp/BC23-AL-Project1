table 60017 "Antares Form"
{

    fields
    {
        field(1;"Record Type Header";Code[10])
        {
        }
        field(2;Filler;Integer)
        {
        }
        field(3;Filler1;Integer)
        {
        }
        field(4;Filler2;Integer)
        {
        }
        field(5;"Record Type Sub Header";Code[10])
        {
        }
        field(6;"Filler Sub Header";Integer)
        {
        }
        field(7;"Record Type Order Item";Code[10])
        {
        }
        field(8;"Filler Order Item";Integer)
        {
        }
        field(9;"Record type Eof";Code[10])
        {
        }
        field(10;"Filler EOF";Integer)
        {
        }
        field(11;"Total Length Header";Integer)
        {
        }
        field(12;"Total Length Sub Header";Integer)
        {
        }
        field(13;"Total Length Order Item";Integer)
        {
        }
        field(14;"Total Length EOF";Integer)
        {
        }
        field(15;"Data Stored Path";Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16;"Card No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17;"Company Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18;"Supply source code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19;"Buyer Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20;"Card No Body";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21;"Country Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(22;"Order No";Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Record Type Header")
        {
        }
    }

    fieldgroups
    {
    }
}

