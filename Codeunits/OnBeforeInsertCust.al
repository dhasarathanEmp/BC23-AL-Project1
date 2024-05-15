codeunit 50110 OnBeforeInsertCust
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeInsert', '', true, true)]
    local procedure OnBeforeInsert(var Customer: Record Customer; var IsHandled: Boolean)
    begin
        RespCenter := UserSetupMgt.GetSalesFilter();
        if RespCenter <> '' then begin
            Customer."Responsibility Center" := RespCenter;
            NoSeries.Reset();
            NoSeries.SetRange("Responsibility Center", RespCenter);
            NoSeries.SetRange("Customer Check", true);
            if NoSeries.FindFirst() then
                NoSeriesMgt.InitSeries(NoSeries.Code, '', 0D, Customer."No.", Customer."No. Series");
        end else begin
            NoSeries.Reset();
            NoSeries.SetRange("Customer Check", true);
            IF Page.RunModal(0, NoSeries) = Action::LookupOK then begin
                NoSeriesMgt.InitSeries(NoSeries.Code, '', 0D, Customer."No.", Customer."No. Series");
                Customer."Responsibility Center" := NoSeries."Responsibility Center";
            end;
        end;
    end;

    var
        NoSeries: Record "No. Series";
        UserSetupMgt: Codeunit "User Setup Management";
        RespCenter: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
}