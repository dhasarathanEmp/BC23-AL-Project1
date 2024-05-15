pageextension 50112 CustListExtn extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    begin
        RespCenter := UserSetupMgt.GetSalesFilter();
        if RespCenter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetFilter("Responsibility Center", RespCenter);
            Rec.FilterGroup(0);
        end;
    end;

    var
        UserSetupMgt: Codeunit "User Setup Management";
        RespCenter: Code[20];
        a: Integer;
}