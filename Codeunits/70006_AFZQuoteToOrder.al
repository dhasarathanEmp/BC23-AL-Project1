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
            //SalesOrderHeader.AFZDiscount := SalesOrderHeader."Invoice Discount%";
            SalesOrderHeader."Invoice Discount%" := 0;
        END;
        //Cu015
    end;

    var
        CompanyInfo: Record "Company Information";
}