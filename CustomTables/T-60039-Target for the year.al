table 60039 "Target for the year"
{

    fields
    {
        field(1; "Agency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(2; Location; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(3; "Accounting Year"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accounting Period"."Starting Date" WHERE("New Fiscal Year" = FILTER(true));
        }
        field(4; "Target for the Year"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Agency Code", Location, "Accounting Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Year := DATE2DMY("Accounting Year", 3);
    end;

    trigger OnModify()
    begin
        Year := DATE2DMY("Accounting Year", 3);
    end;

    trigger OnRename()
    begin
        Year := DATE2DMY("Accounting Year", 3);
    end;
}

