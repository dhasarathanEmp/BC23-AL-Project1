tableextension 70080 PurchaseLineArchiveExtn extends "Purchase Line Archive"
{
    fields
    {
        field(50010; Status; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu002';
            OptionMembers = " ",Cancelled,Modified;
        }
        field(50011; "Cancelled Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu002';
        }
        field(50012; "Original Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu002';
        }
        field(50015; "Serial No"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Cu012';
        }
    }
}

