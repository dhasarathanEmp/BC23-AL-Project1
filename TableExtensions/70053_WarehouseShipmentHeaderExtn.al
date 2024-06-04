tableextension 70053 WarehouseShipmentHeaderExtn extends "Warehouse Shipment Header"
{
    fields
    {

        //Unsupported feature: Property Insertion (Editable) on ""No."(Field 1)".

        field(50013; "Vehicle Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "No. Of Packages"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Customer Representative"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WhseSetup.GET;
    IF "No." = '' THEN BEGIN
      WhseSetup.TESTFIELD("Whse. Ship Nos.");
    #4..9
    VALIDATE("Bin Code",Location."Shipment Bin Code");
    "Posting Date" := WORKDATE;
    "Shipment Date" := WORKDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
    "Assigned User ID" := USERID;
    */
    //end;
}

