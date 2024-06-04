tableextension 70071 WarehouseRequestExtn extends "Warehouse Request"
{
    fields
    {
        field(50000; "Vendor Invoice No"; Code[35])
        {
            DataClassification = ToBeClassified;
            Description = 'GRN Purchase';
        }
        field(50001; "Vendor Invoice Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Vendor invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; SalesInvoiceNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; TransferFromCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; TransferToCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}

