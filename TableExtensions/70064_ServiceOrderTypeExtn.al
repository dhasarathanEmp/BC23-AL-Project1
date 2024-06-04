tableextension 70064 ServiceOrderTypeExtn extends "Service Order Type"
{
    fields
    {
        field(50000; Return; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'CS05';
        }
        field(50001; "Validate po"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS007';
        }
        field(50002; "Approval Level"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
}

