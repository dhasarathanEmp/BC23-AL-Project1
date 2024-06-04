tableextension 70076 InventorySetupExtn extends "Inventory Setup"
{
    fields
    {
        field(50000; "Discrepancy Report No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS017';
            TableRelation = "No. Series";
        }
        field(50001; "AFZ Internal Invoice No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS017';
            TableRelation = "No. Series";
        }
        field(50002; "Hose Price Update Job"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu011';
        }
    }
}

