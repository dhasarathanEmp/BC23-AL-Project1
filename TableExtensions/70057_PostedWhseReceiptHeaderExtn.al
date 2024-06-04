tableextension 70057 PostedWhseReceiptHeaderExtn extends "Posted Whse. Receipt Header"
{
    fields
    {
        field(50000; "Vendor Invoice Number"; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Vendor Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Discrepancy No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Vendor Invoice Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}

