table 60023 ReplacementItem
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ItemNo; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Inventory; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(3; CurrItem; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(4; LocationCode; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(5; ParentItem; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(6; ChildItem; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(7; LatestReplacementItem; Boolean)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; ItemNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}