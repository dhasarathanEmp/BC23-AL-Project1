pageextension 70018 TransferOrderSubformExtn extends "Transfer Order Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field("Ordered Part No."; Rec."Ordered Part No.")
            {

            }
        }
        addbefore(Quantity)
        {
            field("ShippedQty."; Rec."ShippedQty.")
            {

            }
        }
        modify(Quantity)
        {
            Caption = 'Accepted Quantity';
        }
        addafter("ShortcutDimCode[8]")
        {
            field("Transfer-from Code"; Rec."Transfer-from Code")
            {

            }
            field("Transfer-to Code"; Rec."Transfer-to Code")
            {

            }
            field("Original Transfer Order Qty."; Rec."Original Transfer Order Qty.")
            {

            }
            field("Indent No."; Rec."Indent No.")
            {

            }
            field("Required By"; Rec."Required By")
            {

            }
            field("Sales Order Number"; Rec."Sales Order Number")
            {
                Editable = false;
            }
            field("Sales Line No"; Rec."Sales Line No")
            {
                Editable = false;
            }
        }

    }

    actions
    {
        addafter(Reserve)
        {
            action("Item Replacement")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = New;

                trigger OnAction()
                begin
                    RepItem.DELETEALL;
                    ItemR.RESET;
                    ItemR.SETRANGE("No.", Rec."Item No.");
                    IF ItemR.FINDFIRST THEN BEGIN
                        IF (ItemR."Replacement Part Number" <> '') THEN
                            ReplaceItm(ItemR."Replacement Part Number", Rec."Item No.");
                        IF (ItemR.ParentReplacementItem <> '') THEN
                            ReplaceItm(ItemR.ParentReplacementItem, Rec."Item No.");
                    END;
                    InsertAllCItem;
                    InsertAllPItem;

                    IF (ItemR."Replacement Part Number" <> '') OR (ItemR.ParentReplacementItem <> '') THEN BEGIN
                        RepItem.SETRANGE(CurrItem, Rec."Item No.");
                        ReplacementItem.SETTABLEVIEW(RepItem);
                        PreviousPart := Rec."Item No.";
                        COMMIT;
                        IF PAGE.RUNMODAL(PAGE::ReplacementItem, RepItem) =
                           ACTION::LookupOK
                        THEN BEGIN
                            //VALIDATE("Item No.",RepItem.ItemNo);
                            IF RepItem.ItemNo <> Rec."Item No." THEN
                                IF CONFIRM(Text002, TRUE) THEN BEGIN
                                    //Cu103
                                    SaleNewLine := AutoReplace."Auto Replace"(Rec."Item No.", Rec."Document No.", Rec."Line No.", RepItem.ItemNo);
                                    //Cu103
                                    Rec.VALIDATE(Rec."Item No.", RepItem.ItemNo);
                                    //Cu103
                                    Rec.ItemReplacementCheck(TRUE);
                                    Rec."Sales Order Number" := xRec."Sales Order Number";
                                    Rec."Sales Line No" := SaleNewLine;
                                    Rec."Shipment Date" := xRec."Shipment Date";
                                    Rec."Receipt Date" := xRec."Receipt Date";
                                    Rec."Ordered Part No." := PreviousPart;
                                    Rec."ShippedQty." := xRec."ShippedQty.";
                                    Rec.MODIFY;
                                    IF SalesLineReserRepl.GET(1, Rec."Sales Order Number", Rec."Sales Line No") THEN BEGIN
                                        Clear(TrackingSpecification);
                                        TrackingSpecification.InitFromSalesLine(SalesLineReserRepl);
                                        TransferLineReserve2.CreateReservationSetFrom(TrackingSpecification);
                                        TransferLineReserve2.CreateReservation(Rec, Rec.Description, Rec."Receipt Date", SalesLineReserRepl.Quantity, SalesLineReserRepl."Quantity (Base)", ReservationEntry, Enum::"Transfer Direction"::Inbound);
                                        //TransferLineReserve2.CreateReservationSetFrom2(37, 1, Rec."Sales Order Number", SaleNewLine, Rec."Item No.", Rec."Transfer-to Code", Rec."Qty. per Unit of Measure");
                                        //TransferLineReserve2.CreateReservation(Rec, Rec.Description, Rec."Receipt Date", SalesLineReserRepl.Quantity, SalesLineReserRepl."Quantity (Base)", '', '', 1);
                                    END ELSE IF AssemblyLineReserRepl.GET(1, Rec."Sales Order Number", Rec."Sales Line No") THEN BEGIN
                                        Clear(TrackingSpecification);
                                        TrackingSpecification.InitFromAsmLine(AssemblyLineReserRepl);
                                        TransferLineReserve2.CreateReservationSetFrom(TrackingSpecification);
                                        TransferLineReserve2.CreateReservation(Rec, Rec.Description, Rec."Receipt Date", AssemblyLineReserRepl.Quantity, AssemblyLineReserRepl."Quantity (Base)", ReservationEntry, Enum::"Transfer Direction"::Inbound);
                                        //TransferLineReserve2.CreateReservationSetFrom2(901, 1, Rec."Sales Order Number", SaleNewLine, Rec."Item No.", Rec."Transfer-to Code", Rec."Qty. per Unit of Measure");
                                        //TransferLineReserve2.CreateReservation(Rec, Rec.Description, Rec."Receipt Date", AssemblyLineReserRepl.Quantity, AssemblyLineReserRepl."Quantity (Base)", '', '', 1);
                                    END;
                                    //Cu103
                                END
                                ELSE
                                    Rec.VALIDATE(Rec."Item No.", PreviousPart);
                        END;
                    END;
                end;
            }
            action("Split Lines")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = New;

                trigger OnAction()
                begin
                    //Pop up
                    CLEAR(SplitQtyProcessOnly);
                    SplitQtyProcessOnly.RUNMODAL;
                    SplitQty := SplitQtyProcessOnly."Return SplitQty";
                    SplitQtyBase := SplitQty * Rec."Qty. per Unit of Measure";
                    //
                    IF (SplitQty > 0) AND (SplitQty <= Rec."Outstanding Quantity") AND (SplitQty < Rec.Quantity) THEN BEGIN
                        Rec.CALCFIELDS(Rec."Reserved Qty. Inbnd. (Base)");
                        Rec.CALCFIELDS(Rec."Reserved Quantity Inbnd.");
                        OutstandingInb := Rec.Quantity - Rec."Quantity Received";
                        OutstandingInbBase := (Rec.Quantity - Rec."Quantity Received") * Rec."Qty. per Unit of Measure";
                        IF (OutstandingInbBase - Rec."Reserved Qty. Inbnd. (Base)") >= SplitQtyBase THEN BEGIN
                            TransfLine2.RESET;
                            TransfLine2.SETRANGE("Document No.", Rec."Document No.");
                            TransfLine2.FINDLAST;
                            TransfLine.INIT;
                            TransfLine."Document No." := Rec."Document No.";
                            TransfLine."Document Type" := Rec."Document Type";
                            TransfLine."Line No." := TransfLine2."Line No." + 1000;
                            TransfLine."Transfer-from Code" := Rec."Transfer-from Code";
                            TransfLine."Transfer-to Code" := Rec."Transfer-to Code";
                            TransfLine."In-Transit Code" := Rec."In-Transit Code";
                            TransfLine.VALIDATE("Item No.", Rec."Item No.");
                            TransfLine.VALIDATE("ShippedQty.", SplitQty);
                            TransfLine.VALIDATE("Unit of Measure", Rec."Unit of Measure");
                            TransfLine.VALIDATE("Shipment Date", Rec."Shipment Date");
                            TransfLine.VALIDATE("Receipt Date", Rec."Receipt Date");
                            TransfLine."Sales Order Number" := Rec."Sales Order Number";
                            TransfLine."Sales Line No" := Rec."Sales Line No";
                            TransfLine.INSERT;
                            Rec.VALIDATE("ShippedQty.", Rec."ShippedQty." - SplitQty);

                        END ELSE BEGIN
                            CLEAR(ResEngManagement);
                            ReserveCancelforSplit := 0;
                            ReservationEntry.RESET;
                            ReservationEntry.SETRANGE("Source ID", Rec."Document No.");
                            ReservationEntry.SETRANGE("Source Ref. No.", Rec."Line No.");
                            ReservationEntry.SETRANGE("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
                            ReservationEntry.SETRANGE(Positive, TRUE);
                            IF ReservationEntry.FINDFIRST THEN BEGIN
                                ReserveCancelforSplit := (SplitQty - (OutstandingInb - Rec."Reserved Quantity Inbnd."));
                                ResEngManagement.ModifyReservEntry(ReservationEntry, ReservationEntry."Quantity (Base)" - (SplitQtyBase - (OutstandingInbBase - Rec."Reserved Qty. Inbnd. (Base)")), ReservationEntry.Description, FALSE);
                                CurrPage.UPDATE;
                            END;
                            TransfLine2.RESET;
                            TransfLine2.SETRANGE("Document No.", Rec."Document No.");
                            TransfLine2.FINDLAST;
                            TransfLine.INIT;
                            TransfLine."Document No." := Rec."Document No.";
                            TransfLine."Document Type" := Rec."Document Type";
                            TransfLine."Line No." := TransfLine2."Line No." + 1000;
                            TransfLine."Transfer-from Code" := Rec."Transfer-from Code";
                            TransfLine."Transfer-to Code" := Rec."Transfer-to Code";
                            TransfLine."In-Transit Code" := Rec."In-Transit Code";
                            TransfLine.VALIDATE("Item No.", Rec."Item No.");
                            TransfLine.VALIDATE("ShippedQty.", SplitQty);
                            TransfLine.VALIDATE("Unit of Measure", Rec."Unit of Measure");
                            TransfLine.VALIDATE("Shipment Date", Rec."Shipment Date");
                            TransfLine.VALIDATE("Receipt Date", Rec."Receipt Date");
                            TransfLine."Sales Order Number" := Rec."Sales Order Number";
                            TransfLine."Sales Line No" := Rec."Sales Line No";
                            TransfLine.INSERT;
                            CLEAR(TransferLineReserve);
                            Clear(TrackingSpecification);
                            IF COPYSTR(TransfLine."Sales Order Number", 1, 2) = 'SO' THEN begin
                                SourceType := 37;
                                IF SalesLineReserReplforSplit.GET(1, Rec."Sales Order Number", Rec."Sales Line No") THEN;
                                Clear(TrackingSpecification);
                                TrackingSpecification.InitFromSalesLine(SalesLineReserReplforSplit);
                                TransferLineReserve2.CreateReservationSetFrom(TrackingSpecification);
                                TransferLineReserve2.CreateReservation(TransfLine, TransfLine.Description, TransfLine."Receipt Date", ReserveCancelforSplit, ReserveCancelforSplit * TransfLine."Qty. per Unit of Measure", ReservationEntry, enum::"Transfer Direction"::Inbound);
                            END ELSE IF COPYSTR(TransfLine."Sales Order Number", 1, 2) = 'AO' THEN begin
                                SourceType := 901;
                                If AssemblyLineReserReplforSplit.Get(1, Rec."Sales Order Number", Rec."Sales Line No") then;
                                Clear(TrackingSpecification);
                                TrackingSpecification.InitFromAsmLine(AssemblyLineReserReplforSplit);
                                TransferLineReserve2.CreateReservationSetFrom(TrackingSpecification);
                                TransferLineReserve2.CreateReservation(TransfLine, TransfLine.Description, TransfLine."Receipt Date", ReserveCancelforSplit, ReserveCancelforSplit * TransfLine."Qty. per Unit of Measure", ReservationEntry, Enum::"Transfer Direction"::Inbound);
                            end;
                            //TransferLineReserve.CreateReservationSetFrom2(SourceType, 1, TransfLine."Sales Order Number", TransfLine."Sales Line No", TransfLine."Item No.", TransfLine."Transfer-to Code", TransfLine2."Qty. per Unit of Measure");
                            //TransferLineReserve.CreateReservation(TransfLine, TransfLine.Description, TransfLine."Receipt Date", ReserveCancelforSplit, ReserveCancelforSplit * TransfLine."Qty. per Unit of Measure", '', '', 1);
                            Rec.VALIDATE("ShippedQty.", Rec."ShippedQty." - SplitQty);
                        END;
                        CurrPage.UPDATE;
                    END ELSE
                        ERROR('Invalid Split Quantity');
                end;
            }
        }
    }

    var
        RepItem: Record ReplacementItem;
        ItemR: Record Item;
        SaleNewLine: Integer;
        PreviousPart: Code[20];
        Text002: Label 'Do you want to Replace the Item ? Item will be replaced in the related Sale/Assembly Order.';
        K: Integer;
        L: Integer;
        M: Integer;
        ItemRI: Record Item;
        ReplaceItem: Record ReplacementItem;
        ReplaceItem1: Record ReplacementItem;
        ReplaceItem2: Record ReplacementItem;
        ReplaceItem3: Record ReplacementItem;
        ReplaceItem4: Record ReplacementItem;
        ReplaceItem5: Record ReplacementItem;
        ReplaceItem6: Record ReplacementItem;
        ChildItm: array[20] of Code[20];
        ParentItm: array[20] of Code[20];
        ParentRep: Code[20];
        ChildRep: Code[20];
        ItemInventory: Decimal;
        ItemProtective: Decimal;
        ParentPart: Code[20];
        ChildPart: Code[20];
        ReplacementItem: Page ReplacementItem;
        AutoReplace: Codeunit "Auto Replace";
        BinContent: Record "Bin Content";
        Item1: Record Item;
        SalesLineReserRepl: Record "Sales Line";
        TransferLineReserve2: Codeunit "Transfer Line-Reserve";
        AssemblyLineReserRepl: Record "Assembly Line";
        TrackingSpecification: Record "Tracking Specification";
        TransferLineReserv: Record "Transfer Line";
        ReservationEntry: Record "Reservation Entry";
        SplitQtyProcessOnly: Report "Split Qty";
        SplitQty: Decimal;
        SplitQtyBase: Decimal;
        OutstandingInb: Decimal;
        OutstandingInbBase: Decimal;
        TransfLine: Record "Transfer Line";
        TransfLine2: Record "Transfer Line";
        ResEngManagement: Codeunit "Reservation Engine Mgt.";
        ReserveCancelforSplit: Decimal;
        TransferLineReserve: Codeunit "Transfer Line-Reserve";
        SourceType: Decimal;
        SalesLineReserReplforSplit: Record "Sales Line";
        AssemblyLineReserReplforSplit: Record "Assembly Line";



    LOCAL procedure InsertAllCItem()

    begin
        K := 0;
        IF ReplaceItem3.FINDSET THEN
            REPEAT
                IF ReplaceItem3.ChildItem <> '' THEN BEGIN
                    K += 1;
                    ChildItm[K] := ReplaceItem3.ChildItem;
                END;
            UNTIL ReplaceItem3.NEXT = 0;
        FOR L := 1 TO K DO BEGIN
            ReplaceItem4.RESET;
            ReplaceItem4.SETRANGE(ItemNo, ChildItm[L]);
            IF ReplaceItem4.FINDFIRST THEN
                M := 1
            ELSE BEGIN
                ReplaceItem6.RESET;
                ReplaceItem6.SETCURRENTKEY(ChildItem);
                ReplaceItem6.SETRANGE(ChildItem, ChildItm[L]);
                IF ReplaceItem6.FINDFIRST THEN
                    ParentRep := ReplaceItem6.ItemNo;
                ReplaceItem5.INIT;
                ReplaceItem5.ItemNo := ChildItm[L];
                ReplaceItem5.ParentItem := ParentRep;
                ReplaceItem5.CurrItem := Rec."Item No.";
                ReplaceItem5.Inventory := Inventory1(ChildItm[L]);
                ReplaceItem5.INSERT;
            END;
        END;
    end;

    LOCAL procedure InsertAllPItem()
    begin
        K := 0;
        IF ReplaceItem3.FINDSET THEN
            REPEAT
                IF ReplaceItem3.ParentItem <> '' THEN BEGIN
                    K += 1;
                    ParentItm[K] := ReplaceItem3.ParentItem;
                END;
            UNTIL ReplaceItem3.NEXT = 0;
        FOR L := 1 TO K DO BEGIN
            ReplaceItem4.RESET;
            ReplaceItem4.SETRANGE(ItemNo, ParentItm[L]);
            IF ReplaceItem4.FINDFIRST THEN
                M := 1
            ELSE BEGIN
                ReplaceItem6.RESET;
                ReplaceItem6.SETCURRENTKEY(ParentItem);
                ReplaceItem6.SETRANGE(ParentItem, ParentItm[L]);
                IF ReplaceItem6.FINDFIRST THEN
                    ChildRep := ReplaceItem6.ItemNo;
                ReplaceItem5.FINDLAST;
                ReplaceItem5.INIT;
                ReplaceItem5.ItemNo := ParentItm[L];
                ReplaceItem5.CurrItem := Rec."Item No.";
                ReplaceItem5.ChildItem := ChildRep;
                ReplaceItem5.Inventory := Inventory1(ParentItm[L]);
                ReplaceItem5.INSERT;
            END;
        END;
    end;


    procedure ReplaceItm(RI: Code[20]; CurrNo: Code[20])

    begin
        ReplaceItem1.RESET;
        ReplaceItem1.SETRANGE(ItemNo, RI);
        IF NOT ReplaceItem1.FINDFIRST THEN BEGIN
            ItemRI.RESET;
            ItemRI.SETRANGE("No.", RI);
            IF ItemRI.FINDFIRST THEN
                IF RI <> CurrNo THEN BEGIN
                    ReplaceItem.INIT;
                    ReplaceItem.CurrItem := CurrNo;
                    ReplaceItem.ChildItem := ItemRI."Replacement Part Number";
                    IF ReplaceItem.ChildItem = '' THEN
                        ReplaceItem.LatestReplacementItem := TRUE;
                    ReplaceItem.ParentItem := ItemRI.ParentReplacementItem;
                    ReplaceItem.ItemNo := RI;
                    ReplaceItem.Inventory := Inventory1(RI);
                    ReplaceItem.INSERT;
                END;
        END;
    end;

    LOCAL procedure ReplaceItemCheck(RI1: Code[20]; Check: Integer)
    begin
        IF (RI1 <> '') AND (Check = 1) THEN
            ReplaceItm(RI1, Rec."Item No.");
        IF (RI1 <> '') AND (Check = 2) THEN
            ReplaceItm2(RI1, Rec."Item No.");
    end;

    local procedure Inventory1(ItemNum: Code[20]) Stock: Decimal
    begin
        ItemInventory := 0;
        ItemProtective := 0;
        BinContent.RESET;
        BinContent.SETRANGE("Item No.", ItemNum);
        BinContent.SETRANGE("Location Code", Rec."Transfer-from Code");
        BinContent.CALCFIELDS("Bin Blocks");
        BinContent.CALCFIELDS(Quantity);
        BinContent.SETRANGE("Bin Blocks", TRUE);
        IF BinContent.FINDSET THEN
            REPEAT
                BinContent.CALCFIELDS(Quantity);
                ItemProtective += BinContent.Quantity;
            UNTIL BinContent.NEXT = 0;
        Item1.RESET;
        Item1.SETRANGE("No.", ItemNum);
        Item1.SETRANGE("Location Filter", Rec."Transfer-from Code");
        IF Item1.FINDFIRST THEN BEGIN
            Item1.CALCFIELDS(Inventory);
            Item1.CALCFIELDS("Reserved Qty. on Inventory");
            ItemInventory := Item1.Inventory - Item1."Reserved Qty. on Inventory";
        END;
        Stock := ItemInventory - ItemProtective;
        EXIT(Stock);
    end;

    local procedure ReplaceItm2(RI: Code[20]; CurrNo: Code[20])
    begin
        ReplaceItem1.RESET;
        ReplaceItem1.SETRANGE(ItemNo, RI);
        IF NOT ReplaceItem1.FINDFIRST THEN BEGIN
            ItemRI.RESET;
            ItemRI.SETRANGE("No.", RI);
            IF ItemRI.FINDFIRST THEN
                IF RI <> CurrNo THEN BEGIN
                    ReplaceItem.INIT;
                    ReplaceItem.CurrItem := CurrNo;
                    ReplaceItem.ChildItem := ItemRI."Replacement Part Number";
                    ReplaceItem.ParentItem := ItemRI.ParentReplacementItem;
                    ReplaceItem.ItemNo := RI;
                    ReplaceItem.Inventory := Inventory1(RI);
                    ReplaceItem.INSERT;
                END;
        END;
    end;

    local procedure FindParentRelation(RI: Code[10])
    begin
        ItemR.RESET;
        ItemR.SETCURRENTKEY(ItemR.ParentReplacementItem);
        ItemR.SETRANGE(ItemR.ParentReplacementItem, RI);
        IF ItemR.FINDSET THEN
            REPEAT
                ParentPart := ItemR."No.";
                ReplaceItemCheck(ParentPart, 2);
            UNTIL ItemR.NEXT = 0;
    end;

    local procedure FindChildRelation(RI: Code[20])
    begin
        ItemR.RESET;
        ItemR.SETCURRENTKEY(ItemR."Replacement Part Number");
        ItemR.SETRANGE(ItemR."Replacement Part Number", RI);
        IF ItemR.FINDSET THEN
            REPEAT
                ChildPart := ItemR."No.";
                ReplaceItemCheck(ChildPart, 2);
            UNTIL ItemR.NEXT = 0;
    end;



}