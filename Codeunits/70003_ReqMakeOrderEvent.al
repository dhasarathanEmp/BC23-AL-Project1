//Code to pass the requisition line No. to PurchaseLine No.
/*This is required to Auto Reserve Purchase Order created through the requisition worksheet to
corresponding SO/TO/AO*/
codeunit 70003 ReqMakeOrderEvent
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterInitPurchOrderLine', '', true, true)]
    local procedure OnAfterInitPurchOrderLine(var PurchaseLine: Record "Purchase Line"; RequisitionLine: Record "Requisition Line")
    begin
        PurchaseLine."Req Line No." := RequisitionLine."Line No.";
    end;
}