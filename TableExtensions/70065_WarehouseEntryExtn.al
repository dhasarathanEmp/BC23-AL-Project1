tableextension 70065 WarehouseEntryExtn extends "Warehouse Entry"
{
    fields
    {
        field(50000; "Contact No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CS09';
            TableRelation = Contact."No.";
        }
    }
}

