tableextension 70049 SalesInvoiceLineExtn extends "Sales Invoice Line"
{
    fields
    {

        //Unsupported feature: Code Insertion on ""Bin Code"(Field 5403)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        BinCode := WMSManagement.BinLookUp1("Location Code","No.","Variant Code",'',4);
        BinCode := WMSManagement.BinContentLookUp1("Location Code","No.","Variant Code",'',"Bin Code",4);
        */
        //end;


        //Unsupported feature: Code Insertion on ""Bin Code"(Field 5403)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        VALIDATE("Bin Code",BinCode);
        */
        //end;
        field(50001; "Applied Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Document No.1"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS008';
        }
        field(50012; "Gate Pass No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
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
    }
    keys
    {
        key(Key2; "Applied Doc. No.")
        {
        }
    }


    //Unsupported feature: Code Insertion on "OnInsert".

    //trigger OnInsert()
    //begin
    /*
    //Case No customization
    IF "No." <> '' THEN BEGIN
      InvoicePackingList1.No := COUNT;
      InvoicePackingList1."Sales Order No" := "Sale Order No.";
      InvoicePackingList1."Shipment No" := "Shipment No.";
      InvoicePackingList1."Document Number" := "Document No.";
      InvoicePackingList1."Purchase order No" := "PO Number";
      InvoicePackingList1."Customer Serial No" := "Customer Serial No";
      InvoicePackingList1."Sap No":= "Sap No";
      InvoicePackingList1."ALT Part No" := LastPartNumber;
      InvoicePackingList1."Part No" := "No.";
      InvoicePackingList1.Description := Description;
      InvoicePackingList1.Quantity := Quantity;
      InvoicePackingList1."Gross Weight KG" := "Gross Weight kG";
      InvoicePackingList1."Invoice No" := "Document No.";
      InvoicePackingList1."BOM Item No" := "BOM Item No";
      InvoicePackingList1.INSERT;
    END;
    //
    */
    //end;

    var
        BinCode: Code[20];
        WMSManagement: Codeunit "WMS Management";
        InvoicePackingList1: Record "Invoice Packing List1";
}

