tableextension 70020 ItemJournalBatch extends "Item Journal Batch"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Counter_Batch; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Responsibility_Center; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CS02';
            TableRelation = "Responsibility Center".Code;

            trigger OnValidate()
            begin
                ResponsibilityCenter.RESET;
                IF ResponsibilityCenter.GET(Responsibility_Center) THEN
                    Location := ResponsibilityCenter."Location Code"
                ELSE
                    Location := '';
            end;
        }
        field(50002; Location; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CS02';
            TableRelation = Location.Code;
        }
        field(50003; "Temporary Delivery"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Physical Inventory"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'AFZ002';
        }
        field(50005; "Item Reclass Journal"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9607';
        }
        field(50006; "Temporary Delivery Return"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9611';
        }
        field(50007; "Default Batch"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9611';
        }
        field(50008; "FOC Sales"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
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
        ResponsibilityCenter: Record "Responsibility Center";
}