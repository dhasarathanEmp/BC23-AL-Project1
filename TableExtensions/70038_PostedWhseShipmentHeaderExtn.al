tableextension 70038 PostedWhseShipmentHeaderExtn extends "Posted Whse. Shipment Header"
{
    fields
    {
        field(50000; "Vendor Invoice Number"; Code[35])
        {
            DataClassification = ToBeClassified;
        }
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
}

