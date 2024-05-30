pageextension 70016 ReqWorksheetExtn extends "Req. Worksheet"
{
    layout
    {
        // Add changes to page layout here
        modify("No.")
        {
            Editable = false;
        }
        modify(Quantity)
        {
            Editable = false;
        }
        modify("Direct Unit Cost")
        {
            Editable = false;
        }
        modify("Unit of Measure Code")
        {
            Editable = false;
        }
        addafter("Vendor No.")
        {
            field("Sales Order No"; Rec."Sales Order No")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        modify(CalculatePlan)
        {
            Enabled = NOT GetOrders;
            trigger OnAfterAction()
            var
            begin
                FindSaleOrder();
            end;
        }
        modify(CarryOutActionMessage)
        {
            trigger OnAfterAction()
            var

            begin
                if GetOrders then
                    ReservePurchase();
            end;
        }
        addafter(CalculatePlan)
        {
            action(GetOrder)
            {
                ApplicationArea = All;
                Caption = 'Get Order';
                Image = GetOrder;
                Enabled = GetOrders;

                trigger OnAction()
                var
                    GetSalesTransOrd: Report "GetSales. Trans-Orders";
                    SourceType: Integer;
                    PurchLoc: Code[20];
                    Agen: Code[20];
                    TransferHeader: Record "Transfer Header";
                    ReqTransLookup: Page ReqTransLookup;
                    SalesHeaderFil: Record "Sales Header";
                    ReqSalesLookup: Page ReqSalesLookup;
                begin
                    Clear(GetSalesTransOrd);
                    GetSalesTransOrd.RUNMODAL;
                    SourceType := GetSalesTransOrd.ReturnDemandType();
                    PurchLoc := GetSalesTransOrd.ReturnPurchLoc();
                    Agen := GetSalesTransOrd.ReturnAgencyCode();

                    IF SourceType = 0 THEN BEGIN
                        TransferHeader.RESET;
                        TransferHeader.SETRANGE("Transfer-from Code", PurchLoc);
                        TransferHeader.SETFILTER("Agency Code", '%1|%2', Agen, '');
                        ReqTransLookup.SETTABLEVIEW(TransferHeader);
                        ReqTransLookup.LOOKUPMODE := TRUE;
                        IF ReqTransLookup.RUNMODAL <> ACTION::Cancel THEN;
                    END ELSE BEGIN
                        SalesHeaderFil.RESET;
                        SalesHeaderFil.SETRANGE("Location Code", PurchLoc);
                        SalesHeaderFil.SETRANGE("Agency Code", Agen);
                        ReqSalesLookup.SETTABLEVIEW(SalesHeaderFil);
                        ReqSalesLookup.LOOKUPMODE := TRUE;
                        IF ReqSalesLookup.RUNMODAL <> ACTION::Cancel THEN;
                    END;
                    CurrPage.UPDATE;
                end;
            }
            action("Linked Demand")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    LinkedDemand: Record "Req Link Maintainance";
                begin
                    LinkedDemand.Reset();
                    LinkedDemand.SetRange("Req Line No.", Rec."Line No.");
                    IF LinkedDemand.FindSet() then;
                    Page.RunModal(0, LinkedDemand);
                end;
            }
            action("Change Vend No")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    OldVendNo: Code[20];
                    NewVendNo: Code[20];
                    VendorforVendCh: Record Vendor;
                    VendNoChangeProcessOnly: Report "Vend No Change ProcessOnly";
                    RequisitionLineVendCh: Record "Requisition Line";
                begin
                    CLEAR(VendNoChangeProcessOnly);
                    OldVendNo := '';
                    NewVendNo := '';
                    VendNoChangeProcessOnly.RUNMODAL;
                    OldVendNo := VendNoChangeProcessOnly."Return Old Vend No";
                    NewVendNo := VendNoChangeProcessOnly."Return New Vend No";
                    IF VendorforVendCh.GET(NewVendNo) THEN BEGIN
                        RequisitionLineVendCh.RESET;
                        RequisitionLineVendCh.SETRANGE("Vendor No.", OldVendNo);
                        IF RequisitionLineVendCh.FINDSET THEN
                            REPEAT
                                RequisitionLineVendCh."Vendor No." := NewVendNo;
                                RequisitionLineVendCh.MODIFY;
                            UNTIL RequisitionLineVendCh.NEXT = 0;
                        CLEAR(VendNoChangeProcessOnly);
                        OldVendNo := '';
                        NewVendNo := '';
                    END ELSE
                        ERROR('Vendor not available');
                end;
            }
            action("Calc AFZ Free Stock")
            {
                Caption = 'Calc AFZ Free Stock';
                Image = Calculate;

                trigger OnAction()
                var
                    AFZ_RequisitionLine: Record "Requisition Line";
                    AFZ_ItemLedger: Record "Item Ledger Entry";
                    AFZ_ReservationEntry: Record "Reservation Entry";
                    TempTableForAFZFreeStock: Record "Temp Table For AFZ Free Stock";
                    ForAFZ_PurchaseLine: Record "Purchase Line";
                    AFZ_StockkeepingUnit: Record "Stockkeeping Unit";
                    TempTableLineNo: Integer;
                    AFZ_AvailableStock: Integer;
                    AFZ_ReservedStock: Integer;
                    AFZ_UnReservedStock: Integer;
                    AFZUnresStockfromReq: Page "AFZ Unres Stock from Req.";
                begin
                    //EP9621 Calculating AFZ Free Stock for the items available in current PO
                    AFZ_RequisitionLine.RESET;
                    AFZ_RequisitionLine.SETRANGE("Item Category Code", 'CD');
                    AFZ_RequisitionLine.SETRANGE("Vendor No.", 'V000020');
                    IF AFZ_RequisitionLine.FINDFIRST THEN BEGIN
                        ERROR('For CAT Items Vendor Number should be other than V000020, Change the vendor number for the item %1 to proceed further', AFZ_RequisitionLine."No.")
                    END ELSE BEGIN
                        CLEAR(AFZ_ItemLedger);
                        CLEAR(AFZ_ReservationEntry);
                        AFZ_ItemLedger.CHANGECOMPANY('AFZ');
                        AFZ_ReservationEntry.CHANGECOMPANY('AFZ');
                        TempTableForAFZFreeStock.DELETEALL();
                        TempTableLineNo := 0;
                        AFZ_AvailableStock := 0;
                        AFZ_ReservedStock := 0;
                        AFZ_UnReservedStock := 0;
                        AFZ_RequisitionLine.RESET;
                        AFZ_RequisitionLine.SETFILTER("Line No.", '>%1', 0);
                        IF AFZ_RequisitionLine.FINDSET THEN
                            REPEAT
                                AFZ_ItemLedger.RESET;
                                AFZ_ItemLedger.SETRANGE("Item No.", AFZ_RequisitionLine."No.");
                                AFZ_ItemLedger.SETFILTER("Remaining Quantity", '>%1', 0);
                                AFZ_ItemLedger.CALCSUMS("Remaining Quantity");
                                AFZ_AvailableStock := AFZ_ItemLedger."Remaining Quantity";

                                AFZ_ReservationEntry.RESET;
                                AFZ_ReservationEntry.SETRANGE("Item No.", AFZ_RequisitionLine."No.");
                                AFZ_ReservationEntry.SETRANGE("Location Code", 'AFZ-HO');
                                AFZ_ReservationEntry.SETRANGE("Source Type", 32);
                                AFZ_ReservationEntry.SETRANGE("Source Subtype", 0);
                                AFZ_ReservationEntry.SETRANGE("Reservation Status", 0);
                                AFZ_ReservationEntry.CALCSUMS("Quantity (Base)");
                                AFZ_ReservedStock := AFZ_ReservationEntry."Quantity (Base)";

                                AFZ_UnReservedStock := AFZ_AvailableStock - AFZ_ReservedStock;
                                IF AFZ_UnReservedStock <> 0 THEN BEGIN
                                    TempTableForAFZFreeStock.RESET;
                                    TempTableForAFZFreeStock.LineNo := TempTableLineNo + 1;
                                    TempTableLineNo := TempTableForAFZFreeStock.LineNo;
                                    TempTableForAFZFreeStock."Item Number" := AFZ_RequisitionLine."No.";
                                    TempTableForAFZFreeStock."Item Description" := AFZ_RequisitionLine.Description;
                                    TempTableForAFZFreeStock.Quantity := AFZ_RequisitionLine.Quantity;
                                    TempTableForAFZFreeStock."Un Reserved Free Stock" := AFZ_UnReservedStock;
                                    TempTableForAFZFreeStock."Expected Receipt Date" := AFZ_RequisitionLine."Due Date";
                                    TempTableForAFZFreeStock."Dealer Net Price" := ForAFZ_PurchaseLine."Direct Unit Cost";
                                    TempTableForAFZFreeStock."Doc Line No" := AFZ_RequisitionLine."Line No.";
                                    TempTableForAFZFreeStock."Vednor No" := 'V000020';
                                    AFZ_StockkeepingUnit.RESET;
                                    AFZ_StockkeepingUnit.SETRANGE("Item No.", AFZ_RequisitionLine."No.");
                                    AFZ_StockkeepingUnit.SETRANGE("Location Code", AFZ_RequisitionLine."Location Code");
                                    IF AFZ_StockkeepingUnit.FINDFIRST THEN BEGIN
                                        IF AFZ_StockkeepingUnit."Order Multiple" = 0 THEN
                                            TempTableForAFZFreeStock."Order Multiple" := 1
                                        ELSE
                                            TempTableForAFZFreeStock."Order Multiple" := AFZ_StockkeepingUnit."Order Multiple";

                                    END;
                                    TempTableForAFZFreeStock.INSERT;
                                END;
                            UNTIL AFZ_RequisitionLine.NEXT = 0;
                        COMMIT;
                        CLEAR(AFZUnresStockfromReq);
                        AFZUnresStockfromReq.RUN;
                    END
                end;
            }
        }
        addafter(CalculatePlan_Promoted)
        {
            actionref(GetOrder_Promoted; GetOrder)
            {
            }
            actionref(LinkedDemand_Promoted; "Linked Demand")
            {
            }
            actionref(CalcAFZFreeStock_Promoted; "Calc AFZ Free Stock")
            {
            }
        }
        // Add changes to page actions here
    }

    procedure FindSaleOrder()
    var
        ReqLine: Record "Requisition Line";
        ResEntry: Record "Reservation Entry";
        ResEntry1: Record "Reservation Entry";
        ReqLineOut: Record "Requisition Line";
    begin
        ReqLine.RESET;
        ReqLine.SETRANGE("Worksheet Template Name", Rec."Worksheet Template Name");
        ReqLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        //ReqLine.SETRANGE("Replenishment System",ReqLine."Replenishment System"::Transfer);
        IF ReqLine.FINDSET THEN
            REPEAT
                ResEntry.RESET;
                ResEntry.SETRANGE("Source ID", ReqLine."Worksheet Template Name");
                ResEntry.SETRANGE("Source Batch Name", ReqLine."Journal Batch Name");
                ResEntry.SETRANGE("Source Ref. No.", ReqLine."Line No.");
                ResEntry.SETRANGE(Positive, TRUE);
                ReqLine."Sales Order No" := '';
                IF ResEntry.FINDSET THEN
                    REPEAT
                        ResEntry1.RESET;
                        IF ResEntry1.GET(ResEntry."Entry No.", FALSE) THEN BEGIN
                            IF (ResEntry1."Source Type" = 37) OR (ResEntry1."Source Type" = 901) OR (ResEntry1."Source Type" = 5741) THEN BEGIN  //Cu100
                                IF ReqLine."Sales Order No" = '' THEN
                                    ReqLine."Sales Order No" := ResEntry1."Source ID"
                                //Cu100
                                ELSE IF (STRPOS(ReqLine."Sales Order No", ResEntry1."Source ID") <> 0) THEN
                                    ReqLine."Sales Order No" := ReqLine."Sales Order No"
                                //Cu100
                                ELSE
                                    ReqLine."Sales Order No" += ',' + ResEntry1."Source ID";
                                //Cu100
                            END ELSE IF (ResEntry1."Source Type" = 246) THEN BEGIN
                                IF ReqLineOut.GET(ResEntry1."Source ID", ResEntry1."Source Batch Name", ResEntry1."Source Ref. No.") THEN BEGIN
                                    IF ReqLine."Sales Order No" = '' THEN
                                        ReqLine."Sales Order No" := ReqLineOut."Sales Order No"
                                    ELSE IF (STRPOS(ReqLine."Sales Order No", ReqLineOut."Sales Order No") <> 0) THEN
                                        ReqLine."Sales Order No" := ReqLine."Sales Order No"
                                    ELSE
                                        ReqLine."Sales Order No" += ',' + ReqLineOut."Sales Order No";
                                END;
                            END;
                            //Cu100
                        END;
                    UNTIL ResEntry.NEXT = 0;
                ReqLine.MODIFY;
            UNTIL ReqLine.NEXT = 0;
    end;

    trigger OnOpenPage()
    var
        PurchPaySetup: Record "Purchases & Payables Setup";
    begin
        PurchPaySetup.GetRecordOnce();
        if PurchPaySetup."Requisition Type" = PurchPaySetup."Requisition Type"::"Calculate Plan" then
            GetOrders := false
        else
            GetOrders := true;
    end;

    local procedure ReservePurchase()
    var
        ReqLinkMaintainance: Record "Req Link Maintainance";
        PurchaseLine: Record "Purchase Line";
        SalesLine: Record "Sales Line";
        TransferLine: Record "Transfer Line";
        AssemblyLine: Record "Assembly Line";
        ReservEntry: Record "Reservation Entry";
        TrackingSpecification: Record "Tracking Specification";
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
    begin
        ReqLinkMaintainance.RESET;
        IF ReqLinkMaintainance.FINDSET THEN
            REPEAT
                PurchaseLine.RESET;
                PurchaseLine.SETRANGE("Req Line No.", ReqLinkMaintainance."Req Line No.");
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.", ReqLinkMaintainance."Demand Source No.");
                SalesLine.SETRANGE("Line No.", ReqLinkMaintainance."Demand Source Ref No.");
                TransferLine.RESET;
                TransferLine.SETRANGE("Document No.", ReqLinkMaintainance."Demand Source No.");
                TransferLine.SETRANGE("Line No.", ReqLinkMaintainance."Demand Source Ref No.");
                AssemblyLine.RESET;
                AssemblyLine.SETRANGE("Document No.", ReqLinkMaintainance."Demand Source No.");
                AssemblyLine.SETRANGE("Line No.", ReqLinkMaintainance."Demand Source Ref No.");
                IF PurchaseLine.FINDLAST THEN BEGIN
                    IF TransferLine.FINDFIRST THEN BEGIN
                        //PurchLineReserve.CreateReservationSetFrom2(5741, 0, TransferLine."Document No.", TransferLine."Line No.", TransferLine."Item No.", TransferLine."Transfer-from Code", TransferLine."Qty. per Unit of Measure");
                        Clear(TrackingSpecification);
                        TrackingSpecification.InitFromTransLine(TransferLine, TransferLine."Shipment Date", Enum::"Transfer Direction"::Outbound);
                        PurchLineReserve.CreateReservationSetFrom(TrackingSpecification);
                        PurchLineReserve.CreateReservation(PurchaseLine, PurchaseLine.Description, PurchaseLine."Expected Receipt Date", ReqLinkMaintainance."Demand Required Qty", ReqLinkMaintainance."Demand Required Qty" * PurchaseLine."Qty. per Unit of Measure", ReservEntry);
                    END;
                    IF SalesLine.FINDFIRST THEN BEGIN
                        //PurchLineReserve.CreateReservationSetFrom2(37, 1, SalesLine."Document No.", SalesLine."Line No.", SalesLine."No.", SalesLine."Location Code", SalesLine."Qty. per Unit of Measure");
                        Clear(TrackingSpecification);
                        TrackingSpecification.InitFromSalesLine(SalesLine);
                        PurchLineReserve.CreateReservationSetFrom(TrackingSpecification);
                        PurchLineReserve.CreateReservation(PurchaseLine, PurchaseLine.Description, PurchaseLine."Expected Receipt Date", ReqLinkMaintainance."Demand Required Qty", ReqLinkMaintainance."Demand Required Qty" * PurchaseLine."Qty. per Unit of Measure", ReservEntry);
                    END;
                    IF AssemblyLine.FINDFIRST THEN BEGIN
                        //PurchLineReserve.CreateReservationSetFrom2(901, 1, AssemblyLine."Document No.", AssemblyLine."Line No.", AssemblyLine."No.", AssemblyLine."Location Code", AssemblyLine."Qty. per Unit of Measure");
                        Clear(TrackingSpecification);
                        TrackingSpecification.InitFromAsmLine(AssemblyLine);
                        PurchLineReserve.CreateReservationSetFrom(TrackingSpecification);
                        PurchLineReserve.CreateReservation(PurchaseLine, PurchaseLine.Description, PurchaseLine."Expected Receipt Date", ReqLinkMaintainance."Demand Required Qty", ReqLinkMaintainance."Demand Required Qty" * PurchaseLine."Qty. per Unit of Measure", ReservEntry);
                    END;
                END
            UNTIL ReqLinkMaintainance.NEXT = 0;
        ReqLinkMaintainance.DELETEALL;
    end;

    var
        GetOrders: Boolean;
}