codeunit 70002 SalesLine
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateUnitPriceByFieldOnAfterFindPrice', '', true, true)]
    local procedure OnUpdateUnitPriceByFieldOnAfterFindPrice(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CallingFieldNo: Integer)
    var
        DefaultPriceFactor: Record "Default Price Factor";
        Item: Record Item;
        DefaultSalesPrice: Decimal;
    begin
        DefaultPriceFactor.Reset();
        DefaultPriceFactor.SetRange("Agency Code", SalesLine."Gen. Prod. Posting Group");
        if DefaultPriceFactor.FindFirst() then begin
            Item.Reset();
            Item.SetRange("No.", SalesLine."No.");
            if Item.FindFirst() then begin
                DefaultSalesPrice := (((Item."Unit Price" - (Item."Dealer Net - Core Deposit" * Item."Inventory Factor")) * DefaultPriceFactor."Default Price Factor")
                            + (Item."Dealer Net - Core Deposit" * Item."Inventory Factor"));
                SalesLine."Unit Price" := DefaultSalesPrice;
            end;
        end;
    end;
}