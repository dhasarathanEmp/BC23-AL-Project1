tableextension 70041 InventoryProfileExtn extends "Inventory Profile"
{
    fields
    {
        field(50002; "Sales Order No.1"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS015';
        }
        field(50003; "Sales Order No.2"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS015';
        }
        field(50004; "Sales Order No.3"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS015';
        }
    }


    //Unsupported feature: Code Modification on "TransferFromSalesLine(PROCEDURE 2)".

    //procedure TransferFromSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLine.TESTFIELD(Type,SalesLine.Type::Item);
    SetSource(DATABASE::"Sales Line",SalesLine."Document Type",SalesLine."Document No.",SalesLine."Line No.",'',0);
    "Item No." := SalesLine."No.";
    #4..30
    END;
    "Drop Shipment" := SalesLine."Drop Shipment";
    "Special Order" := SalesLine."Special Order";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..33
    "Sales Order No.1" := SalesLine."Document No.";
    */
    //end;

    var
        InventoryProfile1: Record "Inventory Profile";
}

