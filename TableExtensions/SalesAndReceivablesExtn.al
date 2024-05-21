tableextension 70005 SalesAndReceivables extends "Sales & Receivables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Gate Pass ADE"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Gate Pass ADF"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Gate Pass HOD-SHA")
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Gate Pass MUK"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Gate Pass SAN"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Gate Pass TAI"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Daily Part Price Update"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Nisson header"; Code[20])//CUS029
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Nisson Line"; Code[20])//CUS029
        {
            DataClassification = ToBeClassified;
        }
        field(50038; Inc_CoreCharge; Boolean)
        {

        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}