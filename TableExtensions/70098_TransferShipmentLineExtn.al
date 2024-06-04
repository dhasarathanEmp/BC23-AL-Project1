tableextension 70098 TransferShipmentLineExtn extends "Transfer Shipment Line"
{
    fields
    {
        field(50001; "ShippedQty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS010';
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
    "Ordered Part No." := TransLine."Ordered Part No.";

    OnAfterCopyFromTransferLine(Rec,TransLine);
    //  >>  CS14
    "Indent No."  :=  TransLine."Indent No.";
    SalesOrder  :=  TransLine.SalesOrder;
    "Sales Order No" := TransLine."Sales Order No";
    //  <<  CS14
    */
    //end;
}

