tableextension 70044 VendorExtn extends Vendor
{
    fields
    {

        //Unsupported feature: Property Insertion (Editable) on ""No."(Field 1)".


        //Unsupported feature: Property Modification (Data type) on "Address(Field 5)".


        //Unsupported feature: Property Modification (Data type) on ""Address 2"(Field 6)".

        field(50001; "Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Agency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;
        }
        field(50003; "Item Price Update"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Antares Parts Order Interface"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Whse Receipt Validation"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu012';
        }
    }
}

