tableextension 70021 ProdOrderComponentExtn extends "Prod. Order Component"
{

    //Unsupported feature: Code Modification on "AutoReserve(PROCEDURE 2)".

    //procedure AutoReserve();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Status IN [Status::Simulated,Status::Finished] THEN
      EXIT;

    #4..8
    IF "Remaining Qty. (Base)" <> 0 THEN BEGIN
      TESTFIELD("Due Date");
      ReservMgt.SetProdOrderComponent(Rec);
      ReservMgt.AutoReserve(FullAutoReservation,'',"Due Date","Remaining Quantity","Remaining Qty. (Base)");
      CALCFIELDS("Reserved Quantity","Reserved Qty. (Base)");
      FIND;
      IF NOT FullAutoReservation AND
    #16..20
          FIND;
        END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
      // >> CUS019
      ReservMgt.AutoReserve(FullAutoReservation,'',"Due Date","Remaining Quantity","Remaining Qty. (Base)",Bool);
    #13..23
    */
    //end;

    var
        Bool: Boolean;
}

