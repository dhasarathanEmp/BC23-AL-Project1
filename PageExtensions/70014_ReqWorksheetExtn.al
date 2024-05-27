pageextension 70014 ReqWorksheetExtn extends "Req. Worksheet"
{
    layout
    {
        // Add changes to page layout here
        addafter("Vendor No.")
        {
            field("Sales Order No"; Rec."Sales Order No")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter(CalculatePlan)
        {
            action(GetOrder)
            {
                ApplicationArea = All;
                Caption = 'Get Order';
                trigger OnAction()
                var
                    GetSalesTransOrd: Report "GetSales. Trans-Orders";
                    SourceType: Integer;
                    PurchLoc: Code[20];
                    Agen: Code[20];
                    TransferHeader: Record "Transfer Header";
                    TransferOrders: Page "Transfer Orders";
                    SalesHeaderFil: Record "Sales Header";
                    SalesOrderList: Page "Sales Order List";
                begin
                    Clear(GetSalesTransOrd);
                    GetSalesTransOrd.RUNMODAL;
                    SourceType := GetSalesTransOrd.ReturnDemandType();
                    PurchLoc := GetSalesTransOrd.ReturnPurchLoc();
                    Agen := GetSalesTransOrd.ReturnAgencyCode();

                    IF SourceType = 0 THEN BEGIN
                        TransferHeader.RESET;
                        TransferHeader.SETRANGE("Transfer-from Code", PurchLoc);
                        TransferHeader.SETFILTER("Agency Code", '%1|%2', Agen, '');
                        TransferOrders.SETTABLEVIEW(TransferHeader);
                        TransferOrders.LOOKUPMODE := TRUE;
                        IF TransferOrders.RUNMODAL <> ACTION::Cancel THEN;
                    END ELSE BEGIN
                        SalesHeaderFil.RESET;
                        SalesHeaderFil.SETRANGE("Location Code", PurchLoc);
                        SalesHeaderFil.SETRANGE("Agency Code", Agen);
                        SalesOrderList.SETTABLEVIEW(SalesHeaderFil);
                        SalesOrderList.LOOKUPMODE := TRUE;
                        IF SalesOrderList.RUNMODAL <> ACTION::Cancel THEN;
                    END;
                    CurrPage.UPDATE;
                end;

            }
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}