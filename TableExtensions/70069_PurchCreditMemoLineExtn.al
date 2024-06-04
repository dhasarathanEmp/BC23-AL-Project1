tableextension 70069 PurchCreditMemoLineExtn extends "Purch. Cr. Memo Line"
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
        field(50009; "Part Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
    }
}

