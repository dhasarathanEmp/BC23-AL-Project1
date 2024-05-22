codeunit 50032 "One to One TO Against SO"
{
    // EP9625 Insert Transfer Header and Transfer Lines against the stock request


    trigger OnRun()
    begin
    end;

    var
        SalesHeader1: Record "Sales Header";
        SalesLine: Record "Sales Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        SalesLine1: Record "Sales Line";
        LineNo: Integer;
        HeaderControll: Integer;
        TransferOrderNumber: Code[30];
        intranscode: Code[30];
        TransferRoute: Record "Transfer Route";
        ReservEntry: Record "Reservation Entry";
        ReservMgt: Codeunit "Reservation Management";
        SalesLine2: Record "Sales Line";
        TransferLine2: Record "Transfer Line";
        QtyToReserve: Decimal;
        QtyToReserveBase: Decimal;
        QtyReservedThisLine: Decimal;
        QtyReservedThisLineBase: Decimal;
        Direction: Option Outbound,Inbound;
        NewQtyReservedThisLine: Decimal;
        NewQtyReservedThisLineBase: Decimal;
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry1: Record "Reservation Entry";
        Item: Record "Item";
        AssembletoOrderLink: Record "Assemble-to-Order Link";
        AssemblyLine: Record "Assembly Line";
        Location: Record "Location";
        Item1: Record "Item";
        Location1: Record "Location";
        //StockRequestLine: Record "60048";
        LoopControl: Integer;
        StockRequestTONumber: Code[30];

    procedure "Create TO Against SO"(DocumentNo: Code[30])
    begin
        TransferOrderNumber := '';
        CLEAR(NoSeriesMgt);
        TransferOrderNumber := NoSeriesMgt.GetNextNo('T-TO', 0D, TRUE);
        HeaderControll := 1;
        SalesLine.RESET;
        SalesLine.SETRANGE("Document No.", DocumentNo);
        SalesLine.SETFILTER("Outstanding Quantity", '>%1', 0);
        SalesLine.SETFILTER("Location Code", '<>%1', 'HOD-HO');
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        IF SalesLine.FINDSET THEN
            REPEAT
                Item1.GET(SalesLine."No.");
                IF Item1.Type = Item1.Type::Inventory THEN BEGIN
                    SalesLine.CALCFIELDS("Reserved Quantity");
                    IF SalesLine."Qty. to Assemble to Order" > 0 THEN BEGIN
                        LineNo := 10000;
                        AssembletoOrderLink.RESET;
                        AssembletoOrderLink.SETRANGE("Document No.", DocumentNo);
                        AssembletoOrderLink.SETRANGE("Document Line No.", SalesLine."Line No.");
                        AssembletoOrderLink.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                        IF AssembletoOrderLink.FINDFIRST THEN BEGIN
                            AssemblyLine.RESET;
                            AssemblyLine.SETRANGE("Document No.", AssembletoOrderLink."Assembly Document No.");
                            AssemblyLine.SETRANGE("Document Type", AssembletoOrderLink."Assembly Document Type");
                            AssemblyLine.SETRANGE(Type, AssemblyLine.Type::Item);
                            IF AssemblyLine.FINDSET THEN
                                REPEAT
                                    AssemblyLine.CALCFIELDS("Reserved Quantity");
                                    IF (AssemblyLine.Quantity - AssemblyLine."Consumed Quantity") > AssemblyLine."Reserved Quantity" THEN BEGIN
                                        // Creating Transfer lines against Assembly order lines
                                        IF HeaderControll = 1 THEN
                                            "Insert Transfer Header"(DocumentNo);
                                        TransferLine."Document No." := TransferOrderNumber;
                                        TransferLine."In-Transit Code" := intranscode;
                                        TransferLine."Line No." += LineNo;
                                        TransferLine."Item No." := AssemblyLine."No.";
                                        TransferLine.VALIDATE("Item No.");
                                        TransferLine."ShippedQty." := AssemblyLine.Quantity - AssemblyLine."Reserved Quantity";
                                        TransferLine.VALIDATE("ShippedQty.");
                                        TransferLine."Shipment Date" := SalesLine."Shipment Date";
                                        TransferLine.VALIDATE("Shipment Date");
                                        TransferLine."Receipt Date" := SalesLine."Shipment Date";
                                        TransferLine.VALIDATE("Receipt Date");
                                        TransferLine."Sales Order Number" := AssemblyLine."Document No.";
                                        TransferLine."Sales Line No" := AssemblyLine."Line No.";
                                        TransferLine.INSERT();
                                    END;
                                //Assembly Line creation end
                                UNTIL AssemblyLine.NEXT = 0;
                        END;
                    END ELSE IF SalesLine."Outstanding Quantity" > SalesLine."Reserved Quantity" THEN BEGIN
                        IF HeaderControll = 1 THEN
                            "Insert Transfer Header"(DocumentNo);
                        LineNo := 10000;
                        // Creating Trasnfer Lines against Sale Lines
                        TransferLine."Document No." := TransferOrderNumber;
                        TransferLine."In-Transit Code" := intranscode;
                        TransferLine."Line No." += LineNo;
                        TransferLine."Item No." := SalesLine."No.";
                        TransferLine.VALIDATE("Item No.");
                        TransferLine."Unit of Measure" := SalesLine."Unit of Measure";
                        TransferLine.VALIDATE("Unit of Measure");
                        TransferLine."Unit of Measure Code" := SalesLine."Unit of Measure Code";
                        TransferLine.VALIDATE("Unit of Measure Code");
                        TransferLine."ShippedQty." := SalesLine.Quantity - SalesLine."Reserved Quantity";
                        TransferLine.VALIDATE("ShippedQty.");
                        TransferLine."Shipment Date" := SalesLine."Shipment Date";
                        TransferLine.VALIDATE("Shipment Date");
                        TransferLine."Receipt Date" := SalesLine."Shipment Date";
                        TransferLine.VALIDATE("Receipt Date");
                        TransferLine."Sales Order Number" := SalesLine."Document No.";
                        TransferLine."Sales Line No" := SalesLine."Line No.";
                        TransferLine."Item Category Code" := SalesLine."Item Category Code";
                        TransferLine.INSERT();
                        //Sales line creation end
                    END;
                END;
            UNTIL SalesLine.NEXT = 0;
        IF HeaderControll > 1 THEN BEGIN
            COMMIT;
            ReserveTOfromSO;
            MESSAGE(' Transfer Order %1 has been created against %2 and Reservation also been completed', TransferOrderNumber, DocumentNo);
        END
    end;

    local procedure "Insert Transfer Header"(SONumber: Code[30])
    begin
        HeaderControll += 1;
        SalesHeader1.RESET;
        SalesHeader1.SETRANGE("Document Type", SalesHeader1."Document Type"::Order);
        SalesHeader1.SETRANGE("No.", SONumber);
        IF SalesHeader1.FINDFIRST THEN BEGIN
            TransferHeader."No." := TransferOrderNumber;
            TransferHeader.Status := TransferHeader.Status::Open;
            //TransferHeader."Transfer-from Code" := 'HOD-HO';
            TransferHeader.VALIDATE("Transfer-from Code", 'HOD-HO');
            TransferHeader."Transfer-to Code" := SalesHeader1."Location Code";
            TransferHeader.VALIDATE("Transfer-to Code");
            Location.RESET;
            Location.SETRANGE(Code, 'HOD-HO');
            IF Location.FINDFIRST THEN BEGIN
                TransferHeader."Transfer-from Name" := Location.Name;
                //TransferHeader."Transfer-from Name 2" := Location."T.R.No";
                TransferHeader."Transfer-from Address" := Location.Address;
                TransferHeader."Transfer-from Address 2" := Location."Address 2";
                TransferHeader."Transfer-from Post Code" := Location."Post Code";
                TransferHeader."Transfer-from City" := Location.City;
                TransferHeader."Transfer-from County" := Location.County;
                TransferHeader."Trsf.-from Country/Region Code" := Location."Country/Region Code";
                TransferHeader."Transfer-from Contact" := Location.Contact;
            END;
            Location1.RESET;
            Location1.SETRANGE(Code, SalesHeader1."Location Code");
            IF Location1.FINDFIRST THEN BEGIN
                TransferHeader."Transfer-to Name" := Location1.Name;
                //TransferHeader."Transfer-to Name 2" := Location1."T.R.No";
                TransferHeader."Transfer-to Address" := Location1.Address;
                TransferHeader."Transfer-to Address 2" := Location1."Address 2";
                TransferHeader."Transfer-to Post Code" := Location1."Post Code";
                TransferHeader."Transfer-to City" := Location1.City;
                TransferHeader."Transfer-to Contact" := Location1."Phone No.";
                TransferHeader."Transfer-to Fax No" := Location1."Fax No.";
                TransferHeader."Transfer-to County" := Location1.County;
                TransferHeader."Trsf.-to Country/Region Code" := Location1."Country/Region Code";
                TransferHeader."Transfer-to Contact" := Location1.Contact;
            END;
            TransferRoute.RESET;
            TransferRoute.SETRANGE("Transfer-from Code", 'HOD-HO');
            TransferRoute.SETRANGE("Transfer-to Code", SalesHeader1."Location Code");
            IF TransferRoute.FINDFIRST THEN
                TransferHeader."In-Transit Code" := TransferRoute."In-Transit Code";
            intranscode := TransferHeader."In-Transit Code";
            TransferHeader."Shipment Date" := SalesHeader1."Shipment Date";
            TransferHeader."Receipt Date" := SalesHeader1."Shipment Date";
            TransferHeader."Sales Order Number" := SONumber;
            //
            //TransferHeader."Agency Code" := SalesHeader1."Agency Code";
            //
            TransferHeader.INSERT;
        END
    end;

    local procedure ReserveTOfromSO()
    var
        TransferLineReserv: Record "Transfer Line";
        TransferLineReserveMan: Codeunit "Transfer Line-Reserve";
    begin
        // Sales line Reservation
        TransferLineReserv.RESET;
        TransferLineReserv.SETRANGE("Document No.", TransferOrderNumber);
        TransferLineReserv.SETRANGE("Transfer-from Code", TransferHeader."Transfer-from Code");
        TransferLineReserv.SETFILTER("Sales Order Number", 'SO*');
        IF TransferLineReserv.FINDSET THEN
            REPEAT
            //TransferLineReserveMan.CreateReservationSetFrom2(37,1,TransferLineReserv."Sales Order Number",TransferLineReserv."Sales Line No",TransferLineReserv."Item No.",TransferLineReserv."Transfer-to Code",TransferLineReserv."Qty. per Unit of Measure");
            //TransferLineReserveMan.CreateReservation(TransferLineReserv,TransferLineReserv.Description,TransferLineReserv."Receipt Date",TransferLineReserv.Quantity,TransferLineReserv."Quantity (Base)",'','',1);
            UNTIL TransferLineReserv.NEXT = 0;

        // Assembly Line Reservation
        TransferLineReserv.RESET;
        TransferLineReserv.SETRANGE("Document No.", TransferOrderNumber);
        TransferLineReserv.SETRANGE("Transfer-from Code", TransferHeader."Transfer-from Code");
        TransferLineReserv.SETFILTER("Sales Order Number", 'AO*');
        IF TransferLineReserv.FINDSET THEN
            REPEAT
            //TransferLineReserveMan.CreateReservationSetFrom2(901,1,TransferLineReserv."Sales Order Number",TransferLineReserv."Sales Line No",TransferLineReserv."Item No.",TransferLineReserv."Transfer-to Code",TransferLineReserv."Qty. per Unit of Measure");
            //TransferLineReserveMan.CreateReservation(TransferLineReserv,TransferLineReserv.Description,TransferLineReserv."Receipt Date",TransferLineReserv.Quantity,TransferLineReserv."Quantity (Base)",'','',1);
            UNTIL TransferLineReserv.NEXT = 0;
    end;

    /*  [Scope('Personalization')]
      procedure "Create TO Against Stock Request"(StockRequestID: Code[30])
      begin
          //EP9625 Insert Transfer Header and Transfer Lines against the stock request
          LoopControl :=0;
          LineNo := 10000;
          StockRequestTONumber :='';
          CLEAR(NoSeriesMgt);
          StockRequestTONumber := NoSeriesMgt.GetNextNo('T-TO',0D,TRUE);
          StockRequestLine.RESET;
          StockRequestLine.SETRANGE("Stock Request No.",StockRequestID);
          IF StockRequestLine.FINDSET THEN REPEAT
            IF LoopControl =0 THEN BEGIN
              TransferHeader."No." := StockRequestTONumber;
              TransferHeader.Status := TransferHeader.Status::Open;
              TransferHeader.VALIDATE("Transfer-from Code",'HOD-HO');
              TransferHeader."Transfer-to Code" := StockRequestLine."Location Code";
              TransferHeader.VALIDATE("Transfer-to Code");
              Location1.RESET;
              Location1.SETRANGE(Code,StockRequestLine."Location Code");
              IF Location1.FINDFIRST THEN BEGIN
                TransferHeader."Transfer-to Name" := Location1.Name;
                TransferHeader."Transfer-to Name 2" := Location1."T.R.No";
                TransferHeader."Transfer-to Address" := Location1.Address;
                TransferHeader."Transfer-to Address 2" := Location1."Address 2";
                TransferHeader."Transfer-to Post Code" := Location1."Post Code";
                TransferHeader."Transfer-to City" := Location1.City;
                TransferHeader."Transfer-to Contact" := Location1."Phone No.";
                TransferHeader."Transfer-to Fax No":=Location1."Fax No.";
                TransferHeader."Transfer-to County" := Location1.County;
                TransferHeader."Trsf.-to Country/Region Code" := Location1."Country/Region Code";
                TransferHeader."Transfer-to Contact" := Location1.Contact;
              END;
              TransferRoute.RESET;
              TransferRoute.SETRANGE("Transfer-from Code",'HOD-HO');
              TransferRoute.SETRANGE("Transfer-to Code",StockRequestLine."Location Code");
              IF TransferRoute.FINDFIRST THEN
                TransferHeader."In-Transit Code" := TransferRoute."In-Transit Code";
              intranscode := TransferHeader."In-Transit Code";
              TransferHeader."Shipment Date" := StockRequestLine."Requested Date";
              TransferHeader."Receipt Date" := StockRequestLine."Requested Date";
              TransferHeader."Sales Order Number" := StockRequestID;
              TransferHeader."Agency Code" := StockRequestLine."Agency Code";
              TransferHeader.INSERT;

              LoopControl :=1;
              TransferLine."Document No." := StockRequestTONumber;
              TransferLine."In-Transit Code" := intranscode;
              TransferLine."Line No." += LineNo;
              TransferLine."Item No." := StockRequestLine."Item No.";
              TransferLine.VALIDATE("Item No.");
              TransferLine."Unit of Measure" := StockRequestLine."UoM Desc";
              TransferLine.VALIDATE("Unit of Measure");
              TransferLine."Unit of Measure Code" := StockRequestLine.UoM;
              TransferLine.VALIDATE("Unit of Measure Code");
              TransferLine."ShippedQty." := StockRequestLine.Quantity;
              TransferLine.VALIDATE("ShippedQty.");
              TransferLine."Shipment Date" := StockRequestLine."Requested Date";
              TransferLine.VALIDATE("Shipment Date");
              TransferLine."Receipt Date" := StockRequestLine."Requested Date";
              TransferLine.VALIDATE("Receipt Date");
              TransferLine."Sales Order Number" := StockRequestID;
              TransferLine."Sales Line No" := StockRequestLine."Line No.";
              TransferLine."Item Category Code" := StockRequestLine."Agency Code";
              TransferLine.INSERT();
            END ELSE BEGIN
              TransferLine."Document No." := StockRequestTONumber;
              TransferLine."In-Transit Code" := intranscode;
              TransferLine."Line No." += LineNo;
              TransferLine."Item No." := StockRequestLine."Item No.";
              TransferLine.VALIDATE("Item No.");
              TransferLine."Unit of Measure" := StockRequestLine."UoM Desc";
              TransferLine.VALIDATE("Unit of Measure");
              TransferLine."Unit of Measure Code" := StockRequestLine.UoM;
              TransferLine.VALIDATE("Unit of Measure Code");
              TransferLine."ShippedQty." := StockRequestLine.Quantity;
              TransferLine.VALIDATE("ShippedQty.");
              TransferLine."Shipment Date" := StockRequestLine."Requested Date";
              TransferLine.VALIDATE("Shipment Date");
              TransferLine."Receipt Date" := StockRequestLine."Requested Date";
              TransferLine.VALIDATE("Receipt Date");
              TransferLine."Sales Order Number" := StockRequestID;
              TransferLine."Sales Line No" := StockRequestLine."Line No.";
              TransferLine."Item Category Code" := StockRequestLine."Agency Code";
              TransferLine.INSERT();
            END;
            StockRequestLine.Status := StockRequestLine.Status::Released;
            StockRequestLine."Transfer Order No." := StockRequestTONumber;
            StockRequestLine.MODIFY;
          UNTIL StockRequestLine.NEXT=0;
          IF StockRequestTONumber <> '' THEN
            COMMIT;
          MESSAGE('Against the Stock Request %1 transfer order %2 has been created',StockRequestID,StockRequestTONumber);

          //EP9625 Insert Transfer Header and Transfer Lines against the stock request
      end;*/
}

