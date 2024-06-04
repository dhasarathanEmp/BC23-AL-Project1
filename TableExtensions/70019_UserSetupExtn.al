tableextension 70019 UserSetupExtn extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Counter_Batch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name WHERE(Counter_Batch = const(true));
        }
        field(50001; "Phy Inventory Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'AFZ002';
            TableRelation = "Responsibility Center".Code;
        }
        field(50002; "FOC Sales Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
            TableRelation = "Item Journal Batch".Name WHERE("FOC Sales" = FILTER(true));
        }
        field(50003; "Cash Receipt Batch"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Cash Receipt Batch" = const(true));
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