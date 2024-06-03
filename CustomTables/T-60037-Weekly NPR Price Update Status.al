table 60037 "Weekly NPR Price Update Status"
{

    fields
    {
        field(1; "Document Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document Updated Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Log Status"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Updated Day"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "No."; Text[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF WeeklyNPRPriceUpdateStatus.FINDLAST THEN
                  "No.":= WeeklyNPRPriceUpdateStatus."No." + 1
                ELSE
                 "No." := 1;*/

            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        WeeklyNPRPriceUpdateStatus: Record "Weekly NPR Price Update Status";
}

