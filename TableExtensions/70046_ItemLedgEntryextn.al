tableextension 70046 ItemLedgEntryExtn extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
            OptionMembers = " ",Sales,Service,Purchase;
        }
        field(50001; "Applied Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
        }
        field(50002; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
            TableRelation = "Responsibility Center".Code;
        }
        field(50003; "Service Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS002';
        }
        field(50004; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu016';
        }
    }
}

