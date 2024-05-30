tableextension 70028 SalesInvoiceHeaderExtn extends "Sales Invoice Header" 
{
    fields
    {
        field(50003;"Customer PO date";Date)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
        }
        field(50006;"VIN No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50007;"Vehicle Plate No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50008;"Service Item No.";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50009;"Service Item Name";Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50010;"Invoice Discount%";Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS023';
        }
        field(50011;"Price Validate";Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS023';
        }
        field(50012;"Delivery Terms";Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS023';
        }
        field(50013;"CS Prepayment No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014;"No. Of Packages";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50015;"Customer Representative";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50016;"Vehicle Model No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017;"Old Quote No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50018;"Document Type.";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Credit,Prepayment,Counter Sales,Temporary Delivery';
            OptionMembers = Credit,Prepayment,"Counter Sales","Temporary Delivery";
        }
        field(50019;"CR  Document No.";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50020;"CR External Reference No.";Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50030;"Special Price Factor";Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu001';
        }
    }

    //Unsupported feature: Property Modification (Fields) on "Brick(FieldGroup 2)".

}

