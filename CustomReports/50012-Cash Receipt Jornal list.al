report 50012 "Cash Receipt Jornal list"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Cash Receipt Jornal list.rdlc';

    dataset
    {
        dataitem(DataItem1; "G/L Entry")
        {
            DataItemTableView = SORTING("Document No.", "Posting Date")
                                WHERE("Document Type" = CONST(Payment),
                                      Amount = FILTER(> 0));
            RequestFilterFields = "Document No.";
            column(PostingDate_GLEntry; "Posting Date")
            {
            }
            column(DocumentType_GLEntry; "Document Type")
            {
            }
            column(DocumentNo_GLEntry; "Document No.")
            {
            }
            column(Description_GLEntry; Description)
            {
            }
            column(Amount_GLEntry; Amount)
            {
            }
            column(FromDate; FromDate)
            {
            }
            column(ToDate; ToDate)
            {
            }
            column(Doc; Doc)
            {
            }
            column(CNAme; CNAme)
            {
            }
            column(CUCode; CUCode)
            {
            }
            column(AmountinUSD; AmountinUSD)
            {
            }
            column(TaxinUSD; TaxinUSD)
            {
            }
            column(AmountinvatUSD; AmountinvatUSD)
            {
            }
            column(Curr; Curr)
            {
            }
            column(VATAmount_GLEntry; "VAT Amount")
            {
            }
            column(SumAmount; SumAmount)
            {
            }
            column(Sumtax; Sumtax)
            {
            }
            column(SumofAmount; SumofAmount)
            {
            }
            column(Amountcal; Amountcal)
            {
            }
            column(Amountcal1; Amountcal1)
            {
            }
            column(Amountcal2; Amountcal2)
            {
            }
            dataitem(DataItem9; "Sales Invoice Header")
            {
                CalcFields = Amount, "Amount Including VAT";
                DataItemLink = "Applies-to Doc. No." = FIELD("Document No.");
                DataItemTableView = SORTING("No.");
                column(AppliestoDocNo_SalesInvoiceHeader; "Applies-to Doc. No.")
                {
                }
                column(PostingDate_SalesInvoiceHeader; "Posting Date")
                {
                }
                column(Amount_SalesInvoiceHeader; Amount)
                {
                }
                column(CurrencyCode_SalesInvoiceHeader; "Currency Code")
                {
                }
                column(AmountIncludingVAT_SalesInvoiceHeader; "Amount Including VAT")
                {
                }
                column(No_SalesInvoiceHeader; "No.")
                {
                }
                column(Tax; Tax)
                {
                }
                dataitem(DataItem28; "Company Information")
                {
                    column(Name_CompanyInformation; Name)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    Tax := ("Sales Invoice Header".Amount * 5 / 100);
                    Curr := "Sales Invoice Header"."Currency Code";
                    IF Curr = '' THEN
                        Curr := 'USD';
                    VATEntry.RESET;
                    VATEntry.SETRANGE("Document Type", VATEntry."Document Type"::Invoice);
                    VATEntry.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                    IF VATEntry.FINDFIRST THEN BEGIN
                        Amountgl := -(VATEntry.Base);
                        Amountgl1 := -(VATEntry.Amount);
                        postingdate := VATEntry."Posting Date";
                        Currency := ' ';
                    END;
                    CLEAR(AmountinvatUSD);
                    //  Amount
                    IF CUCode = CUCode::USD THEN BEGIN
                        IF ("Sales Invoice Header"."Currency Code" <> '') THEN BEGIN
                            "Currency Factor" := CurrExchRate.ExchangeRate(WORKDATE, "Sales Invoice Header"."Currency Code");
                            AmountinvatUSD := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Amount Including VAT", "Currency Factor"));
                        END
                        ELSE
                            IF "Sales Invoice Header"."Currency Code" = '' THEN
                                AmountinvatUSD := ROUND("Sales Invoice Header"."Amount Including VAT");
                    END ELSE
                        IF CUCode = CUCode::YER THEN BEGIN
                            IF ("Sales Invoice Header"."Currency Code" <> 'YER') AND ("Sales Invoice Header"."Currency Code" <> '') THEN
                                AmountinvatUSD := ROUND(CurrExchRate.ExchangeAmtFCYToFCY("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 'YER', "Sales Invoice Header"."Amount Including VAT"))
                            ELSE
                                IF "Sales Invoice Header"."Currency Code" = '' THEN BEGIN
                                    "Currency Factor" := CurrExchRate.ExchangeRate("Sales Invoice Header"."Posting Date", 'YER');
                                    AmountinvatUSD := ROUND(CurrExchRate.ExchangeAmtLCYToFCY("Sales Invoice Header"."Posting Date", 'YER', "Sales Invoice Header"."Amount Including VAT", "Currency Factor"));
                                END ELSE
                                    IF "Sales Invoice Header"."Currency Code" = 'YER' THEN
                                        AmountinvatUSD := ROUND("Sales Invoice Header"."Amount Including VAT");
                        END;
                    SumofAmount += ROUND(AmountinvatUSD, 0.01);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CancelledCounterSalesHistory.RESET;
                CancelledCounterSalesHistory.SETRANGE("CashDocument No.", "G/L Entry"."Document No.");
                IF CancelledCounterSalesHistory.FINDFIRST THEN BEGIN
                    Doc := CancelledCounterSalesHistory."Document No.";
                    CNAme := CancelledCounterSalesHistory."Contact Name";
                END
                ELSE BEGIN
                    Doc := '';
                    CNAme := '';
                END;


                Countersales(Doc);
            end;

            trigger OnPreDataItem()
            begin
                IF ToDate = 0D THEN
                    ToDate := WORKDATE;
                "G/L Entry".SETRANGE("G/L Entry"."Posting Date", FromDate, ToDate);


                SumAmount := 0;
                SumofAmount := 0;
                Sumtax := 0;
                TaxCost := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Date)
                {
                    field("From Date"; FromDate)
                    {
                        DateFormula = false;

                        trigger OnValidate()
                        begin
                            FromDate := FromDate;
                        end;
                    }
                    field("To Date"; ToDate)
                    {

                        trigger OnValidate()
                        begin
                            ToDate := ToDate;
                        end;
                    }
                    field("Required Currency"; CUCode)
                    {

                        trigger OnValidate()
                        begin
                            CurrencyCode := FORMAT(CUCode);
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        FromDate: Date;
        ToDate: Date;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CancelledCounterSalesHistory: Record "Cancelled CounterSales History";
        Doc: Code[20];
        CNAme: Text[100];
        "Currency Factor": Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        SalesInvoiceLine: Record "Sales Invoice Line";
        "Posting Date": Date;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Tax: Decimal;
        CUCode: Option USD,YER;
        CurrencyCode: Text;
        AmountinUSD: Decimal;
        TaxinUSD: Decimal;
        AmountinvatUSD: Decimal;
        LineAmount: Decimal;
        Curr: Code[20];
        TaxCost: Decimal;
        TaxWithamount: Decimal;
        GLEntry: Record "G/L Entry";
        Amountgl: Decimal;
        Amountgl1: Decimal;
        VATEntry: Record "VAT Entry";
        Currency: Code[10];
        postingdate: Date;
        SumAmount: Decimal;
        Sumtax: Decimal;
        SumofAmount: Decimal;
        Amounttax: Decimal;
        Amountcal: Decimal;
        Amountcal1: Decimal;
        Amountcal2: Decimal;
        "Sales Invoice Header": Record "Sales Invoice Header";
        "G/L Entry": Record "G/L Entry";

    local procedure Countersales(DocNo: Code[20])
    begin
        CLEAR(LineAmount);
        CancelledCounterSalesHistory.RESET;
        CancelledCounterSalesHistory.SETRANGE("Document No.", DocNo);
        CancelledCounterSalesHistory.SETRANGE(Status, CancelledCounterSalesHistory.Status::Approved);
        IF CancelledCounterSalesHistory.FINDSET THEN
            REPEAT
                LineAmount += ROUND(CancelledCounterSalesHistory."Line Amount");
                Curr := CancelledCounterSalesHistory."Currency Code";
            UNTIL CancelledCounterSalesHistory.NEXT = 0;

        Amounttax := ROUND(LineAmount, 0.01);
        TaxWithamount := ROUND((LineAmount + (LineAmount * 5 / 100)), 0.01);
        TaxCost := ROUND(TaxWithamount - Amounttax);
        //
        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETRANGE("Document No.1", DocNo);
        IF SalesInvoiceLine.ISEMPTY THEN BEGIN
            Curr := CancelledCounterSalesHistory."Currency Code";

            CLEAR(AmountinvatUSD);
            //  Amount
            IF CUCode = CUCode::USD THEN BEGIN
                IF (Curr <> '') THEN BEGIN
                    "Currency Factor" := CurrExchRate.ExchangeRate(WORKDATE, Curr);
                    AmountinvatUSD := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(CancelledCounterSalesHistory."Date of Enquiry", Curr, TaxWithamount, "Currency Factor"));
                END
                ELSE
                    IF "Sales Invoice Header"."Currency Code" = '' THEN
                        AmountinvatUSD := "Sales Invoice Header".Amount;
            END ELSE
                IF CUCode = CUCode::YER THEN BEGIN
                    IF (Curr <> 'YER') AND (Curr <> '') THEN
                        AmountinvatUSD := ROUND(CurrExchRate.ExchangeAmtFCYToFCY(CancelledCounterSalesHistory."Date of Enquiry", Curr, 'YER', TaxWithamount))
                    ELSE
                        IF Curr = '' THEN BEGIN
                            "Currency Factor" := CurrExchRate.ExchangeRate(CancelledCounterSalesHistory."Date of Enquiry", 'YER');
                            AmountinvatUSD := ROUND(CurrExchRate.ExchangeAmtLCYToFCY(CancelledCounterSalesHistory."Date of Enquiry", 'YER', TaxWithamount, "Currency Factor"));
                        END ELSE
                            IF Curr = 'YER' THEN
                                AmountinvatUSD := ROUND(TaxWithamount);
                END;
            SumofAmount += ROUND(AmountinvatUSD, 0.01);

        END;
        IF (Curr <> '') THEN
            TaxinUSD := AmountinvatUSD - AmountinUSD;
    end;
}

