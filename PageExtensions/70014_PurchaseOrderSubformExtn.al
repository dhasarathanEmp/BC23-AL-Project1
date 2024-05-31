pageextension 70014 PurchaseOrderSubformExtn extends "Purchase Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Serial No"; Rec."Serial No")
            {

            }
        }
        addafter("Expected Receipt Date")
        {
            field("Part Type"; Rec."Part Type")
            {

            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Item Availability by")
        {
            action(Replacement_History)
            {
                trigger OnAction()
                begin
                    OrderedPartNo := '';
                    ParentItemNo := '';
                    ChildItemNo := '';
                    ItemReplacementHist.Reset();
                    ItemReplacementHist.SetRange(LocationCode, Rec."Location Code");
                    if ItemReplacementHist.FindSet() then
                        ItemReplacementHist.DeleteAll();

                    Item.Reset();
                    Item.SetRange("No.", Rec."No.");
                    IF Item.FindFirst() then begin
                        if (Item."Replacement Part Number" <> '') OR (Item.ParentReplacementItem <> '') then begin
                            InitialParentItm := Item.ParentReplacementItem;
                            InitialChildItm := Item."Replacement Part Number";
                            OrderedPartNo := Rec."No.";
                            Initial_Parent_ChildRelation(InitialParentItm, InitialChildItm);
                            Commit();
                            ItemReplacementHist.Reset();
                            ItemReplacementHist.SetRange(LocationCode, Rec."Location Code");
                            if Page.RunModal(Page::ReplacementItem, ItemReplacementHist) = Action::LookupOK then begin
                                CancelReserve();
                                Rec."No." := ItemReplacementHist.ItemNo;
                                Rec.Validate("No.");
                                Rec.LastPartNumber := OrderedPartNo;
                                Rec.Quantity := xRec.Quantity;
                                Rec.Validate(Quantity);
                                Rec.VALIDATE("Direct Unit Cost", xRec."Direct Unit Cost");
                                Rec.VALIDATE("Expected Receipt Date", xRec."Expected Receipt Date");
                                Rec."Serial No" := xRec."Serial No";
                            end;
                        end;
                    end;
                end;
            }
        }
    }

    var
        ReservationCancellationHist: Record "Reservation Cancellation Hist.";
        TempLine: Integer;
        ItemReplacementHist: Record ReplacementItem;
        ItemReplacementHisInsert: Record ReplacementItem;
        Item: Record Item;
        ItemInventory: Record Item;
        OrderedPartNo: Code[30];
        ParentItemNo: Code[30];
        ChildItemNo: code[30];
        InitialParentItm: Code[30];
        InitialChildItm: Code[30];

    LOCAL procedure CancelReserve()
    var
        ReservationEntry: Record "Reservation Entry";
        ReservationEngineMgt: Codeunit "Reservation Engine Mgt.";
    begin
        ReservationEntry.RESET;
        ReservationEntry.SETRANGE("Source ID", Rec."Document No.");
        ReservationEntry.SETRANGE("Source Ref. No.", Rec."Line No.");
        ReservationEntry.SETRANGE("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
        IF ReservationEntry.FINDSET THEN
            REPEAT
                InsertCancellationHistory_Full(ReservationEntry);
                ReservationEngineMgt.CancelReservation(ReservationEntry);
            UNTIL ReservationEntry.NEXT = 0;
    end;

    LOCAL procedure InsertCancellationHistory_Full(ReservationEntry2: Record "Reservation Entry")
    var
        ReservationEntry3: Record "Reservation Entry";
    begin
        //EP9617
        ReservationCancellationHist.RESET;
        //IF ReservationCancellationHist.FINDLAST THEN BEGIN
        GetLastLineNo;
        ReservationCancellationHist."Line No." := TempLine;
        ReservationCancellationHist."Cancelled By" := USERID;
        ReservationCancellationHist."Reservation Cancelled On." := TODAY;
        ReservationCancellationHist."Item No." := Rec."No.";
        ReservationCancellationHist."Cancelled Qty." := ReservationEntry2."Quantity (Base)";
        ReservationCancellationHist."Location Code" := Rec."Location Code";
        ReservationCancellationHist."Reason Code" := 'Replacement';
        ReservationCancellationHist."Reservation Cancelled For" := 'Replacement';
        ReservationEntry3.RESET;
        IF ReservationEntry2.Positive = TRUE THEN BEGIN
            IF ReservationEntry3.GET(ReservationEntry2."Entry No.", FALSE) THEN BEGIN
                ReservationCancellationHist."Reservation Cancelled From" := ReservationEntry2."Source ID";
                ReservationCancellationHist."Reserved In" := ReservationEntry3."Source ID";
            END;
        END;
        ReservationCancellationHist.INSERT;

        //END ;
        //EP9617
    end;

    LOCAL procedure GetLastLineNo()
    begin
        ReservationCancellationHist.RESET;
        IF ReservationCancellationHist.FINDLAST THEN
            TempLine := ReservationCancellationHist."Line No." + 1
        ELSE
            TempLine := 1;
    end;

    procedure Initial_Parent_ChildRelation(ParentItm: Code[30]; ChildItm: Code[30])
    begin
        if ParentItm <> '' then begin
            ParentInsert(ParentItm);
        end;
        if ChildItm <> '' then begin
            ChildInsert(ChildItm);
        end;
    end;

    procedure ParentInsert(CurParentItm: Code[30])
    begin
        ParentItemNo := '';
        ChildItemNo := '';
        ItemReplacementHist.Reset();
        ItemReplacementHist.SetRange(ItemNo, CurParentItm);
        if not ItemReplacementHist.FindFirst() then begin
            Item.Reset();
            Item.SetRange("No.", CurParentItm);
            if Item.FindFirst() then begin
                Item.CalcFields(Inventory);
                ItemReplacementHisInsert.Reset();
                ItemReplacementHisInsert.ItemNo := CurParentItm;
                ItemReplacementHisInsert.ChildItem := Item."Replacement Part Number";
                ItemReplacementHisInsert.ParentItem := Item.ParentReplacementItem;
                ItemReplacementHisInsert.LocationCode := Rec."Location Code";
                if Item.Inventory > 0 then begin
                    ItemInventory.Reset();
                    ItemInventory.SetRange("No.", CurParentItm);
                    ItemInventory.SetRange("Location Filter", Rec."Location Code");
                    if ItemInventory.FindFirst() then begin
                        ItemReplacementHisInsert.Inventory := ItemInventory.Inventory;
                    end;
                end;
                ItemReplacementHisInsert.CurrItem := OrderedPartNo;
                IF ItemReplacementHisInsert.ItemNo <> '' then
                    ItemReplacementHisInsert.Insert();
                if Item.ParentReplacementItem <> '' then begin
                    if Item.ParentReplacementItem <> Rec."No." then
                        ParentItemNo := Item.ParentReplacementItem;
                end;
                FurtherRelationCheck();
            end;
        end;
    end;

    procedure ChildInsert(CurrChildItem: Code[30])
    begin
        ParentItemNo := '';
        ChildItemNo := '';
        ItemReplacementHist.Reset();
        ItemReplacementHist.SetRange(ItemNo, CurrChildItem);
        if not ItemReplacementHist.FindFirst() then begin
            Item.Reset();
            Item.SetRange("No.", CurrChildItem);
            if Item.FindFirst() then begin
                Item.CalcFields(Inventory);
                ItemReplacementHisInsert.Reset();
                ItemReplacementHisInsert.ItemNo := CurrChildItem;
                ItemReplacementHisInsert.ChildItem := Item."Replacement Part Number";
                ItemReplacementHisInsert.ParentItem := Item.ParentReplacementItem;
                ItemReplacementHisInsert.LocationCode := Rec."Location Code";
                if Item.Inventory > 0 then begin
                    ItemInventory.Reset();
                    ItemInventory.SetRange("No.", CurrChildItem);
                    ItemInventory.SetRange("Location Filter", Rec."Location Code");
                    if ItemInventory.FindFirst() then begin
                        ItemReplacementHisInsert.Inventory := ItemInventory.Inventory;
                    end;
                end;
                ItemReplacementHisInsert.CurrItem := OrderedPartNo;
                IF ItemReplacementHisInsert.ItemNo <> '' then
                    ItemReplacementHisInsert.Insert();
                if Item.ParentReplacementItem <> '' then begin
                    if Item.ParentReplacementItem <> Rec."No." then
                        ParentItemNo := Item.ParentReplacementItem;
                end;
                if Item."Replacement Part Number" <> '' then begin
                    if CurrChildItem <> Item."Replacement Part Number" then
                        ChildItemNo := Item."Replacement Part Number";
                end;
                FurtherRelationCheck();
            end;
        end;
    end;

    procedure FurtherRelationCheck()
    begin
        if ParentItemNo <> '' then begin
            ParentInsert(ParentItemNo);
        end;
        if ChildItemNo <> '' then begin
            ChildInsert(ChildItemNo);
        end;
    end;
}