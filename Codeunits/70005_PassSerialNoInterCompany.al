codeunit 70005 PassSNoIntercompany
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnBeforeICInboxSalesLineInsert', '', true, true)]
    local procedure OnBeforeICInboxSalesLineInsert(var ICInboxSalesLine: Record "IC Inbox Sales Line"; ICOutboxPurchaseLine: Record "IC Outbox Purchase Line")
    begin
        ICInboxSalesLine."Customer Serial No" := ICOutboxPurchaseLine."Serial No";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnAfterCreateSalesLines', '', true, true)]
    local procedure OnAfterCreateSalesLines(ICInboxSalesLine: Record "IC Inbox Sales Line"; var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
    begin
        SalesLine."Customer Serial No" := ICInboxSalesLine."Customer Serial No";
    end;
}