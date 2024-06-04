tableextension 70048 SalesShipmentLineExtn extends "Sales Shipment Line"
{
    fields
    {
        field(50001; "Applied Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Document No.1"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS008';
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
        field(50016; "Sale Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS022';
        }
        field(50026; "Core Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "PO Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Case Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Gross Weight kG"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Sale Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'AFZ001';
        }
        field(50032; "BOM Item No"; Code[20])
        {
            Caption = 'BOM Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
    }
}

