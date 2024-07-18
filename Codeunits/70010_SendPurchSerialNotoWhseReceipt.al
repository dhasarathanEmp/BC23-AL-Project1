codeunit 70010 SendPurchSNotoWhseReceipt
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchases Warehouse Mgt.", 'OnPurchLine2ReceiptLineOnAfterInitNewLine', '', true, true)]
    local procedure OnPurchLine2ReceiptLineOnAfterInitNewLine(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        //GRN Rpt
        WarehouseReceiptLine."Serial No" := PurchaseLine."Serial No";
        WarehouseReceiptLine."Unit Price" := PurchaseLine."Direct Unit Cost";
        WarehouseReceiptLine.Amount := PurchaseLine."Line Amount";
        //Cu012
        WarehouseReceiptLine.VendorNo := PurchaseLine."Buy-from Vendor No.";
        //Cu012
        //
    end;

    var
        a: codeunit "Whse.-Post Receipt";
}