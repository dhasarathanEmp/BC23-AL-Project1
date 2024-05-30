pageextension 70022 SalesOrderSubformExtn extends "Sales Order Subform"
{

    layout
    {
        addafter("No.")
        {
            field(Ordered_Part_No; Rec.Ordered_Part_No)
            {

            }
            field("Customer Serial No"; Rec."Customer Serial No")
            {
                Caption = 'Purchase Order Serial No';
            }
        }

        modify("No.")
        {
            trigger OnBeforeValidate()
            begin
                //Message through if it's a hose item
                Item.Reset();
                Item.SetRange("No.", Rec."No.");
                Item.SetRange("Hose Main item", true);
                if Item.FindFirst() then begin
                    SalesLine.Reset();
                    SalesLine.SetRange("No.", Rec."No.");
                    SalesLine.SetRange(Type, SalesLine.Type::Item);
                    if SalesLine.FindFirst() then
                        Message('The chosen item is a Hose Main Item');
                end;
                //Message through if it's a hose item

                //Unit price is editable if type is service item
                Item.RESET;
                IF Item.GET(Rec."No.") THEN BEGIN
                    IF Item.Type = Item.Type::Service THEN
                        PriceEditable := TRUE
                    ELSE
                        PriceEditable := FALSE
                END;
                //Unit price is editable if type is service item
            end;
        }
        modify("Unit Price")
        {
            Editable = PriceEditable;
        }

    }

    actions
    {
        addafter(OrderTracking)
        {
            action(Replacement_History)
            {
                Image = Replan;
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


    var
        Item: Record Item;
        PriceEditable: Boolean;
        SalesLine: Record "Sales Line";

}