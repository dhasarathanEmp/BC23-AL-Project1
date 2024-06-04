tableextension 70077 CustomerTemplateExtn extends "Customer Template"
{
    fields
    {
        field(50000; "Responsibility Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CS03';
            TableRelation = "Responsibility Center".Code;
        }
        field(50001; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CS03';
            TableRelation = Location.Code;
        }
        field(50002; "Pre-Payment %"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
}

