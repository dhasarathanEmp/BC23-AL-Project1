tableextension 70005 SalesAndReceivables extends "Sales & Receivables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50020; "Nisson header"; Code[20])//CUS029
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Nisson Line"; Code[20])//CUS029
        {
            DataClassification = ToBeClassified;
        }
        field(50022; Inc_CoreCharge; Boolean)
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