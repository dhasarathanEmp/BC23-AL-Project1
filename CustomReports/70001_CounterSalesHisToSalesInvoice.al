report 70001 CounterSalesHisToSalesInvoice
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemName; "Sales Header")
        {
            column(No_; "No.")
            {

            }
            trigger OnPostDataItem()
            begin
                ModifySalesInvoiceHeader(DataItemName);
                InsertCounterLinesToInvoice(DataItemName);
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group("Customer&Counter_Details")
                {
                    field("Customer No."; "Customer No.")
                    {
                        ApplicationArea = All;
                        TableRelation = Customer."No.";
                        Importance = Promoted;
                    }
                    field("Counter Document No."; "Counter Document No.")
                    {
                        ApplicationArea = All;
                        TableRelation = "Cancelled CounterSales History"."CashDocument No.";
                        Importance = Promoted;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            CSHistory: Record "Cancelled CounterSales History";
                        begin
                            CSHistory.Reset();
                            CSHistory.SetRange("CustomerNo.", "Customer No.");
                            CSHistory.SetRange(Cash, true);
                            if CSHistory.FindSet() then begin
                                if Page.RunModal(55002, CSHistory) = Action::LookupOK then begin
                                    CSHDocNo := CSHistory."Document No.";
                                    "Counter Document No." := CSHDocNo;
                                end;
                            end else
                                Error('There is no Counter Sales document were posted for this customer');
                        end;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = Excel;
            LayoutFile = 'mySpreadsheet.xlsx';
        }
    }

    var
        myInt: Integer;
        UserSetup: Record "User Setup";
        "Customer No.": Code[30];
        "Counter Document No.": Code[30];
        CSHDocNo: Code[30];

    procedure ModifySalesInvoiceHeader(SIH: Record "Sales Header")
    var
        CSHistory1: Record "Cancelled CounterSales History";
        SalesHeader1: Record "Sales Header";
    begin
        CSHistory1.RESET;
        CSHistory1.SETRANGE("Document No.", CSHDocNo);
        CSHistory1.SETRANGE(Status, CSHistory1.Status::Approved);
        CSHistory1.SETRANGE(Contact, CSHistory1."CustomerNo.");
        IF CSHistory1.FINDFIRST THEN BEGIN
            SalesHeader1.RESET;
            SalesHeader1.SETRANGE("No.", SIH."No.");
            SalesHeader1.SETRANGE("Document Type", SIH."Document Type");
            IF SalesHeader1.FINDFIRST THEN BEGIN
                SalesHeader1.VALIDATE("Currency Code", CSHistory1."Currency Code");
                SalesHeader1.VALIDATE("Applies-to Doc. Type", SalesHeader1."Applies-to Doc. Type"::Payment);
                SalesHeader1.VALIDATE("Applies-to Doc. No.", CSHistory1."CashDocument No.");
                // SalesHeader1.VALIDATE("VIN No.", CSHistory1."VIN No.");
                //SalesHeader1.VALIDATE("Vehicle Model No.", CSHistory1."Vehicle Model No.");
                //SalesHeader1.VALIDATE("Vehicle Plate No.", CSHistory1."Vehicle Plate No.");
                //SalesHeader1.VALIDATE("Service Item No.", CSHistory1."Service Item No.");
                //SalesHeader1.VALIDATE("Service Item Name", CSHistory1."Service Item Name");
                SalesHeader1.VALIDATE("VAT Bus. Posting Group", CSHistory1."VAT Bus");
                //SalesHeader1.VALIDATE("CR Document No.", CSHistory1."CashDocument No.");
                // SalesHeader1.VALIDATE("CR External Reference No.", CSHistory1."CR External Reference No.");
                //SalesHeader1."Document Type." := SalesHeader1."Document Type."::"Counter Sales";
                SalesHeader1.MODIFY;
            END;
        END;
    end;

    procedure InsertCounterLinesToInvoice(SIH: Record "Sales Header")
    var
        CSHistory1: Record "Cancelled CounterSales History";
        CSHistory2: Record "Cancelled CounterSales History";
        SalesHeader1: Record "Sales Header";
        SalesLine1: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        Item: Record Item;
        InvoiceDiscount: Decimal;
        LineNo: Integer;
    begin
        CSHistory1.RESET;
        CSHistory1.SETRANGE("Document No.", CSHDocNo);
        CSHistory1.SETRANGE(Status, CSHistory1.Status::Approved);
        CSHistory1.SETRANGE("CustomerNo.", "Customer No.");
        IF CSHistory1.FINDFIRST THEN
            repeat
                SalesLine1.RESET;
                SalesLine1.SETRANGE("No.", SIH."No.");
                SalesLine1.SETRANGE("Document Type", SIH."Document Type");
                IF SalesLine1.FindLast() THEN
                    LineNo := SalesLine1."Line No.";
                SalesLine2.INIT;
                SalesLine2."Document Type" := SIH."Document Type";
                SalesLine2."Document No." := SIH."No.";
                SalesLine2."Line No." := LineNo + 10000;
                SalesLine2.Type := SalesLine2.Type::Item;
                SalesLine2.VALIDATE(Type, SalesLine2.Type::Item);
                Item.Reset();
                if Item.Get(CSHistory1."Item No.") then begin
                    SalesLine2.VALIDATE("No.", CSHistory1."Item No.");
                    SalesLine2.Description := Item.Description;
                end;
                SalesLine2.Quantity := CSHistory1.Quantity;
                SalesLine2."Qty. to Ship" := CSHistory1.Quantity;
                SalesLine2."Qty. to Invoice" := CSHistory1.Quantity;
                SalesLine2."Unit of Measure Code" := CSHistory1."Unit of Measure Code";
                SalesLine2.VALIDATE("Unit of Measure Code");
                SalesLine2.VALIDATE(Quantity, CSHistory1.Quantity);
                SalesLine2."Location Code" := CSHistory1."Location Code";
                SalesLine2."Bin Code" := CSHistory1."Location Code";
                //SalesLine2."Shortcut Dimension 1 Code" := GetAgencyCode(CSHistory1."Item No.");
                SalesLine2.VALIDATE("Unit Price", CSHistory1."Unit Price");
                //SalesLine2."Document No.1" := CSHistory1."Document No.";
                //SalesLine2."Sales Type" := SalesLine2."Sales Type"::Sales;
                //SalesLine2."Applied Doc. No." := SH."No.";
                SalesLine2.INSERT;

            UNTIL CSHistory1.NEXT = 0;
        /*CLEAR(InvoiceDiscount);
        CSHistory2.RESET;
        CSHistory2.SETRANGE("Document No.", CSHDocNo);
        CSHistory2.SETRANGE(Status, CSHistory2.Status::Approved);
        IF CSHistory2.FINDSET THEN
            REPEAT
                InvoiceDiscount += CSHistory2.DiscountAmount1;
            UNTIL CSHistory2.NEXT = 0;

        CSHistory2.RESET;
        CSHistory2.SETRANGE("Document No.", CSHDocNo);
        CSHistory2.SETRANGE(Status, CSHistory2.Status::Approved);
        CSHistory2.SETRANGE(Contact, SIH."Sell-to Contact No.");
        IF CSHistory2.FINDFIRST THEN BEGIN
            // SalesSubform.ValidateInvoiceDiscountAmount1(SH, InvoiceDiscount);
        END;*/
    end;
}