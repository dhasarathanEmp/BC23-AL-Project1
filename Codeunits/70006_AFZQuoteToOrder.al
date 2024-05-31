codeunit 70006 AFZQuoteToOrder
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeModifySalesOrderHeader', '', true, true)]
    local procedure OnBeforeModifySalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    begin
        //Cu015
        CompanyInfo.GET;
        IF CompanyInfo.AFZ THEN BEGIN
            SalesOrderHeader."Invoice Discount Calculation" := SalesOrderHeader."Invoice Discount Calculation"::None;
            SalesOrderHeader."Invoice Discount Amount" := 0;
            SalesOrderHeader."Invoice Discount Value" := 0;
            SalesOrderHeader.AFZDiscount := SalesOrderHeader."Invoice Discount%";
            SalesOrderHeader."Invoice Discount%" := 0;
        END;
        //Cu015
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderLine', '', TRUE, true)]
    local procedure OnBeforeInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    begin
        //Cu015
        CompanyInfo.Get;
        IF CompanyInfo.AFZ THEN BEGIN
            SalesOrderLine."Unit Price" := (SalesOrderLine."Unit Price" - SalesOrderLine.CoreCharge) * (100 - SalesOrderHeader.AFZDiscount) / 100 + SalesOrderLine.CoreCharge;
            SalesOrderLine."Unit Price" := ROUND(SalesOrderLine."Unit Price", 0.01, '=');
            SalesOrderLine."Inv. Discount Amount" := 0;
        END;
        //Cu015
    end;

    var
        CompanyInfo: Record "Company Information";
}