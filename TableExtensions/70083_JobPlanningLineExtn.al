tableextension 70083 JobPlanningLineExtn extends "Job Planning Line" 
{

    //Unsupported feature: Code Modification on "AutoReserve(PROCEDURE 73)".

    //procedure AutoReserve();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD(Type,Type::Item);
        TESTFIELD("No.");
        IF Reserve = Reserve::Never THEN
          FIELDERROR(Reserve);
        JobPlanningLineReserve.ReservQuantity(Rec,QtyToReserve,QtyToReserveBase);
        IF QtyToReserveBase <> 0 THEN BEGIN
          ReservMgt.SetJobPlanningLine(Rec);
          TESTFIELD("Planning Date");
          ReservMgt.AutoReserve(FullAutoReservation,'',"Planning Date",QtyToReserve,QtyToReserveBase);
          FIND;
          IF NOT FullAutoReservation THEN BEGIN
            COMMIT;
        #13..16
          END;
          UpdatePlanned;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
          //  >> CUS019
          ReservMgt.AutoReserve(FullAutoReservation,'',"Planning Date",QtyToReserve,QtyToReserveBase,Bool);
        #10..19
        */
    //end;

    var
        Bool: Boolean;
}

