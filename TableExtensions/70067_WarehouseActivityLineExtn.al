tableextension 70067 WarehouseActivityLineExtn extends "Warehouse Activity Line"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Bin Code"(Field 7300).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Action Type" = "Action Type"::Take THEN
          BinCode := WMSMgt.BinContentLookUp2("Location Code","Item No.","Variant Code","Zone Code","Lot No.","Serial No.","Bin Code")
        ELSE
          BinCode := WMSMgt.BinLookUp("Location Code","Item No.","Variant Code","Zone Code");

        IF BinCode <> '' THEN BEGIN
          VALIDATE("Bin Code",BinCode);
          MODIFY;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Action Type" = "Action Type"::Take THEN
          BinCode := WMSMgt.BinContentLookUp("Location Code","Item No.","Variant Code","Zone Code","Bin Code")
        #3..9
        */
        //end;
    }
}

