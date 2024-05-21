tableextension 70004 NoSeriesExtn extends "No. Series"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
        }
        field(50001; "Customer Check"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Global Customer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "No Series Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = None,Invoice,CreditMemo;
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