codeunit 70011 ResendPricetoPurch
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnInitSourceDocumentLinesOnAfterSourcePurchLineFound', '', true, true)]
    local procedure OnInitSourceDocumentLinesOnAfterSourcePurchLineFound(var PurchaseLine: Record "Purchase Line"; WhseRcptLine: Record "Warehouse Receipt Line"; var ModifyLine: Boolean; WhseRcptHeader: Record "Warehouse Receipt Header")
    begin
        //Cu012
        IF PurchaseLine."Direct Unit Cost" <> WhseRcptLine."Unit Price" THEN BEGIN
            PurchaseLine.SuspendStatusCheck(TRUE);
            PurchaseLine.VALIDATE("Direct Unit Cost", WhseRcptLine."Unit Price");
            PurchaseLine.SuspendStatusCheck(FALSE);
            ModifyLine := TRUE
        END;
        //Cu012
    end;
}