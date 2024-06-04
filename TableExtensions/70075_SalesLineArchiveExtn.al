tableextension 70075 SalesLineArchiveExtn extends "Sales Line Archive"
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
        field(50002; "Document No.1"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS009';
        }
        field(50003; InvoiceDiscountAmount1; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50004; VATAmount1; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50012; Stock_ADE; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50013; "Sap No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Customer Serial No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; LastPartNumber; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; Stock_HOD; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50018; Stock_MUK; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50019; Stock_SAN; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50020; Stock_TAI; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50021; Stock_HO; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50022; "HOD_Pro. Avil. Balance"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50023; "MUK_Pro. Avil. Balance"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50024; "SAN_Pro. Avil. Balance"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50025; "TAI_Pro. Avil. Balance"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
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
            Description = 'CUS011';
        }
        field(50030; Stock_ADF; Decimal)
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
        field(50033; "BOM Quantity Per"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "BOM Main Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Qty to cancel"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EMP108.09';

            trigger OnValidate()
            begin
                /*
                MainQty := Quantity - "Cancelled Quantity";
                Quantity := MainQty;
                */

            end;
        }
        field(50038; "Cancelled Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EMP108.09';
        }
    }
}

