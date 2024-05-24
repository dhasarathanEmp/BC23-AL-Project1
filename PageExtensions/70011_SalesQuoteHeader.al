pageextension 70011 SalesQuoteHeader extends "Sales Quote"
{
    layout
    {
        addafter(Status)
        {
            field(Special_Price_Factor; Rec.Special_Price_Factor)
            {
                trigger OnValidate()
                begin
                    ConfirmationMess := 'Do you want to apply the special price factor to all Quote Lines ?';
                    if Confirm(ConfirmationMess, true) then begin
                        UpdateSpecialPriceFactortoLines();
                    end;

                end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    procedure UpdateSpecialPriceFactortoLines()
    var
        SalesLine: Record "Sales Line";
        Item: Record Item;
        DefaultPriceFactor: Record "Default Price Factor";
        SpecialPriceFactorSalesPrice: Decimal;
        DefaultFactorSalesPrice: Decimal;
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        GeneralLedgerSetup.FindFirst();
        if Rec.Status = Rec.Status::Open then begin
            if Rec.Special_Price_Factor <> 0 then begin // If special factory field have in sales header value the below code will execute
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", Rec."Document Type");
                SalesLine.SETRANGE("Document No.", Rec."No.");
                SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                IF SalesLine.FINDSET THEN
                    REPEAT
                        SpecialPriceFactorSalesPrice := 0;
                        SpecialPriceFactorSalesPrice := (((Item."Unit Price" - (Item."Dealer Net - Core Deposit" * Item."Inventory Factor")) * Rec.Special_Price_Factor)
                            + (Item."Dealer Net - Core Deposit" * Item."Inventory Factor")) * SalesLine."Qty. per Unit of Measure";
                        if (Rec."Currency Code" <> '') AND (Rec."Currency Code" <> GeneralLedgerSetup."LCY Code") then begin // If sales header have Currency Code, the Amount Convertion and Rounding Precision calculation below code will work 
                            Currency.Reset();
                            Currency.get(Rec."Currency Code");
                            SpecialPriceFactorSalesPrice := ConvertPricetoDocumentCurrency(SpecialPriceFactorSalesPrice);
                            SpecialPriceFactorSalesPrice := Round(SpecialPriceFactorSalesPrice, Currency."Unit-Amount Rounding Precision", '=');
                        end else begin // if sales header doesn't have curreny code
                            SpecialPriceFactorSalesPrice := Round(SpecialPriceFactorSalesPrice, GeneralLedgerSetup."Unit-Amount Rounding Precision", '=');
                        end;
                        SalesLine."Unit Price" := SpecialPriceFactorSalesPrice;
                        SalesLine.Validate("Unit Price");
                        SalesLine.Modify();
                    until SalesLine.Next = 0;
            end else begin // If user removes Special price factor after applied, the initial unit price will be updated through below code
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", Rec."Document Type");
                SalesLine.SETRANGE("Document No.", Rec."No.");
                SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                IF SalesLine.FINDSET THEN
                    REPEAT
                        DefaultFactorSalesPrice := 0;
                        DefaultPriceFactor.Reset();
                        DefaultPriceFactor.SetRange("Agency Code", SalesLine."Gen. Prod. Posting Group");
                        if DefaultPriceFactor.FindFirst() then begin
                            DefaultFactorSalesPrice := (((Item."Unit Price" - (Item."Dealer Net - Core Deposit" * Item."Inventory Factor")) * DefaultPriceFactor."Default Price Factor")
                                                       + (Item."Dealer Net - Core Deposit" * Item."Inventory Factor")) * SalesLine."Qty. per Unit of Measure";

                        end;
                        if (Rec."Currency Code" <> '') AND (Rec."Currency Code" <> GeneralLedgerSetup."LCY Code") then begin // If sales header have Currency Code
                            Currency.Reset();
                            Currency.get(Rec."Currency Code");
                            SpecialPriceFactorSalesPrice := ConvertPricetoDocumentCurrency(SpecialPriceFactorSalesPrice);
                            SpecialPriceFactorSalesPrice := Round(SpecialPriceFactorSalesPrice, Currency."Unit-Amount Rounding Precision", '=');
                        end else begin // if sales header doesn't have curreny code
                            SpecialPriceFactorSalesPrice := Round(SpecialPriceFactorSalesPrice, GeneralLedgerSetup."Unit-Amount Rounding Precision", '=');
                        end;
                        SalesLine."Unit Price" := DefaultFactorSalesPrice;
                        SalesLine.Validate("Unit Price");
                        SalesLine.Modify();
                    until SalesLine.Next = 0;
            end;
        end;
    end;

    procedure ConvertPricetoDocumentCurrency(var CalculatedPrice: Decimal) ReturnConvertedPrice: Decimal
    var
        CurrencyExcRate: Record "Currency Exchange Rate";
    begin
        ReturnConvertedPrice := CurrencyExcRate.ExchangeAmtLCYToFCY(Rec."Order Date", Rec."Currency Code", CalculatedPrice, 1);
    end;

    var
        myInt: Integer;
        ConfirmManagement: Codeunit "Confirm Management";
        ConfirmationMess: Text;
        CurrencyConvertedPrice: Decimal;
}