tableextension 70062 ServiceLineExtn extends "Service Line"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Bin Code"(Field 5403).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Location Code");
        TESTFIELD(Type,Type::Item);

        IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice] THEN
          BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code",'',"Bin Code")
        ELSE
          IF "Document Type" = "Document Type"::"Credit Memo" THEN
            BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code",'');

        IF BinCode <> '' THEN
          VALIDATE("Bin Code",BinCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        {IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice] THEN
        #5..10
          VALIDATE("Bin Code",BinCode);}
        //CS18
        IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice] THEN
          BinCode := WMSManagement.BinContentLookUp1("Location Code","No.","Variant Code",'',"Bin Code",1)
        ELSE
          IF "Document Type" = "Document Type"::"Credit Memo" THEN
            BinCode := WMSManagement.BinLookUp1("Location Code","No.","Variant Code",'',1);
        //CS18
        IF BinCode <> '' THEN
          VALIDATE("Bin Code",BinCode);
        */
        //end;
        field(50000; PurchlineDetials; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS003';
        }
        field(50001; CusReturns; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'CS05';
        }
        field(50002; "Service Quotes"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS007';
        }
    }


    //Unsupported feature: Code Modification on "AutoReserve(PROCEDURE 39)".

    //procedure AutoReserve();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD(Type,Type::Item);
    TESTFIELD("No.");
    IF Reserve = Reserve::Never THEN
      FIELDERROR(Reserve);
    ReserveServLine.ReservQuantity(Rec,QtyToReserve,QtyToReserveBase);
    IF QtyToReserveBase <> 0 THEN BEGIN
      ReservMgt.SetServLine(Rec);
      ReservMgt.AutoReserve(FullAutoReservation,'',"Order Date",QtyToReserve,QtyToReserveBase);
      FIND;
      IF NOT FullAutoReservation THEN BEGIN
        COMMIT;
    #12..14
        END;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
      ReservMgt.AutoReserve(FullAutoReservation,'',"Order Date",QtyToReserve,QtyToReserveBase,Bool);
    #9..17
    */
    //end;


    //Unsupported feature: Code Modification on "GetDefaultBin(PROCEDURE 50)".

    //procedure GetDefaultBin();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Type <> Type::Item THEN
      EXIT;

    #4..7
      IF NOT Location."Bin Mandatory" THEN
        EXIT;
      IF (NOT Location."Directed Put-away and Pick") OR ("Document Type" <> "Document Type"::Order) THEN BEGIN
        WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
        IF ("Document Type" <> "Document Type"::Order) AND ("Bin Code" <> '') AND Location."Directed Put-away and Pick"
        THEN BEGIN
          // Clear the bin code if the bin is not of pick type
    #15..18
        END;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
       //CS18
         WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
       //CS18
    #12..21
    */
    //end;

    var
        Bool: Boolean;
}

