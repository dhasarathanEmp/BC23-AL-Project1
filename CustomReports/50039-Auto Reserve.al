codeunit 50039 "Auto Reserve"
{
    TableNo = 472;

    trigger OnRun()
    begin
        ReservEntry.RESET;
        ReservEntry.SETRANGE("Reservation Status", ReservEntry."Reservation Status"::Tracking);
        ReservEntry.SETRANGE("Source Type", 39);
        ReservEntry.SETRANGE("Source Subtype", 1);
        IF ReservEntry.FINDSET THEN
            REPEAT
                PurchLine.RESET;
                PurchLine.GET(ReservEntry."Source Subtype", ReservEntry."Source ID", ReservEntry."Source Ref. No.");
                IF PurchLine."Sales Order No" <> '' THEN BEGIN
                    ReservationEntry.RESET;
                    ReservationEntry.SETRANGE("Entry No.", ReservEntry."Entry No.");
                    ReservationEntry.SETFILTER("Source Type", '<>%1', 246);
                    IF ReservationEntry.COUNT = 2 THEN
                        IF ReservationEntry.FINDSET THEN
                            REPEAT
                                ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Reservation;
                                ReservationEntry.MODIFY;
                            UNTIL ReservationEntry.NEXT = 0;
                END;
            UNTIL ReservEntry.NEXT = 0;

        ReservationEntry3.RESET;
        ReservationEntry3.SETRANGE("Reservation Status", ReservationEntry3."Reservation Status"::Tracking);
        ReservationEntry3.SETRANGE("Source Type", 5741);
        ReservationEntry3.SETRANGE(Positive, TRUE);
        IF ReservationEntry3.FINDSET THEN
            REPEAT
                TransLine.RESET;
                TransLine.GET(ReservationEntry3."Source ID", ReservationEntry3."Source Ref. No.");
                IF TransLine."Sales Order No" <> '' THEN BEGIN
                    ReservationEntry4.RESET;
                    ReservationEntry4.SETRANGE("Entry No.", ReservationEntry3."Entry No.");
                    ReservationEntry4.SETFILTER("Source Type", '<>%1', 246);
                    IF ReservationEntry4.COUNT = 2 THEN
                        IF ReservationEntry4.FINDSET THEN
                            REPEAT
                                ReservationEntry4."Reservation Status" := ReservationEntry4."Reservation Status"::Reservation;
                                ReservationEntry4.MODIFY;
                            UNTIL ReservationEntry4.NEXT = 0;
                END;
            UNTIL ReservationEntry3.NEXT = 0;


        /*ReservationEntry5.RESET;
        ReservationEntry5.SETRANGE("Reservation Status",ReservationEntry5."Reservation Status"::Tracking);
        ReservationEntry5.SETRANGE("Source Type",32);
        ReservationEntry5.SETRANGE(Positive,TRUE);
        ReservationEntry5.SETRANGE("Location Code","Parameter String");
        IF ReservationEntry5.FINDSET THEN REPEAT
          ReservationEntry6.RESET;
          ReservationEntry6.SETRANGE("Entry No.",ReservationEntry5."Entry No.");
          ReservationEntry6.SETFILTER("Source Type",'<>%1',246);
          IF ReservationEntry6.COUNT=2 THEN
            IF ReservationEntry6.FINDSET THEN REPEAT
              ReservationEntry6."Reservation Status":=ReservationEntry6."Reservation Status"::Reservation;
              ReservationEntry6.MODIFY;
            UNTIL ReservationEntry6.NEXT=0;
        UNTIL ReservationEntry5.NEXT=0;*/

    end;

    var
        ReservEntry: Record "Reservation Entry";
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry3: Record "Reservation Entry";
        ReservationEntry4: Record "Reservation Entry";
        ReservationEntry5: Record "Reservation Entry";
        ReservationEntry6: Record "Reservation Entry";
        PurchLine: Record "Purchase Line";
        TransLine: Record "Transfer Line";
}

