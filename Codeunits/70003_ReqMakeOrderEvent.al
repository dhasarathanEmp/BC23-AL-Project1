codeunit 70003 ReqMakeOrderEvent
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterInitPurchOrderLine', '', true, true)]
    local procedure OnAfterInitPurchOrderLine(var PurchaseLine: Record "Purchase Line"; RequisitionLine: Record "Requisition Line")
    begin
        PurchaseLine."Req Line No." := RequisitionLine."Line No.";
    end;
}