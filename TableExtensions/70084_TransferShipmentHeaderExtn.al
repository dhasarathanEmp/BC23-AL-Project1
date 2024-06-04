tableextension 70084 TransferShipmentHeaderExtn extends "Transfer Shipment Header"
{
    fields
    {
        field(50000; "Transfer-to Fax No"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50001; "Transfer-From Fax No"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50004; "Delivery Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS010';
        }
    }


    //Unsupported feature: Code Modification on "CopyFromTransferHeader(PROCEDURE 4)".

    //procedure CopyFromTransferHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Transfer-from Code" := TransHeader."Transfer-from Code";
    "Transfer-from Name" := TransHeader."Transfer-from Name";
    "Transfer-from Name 2" := TransHeader."Transfer-from Name 2";
    #4..36
    Area := TransHeader.Area;
    "Transaction Specification" := TransHeader."Transaction Specification";
    "Direct Transfer" := TransHeader."Direct Transfer";

    OnAfterCopyFromTransferHeader(Rec,TransHeader);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..39
    // >> K02
    "Delivery Order No." :=TransHeader."Delivery Order No.";
    // << K02
    OnAfterCopyFromTransferHeader(Rec,TransHeader);
    */
    //end;
}

