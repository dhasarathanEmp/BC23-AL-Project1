codeunit 50056 "Auto Replace"
{

    trigger OnRun()
    begin
    end;

    var
        TransferLine: Record "Transfer Line";
        TransferShipmentLine: Record "Transfer Shipment Line";
        TransferReceiptLine: Record "Transfer Receipt Line";
        Flag: Integer;
        UnitPrice: Decimal;
        CustomerSerialNo: Code[20];
        "BOM Item No": Code[20];
        "BOM Line NO": Integer;
        "BOM Quantity per": Decimal;

    procedure "Auto Replace"(OldPartNo: Code[20]; TransferOrderNo: Code[20]; "Transfer Line No": Integer; NewPartNo: Code[20]) NewLineNo: Integer
    var
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        SalesLine3: Record "Sales Line";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        WarehouseShipmentLine2: Record "Warehouse Shipment Line" temporary;
        WhseCreateSourceDocument: Codeunit "Whse.-Create Source Document";
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        ReservationEngineMgt: Codeunit "Reservation Engine Mgt.";
        AssemblyLine: Record "Assembly Line";
        AssemblyLine2: Record "Assembly Line";
        AssemblyLine3: Record "Assembly Line";
    begin
        Flag := 0;
        ReservationEntry.RESET;
        ReservationEntry.SETRANGE("Source Type", 5741);
        ReservationEntry.SETRANGE(Positive, TRUE);
        ReservationEntry.SETRANGE("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
        ReservationEntry.SETRANGE("Source ID", TransferOrderNo);
        ReservationEntry.SETRANGE("Source Ref. No.", "Transfer Line No");
        IF ReservationEntry.FINDSET THEN
            REPEAT
                IF ReservationEntry2.GET(ReservationEntry."Entry No.", FALSE) THEN BEGIN
                    IF ReservationEntry2."Source Type" = 37 THEN BEGIN

                        SalesLine.GET(ReservationEntry2."Source Subtype", ReservationEntry2."Source ID", ReservationEntry2."Source Ref. No.");
                        IF SalesLine.Quantity <> -ReservationEntry2.Quantity THEN BEGIN //SO Qty greater than TO Qty, SO should be split 
                            Flag := 1;
                            SalesLine2.RESET;
                            SalesLine2.SETRANGE("Document Type", SalesLine2."Document Type"::Order);
                            SalesLine2.SETRANGE("Document No.", ReservationEntry2."Source ID");
                            IF SalesLine2.FINDLAST THEN;
                            //Code to create new line starts
                            SalesLine3.INIT;
                            SalesLine3.SuspendStatusCheck(TRUE);
                            //SalesLine3.TRANSFERFIELDS(SalesLine);
                            SalesLine3."Document Type" := SalesLine3."Document Type"::Order;
                            SalesLine3."Document No." := SalesLine."Document No.";
                            SalesLine3."Line No." := SalesLine2."Line No." + 1000;
                            SalesLine3.Type := SalesLine3.Type::Item;
                            SalesLine3.VALIDATE("No.", NewPartNo);
                            SalesLine3.LastPartNumber := OldPartNo;
                            SalesLine3.VALIDATE(Quantity, -ReservationEntry2.Quantity);
                            SalesLine3.VALIDATE("Unit Price", SalesLine."Unit Price");
                            SalesLine3."Customer Serial No" := SalesLine."Customer Serial No";
                            //SalesLine3."BOM Item No" := SalesLine."BOM Item No";
                            //SalesLine3."BOM Main Line No." := SalesLine."BOM Main Line No."+1;
                            //SalesLine3."BOM Quantity Per" := SalesLine3.Quantity/SalesLine.Quantity * SalesLine."BOM Quantity Per";
                            SalesLine3.SuspendStatusCheck(FALSE);
                            SalesLine3.INSERT;
                            //Code to create new line ends

                            //Code to check if Whse Exists, if exists then Whse should be deleted and recreated.
                            WarehouseShipmentLine.RESET;
                            WarehouseShipmentLine.SETRANGE("Source No.", SalesLine."Document No.");
                            WarehouseShipmentLine.SETRANGE("Source Line No.", SalesLine."Line No.");
                            IF WarehouseShipmentLine.FINDFIRST THEN BEGIN
                                WarehouseShipmentLine2.COPY(WarehouseShipmentLine);
                                WarehouseShipmentLine.DELETE;

                                SalesLine.SuspendStatusCheck(TRUE);
                                ReservationEngineMgt.CancelReservation(ReservationEntry2);
                                //SalesLine."BOM Quantity Per" := (SalesLine.Quantity+ReservationEntry2.Quantity)/SalesLine.Quantity * SalesLine."BOM Quantity Per";
                                SalesLine.VALIDATE(Quantity, SalesLine.Quantity + ReservationEntry2.Quantity);//Changing original Sale Line Qty
                                SalesLine.SuspendStatusCheck(FALSE);
                                SalesLine.MODIFY;

                                WarehouseShipmentHeader.GET(WarehouseShipmentLine2."No.");
                                WhseCreateSourceDocument.FromSalesLine2ShptLine(WarehouseShipmentHeader, SalesLine);
                                WhseCreateSourceDocument.FromSalesLine2ShptLine(WarehouseShipmentHeader, SalesLine3);
                            END ELSE BEGIN
                                SalesLine.SuspendStatusCheck(TRUE);
                                ReservationEngineMgt.CancelReservation(ReservationEntry2);
                                //SalesLine."BOM Quantity Per" := (SalesLine.Quantity+ReservationEntry2.Quantity)/SalesLine.Quantity * SalesLine."BOM Quantity Per";
                                SalesLine.VALIDATE(Quantity, SalesLine.Quantity + ReservationEntry2.Quantity);//Changing original Sale Line Qty
                                SalesLine.SuspendStatusCheck(FALSE);
                                SalesLine.MODIFY;
                            END;
                            /*SalesLine2.INIT;
                            SalesLine2.TRANSFERFIELDS(SalesLine);
                            SalesLine2.INSERT;*/
                        END ELSE BEGIN  /*Here SO Qty is equal to qty reserved from transfer, when item
                            is replaced in TO it should be replaced in SO*/
                            Flag := 2;
                            WarehouseShipmentLine.RESET;
                            WarehouseShipmentLine.SETRANGE("Source No.", SalesLine."Document No.");
                            WarehouseShipmentLine.SETRANGE("Source Line No.", SalesLine."Line No.");
                            IF WarehouseShipmentLine.FINDFIRST THEN BEGIN
                                WarehouseShipmentLine2.COPY(WarehouseShipmentLine);
                                WarehouseShipmentLine.DELETE;
                                SalesLine.SuspendStatusCheck(TRUE);
                                ReservationEngineMgt.CancelReservation(ReservationEntry2);
                                UnitPrice := SalesLine."Unit Price";
                                CustomerSerialNo := SalesLine."Customer Serial No";
                                "BOM Item No" := SalesLine."BOM Item No";
                                "BOM Line NO" := SalesLine."BOM Main Line No.";
                                "BOM Quantity per" := SalesLine."BOM Quantity Per";
                                SalesLine.VALIDATE("No.", NewPartNo);
                                SalesLine.LastPartNumber := OldPartNo;
                                SalesLine.VALIDATE("Unit Price", UnitPrice);
                                SalesLine."Customer Serial No" := CustomerSerialNo;
                                SalesLine."BOM Item No" := "BOM Item No";
                                SalesLine."BOM Main Line No." := "BOM Line NO";
                                SalesLine."BOM Quantity Per" := "BOM Quantity per";
                                SalesLine.MODIFY;
                                SalesLine.SuspendStatusCheck(FALSE);
                                WarehouseShipmentHeader.GET(WarehouseShipmentLine2."No.");
                                WhseCreateSourceDocument.FromSalesLine2ShptLine(WarehouseShipmentHeader, SalesLine);
                            END ELSE BEGIN
                                SalesLine.SuspendStatusCheck(TRUE);
                                ReservationEngineMgt.CancelReservation(ReservationEntry2);
                                UnitPrice := SalesLine."Unit Price";
                                CustomerSerialNo := SalesLine."Customer Serial No";
                                "BOM Item No" := SalesLine."BOM Item No";
                                "BOM Line NO" := SalesLine."BOM Main Line No.";
                                "BOM Quantity per" := SalesLine."BOM Quantity Per";
                                SalesLine.VALIDATE("No.", NewPartNo);
                                SalesLine.LastPartNumber := OldPartNo;
                                SalesLine.VALIDATE("Unit Price", UnitPrice);
                                SalesLine."Customer Serial No" := CustomerSerialNo;
                                SalesLine."BOM Item No" := "BOM Item No";
                                SalesLine."BOM Main Line No." := "BOM Line NO";
                                SalesLine."BOM Quantity Per" := "BOM Quantity per";
                                SalesLine.MODIFY;
                                SalesLine.SuspendStatusCheck(FALSE);
                            END;
                        END;
                    END ELSE IF ReservationEntry2."Source Type" = 901 THEN BEGIN//For Assembly same as Sales

                        AssemblyLine.GET(ReservationEntry2."Source Subtype", ReservationEntry2."Source ID", ReservationEntry2."Source Ref. No.");
                        IF AssemblyLine.Quantity <> -ReservationEntry2.Quantity THEN BEGIN
                            Flag := 3;
                            AssemblyLine2.RESET;
                            AssemblyLine2.SETRANGE("Document Type", AssemblyLine2."Document Type"::Order);
                            AssemblyLine2.SETRANGE("Document No.", ReservationEntry2."Source ID");
                            IF AssemblyLine2.FINDLAST THEN;
                            AssemblyLine3.INIT;
                            AssemblyLine3.SuspendStatusCheck(TRUE);
                            //SalesLine3.TRANSFERFIELDS(SalesLine);
                            AssemblyLine3."Document Type" := AssemblyLine3."Document Type"::Order;
                            AssemblyLine3."Document No." := AssemblyLine."Document No.";
                            AssemblyLine3."Line No." := AssemblyLine2."Line No." + 1000;
                            AssemblyLine3.Type := AssemblyLine3.Type::Item;
                            AssemblyLine3.VALIDATE("No.", NewPartNo);
                            AssemblyLine3.LastPartNumber := OldPartNo;
                            AssemblyLine3.VALIDATE("Quantity per", -ReservationEntry2.Quantity / (AssemblyLine2.Quantity / AssemblyLine2."Quantity per"));

                            AssemblyLine3.SuspendStatusCheck(FALSE);
                            AssemblyLine3.INSERT;


                            /*WarehouseShipmentLine.RESET;
                            WarehouseShipmentLine.SETRANGE("Source No.",SalesLine."Document No.");
                            WarehouseShipmentLine.SETRANGE("Source Line No.",SalesLine."Line No.");
                            IF WarehouseShipmentLine.FINDFIRST THEN BEGIN
                              WarehouseShipmentLine2.COPY(WarehouseShipmentLine);
                              WarehouseShipmentLine.DELETE;

                              SalesLine.SuspendStatusCheck(TRUE);
                              ReservationEngineMgt.CancelReservation(ReservationEntry2);
                              SalesLine.VALIDATE(Quantity,SalesLine.Quantity+ReservationEntry2.Quantity);
                              SalesLine.SuspendStatusCheck(FALSE);
                              SalesLine.MODIFY;

                              WarehouseShipmentHeader.GET(WarehouseShipmentLine2."No.");
                              WhseCreateSourceDocument.FromSalesLine2ShptLine(WarehouseShipmentHeader,SalesLine);
                              WhseCreateSourceDocument.FromSalesLine2ShptLine(WarehouseShipmentHeader,SalesLine3);
                            END ELSE BEGIN    */
                            AssemblyLine.SuspendStatusCheck(TRUE);
                            ReservationEngineMgt.CancelReservation(ReservationEntry2);
                            AssemblyLine.VALIDATE("Quantity per", AssemblyLine."Quantity per" + ReservationEntry2.Quantity / (AssemblyLine.Quantity / AssemblyLine."Quantity per"));
                            AssemblyLine.SuspendStatusCheck(FALSE);
                            AssemblyLine.MODIFY;
                            //    END;
                            /*SalesLine2.INIT;
                            SalesLine2.TRANSFERFIELDS(SalesLine);
                            SalesLine2.INSERT;*/
                        END ELSE BEGIN
                            Flag := 4;
                            AssemblyLine.SuspendStatusCheck(TRUE);
                            ReservationEngineMgt.CancelReservation(ReservationEntry2);
                            AssemblyLine.VALIDATE("No.", NewPartNo);
                            AssemblyLine.LastPartNumber := OldPartNo;
                            AssemblyLine.MODIFY;
                            AssemblyLine.SuspendStatusCheck(FALSE);
                        END;
                    END;
                END;
            UNTIL ReservationEntry.NEXT = 0;
        WarehouseShipmentLine.RESET;
        IF Flag = 1 THEN
            EXIT(SalesLine3."Line No.");
        IF Flag = 2 THEN
            EXIT(SalesLine."Line No.");
        IF Flag = 3 THEN
            EXIT(AssemblyLine3."Line No.");
        IF Flag = 4 THEN
            EXIT(AssemblyLine."Line No.");

    end;
}

