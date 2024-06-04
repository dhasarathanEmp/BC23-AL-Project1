tableextension 70054 WarehouseShipmentLineExtn extends "Warehouse Shipment Line"
{
    fields
    {
        modify("Bin Code")
        {
            TableRelation = IF ("Zone Code" = FILTER('')) "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                                      "Item No." = FIELD("Item No."),
                                                                                      "Variant Code" = FIELD("Variant Code"),
                                                                                      "Counter sale" = FILTER(false),
                                                                                      "Bin Blocks" = FILTER(false),
                                                                                      DeadBlocks = FILTER(false),
                                                                                      Discrepancy = FILTER(false),
                                                                                      "Temporary Delivery" = FILTER(false))
            ELSE IF ("Zone Code" = FILTER(<> '')) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                                       "Zone Code" = FIELD("Zone Code"),
                                                                                                                                       "Counter sale" = FILTER(false),
                                                                                                                                       Blocks = FILTER(false),
                                                                                                                                       "Temporary Delivery" = FILTER(false),
                                                                                                                                       Discrepancy = FILTER(false));
        }
        field(50000; "Original Transfer Order Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS013';
        }
        field(50001; "Case No"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS022';
        }
        field(50002; "Sales Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS022';
        }
        field(50004; VATAmount1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Sales Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS013';
        }
        field(50006; SaleInvNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CS90';
        }
        field(50007; "VIN No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50008; "Vehicle Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50009; SaleInvLineNo; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CS90';
        }
        field(50010; "Service Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50011; "Service Item Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
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
        }
        field(50018; "Default Price/Unit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50019; "Agency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50026; "Core Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "PO Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'AFZ001';
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
            Description = 'AFZ001';
            TableRelation = Item;
        }
        field(50033; "BOM Quantity per"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "BOM Main Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        WarehouseShipmentLineBuf: Record "Warehouse Shipment Line";
        CountBuf: Integer;
        WarehouseShipmentLineBuf1: Record "Warehouse Shipment Line";
}

