codeunit 70007 DiscPer
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnAfterCalculateSalesSubPageTotals', '', true, true)]
    local procedure OnAfterCalculateSalesSubPageTotals(var TotalSalesHeader: Record "Sales Header"; var TotalSalesLine: Record "Sales Line"; var VATAmount: Decimal; var InvoiceDiscountAmount: Decimal; var InvoiceDiscountPct: Decimal; var TotalSalesLine2: Record "Sales Line")
    begin
        InvoiceDiscountPct := TotalSalesHeader."Invoice Discount%";
    end;
}