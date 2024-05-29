tableextension 70024 AssemblyLineExtn extends "Assembly Line"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Bin Code"(Field 23).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TESTFIELD(Type,Type::Item);
        IF "Bin Code" <> '' THEN BEGIN
          TESTFIELD("Location Code");
        #5..8
            "Bin Code",0);
          CheckBin;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //TestStatusOpen;
        #2..11
        */
        //end;
        field(50000; "Old Part Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; LastPartNumber; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }


    //Unsupported feature: Code Modification on "AutoReserve(PROCEDURE 148)".

    //procedure AutoReserve();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Type <> Type::Item THEN
      EXIT;

    #4..7
    IF "Remaining Quantity (Base)" <> 0 THEN BEGIN
      TESTFIELD("Due Date");
      ReservMgt.SetAssemblyLine(Rec);
      ReservMgt.AutoReserve(FullAutoReservation,'',"Due Date","Remaining Quantity","Remaining Quantity (Base)");
      FIND;
      IF NOT FullAutoReservation AND (CurrFieldNo <> 0) THEN
        IF CONFIRM(Text001,TRUE) THEN BEGIN
          COMMIT;
          ShowReservation;
          FIND;
        END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
      //  >> CUS019
      ReservMgt.AutoReserve(FullAutoReservation,'',"Due Date","Remaining Quantity","Remaining Quantity (Base)",Bool);
    #12..19
    */
    //end;

    var
        Bool: Boolean;
}

