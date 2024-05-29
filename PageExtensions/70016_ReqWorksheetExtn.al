pageextension 70016 ReqWorksheetExtn extends "Req. Worksheet"
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
                    ReqTransLookup: Page ReqTransLookup;
                    SalesHeaderFil: Record "Sales Header";
                    ReqSalesLookup: Page ReqSalesLookup;
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
                        ReqTransLookup.SETTABLEVIEW(TransferHeader);
                        ReqTransLookup.LOOKUPMODE := TRUE;
                        IF ReqTransLookup.RUNMODAL <> ACTION::Cancel THEN;
                    END ELSE BEGIN
                        SalesHeaderFil.RESET;
                        SalesHeaderFil.SETRANGE("Location Code", PurchLoc);
                        SalesHeaderFil.SETRANGE("Agency Code", Agen);
                        ReqSalesLookup.SETTABLEVIEW(SalesHeaderFil);
                        ReqSalesLookup.LOOKUPMODE := TRUE;
                        IF ReqSalesLookup.RUNMODAL <> ACTION::Cancel THEN;
                    END;
                    CurrPage.UPDATE;
                end;
            }
        }
        addafter(CalculatePlan_Promoted)
        {
            actionref(GetOrder_Promoted; GetOrder)
            {
            }
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}