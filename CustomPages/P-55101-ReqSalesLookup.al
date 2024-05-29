page 55101 ReqSalesLookup
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Header";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::LookupOK] THEN
            selectionfilterforReq();
    end;

    local procedure selectionfilterforReq()
    var
        GetHOOrders: Codeunit GetHOOrders;
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        GetHOOrders.GetHOSaleOrders(Rec);
    end;
}