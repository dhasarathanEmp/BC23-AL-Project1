codeunit 50058 GetHOOrders
{
    // EMP108.21 - Document type item only come in requision line


    trigger OnRun()
    begin
    end;

    var
        TransferLine: Record "Transfer Line";
        RequisitionLine: Record "Requisition Line";
        TransferHeader: Record "Transfer Header";
        RequisitionLine2: Record "Requisition Line";
        Item: Record "Item";
        TransHeadNo: Code[20];
        StockkeepingUnit: Record "Stockkeeping Unit";
        ReqLinkMaintainance: Record "Req Link Maintainance";
        Reservation: Page "Reservation";
        SalesLine: Record "Sales Line";
        RequisitionLine3: Record "Requisition Line";
        SalesHeader: Record "Sales Header";
        RequisitionLine4: Record "Requisition Line";
        Item2: Record "Item";
        SalesHeadNo: Code[20];
        StockkeepingUnit2: Record "Stockkeeping Unit";
        ReqLinkMaintainance2: Record "Req Link Maintainance";
        Reservation2: Page Reservation;
        ReqLinkMaintainance3: Record "Req Link Maintainance";
        ReqLinkMaintainance4: Record "Req Link Maintainance";
        SNo1: Integer;
        SNo2: Integer;
        AssembletoOrderLink: Record "Assemble-to-Order Link";
        AssemblyLine: Record "Assembly Line";
        CompanyInformation: Record "Company Information";
        ReservMgt: Codeunit "Reservation Management";
        ReservMgt2: Codeunit "Reservation Management";

    procedure GetHOOrders(var TransferHeaderOrg: Record "Transfer Header")
    var
        RemQtytoRes: Decimal;
        RemQtytoResBase: Decimal;
    begin
        WITH TransferHeaderOrg DO
            IF FINDSET THEN
                REPEAT
                    TransHeadNo := TransferHeaderOrg."No.";

                    TransferLine.RESET;
                    TransferLine.SETRANGE("Document No.", TransHeadNo);
                    TransferLine.SETRANGE("Transfer-from Code", TransferHeaderOrg."Transfer-from Code");

                    ReqLinkMaintainance3.RESET;
                    IF ReqLinkMaintainance3.FINDLAST THEN
                        SNo1 := ReqLinkMaintainance3."S.No"
                    ELSE
                        SNo1 := 0;

                    IF TransferLine.FINDSET THEN
                        REPEAT
                            //Reserving Trans Lines from stock before pulling remaining qty to req.
                            TransferLine.CALCFIELDS("Reserved Quantity Outbnd.", "Reserved Qty. Outbnd. (Base)");
                            RemQtytoRes := TransferLine."Outstanding Quantity" - TransferLine."Reserved Quantity Outbnd.";
                            RemQtytoResBase := TransferLine."Outstanding Qty. (Base)" - TransferLine."Reserved Qty. Outbnd. (Base)";
                            CLEAR(ReservMgt);
                            ReservMgt.SetReservSource(TransferLine, Enum::"Transfer Direction"::Outbound);
                            ReservMgt.AutoReserveOneLine(1, RemQtytoRes, RemQtytoResBase, '', TransferLine."Shipment Date");
                            //Reserving Trans Lines from stock before pulling remaining qty to req.
                            TransferLine.CALCFIELDS("Reserved Quantity Outbnd.");
                            IF TransferLine."Outstanding Quantity" > TransferLine."Reserved Quantity Outbnd." THEN BEGIN
                                RequisitionLine.RESET;
                                RequisitionLine.SETRANGE("No.", TransferLine."Item No.");
                                RequisitionLine.SETRANGE("Worksheet Template Name", 'REQ.');
                                RequisitionLine.SETRANGE("Journal Batch Name", 'DEFAULT');
                                RequisitionLine.SETRANGE("Unit of Measure Code", TransferLine."Unit of Measure Code");
                                IF RequisitionLine.FINDFIRST THEN BEGIN//Increase Qty, change due date if item exists in req
                                    RequisitionLine.Quantity += (TransferLine."Outstanding Quantity" - TransferLine."Reserved Quantity Outbnd.");
                                    IF RequisitionLine."Due Date" > TransferLine."Shipment Date" THEN
                                        RequisitionLine."Due Date" := TransferLine."Shipment Date";
                                    RequisitionLine.MODIFY;
                                END ELSE BEGIN
                                    RequisitionLine.INIT;
                                    RequisitionLine2.RESET;
                                    RequisitionLine."Worksheet Template Name" := 'REQ.';
                                    RequisitionLine."Journal Batch Name" := 'DEFAULT';
                                    IF RequisitionLine2.FINDLAST THEN
                                        RequisitionLine."Line No." := RequisitionLine2."Line No." + 1000
                                    ELSE
                                        RequisitionLine."Line No." := 10000;
                                    RequisitionLine.Type := RequisitionLine.Type::Item;
                                    RequisitionLine.VALIDATE("No.", TransferLine."Item No.");
                                    RequisitionLine."Action Message" := RequisitionLine."Action Message"::New;
                                    RequisitionLine.VALIDATE("Location Code", TransferLine."Transfer-from Code");
                                    RequisitionLine.VALIDATE("Replenishment System", RequisitionLine."Replenishment System"::Purchase);
                                    Item.GET(TransferLine."Item No.");
                                    RequisitionLine.VALIDATE("Vendor No.", Item."Vendor No.");
                                    RequisitionLine.VALIDATE(Quantity, TransferLine."Outstanding Quantity" - TransferLine."Reserved Quantity Outbnd.");
                                    RequisitionLine.VALIDATE("Unit of Measure Code", TransferLine."Unit of Measure Code");
                                    RequisitionLine."Due Date" := TransferLine."Shipment Date";
                                    RequisitionLine.INSERT;
                                END;
                                //Update Link with demand will be used later for reservation
                                SNo1 += 1;
                                ReqLinkMaintainance."S.No" := SNo1;
                                ReqLinkMaintainance."Req Line No." := RequisitionLine."Line No.";
                                ReqLinkMaintainance."Demand Source No." := TransferLine."Document No.";
                                ReqLinkMaintainance."Demand Source Ref No." := TransferLine."Line No.";
                                ReqLinkMaintainance."Demand Required Qty" := TransferLine."Outstanding Quantity" - TransferLine."Reserved Quantity Outbnd.";
                                ReqLinkMaintainance."Item No." := RequisitionLine."No.";
                                ReqLinkMaintainance.Description := RequisitionLine.Description;
                                ReqLinkMaintainance.INSERT;
                            END;
                        UNTIL TransferLine.NEXT = 0;
                UNTIL NEXT = 0;

        RequisitionLine.RESET;
        IF RequisitionLine.FINDSET THEN
            REPEAT
                StockkeepingUnit.SETRANGE("Item No.", RequisitionLine."No.");
                StockkeepingUnit.SETRANGE("Location Code", RequisitionLine."Location Code");
                StockkeepingUnit.SETRANGE("Variant Code", RequisitionLine."Variant Code");
                StockkeepingUnit.SETFILTER("Order Multiple", '<>%1', 0);
                IF StockkeepingUnit.FINDFIRST THEN BEGIN
                    IF (RequisitionLine.Quantity / StockkeepingUnit."Order Multiple") <> ROUND(RequisitionLine.Quantity / StockkeepingUnit."Order Multiple", 1, '>') THEN BEGIN
                        RequisitionLine.Quantity := StockkeepingUnit."Order Multiple" * ROUND(RequisitionLine.Quantity / StockkeepingUnit."Order Multiple", 1, '>');
                        RequisitionLine.VALIDATE(Quantity);
                        RequisitionLine.MODIFY;
                    END;
                END;
            UNTIL RequisitionLine.NEXT = 0;
    end;

    procedure GetHOSaleOrders(var SaleHeaderOrg: Record "Sales Header")
    var
        RemQtytoRes2: Decimal;
        RemQtytoResBase2: Decimal;
    begin
        WITH SaleHeaderOrg DO
            IF FINDSET THEN
                REPEAT
                    SalesHeadNo := SaleHeaderOrg."No.";
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document No.", SalesHeadNo);
                    //EMP108.21
                    SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                    //EMP108.21
                    ReqLinkMaintainance4.RESET;
                    IF ReqLinkMaintainance4.FINDLAST THEN
                        SNo2 := ReqLinkMaintainance4."S.No"
                    ELSE
                        SNo2 := 0;
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            SalesLine.CALCFIELDS("Reserved Quantity", "Reserved Qty. (Base)");
                            RemQtytoRes2 := SalesLine."Outstanding Quantity" - SalesLine."Reserved Quantity";
                            RemQtytoResBase2 := SalesLine."Outstanding Qty. (Base)" - SalesLine."Reserved Qty. (Base)";
                            CLEAR(ReservMgt2);
                            ReservMgt2.SetReservSource(SalesLine);
                            ReservMgt2.AutoReserveOneLine(1, RemQtytoRes2, RemQtytoResBase2, '', SalesLine."Shipment Date");
                            SalesLine.CALCFIELDS("Reserved Quantity");
                            IF SalesLine."Outstanding Quantity" > SalesLine."Reserved Quantity" THEN BEGIN
                                RequisitionLine3.RESET;
                                RequisitionLine3.SETRANGE("No.", SalesLine."No.");
                                RequisitionLine3.SETRANGE("Worksheet Template Name", 'REQ.');
                                RequisitionLine3.SETRANGE("Journal Batch Name", 'DEFAULT');
                                IF RequisitionLine3.FINDFIRST THEN BEGIN
                                    RequisitionLine3.Quantity += SalesLine."Outstanding Quantity" - SalesLine."Reserved Quantity";
                                    IF SalesLine."Shipment Date" < RequisitionLine3."Due Date" THEN
                                        RequisitionLine3."Due Date" := SalesLine."Shipment Date";
                                    RequisitionLine3.MODIFY;
                                END ELSE BEGIN
                                    RequisitionLine3.INIT;
                                    RequisitionLine4.RESET;
                                    RequisitionLine3."Worksheet Template Name" := 'REQ.';
                                    RequisitionLine3."Journal Batch Name" := 'DEFAULT';
                                    IF RequisitionLine4.FINDLAST THEN
                                        RequisitionLine3."Line No." := RequisitionLine4."Line No." + 1000
                                    ELSE
                                        RequisitionLine3."Line No." := 10000;
                                    RequisitionLine3.Type := RequisitionLine3.Type::Item;
                                    RequisitionLine3.VALIDATE("No.", SalesLine."No.");
                                    RequisitionLine3."Action Message" := RequisitionLine3."Action Message"::New;
                                    CompanyInformation.RESET;
                                    IF CompanyInformation.FINDFIRST THEN
                                        IF NOT CompanyInformation.AFZ THEN
                                            RequisitionLine3.VALIDATE("Location Code", SalesLine."Location Code")
                                        ELSE
                                            RequisitionLine3.VALIDATE("Location Code", SalesLine."Location Code");
                                    RequisitionLine3.VALIDATE("Replenishment System", RequisitionLine."Replenishment System"::Purchase);
                                    Item2.GET(SalesLine."No.");
                                    RequisitionLine3.VALIDATE("Vendor No.", Item2."Vendor No.");
                                    RequisitionLine3.VALIDATE(Quantity, SalesLine."Outstanding Quantity" - SalesLine."Reserved Quantity");
                                    RequisitionLine3."Due Date" := SalesLine."Shipment Date";
                                    RequisitionLine3.VALIDATE("Unit of Measure Code", SalesLine."Unit of Measure Code");
                                    RequisitionLine3.INSERT;
                                END;
                                SNo2 += 1;
                                ReqLinkMaintainance2."S.No" := SNo2;
                                ReqLinkMaintainance2."Req Line No." := RequisitionLine3."Line No.";
                                ReqLinkMaintainance2."Demand Source No." := SalesLine."Document No.";
                                ReqLinkMaintainance2."Demand Source Ref No." := SalesLine."Line No.";
                                ReqLinkMaintainance2."Demand Required Qty" := SalesLine."Outstanding Quantity" - SalesLine."Reserved Quantity";
                                ReqLinkMaintainance2."Item No." := RequisitionLine3."No.";
                                ReqLinkMaintainance2.Description := RequisitionLine3.Description;
                                ReqLinkMaintainance2.INSERT;
                            END;
                        UNTIL SalesLine.NEXT = 0;
                    AssembletoOrderLink.RESET;
                    AssembletoOrderLink.SETRANGE("Document Type", AssembletoOrderLink."Document Type"::Order);
                    AssembletoOrderLink.SETRANGE("Document No.", SaleHeaderOrg."No.");
                    IF AssembletoOrderLink.FINDSET THEN
                        REPEAT
                            AssemblyLine.RESET;
                            AssemblyLine.SETRANGE("Document Type", AssemblyLine."Document Type"::Order);
                            AssemblyLine.SETRANGE("Document No.", AssembletoOrderLink."Assembly Document No.");
                            AssemblyLine.SETRANGE(Type, AssemblyLine.Type::Item);
                            IF AssemblyLine.FINDSET THEN
                                REPEAT
                                    AssemblyLine.CALCFIELDS("Reserved Quantity", "Reserved Qty. (Base)");
                                    IF AssemblyLine.Quantity - AssemblyLine."Consumed Quantity" > AssemblyLine."Reserved Quantity" THEN BEGIN
                                        RemQtytoRes2 := AssemblyLine.Quantity - AssemblyLine."Consumed Quantity" - AssemblyLine."Reserved Quantity";
                                        RemQtytoResBase2 := AssemblyLine."Quantity (Base)" - AssemblyLine."Consumed Quantity (Base)" - AssemblyLine."Reserved Qty. (Base)";
                                        CLEAR(ReservMgt2);
                                        ReservMgt2.SetReservSource(AssemblyLine);
                                        ReservMgt2.AutoReserveOneLine(1, RemQtytoRes2, RemQtytoResBase2, '', AssemblyLine."Due Date");
                                    END;
                                    AssemblyLine.CALCFIELDS("Reserved Quantity");
                                    IF ((AssemblyLine.Quantity - AssemblyLine."Consumed Quantity") > AssemblyLine."Reserved Quantity") THEN BEGIN
                                        RequisitionLine3.RESET;
                                        RequisitionLine3.SETRANGE("No.", AssemblyLine."No.");
                                        RequisitionLine3.SETRANGE("Worksheet Template Name", 'REQ.');
                                        RequisitionLine3.SETRANGE("Journal Batch Name", 'DEFAULT');
                                        IF RequisitionLine3.FINDFIRST THEN BEGIN
                                            RequisitionLine3.Quantity += ((AssemblyLine.Quantity - AssemblyLine."Consumed Quantity") - AssemblyLine."Reserved Quantity");
                                            IF AssemblyLine."Due Date" < RequisitionLine3."Due Date" THEN
                                                RequisitionLine3."Due Date" := AssemblyLine."Due Date";
                                            RequisitionLine3.MODIFY;
                                        END ELSE BEGIN
                                            RequisitionLine3.INIT;
                                            RequisitionLine4.RESET;
                                            RequisitionLine3."Worksheet Template Name" := 'REQ.';
                                            RequisitionLine3."Journal Batch Name" := 'DEFAULT';
                                            IF RequisitionLine4.FINDLAST THEN
                                                RequisitionLine3."Line No." := RequisitionLine4."Line No." + 1000
                                            ELSE
                                                RequisitionLine3."Line No." := 10000;
                                            RequisitionLine3.Type := RequisitionLine3.Type::Item;
                                            RequisitionLine3.VALIDATE("No.", AssemblyLine."No.");
                                            RequisitionLine3."Action Message" := RequisitionLine3."Action Message"::New;
                                            CompanyInformation.RESET;
                                            IF CompanyInformation.FINDFIRST THEN
                                                IF NOT CompanyInformation.AFZ THEN
                                                    RequisitionLine3.VALIDATE("Location Code", AssemblyLine."Location Code")
                                                ELSE
                                                    RequisitionLine3.VALIDATE("Location Code", AssemblyLine."Location Code");
                                            RequisitionLine3.VALIDATE("Replenishment System", RequisitionLine."Replenishment System"::Purchase);
                                            Item2.GET(AssemblyLine."No.");
                                            RequisitionLine3.VALIDATE("Vendor No.", Item2."Vendor No.");
                                            RequisitionLine3.VALIDATE(Quantity, (AssemblyLine.Quantity - AssemblyLine."Consumed Quantity") - AssemblyLine."Reserved Quantity");
                                            RequisitionLine3."Due Date" := AssemblyLine."Due Date";
                                            RequisitionLine3.INSERT;
                                        END;
                                        SNo2 += 1;
                                        ReqLinkMaintainance2."S.No" := SNo2;
                                        ReqLinkMaintainance2."Req Line No." := RequisitionLine3."Line No.";
                                        ReqLinkMaintainance2."Demand Source No." := AssemblyLine."Document No.";
                                        ReqLinkMaintainance2."Demand Source Ref No." := AssemblyLine."Line No.";
                                        ReqLinkMaintainance2."Demand Required Qty" := (AssemblyLine.Quantity - AssemblyLine."Consumed Quantity") - AssemblyLine."Reserved Quantity";
                                        ReqLinkMaintainance2."Item No." := RequisitionLine3."No.";
                                        ReqLinkMaintainance2.Description := RequisitionLine3.Description;
                                        ReqLinkMaintainance2.INSERT;
                                    END;
                                UNTIL AssemblyLine.NEXT = 0;
                        UNTIL AssembletoOrderLink.NEXT = 0;
                UNTIL NEXT = 0;

        RequisitionLine3.RESET;
        IF RequisitionLine3.FINDSET THEN
            REPEAT
                StockkeepingUnit2.SETRANGE("Item No.", RequisitionLine3."No.");
                CompanyInformation.RESET;
                IF CompanyInformation.FINDFIRST THEN
                    IF NOT CompanyInformation.AFZ THEN
                        StockkeepingUnit2.SETRANGE("Location Code", RequisitionLine3."Location Code")
                    ELSE
                        StockkeepingUnit2.SETRANGE("Location Code", RequisitionLine3."Location Code");
                StockkeepingUnit2.SETRANGE("Variant Code", RequisitionLine3."Variant Code");
                StockkeepingUnit2.SETFILTER("Order Multiple", '<>%1', 0);
                IF StockkeepingUnit2.FINDFIRST THEN BEGIN
                    IF (RequisitionLine3.Quantity / StockkeepingUnit2."Order Multiple") <> ROUND(RequisitionLine3.Quantity / StockkeepingUnit2."Order Multiple", 1, '>') THEN BEGIN
                        RequisitionLine3.Quantity := StockkeepingUnit2."Order Multiple" * ROUND(RequisitionLine3.Quantity / StockkeepingUnit2."Order Multiple", 1, '>');
                        RequisitionLine3.VALIDATE(Quantity);
                        RequisitionLine3.MODIFY;
                    END;
                END;
            UNTIL RequisitionLine3.NEXT = 0;
    end;
}

