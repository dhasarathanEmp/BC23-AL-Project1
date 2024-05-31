codeunit 70008 AssignCoreChargetoSaleLine
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCopyFromItemOnAfterCheck', '', true, true)]
    local procedure OnCopyFromItemOnAfterCheck(var SalesLine: Record "Sales Line"; Item: Record Item)
    var
        Currency: Record Currency;
    begin
        IF Currency.GET(SalesLine."Currency Code") then;
        SalesLine.CoreCharge := Item."Dealer Net - Core Deposit";
    end;
}