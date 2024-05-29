page 55100 ReqTransLookup
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Transfer Header";
    Editable = false;
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
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;

                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
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
        GetHOOrders.GetHOOrders(Rec);
    end;
}