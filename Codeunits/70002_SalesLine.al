codeunit 70002 SalesLine
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateUnitPriceByFieldOnAfterFindPrice', '', true, true)]
    local procedure OnUpdateUnitPriceByFieldOnAfterFindPrice(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CallingFieldNo: Integer)
    var
        DefaultPriceFactor: Record "Default Price Factor";
        Item: Record Item;
        DefaultSalesPrice: Decimal;
    begin
        if SalesHeader.Special_Price_Factor <> 0 then begin
            Item.Reset();
            Item.SetRange("No.", SalesLine."No.");
            if Item.FindFirst() then begin
                DefaultSalesPrice := (((Item."Unit Price" - (Item."Dealer Net - Core Deposit" * Item."Inventory Factor")) * SalesHeader.Special_Price_Factor)
                                                + (Item."Dealer Net - Core Deposit" * Item."Inventory Factor"));
                SalesLine."Unit Price" := DefaultSalesPrice;
            end;
        end else begin
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

    end;

    [EventSubscriber(ObjectType::table, Database::"Transfer Line", 'OnBeforeVerifyReserveTransferLineQuantity', '', true, true)]
    local procedure OnBeforeVerifyReserveTransferLineQuantity(var TransferLine: Record "Transfer Line"; var IsHandled: Boolean)
    begin
        IsHandled := false;
    end;
}