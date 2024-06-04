tableextension 70100 TransferReceiptLineExtn extends "Transfer Receipt Line"
{
    fields
    {
        field(50000; "Original Transfer Order Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS013';
        }
        field(50001; "ShippedQty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS013';
        }
        field(50004; "Indent No."; Code[250])
        {
            DataClassification = ToBeClassified;
            Description = 'CS14/Indent No.';
        }
        field(50005; "Sales Order No"; Code[250])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS015';
        }
        field(50008; SalesOrder; Code[250])
        {
            DataClassification = ToBeClassified;
            Description = 'CS14';
        }
        field(50009; "Required By"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code WHERE(Code = FILTER(<> 'ADF'));
        }
        field(50010; Remarks; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'None,Damage,Missing';
            OptionMembers = "None ",Damage,Missing;
        }
        field(50011; Excess; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Default Price/Unit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'ep9613';
        }
        field(50019; "Agency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50021; "Ordered Part No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "CopyFromTransferLine(PROCEDURE 1)".

    //procedure CopyFromTransferLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Line No." := TransLine."Line No.";
    "Item No." := TransLine."Item No.";
    Description := TransLine.Description;
    #4..27
    "Shipping Time" := TransLine."Shipping Time";
    "Item Category Code" := TransLine."Item Category Code";
    "Product Group Code" := TransLine."Product Group Code";

    OnAfterCopyFromTransferLine(Rec,TransLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..30
    "ShippedQty." := TransLine."ShippedQty.";
    "Original Transfer Order Qty." := TransLine."Original Transfer Order Qty.";
    "Ordered Part No." := TransLine."Ordered Part No.";

    //  >>  CS14
    "Indent No."  :=  TransLine."Indent No.";
    SalesOrder  :=  TransLine.SalesOrder;
    "Sales Order No" := TransLine."Sales Order No";
    //  <<  CS14
    WarehouseReceiptLine.RESET;
    WarehouseReceiptLine.SETRANGE("Item No.",TransLine."Item No.");
    WarehouseReceiptLine.SETRANGE("Line No.",TransLine."Line No.");
    WarehouseReceiptLine.SETRANGE("Source No.",TransLine."Document No.");
    IF WarehouseReceiptLine.FINDFIRST THEN BEGIN
      Remarks := WarehouseReceiptLine.Remarks;
      Excess := WarehouseReceiptLine.Excess;
    END;
    "Required By" := TransLine."Required By";
    OnAfterCopyFromTransferLine(Rec,TransLine);
    */
    //end;

    var
        TransferReceiptLine: Record "Transfer Receipt Line";
        Qty: Decimal;
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
}

