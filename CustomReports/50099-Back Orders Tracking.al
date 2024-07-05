report 50099 "Back Orders Tracking"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Back Orders Tracking.rdlc';

    dataset
    {
        dataitem(DataItem1; "Sales Line")
        {
            DataItemTableView = WHERE(Type = CONST(Item),
                                      Quantity = FILTER(> 0));
            RequestFilterFields = "Document Type", "Sell-to Customer No.", "Document No.", "Location Code", "No.";

            trigger OnAfterGetRecord()
            begin
                EntryNo := EntryNo + 1000;
                TransferQtyOnHand := 0;
                CustomerCode := "Sales Line"."Sell-to Customer No.";
                AgencyCode := "Sales Line"."Gen. Prod. Posting Group";
                SONum := "Sales Line"."Document No.";
                "SaleLineNo." := "Sales Line"."Line No.";
                "Sales Line".CALCFIELDS("Reserved Qty. (Base)");
                "Unit Price Calculation"("Sales Line"."No.");

                Customer.RESET;
                Customer.SETRANGE("No.", "Sales Line"."Sell-to Customer No.");
                IF Customer.FINDFIRST THEN
                    CustomerName := Customer.Name;

                IF "Sales Line"."Reserved Qty. (Base)" > 0 THEN BEGIN
                    UnResSalesLineInsert("Sales Line", 'General');
                    Item.RESET;
                    Item.SETRANGE("No.", "Sales Line"."No.");
                    Item.SETRANGE("Hose Main item", TRUE);
                    IF Item.FINDFIRST THEN BEGIN
                        AssembletoOrderLink.RESET;
                        AssembletoOrderLink.SETRANGE("Document No.", "Sales Line"."Document No.");
                        AssembletoOrderLink.SETRANGE("Document Line No.", "Sales Line"."Line No.");
                        AssembletoOrderLink.SETRANGE("Document Type", "Sales Line"."Document Type"::Order);
                        IF AssembletoOrderLink.FINDFIRST THEN BEGIN
                            AssemblyLine.RESET;
                            AssemblyLine.SETRANGE("Document No.", AssembletoOrderLink."Assembly Document No.");
                            AssemblyLine.SETRANGE("Document Type", AssembletoOrderLink."Assembly Document Type");
                            AssemblyLine.SETRANGE(Type, AssemblyLine.Type::Item);
                            IF AssemblyLine.FINDSET THEN
                                REPEAT
                                    AssemblyLine.CALCFIELDS("Reserved Qty. (Base)");
                                    IF AssemblyLine."Reserved Qty. (Base)" = 0 THEN BEGIN
                                        UnResAssemblyLineInsert(AssemblyLine);
                                    END ELSE BEGIN
                                        ReservationEntry.RESET;
                                        ReservationEntry.SETRANGE("Item No.", AssemblyLine."No.");
                                        ReservationEntry.SETRANGE("Source ID", AssemblyLine."Document No.");
                                        ReservationEntry.SETRANGE("Item No.", AssemblyLine."No.");
                                        ReservationEntry.SETRANGE("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
                                        ReservationEntry.SETRANGE(Positive, FALSE);
                                        IF ReservationEntry.FINDSET THEN
                                            REPEAT
                                                TransferReservationEntryAssembly(ReservationEntry."Entry No.", AssemblyLine);
                                            UNTIL ReservationEntry.NEXT = 0;
                                    END;
                                UNTIL AssemblyLine.NEXT = 0;
                        END;
                    END ELSE BEGIN
                        ReservationEntry.RESET;
                        ReservationEntry.SETRANGE("Source ID", "Sales Line"."Document No.");
                        ReservationEntry.SETRANGE("Source Ref. No.", "Sales Line"."Line No.");
                        ReservationEntry.SETRANGE("Item No.", "Sales Line"."No.");
                        ReservationEntry.SETRANGE("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
                        ReservationEntry.SETRANGE(Positive, FALSE);
                        IF ReservationEntry.FINDFIRST THEN
                            REPEAT
                                TransferReservationEntrySale(ReservationEntry."Entry No.", "Sales Line");
                            UNTIL ReservationEntry.NEXT = 0;
                    END;
                END ELSE BEGIN
                    UnResSalesLineInsert("Sales Line", 'UnReserved');
                END;
            end;

            trigger OnPreDataItem()
            begin
                SLUnitPrice := 0;
                BackorderLineNo := 0;
                IF BackOrdersTracking.FINDSET THEN
                    BackOrdersTracking.DELETEALL;
            end;
        }
        dataitem(DataItem2; "Back Orders Tracking")
        {
            column(OrderNumber_BackOrdersTracking; "Order Number")
            {
            }
            column(CusVenNumber_BackOrdersTracking; "Cus/Ven Number")
            {
            }
            column(CustomerName_BackOrdersTracking; "Customer Name")
            {
            }
            column(PartNumber_BackOrdersTracking; "Part Number")
            {
            }
            column(AgencyCode_BackOrdersTracking; "Agency Code")
            {
            }
            column(LocationCode_BackOrdersTracking; "Location Code")
            {
            }
            column(SOLineNo_BackOrdersTracking; "SO Line No.")
            {
            }
            column(PurchaseOutstnQty_BackOrdersTracking; "Purchase Outstn Qty.")
            {
            }
            column(TransferOutstnQty_BackOrdersTracking; "Transfer Outstn Qty.")
            {
            }
            column(AssemblyOutstnQty_BackOrdersTracking; "Assembly Outstn Qty.")
            {
            }
            column(Comments_BackOrdersTracking; Comments)
            {
            }
            column(SubOrderNumber_BackOrdersTracking; "Sub Order Number")
            {
            }
            column(UOM_BackOrdersTracking; UOM)
            {
            }
            column(OrderPrice_BackOrdersTracking; "Order Price")
            {
            }
            column(UnreservedQty_BackOrdersTracking; "Unreserved Qty.")
            {
            }
            column(ReservedBranchFreeStock_BackOrdersTracking; "Res Branch Free Stock Qty.")
            {
            }
            column(ReservedQty_BackOrdersTracking; "Reserved Qty.")
            {
            }
            column(OutstandingQt_BackOrdersTracking; "Outstanding Qty.")
            {
            }
            column(ShippedReceivedQty_BackOrdersTracking; "Shipped/Received Qty.")
            {
            }
            column(OrderQty_BackOrdersTracking; "Order Qty.")
            {
            }
            column(ReservationType_BackOrdersTracking; "Reservation Type")
            {
            }
            column(PartDescription_BackOrdersTracking; "Part Description")
            {
            }
            column(SOAOResAgainstTOQty_BackOrdersTracking; "SO/AO Res Against TO Qty.")
            {
            }
            column(ReservedHOFreeStock_BackOrdersTracking; "Res HO Free Stock Qty.")
            {
            }
            column(ReservedAgainstPO_BackOrdersTracking; "TO Res Against PO Qty.")
            {
            }
            column(TransferUnReservedQty_BackOrdersTracking; "Transfer UnReserved Qty.")
            {
            }
            column(SOResAgainstPOQty_BackOrdersTracking; "SO Res Against PO Qty.")
            {
            }
            column(AssemblyResAgainstQty_BackOrdersTracking; "Assembly Res Qty.")
            {
            }
            column(Print_as_Detailed_Report; Print_as_Detailed_Report)
            {
            }
            column(Print_CustomerWise; Print_CustomerWise)
            {
            }
            column(Print_OrderWise; Print_OrderWise)
            {
            }
            column(Print_Sales_ItemWise_Summary; Print_Sales_ItemWise_Summary)
            {
            }

            trigger OnPreDataItem()
            begin
                "Back Orders Tracking".FINDSET;
                Print_as_Detailed_Report := FALSE;
                Print_CustomerWise := FALSE;
                Print_OrderWise := FALSE;
                Print_Sales_ItemWise_Summary := FALSE;
                CASE Report_Type OF
                    1:
                        Print_as_Detailed_Report := TRUE;
                    2:
                        Print_Sales_ItemWise_Summary := TRUE;
                    3:
                        Print_CustomerWise := TRUE;
                    4:
                        Print_OrderWise := TRUE;
                END
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Report_Type; Report_Type)
                {
                    Caption = 'Choose Report Output Format:';
                    OptionCaption = ' ,Detailed Report,Item Wise Summary,Customer Wise Summary,Order Wise Summary';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PurchaseLine: Record "Purchase Line";
        TransferLine: Record "Transfer Line";
        SalesLine: Record "Sales Line";
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry1: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        ReservationEntry3: Record "Reservation Entry";
        BackOrdersTracking: Record "Back Orders Tracking";
        BackOrdersTracking1: Record "Back Orders Tracking";
        Item: Record Item;
        AssemblyLine: Record "Assembly Line";
        AssembletoOrderLink: Record "Assemble-to-Order Link";
        EntryNo: Integer;
        BackorderLineNo: Integer;
        Sales: Boolean;
        Purchase: Boolean;
        SLUnitPrice: Decimal;
        CustomerCode: Code[30];
        AgencyCode: Code[30];
        SONum: Code[30];
        FilterCusNum: Code[30];
        FilterDocNum: Code[30];
        FilterLoc: Code[30];
        QuantityOnHand: Decimal;
        Item1: Record Item;
        DefaultPriceFactor: Record "Default Price Factor";
        "SaleLineNo.": Integer;
        CurrentPartNo: Code[30];
        PreviousPartNo: Code[30];
        TransferQtyOnHand: Decimal;
        PreviouTONo: Code[30];
        PurchaseLine1: Record "Purchase Line";
        ReservationEntry4: Record "Reservation Entry";
        ReservationEntry5: Record "Reservation Entry";
        Sale_TOResFreeStkQty: Decimal;
        Assem_TOResFreeStkQty: Decimal;
        TransferLine1: Record "Transfer Line";
        Print_as_Detailed_Report: Boolean;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        Print_CustomerWise: Boolean;
        Print_OrderWise: Boolean;
        Print_Sales_ItemWise_Summary: Boolean;
        Customer: Record Customer;
        CustomerName: Text;
        Report_Type: Option;
        "Sales Line": Record "Sales Line";
        "Back Orders Tracking": Record "Back Orders Tracking";

    local procedure UnResSalesLineInsert(FuncSalesLine: Record "Sales Line"; Type: Text)
    begin
        QuantityOnHand := 0;
        BackOrdersTracking.RESET;
        IF BackOrdersTracking.FINDLAST THEN
            BackorderLineNo := BackOrdersTracking."Line No.";

        BackOrdersTracking."Line No." := BackorderLineNo + 1;
        BackOrdersTracking."Order Number" := FuncSalesLine."Document No.";
        BackOrdersTracking."Cus/Ven Number" := FuncSalesLine."Sell-to Customer No.";
        BackOrdersTracking."Customer Name" := CustomerName;
        BackOrdersTracking."Location Code" := FuncSalesLine."Location Code";
        BackOrdersTracking."Agency Code" := FuncSalesLine."Gen. Prod. Posting Group";
        BackOrdersTracking."Part Number" := FuncSalesLine."No.";
        BackOrdersTracking."Part Description" := FuncSalesLine.Description;
        BackOrdersTracking."Reservation Type" := 'Order';
        BackOrdersTracking."Order Qty." := FuncSalesLine."Quantity (Base)";
        BackOrdersTracking."Shipped/Received Qty." := FuncSalesLine."Qty. Shipped (Base)";
        BackOrdersTracking."Outstanding Qty." := FuncSalesLine."Outstanding Qty. (Base)";
        IF Type = 'General' THEN BEGIN
            BackOrdersTracking."Reserved Qty." := FuncSalesLine."Reserved Qty. (Base)";
            Item.RESET;
            Item.SETRANGE("No.", FuncSalesLine."No.");
            Item.SETRANGE("Hose Main item", TRUE);
            IF Item.FINDFIRST THEN BEGIN
                IF FuncSalesLine."Location Code" <> 'HOD-HO' THEN BEGIN
                    BackOrdersTracking."SO/AO Res Against TO Qty." := BackOrdersTracking."Reserved Qty.";
                    BackOrdersTracking."SO Res Against PO Qty." := 0;
                END ELSE BEGIN
                    BackOrdersTracking."SO Res Against PO Qty." := BackOrdersTracking."Reserved Qty.";
                    BackOrdersTracking."SO/AO Res Against TO Qty." := 0;
                END;
            END ELSE BEGIN
                BackOrdersTracking."SO/AO Res Against TO Qty." := 0;
                BackOrdersTracking."SO Res Against PO Qty." := 0;
            END;
        END ELSE BEGIN
            BackOrdersTracking."Reserved Qty." := 0;
            BackOrdersTracking."SO/AO Res Against TO Qty." := 0;
            BackOrdersTracking."SO Res Against PO Qty." := 0;
        END;

        ReservationEntry.RESET;
        ReservationEntry.SETRANGE("Source ID", FuncSalesLine."Document No.");
        ReservationEntry.SETRANGE("Item No.", FuncSalesLine."No.");
        ReservationEntry.SETRANGE("Source Ref. No.", FuncSalesLine."Line No.");
        ReservationEntry.SETRANGE("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
        IF ReservationEntry.FINDSET THEN
            REPEAT
                ReservationEntry1.RESET;
                ReservationEntry1.SETRANGE("Entry No.", ReservationEntry."Entry No.");
                ReservationEntry1.SETRANGE("Source Type", 32);
                ReservationEntry1.SETRANGE(Positive, TRUE);
                IF ReservationEntry1.FINDFIRST THEN
                    QuantityOnHand += ReservationEntry1."Quantity (Base)";
            UNTIL ReservationEntry.NEXT = 0;
        IF QuantityOnHand <= 0 THEN
            QuantityOnHand := 0;

        BackOrdersTracking."Res Branch Free Stock Qty." := QuantityOnHand;
        BackOrdersTracking."Res HO Free Stock Qty." := 0;
        BackOrdersTracking."Transfer UnReserved Qty." := 0;
        BackOrdersTracking."Unreserved Qty." := FuncSalesLine."Outstanding Qty. (Base)" - FuncSalesLine."Reserved Qty. (Base)";
        BackOrdersTracking."Order Price" := SLUnitPrice;
        BackOrdersTracking.Comments := '';
        BackOrdersTracking.UOM := FuncSalesLine."Unit of Measure Code";
        BackOrdersTracking."Sub Order Number" := '';

        BackOrdersTracking."Transfer Outstn Qty." := 0;
        BackOrdersTracking."Assembly Outstn Qty." := 0;
        BackOrdersTracking."Purchase Outstn Qty." := 0;
        BackOrdersTracking."SO Line No." := "SaleLineNo.";
        BackOrdersTracking."TO Res Against PO Qty." := 0;
        BackOrdersTracking."Assembly Res Qty." := 0;
        BackOrdersTracking.INSERT;
        COMMIT;
    end;

    local procedure UnResAssemblyLineInsert(FuncAssemblyLine: Record "Assembly Line")
    begin
        BackOrdersTracking.RESET;
        IF BackOrdersTracking.FINDLAST THEN
            BackorderLineNo := BackOrdersTracking."Line No.";

        BackOrdersTracking."Line No." := BackorderLineNo + 1;
        BackOrdersTracking."Order Number" := SONum;
        BackOrdersTracking."Cus/Ven Number" := CustomerCode;
        BackOrdersTracking."Customer Name" := CustomerName;
        BackOrdersTracking."Location Code" := FuncAssemblyLine."Location Code";
        BackOrdersTracking."Agency Code" := FuncAssemblyLine."Gen. Prod. Posting Group";
        BackOrdersTracking."Part Number" := FuncAssemblyLine."No.";
        BackOrdersTracking."Part Description" := FuncAssemblyLine.Description;
        BackOrdersTracking."Reservation Type" := 'Assembly';
        BackOrdersTracking."Order Qty." := 0;
        BackOrdersTracking."Shipped/Received Qty." := 0;
        BackOrdersTracking."Outstanding Qty." := 0;
        BackOrdersTracking."Reserved Qty." := 0;
        BackOrdersTracking."Res Branch Free Stock Qty." := 0;
        BackOrdersTracking."SO/AO Res Against TO Qty." := 0;
        BackOrdersTracking."Res HO Free Stock Qty." := 0;
        BackOrdersTracking."Transfer UnReserved Qty." := 0;
        BackOrdersTracking."Unreserved Qty." := 0;
        BackOrdersTracking."Order Price" := SLUnitPrice;
        BackOrdersTracking.Comments := '';
        BackOrdersTracking.UOM := FuncAssemblyLine."Unit of Measure Code";
        BackOrdersTracking."Sub Order Number" := '';
        BackOrdersTracking."Assembly Outstn Qty." := 0;
        BackOrdersTracking."Transfer Outstn Qty." := 0;
        BackOrdersTracking."Purchase Outstn Qty." := 0;
        BackOrdersTracking."SO Line No." := "SaleLineNo.";
        BackOrdersTracking."TO Res Against PO Qty." := 0;
        BackOrdersTracking."SO Res Against PO Qty." := 0;
        BackOrdersTracking."Assembly Res Qty." := 0;
        BackOrdersTracking.INSERT;
        COMMIT;
    end;

    local procedure TransferReservationEntrySale(FuncEntryNo: Integer; FuncSalesLine: Record "Sales Line")
    begin
        ReservationEntry1.RESET;
        ReservationEntry1.SETRANGE("Entry No.", FuncEntryNo);
        ReservationEntry1.SETRANGE(Positive, TRUE);
        IF ReservationEntry1.FINDFIRST THEN BEGIN
            BackOrdersTracking.RESET;
            IF BackOrdersTracking.FINDLAST THEN
                BackorderLineNo := BackOrdersTracking."Line No.";

            BackOrdersTracking."Line No." := BackorderLineNo + 1;
            BackOrdersTracking."Order Number" := FuncSalesLine."Document No.";
            BackOrdersTracking."Cus/Ven Number" := FuncSalesLine."Sell-to Customer No.";
            BackOrdersTracking."Customer Name" := CustomerName;
            BackOrdersTracking."Location Code" := FuncSalesLine."Location Code";
            BackOrdersTracking."Agency Code" := FuncSalesLine."Gen. Prod. Posting Group";
            BackOrdersTracking."Part Number" := FuncSalesLine."No.";
            BackOrdersTracking."Part Description" := FuncSalesLine.Description;
            BackOrdersTracking."Order Qty." := 0;
            BackOrdersTracking."Shipped/Received Qty." := 0;
            BackOrdersTracking."Outstanding Qty." := 0;
            BackOrdersTracking."Reserved Qty." := 0;
            BackOrdersTracking."Res Branch Free Stock Qty." := 0;
            BackOrdersTracking."Unreserved Qty." := 0;
            BackOrdersTracking."Order Price" := SLUnitPrice;
            BackOrdersTracking.Comments := '';
            BackOrdersTracking.UOM := FuncSalesLine."Unit of Measure Code";
            BackOrdersTracking."SO/AO Res Against TO Qty." := 0;
            BackOrdersTracking."Assembly Outstn Qty." := 0;
            BackOrdersTracking."Purchase Outstn Qty." := 0;
            BackOrdersTracking."SO Line No." := "SaleLineNo.";
            BackOrdersTracking."TO Res Against PO Qty." := 0;
            BackOrdersTracking."Assembly Res Qty." := 0;
            TransferLine.RESET;
            TransferLine.SETRANGE("Document No.", ReservationEntry1."Source ID");
            TransferLine.SETRANGE("Line No.", ReservationEntry1."Source Ref. No.");
            IF TransferLine.FINDFIRST THEN BEGIN
                BackOrdersTracking."Sub Order Number" := ReservationEntry1."Source ID";
                Sale_TransCalFreeStock(TransferLine."Document No.", TransferLine."Line No.", TransferLine."Item No.");
                BackOrdersTracking."SO/AO Res Against TO Qty." := ReservationEntry1."Quantity (Base)";
                BackOrdersTracking."Res HO Free Stock Qty." := Sale_TOResFreeStkQty;
                BackOrdersTracking."Reservation Type" := 'Transfer';
                BackOrdersTracking."Transfer Outstn Qty." := TransferLine."Quantity (Base)" - TransferLine."Qty. Shipped (Base)";
                TransferLine.CALCFIELDS("Reserved Qty. Outbnd. (Base)");
                BackOrdersTracking."Transfer UnReserved Qty." := BackOrdersTracking."Transfer Outstn Qty." - TransferLine."Reserved Qty. Outbnd. (Base)";
                BackOrdersTracking.INSERT;
                COMMIT;
                TransferToPurchase(TransferLine."Document No.", TransferLine."Line No.");
            END;
            PurchaseLine1.RESET;
            PurchaseLine1.SETRANGE("Document No.", ReservationEntry1."Source ID");
            PurchaseLine1.SETRANGE("Line No.", ReservationEntry1."Source Ref. No.");
            IF PurchaseLine1.FINDFIRST THEN BEGIN
                BackOrdersTracking."Order Price" := SLUnitPrice;
                BackOrdersTracking."Sub Order Number" := PurchaseLine1."Document No.";
                BackOrdersTracking."Reservation Type" := 'Purchase';
                BackOrdersTracking."Transfer Outstn Qty." := 0;
                BackOrdersTracking."Transfer UnReserved Qty." := 0;
                BackOrdersTracking."SO Res Against PO Qty." := ReservationEntry1."Quantity (Base)";
                BackOrdersTracking.INSERT;
                COMMIT;
            END;
        END;
    end;

    local procedure TransferReservationEntryAssembly("FuncEntry No": Integer; FuncAssemblyLine: Record "Assembly Line")
    begin
        ReservationEntry1.RESET;
        ReservationEntry1.SETRANGE("Entry No.", "FuncEntry No");
        ReservationEntry1.SETRANGE(Positive, TRUE);
        IF ReservationEntry1.FINDFIRST THEN BEGIN
            BackOrdersTracking.RESET;
            IF BackOrdersTracking.FINDLAST THEN
                BackorderLineNo := BackOrdersTracking."Line No.";

            BackOrdersTracking."Line No." := BackorderLineNo + 1;
            BackOrdersTracking."Order Number" := SONum;
            BackOrdersTracking."Cus/Ven Number" := CustomerCode;
            BackOrdersTracking."Customer Name" := CustomerName;
            BackOrdersTracking."Location Code" := FuncAssemblyLine."Location Code";
            BackOrdersTracking."Agency Code" := FuncAssemblyLine."Gen. Prod. Posting Group";
            BackOrdersTracking."Part Number" := FuncAssemblyLine."No.";
            BackOrdersTracking."Part Description" := FuncAssemblyLine.Description;
            BackOrdersTracking."Reservation Type" := 'Transfer';
            BackOrdersTracking."Order Qty." := 0;
            BackOrdersTracking."Shipped/Received Qty." := 0;
            BackOrdersTracking."Outstanding Qty." := 0;
            BackOrdersTracking."Reserved Qty." := 0;
            BackOrdersTracking."SO/AO Res Against TO Qty." := ReservationEntry1."Quantity (Base)";
            BackOrdersTracking."Res Branch Free Stock Qty." := 0;
            IF ReservationEntry1."Source Type" = 32 THEN
                BackOrdersTracking."Res HO Free Stock Qty." := ReservationEntry1."Quantity (Base)"
            ELSE
                BackOrdersTracking."Res HO Free Stock Qty." := 0;

            BackOrdersTracking."Unreserved Qty." := FuncAssemblyLine."Quantity (Base)" - FuncAssemblyLine."Reserved Qty. (Base)";
            BackOrdersTracking."Order Price" := SLUnitPrice;
            BackOrdersTracking.Comments := 'Assembly Comp' + ',' + FuncAssemblyLine."Document No.";
            BackOrdersTracking.UOM := FuncAssemblyLine."Unit of Measure Code";
            BackOrdersTracking."Assembly Outstn Qty." := FuncAssemblyLine."Quantity (Base)" - FuncAssemblyLine."Consumed Quantity (Base)";
            BackOrdersTracking."Assembly Res Qty." := ReservationEntry1."Quantity (Base)";
            BackOrdersTracking."Purchase Outstn Qty." := 0;
            BackOrdersTracking."SO Line No." := "SaleLineNo.";
            BackOrdersTracking."TO Res Against PO Qty." := 0;
            BackOrdersTracking."SO Res Against PO Qty." := 0;
            TransferLine.RESET;
            TransferLine.SETRANGE("Document No.", ReservationEntry1."Source ID");
            TransferLine.SETRANGE("Line No.", ReservationEntry1."Source Ref. No.");
            IF TransferLine.FINDSET THEN BEGIN
                BackOrdersTracking."Sub Order Number" := TransferLine."Document No.";
                Assembly_TransCalFreeStock(TransferLine."Document No.", TransferLine."Line No.", TransferLine."Item No.");
                BackOrdersTracking."Res HO Free Stock Qty." := Assem_TOResFreeStkQty;
                BackOrdersTracking."Transfer Outstn Qty." := TransferLine."Quantity (Base)" - TransferLine."Qty. Shipped (Base)";
                BackOrdersTracking."Transfer UnReserved Qty." := BackOrdersTracking."Transfer Outstn Qty." - ReservationEntry1."Quantity (Base)";
                BackOrdersTracking.INSERT;
                COMMIT;
                TransferToPurchase(TransferLine."Document No.", TransferLine."Line No.");
            END;
            PurchaseLine1.RESET;
            PurchaseLine1.SETRANGE("Document No.", ReservationEntry1."Source ID");
            PurchaseLine1.SETRANGE("Line No.", ReservationEntry1."Source Ref. No.");
            IF PurchaseLine1.FINDFIRST THEN BEGIN
                BackOrdersTracking."Order Price" := SLUnitPrice;
                BackOrdersTracking."Reservation Type" := 'Purchase';
                BackOrdersTracking."Transfer Outstn Qty." := 0;
                BackOrdersTracking."Transfer UnReserved Qty." := 0;
                BackOrdersTracking."SO Res Against PO Qty." := ReservationEntry1."Quantity (Base)";
                BackOrdersTracking.INSERT;
                COMMIT;
            END;
        END;
    end;

    local procedure TransferToPurchase(TONum: Code[30]; "TOLineNo.": Integer)
    begin
        TransferLine.RESET;
        TransferLine.SETRANGE("Document No.", TONum);
        TransferLine.SETRANGE("Line No.", "TOLineNo.");
        IF TransferLine.FINDFIRST THEN BEGIN
            ReservationEntry2.RESET;
            ReservationEntry2.SETRANGE("Source ID", TransferLine."Document No.");
            ReservationEntry2.SETRANGE("Source Ref. No.", TransferLine."Line No.");
            ReservationEntry2.SETRANGE("Item No.", TransferLine."Item No.");
            ReservationEntry2.SETRANGE("Reservation Status", ReservationEntry2."Reservation Status"::Reservation);
            ReservationEntry2.SETRANGE(Positive, FALSE);
            IF ReservationEntry2.FINDSET THEN
                REPEAT
                    ReservationEntry3.RESET;
                    ReservationEntry3.SETRANGE("Entry No.", ReservationEntry2."Entry No.");
                    ReservationEntry3.SETRANGE(Positive, TRUE);
                    IF ReservationEntry3.FINDFIRST THEN BEGIN
                        BackOrdersTracking.RESET;
                        IF BackOrdersTracking.FINDLAST THEN
                            BackorderLineNo := BackOrdersTracking."Line No.";

                        BackOrdersTracking."Line No." := BackorderLineNo + 1;
                        BackOrdersTracking."Order Number" := SONum;
                        BackOrdersTracking."Cus/Ven Number" := CustomerCode;
                        BackOrdersTracking."Customer Name" := CustomerName;
                        BackOrdersTracking."Location Code" := 'HOD-HO';
                        BackOrdersTracking."Agency Code" := AgencyCode;
                        BackOrdersTracking."Part Number" := ReservationEntry3."Item No.";
                        BackOrdersTracking."Part Description" := TransferLine.Description;
                        ;
                        BackOrdersTracking."Reservation Type" := 'Purchase';
                        BackOrdersTracking."Order Qty." := 0;
                        BackOrdersTracking."Shipped/Received Qty." := 0;
                        BackOrdersTracking."Outstanding Qty." := 0;
                        BackOrdersTracking."Reserved Qty." := 0;
                        BackOrdersTracking."SO/AO Res Against TO Qty." := 0;
                        BackOrdersTracking."TO Res Against PO Qty." := ReservationEntry3."Quantity (Base)";
                        BackOrdersTracking."Res Branch Free Stock Qty." := 0;
                        IF PreviousPartNo <> BackOrdersTracking."Part Number" THEN BEGIN
                            TransferQtyOnHand := 0;
                            PreviousPartNo := BackOrdersTracking."Part Number";
                        END;
                        IF ReservationEntry3."Source Type" = 32 THEN
                            TransferQtyOnHand += ReservationEntry3."Quantity (Base)"
                        ELSE
                            BackOrdersTracking."Res HO Free Stock Qty." := 0;

                        BackOrdersTracking."Unreserved Qty." := 0;
                        BackOrdersTracking.Comments := '';
                        BackOrdersTracking.UOM := TransferLine."Unit of Measure Code";
                        BackOrdersTracking."Assembly Outstn Qty." := 0;
                        BackOrdersTracking."Transfer Outstn Qty." := 0;
                        BackOrdersTracking."SO Line No." := "SaleLineNo.";
                        BackOrdersTracking."SO Res Against PO Qty." := 0;
                        BackOrdersTracking."Assembly Res Qty." := 0;
                        PurchaseLine.RESET;
                        PurchaseLine.SETRANGE("Document No.", ReservationEntry3."Source ID");
                        PurchaseLine.SETRANGE("Line No.", ReservationEntry3."Source Ref. No.");
                        IF PurchaseLine.FINDFIRST THEN BEGIN
                            BackOrdersTracking."Order Price" := SLUnitPrice;
                            BackOrdersTracking."Sub Order Number" := PurchaseLine."Document No.";
                            BackOrdersTracking."Purchase Outstn Qty." := PurchaseLine."Outstanding Qty. (Base)";
                            BackOrdersTracking.INSERT;
                            COMMIT;
                        END;
                    END;
                UNTIL ReservationEntry2.NEXT = 0;
        END
    end;

    local procedure "Unit Price Calculation"("Item No.": Code[30])
    begin
        Item1.RESET;
        IF Item1.GET("Item No.") THEN BEGIN
            DefaultPriceFactor.RESET;
            DefaultPriceFactor.SETRANGE("Agency Code", Item1."Global Dimension 1 Code");
            IF DefaultPriceFactor.FINDFIRST THEN BEGIN
                SLUnitPrice := (Item1."Unit Price" - Item1."Dealer Net - Core Deposit" * Item1."Inventory Factor") * DefaultPriceFactor."Default Price Factor" + Item1."Dealer Net - Core Deposit" * Item1."Inventory Factor";
                ItemUnitofMeasure.RESET;
                ItemUnitofMeasure.SETRANGE("Item No.", Item1."No.");
                IF ItemUnitofMeasure.FINDFIRST THEN
                    SLUnitPrice := SLUnitPrice / ItemUnitofMeasure."Qty. per Unit of Measure";
                SLUnitPrice := ROUND(SLUnitPrice, 0.01);
            END;
        END
    end;

    local procedure Sale_TransCalFreeStock(DocNo: Code[30]; Lno: Integer; ItmNo: Code[30])
    begin
        Sale_TOResFreeStkQty := 0;
        ReservationEntry4.RESET;
        ReservationEntry4.SETRANGE("Source ID", DocNo);
        ReservationEntry4.SETRANGE("Item No.", ItmNo);
        ReservationEntry4.SETRANGE("Source Ref. No.", Lno);
        ReservationEntry4.SETRANGE("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
        ReservationEntry4.SETRANGE(Positive, FALSE);
        IF ReservationEntry4.FINDSET THEN
            REPEAT
                ReservationEntry5.RESET;
                ReservationEntry5.SETRANGE("Entry No.", ReservationEntry4."Entry No.");
                ReservationEntry5.SETRANGE("Source Type", 32);
                ReservationEntry5.SETRANGE(Positive, TRUE);
                IF ReservationEntry5.FINDFIRST THEN
                    Sale_TOResFreeStkQty += ReservationEntry5."Quantity (Base)";
            UNTIL ReservationEntry4.NEXT = 0;
    end;

    local procedure Assembly_TransCalFreeStock(DocNo: Code[30]; LineNo: Integer; ItmNo: Code[30])
    begin
        Assem_TOResFreeStkQty := 0;
        ReservationEntry4.RESET;
        ReservationEntry4.SETRANGE("Source ID", DocNo);
        ReservationEntry4.SETRANGE("Item No.", ItmNo);
        ReservationEntry4.SETRANGE("Source Ref. No.", LineNo);
        ReservationEntry4.SETRANGE("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
        ReservationEntry4.SETRANGE(Positive, FALSE);
        IF ReservationEntry4.FINDSET THEN
            REPEAT
                ReservationEntry5.RESET;
                ReservationEntry5.SETRANGE("Entry No.", ReservationEntry4."Entry No.");
                ReservationEntry5.SETRANGE("Source Type", 32);
                ReservationEntry5.SETRANGE(Positive, TRUE);
                IF ReservationEntry5.FINDFIRST THEN
                    Assem_TOResFreeStkQty += ReservationEntry5."Quantity (Base)";
            UNTIL ReservationEntry4.NEXT = 0;
    end;
}

