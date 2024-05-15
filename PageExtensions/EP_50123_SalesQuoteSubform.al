pageextension 50123 EP_50123_SalesQuoteSubform extends "Sales Quote Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Ordered Part No"; Rec.Ordered_Part_No)
            {

            }
        }
    }

    actions
    {
        addafter("Assemble to Order")
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
                            if Page.RunModal(Page::CP_50122_ItemReplacmentHis, ItemReplacementHist) = Action::LookupOK then begin
                                Rec."No." := ItemReplacementHist.ItemNo;
                                Rec.Validate("No.");
                                Rec.Ordered_Part_No := OrderedPartNo;
                                Rec.Quantity := xRec.Quantity;
                                Rec.Validate(Quantity);
                            end;
                        end;
                    end;
                end;
            }
        }
    }
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

    var
        myInt: Integer;
        ItemReplacementHist: Record CT_50121_ItemReplacementHis;
        ItemReplacementHisInsert: Record CT_50121_ItemReplacementHis;
        Item: Record Item;
        ItemInventory: Record Item;
        OrderedPartNo: Code[30];
        ParentItemNo: Code[30];
        ChildItemNo: code[30];
        InitialParentItm: Code[30];
        InitialChildItm: Code[30];
}