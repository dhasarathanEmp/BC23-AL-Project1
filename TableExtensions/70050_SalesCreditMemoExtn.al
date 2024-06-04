tableextension 70050 SalesCreditMemoExtn extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50002; "Document No.1"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'K01';
        }
        field(50006; SaleInvNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50012; "Gate Pass No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50013; "Sap No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS022';
        }
        field(50014; "Customer Serial No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS022';
        }
        field(50015; LastPartNumber; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50026; "Core Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "PO Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}

