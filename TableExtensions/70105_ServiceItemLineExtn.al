tableextension 70105 ServiceItemLineExtn extends "Service Item Line"
{
    fields
    {
        field(50000; ModifyRec; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS013';
        }
        field(50004; "Vehicle Plate No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CS09';
        }
        field(50005; Kilometer; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
}

