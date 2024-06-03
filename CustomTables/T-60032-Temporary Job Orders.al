table 60032 "Temporary Job Orders"
{
    LookupPageID = "Job Order List";

    fields
    {
        field(1; "Job Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Job Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Job Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Job Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,On Job,Completed';
            OptionMembers = Open,"On Job",Completed;
        }
        field(5; Location; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code WHERE("Use As In-Transit" = CONST(false));
        }
        field(6; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Vehicle Plate No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Model No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Job Crad No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Job Order No", "Job Description", Location)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(Lookup; "Job Order No", "Job Description", "Job Creation Date", Location, "Job Status")
        {
        }
    }

    trigger OnDelete()
    begin
        /*IF (Rec."Job Status" = Rec."Job Status"::Completed) OR (Rec."Job Status" = Rec."Job Status"::"On Job") THEN
          ERROR('Deletion allowed only for the job status "Open"');*/

    end;
}

