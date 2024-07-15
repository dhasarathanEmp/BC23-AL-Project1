report 50005 "Sales Quote"
{
    // Fx 02 Changed all STK fields and PAB fields to Decimal from Integer
    DefaultLayout = RDLC;
    RDLCLayout = './Sales Quote.rdlc';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem32; "Company Information")
        {
            column(FaxNo_CompanyInformation; "Fax No.")
            {
            }
            column(Name2_CompanyInformation; "Name 2")
            {
            }
            column(VATRegistrationNo_CompanyInformation; "VAT Registration No.")
            {
            }
            column(Address_CompanyInformation; Address)
            {
            }
            column(Address2_CompanyInformation; "Address 2")
            {
            }
            column(City_CompanyInformation; City)
            {
            }
            column(PhoneNo_CompanyInformation; "Phone No.")
            {
            }
            column(Name_CompanyInformation; Name)
            {
            }
            column(IsADFZ; IsADFZ)
            {
            }
            dataitem(DataItem1; "Sales Header")
            {
                DataItemTableView = SORTING("Document Type", "No.")
                                    WHERE("Document Type" = CONST(Quote));
                RequestFilterFields = "Document Type", "No.";
                column(InvoiceDiscountValue_SalesHeader; "Invoice Discount Value")
                {
                }
                column(InvoiceDiscount_SalesHeader; "Invoice Discount%")
                {
                }
                column(PaymentDiscount_SalesHeader; "Payment Discount %")
                {
                }
                column(DocumentType_SalesHeader; "Document Type")
                {
                }
                column(PriceValidate_SalesHeader; "Price Validate")
                {
                }
                column(DeliveryTerms_SalesHeader; "Delivery Terms")
                {
                }
                column(InvoiceDiscountAmount_SalesHeader; "Invoice Discount Amount")
                {
                }
                column(SelltoCustomerNo_SalesHeader; "Sell-to Customer No.")
                {
                }
                column(No_SalesHeader; "No.")
                {
                }
                column(BilltoCustomerNo_SalesHeader; "Bill-to Customer No.")
                {
                }
                column(BilltoName_SalesHeader; "Bill-to Name")
                {
                }
                column(BilltoName2_SalesHeader; "Bill-to Name 2")
                {
                }
                column(QuoteNo_SalesHeader; "Quote No.")
                {
                }
                column(OrderDate_SalesHeader; "Order Date")
                {
                }
                column(BilltoCountryRegionCode_SalesHeader; "Bill-to Country/Region Code")
                {
                }
                column(BilltoPostCode_SalesHeader; "Bill-to Post Code")
                {
                }
                column(BilltoCounty_SalesHeader; "Bill-to County")
                {
                }
                column(BilltoAddress_SalesHeader; "Bill-to Address")
                {
                }
                column(BilltoAddress2_SalesHeader; "Bill-to Address 2")
                {
                }
                column(BilltoCity_SalesHeader; "Bill-to City")
                {
                }
                column(BilltoContact_SalesHeader; "Bill-to Contact")
                {
                }
                column(AmountInWordes; AmountInWordes)
                {
                }
                column(WorkDescription_SalesHeader; "Work Description")
                {
                }
                column(DescIntroText1; DescIntroText1)
                {
                }
                column(DescConclText1; DescConclText1)
                {
                }
                column(Curr; Curr)
                {
                }
                column(LocName; LocName)
                {
                }
                column(LocAddress; LocAddress)
                {
                }
                column(LocAddress2; LocAddress2)
                {
                }
                column(LocCity; LocCity)
                {
                }
                column(LocPhone; LOCPhone)
                {
                }
                column(LocFaxNo; LocFaxNo)
                {
                }
                column(LocCountry; LocCountry)
                {
                }
                column(LocPostcode; LocPostcode)
                {
                }
                column(UserName; UserName)
                {
                }
                column(BillToContact; BillToContact)
                {
                }
                column(CountryRegion; CountryRegion1)
                {
                }
                column(ItemCategoryDesc; ItemCategoryDesc)
                {
                }
                dataitem(DataItem17; "Sales Line")
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"),
                                   "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                        WHERE(Quantity = FILTER(> 0));
                    column(LineDiscount_SalesLine; "Line Discount %")
                    {
                    }
                    column(Amount_SalesLine; Amount)
                    {
                    }
                    column(AmountIncludingVAT_SalesLine; "Amount Including VAT")
                    {
                    }
                    column(UnitofMeasure_SalesLine; "Unit of Measure")
                    {
                    }
                    column(Quantity_SalesLine; Quantity)
                    {
                    }
                    column(UnitPrice_SalesLine; "Unit Price")
                    {
                    }
                    column(VAT_SalesLine; "VAT %")
                    {
                    }
                    column(DocumentType_SalesLinessss; "Document Type")
                    {
                    }
                    column(SelltoCustomerNo_SalesLine; "Sell-to Customer No.")
                    {
                    }
                    column(DocumentNo_SalesLine; "Document No.")
                    {
                    }
                    column(No_SalesLine; "No.")
                    {
                    }
                    column(LocationCode_SalesLine; "Location Code")
                    {
                    }
                    column(PostingGroup_SalesLine; "Posting Group")
                    {
                    }
                    column(ItemCategoryCode_SalesLine; "Item Category Code")
                    {
                    }
                    column(Description_SalesLine; Description)
                    {
                    }
                    column(NetWeight_SalesLine; "Net Weight")
                    {
                    }
                    column(SNo; "Serial No.")
                    {
                    }
                    column(STK_ADE; STK_ADE)
                    {
                    }
                    column(STK_ADF; STK_ADF)
                    {
                    }
                    column(STK_HOD; STK_HOD)
                    {
                    }
                    column(STK_MUK; STK_MUK)
                    {
                    }
                    column(STK_SAN; STK_SAN)
                    {
                    }
                    column(STK_TAZ; STK_TAZ)
                    {
                    }
                    column(STK_HO; STK_HO)
                    {
                    }
                    column(TotalStock; TotalStock)
                    {
                    }
                    column(NetWeight; NetWeight)
                    {
                    }
                    column(Tax; Tax)
                    {
                    }
                    column(NetAmount; NetAmount)
                    {
                    }
                    column(LineDiscountAmount_SalesLine; "Line Discount Amount")
                    {
                    }
                    column(LineAmount_SalesLine; "Line Amount")
                    {
                    }
                    column(ADE_PAB; ADE_PAB)
                    {
                    }
                    column(HOD_PAB; HOD_PAB)
                    {
                    }
                    column(MUK_PAB; MUK_PAB)
                    {
                    }
                    column(SAN_PAB; SAN_PAB)
                    {
                    }
                    column(TAI_PAB; TAI_PAB)
                    {
                    }
                    column(Number; Number)
                    {
                    }
                    column(HO_PAB; "HOD-HO-PAB")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        "Serial No." += 1;
                        IF Itemnovisible = TRUE THEN
                            Number := "Sales Line"."No."
                        ELSE
                            IF Itemnovisible = FALSE THEN
                                Number := '';
                        subtotal += "Sales Line".Amount;
                        Tax := ROUND((subtotal * "Sales Line"."VAT %") / 100, 0.01);
                        Total += "Sales Line"."Amount Including VAT";
                        NetAmount := subtotal - "Sales Header"."Invoice Discount Amount";
                        InitTextVariables;
                        AmountInWordes := NumberInWords(Total, '', Currcode);
                        //EP96
                        CalcAvailableUnreservedFreeStock("Sales Line"."No.");
                        //
                        NetWeight += "Sales Line"."Net Weight" * "Sales Line".Quantity;
                        Location.RESET;
                        Location.SETRANGE(Code, "Sales Line"."Location Code");
                        IF Location.FINDFIRST THEN BEGIN
                            LocName := Location.Name;
                            LocAddress := Location.Address;
                            LocAddress2 := Location."Address 2";
                            LocCity := Location.City;
                            LOCPhone := Location."Phone No.";
                            LocFaxNo := Location."Fax No.";
                            LocCountry := Location.County;
                            LocPostcode := Location."Post Code";
                        END;
                        DescConclText1 := INSSTR(DescConclText, LocName, 107);
                        //
                        itemCategory.RESET;
                        IF itemCategory.GET("Sales Line"."Item Category Code") THEN
                            ItemCategoryDesc := itemCategory.Description;
                    end;

                    trigger OnPreDataItem()
                    begin
                        "Serial No." := 0;
                        Total := 0;
                        TotalStock := 0;
                        NetWeight := 0;
                        subtotal := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Sales Header".Template <> '' THEN BEGIN
                        TemplateRec.RESET;
                        TemplateRec.SETRANGE(Code, "Sales Header".Template);
                        IF TemplateRec.FINDFIRST THEN BEGIN
                            TemplateRec.CALCFIELDS("Document Introduction");
                            TemplateRec.CALCFIELDS("Document Conclusion");
                            DescIntroText := TemplateRec.GetWorkDescription;
                            DescConclText := TemplateRec.GetWorkDescription1;
                        END;
                        IF "Sales Header"."Your Reference" = '' THEN
                            "Sales Header"."Your Reference" := ' ';
                        DescIntroText1 := INSSTR(DescIntroText, "Sales Header"."Your Reference", 25);
                        DescConclText1 := INSSTR(DescConclText, FORMAT("Sales Header"."Price Validate"), 127);
                        DescConclText1 := INSSTR(DescConclText, FORMAT("Sales Header"."Delivery Terms"), 391);
                    END;
                    IF "Sales Header"."Currency Code" <> '' THEN
                        Curr := "Sales Header"."Currency Code"
                    ELSE
                        Curr := 'USD';
                    Currency.SETRANGE(Code, Curr);
                    IF Currency.FINDFIRST THEN
                        Currcode := Currency."Currency Code"
                    ELSE
                        Currcode := 'Cent';

                    User.RESET;
                    User.SETRANGE("User Name", USERID);
                    IF User.FINDFIRST THEN
                        UserName := User."Full Name";

                    IF "Sales Header"."Bill-to Name" = '' THEN
                        BillToContact := "Sales Header"."Bill-to Contact"
                    ELSE
                        BillToContact := "Sales Header"."Bill-to Name";

                    CountryRegion.RESET;
                    CountryRegion.SETRANGE(Code, "Sales Header"."Sell-to Country/Region Code");
                    IF CountryRegion.FINDFIRST THEN
                        CountryRegion1 := CountryRegion.Name;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Item No Visible")
                {
                    Caption = 'Item  Visibility';
                    field(Itemnovisible; Itemnovisible)
                    {
                        Caption = 'Part No Visible';
                    }
                    field(Select_Printer; Select_Printer)
                    {
                        Caption = 'Select Printer:';
                        TableRelation = Printer;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            /*IF CloseAction IN [ACTION::LookupOK] THEN BEGIN
              IF Select_Printer = '' THEN
                ERROR('Please select the printer')
            END*/

        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        PeriodStart := 0D;
        PeriodEnd := DMY2DATE(31, 12, 1999);
        Itemnovisible := TRUE;
        IF COMPANYNAME = 'AFZ' THEN
            IsADFZ := TRUE
        ELSE
            IsADFZ := FALSE;
    end;

    trigger OnPreReport()
    begin
        IF ChosenOption = 1 THEN
            IF CurrReport.PREVIEW THEN
    end;

    var
        Location: Record Location;
        AmountInWordes: Text;
        OnesText: array[20] of Text[90];
        TensText: array[10] of Text[90];
        ThousText: array[5] of Text[30];
        WholePart: Integer;
        DecimalPart: Integer;
        WholeInWords: Text;
        DecimalInWords: Text;
        ILE: Record "Item Ledger Entry";
        "Sales Quote No.": Code[10];
        "Serial No.": Integer;
        STK_ADE: Decimal;
        STK_ADF: Decimal;
        STK_MUK: Decimal;
        STK_SAN: Decimal;
        STK_TAZ: Decimal;
        DescIntroText: Text;
        TemplateRec: Record "Quote Template";
        DescConclText: Text;
        DescIntroText1: Text;
        DescConclText1: Text;
        subtotal: Decimal;
        Total: Decimal;
        Tax: Decimal;
        Curr: Code[20];
        Item: Record Item;
        ItemAvail: Codeunit "Item Availability Forms Mgt";
        ExpectedInventory: Decimal;
        QuantityAvailable: Decimal;
        AmountType: Option "Net Change","Balance at Date";
        PlannedOrderRelease: Decimal;
        GrossRequirement: Decimal;
        PlannedOrderReceipt: Decimal;
        ScheduledReceipt: Decimal;
        ProjectedAvailableBalance: Decimal;
        PeriodStart: Date;
        PeriodEnd: Date;
        STK_ADE1: Text;
        STK_ADF1: Text;
        STK_HOD1: Text;
        STK_MUK1: Text;
        STK_SAN1: Text;
        STK_TAZ1: Text;
        Currency: Record Currency;
        Currcode: Text[50];
        TotalStock: Decimal;
        BinContent: Record "Bin Content";
        PtkStkQty: Integer;
        ExcludeProtectiveStock: Boolean;
        NetWeight: Decimal;
        RESQTY: Decimal;
        LocName: Text;
        NetAmount: Decimal;
        SalesLine: Record "Sales Line";
        Qty1: Decimal;
        Qty2: Decimal;
        Qty3: Decimal;
        Qty4: Decimal;
        Qty5: Decimal;
        Pjb: Decimal;
        ItemAvl: Codeunit "Item-Check Avail.";
        Loc: Record Location;
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        LocationCode: Code[10];
        PlannedOrderRcpt: Decimal;
        ScheduledRcpt: Decimal;
        PlannedOrderReleases: Decimal;
        ProjAvailableBalance: Decimal;
        QtyAvailable: Decimal;
        Pjb1: Decimal;
        Pjb2: Decimal;
        IAL: Page "Item Availability by Location";
        Item1: Record Item;
        ADE_PAB: Decimal;
        HOD_PAB: Decimal;
        MUK_PAB: Decimal;
        SAN_PAB: Decimal;
        TAI_PAB: Decimal;
        User: Record User;
        LocAddress: Text;
        LocAddress2: Text;
        LocCity: Text;
        LOCPhone: Text;
        LocFaxNo: Text;
        LocCountry: Text;
        LocPostcode: Text;
        UserName: Text;
        Contact: Record Contact;
        BillToContact: Text;
        Itemnovisible: Boolean;
        Number: Code[20];
        ResQty1: Integer;
        itemCategory: Record "Item Category";
        ItemCategoryDesc: Text[50];
        CountryRegion: Record "Country/Region";
        CountryRegion1: Text;
        STK_HOD: Decimal;
        STK_HO: Decimal;
        "HOD-HO-PAB": Decimal;
        IsADFZ: Boolean;
        ADF_PAB: Decimal;
        ItemRes: Record Item;
        TotalInventory: Decimal;
        ReservedInventory: Decimal;
        Select_Printer: Text;
        ChosenOption: Integer;
        "Sales Line": Record "Sales Line";
        "Sales Header": Record "Sales Header";

    procedure NumberInWords(number: Decimal; CurrencyName: Text[30]; DenomName: Text[30]): Text[300]
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
    begin
        WholePart := ROUND(ABS(number), 1, '<');
        DecimalPart := ABS((ABS(number) - WholePart) * 100);

        WholeInWords := NumberToWords(WholePart, CurrencyName);
        IF DecimalPart <> 0 THEN BEGIN
            DecimalInWords := NumberToWords(DecimalPart, DenomName);
            IF WholePart = 0 THEN
                WholeInWords := 'Zero' + ' and ' + DecimalInWords
            ELSE
                WholeInWords := WholeInWords + ' and ' + DecimalInWords;
        END;
        AmountInWordes := ' ' + WholeInWords + ' Only';
        EXIT(AmountInWordes);
    end;

    procedure NumberToWords(number: Decimal; appendScale: Text[30]): Text[300]
    var
        numString: Text[300];
        pow: Integer;
        powStr: Text[50];
        log: Integer;
    begin
        numString := '';
        IF number < 100 THEN
            IF number < 20 THEN BEGIN
                IF number <> 0 THEN numString := OnesText[number];
            END ELSE BEGIN
                numString := TensText[number DIV 10];
                IF (number MOD 10) > 0 THEN
                    numString := numString + ' ' + OnesText[number MOD 10];
            END
        ELSE BEGIN
            pow := 0;
            powStr := '';
            IF number < 1000 THEN BEGIN // number is between 100 and 1000
                pow := 100;
                powStr := ThousText[1];
            END ELSE BEGIN // find the scale of the number
                log := ROUND(STRLEN(FORMAT(number DIV 1000)) / 3, 1, '>');
                pow := POWER(1000, log);
                powStr := ThousText[log + 1];
            END;

            numString := NumberToWords(number DIV pow, powStr) + ' ' + NumberToWords(number MOD pow, '');
        END;

        EXIT(DELCHR(numString, '<>', ' ') + ' ' + appendScale);
    end;

    procedure InitTextVariables()
    begin
        OnesText[1] := 'One';
        OnesText[2] := 'Two';
        OnesText[3] := 'Three';
        OnesText[4] := 'Four';
        OnesText[5] := 'Five';
        OnesText[6] := 'Six';
        OnesText[7] := 'Seven';
        OnesText[8] := 'Eight';
        OnesText[9] := 'Nine';
        OnesText[10] := 'Ten';
        OnesText[11] := 'Eleven';
        OnesText[12] := 'Twelve';
        OnesText[13] := 'Thirteen';
        OnesText[14] := 'Fourteen';
        OnesText[15] := 'Fifteen';
        OnesText[16] := 'Sixteen';
        OnesText[17] := 'Seventeen';
        OnesText[18] := 'Eighteen';
        OnesText[19] := 'Nineteen';

        TensText[1] := '';
        TensText[2] := 'Twenty';
        TensText[3] := 'Thirty';
        TensText[4] := 'Forty';
        TensText[5] := 'Fifty';
        TensText[6] := 'Sixty';
        TensText[7] := 'Seventy';
        TensText[8] := 'Eighty';
        TensText[9] := 'Ninety';

        ThousText[1] := 'Hundred';
        ThousText[2] := 'Thousand';
        ThousText[3] := 'Million';
        ThousText[4] := 'Billion';
        ThousText[5] := 'Trillion';
    end;

    local procedure CalcAvailableUnreservedFreeStock(ItemNo: Code[30])
    begin
        CLEAR(STK_ADE);
        CLEAR(STK_ADF);
        CLEAR(STK_HOD);
        CLEAR(STK_MUK);
        CLEAR(STK_SAN);
        CLEAR(STK_TAZ);
        CLEAR(STK_HO);
        Location.RESET;
        Location.SETRANGE("Use As In-Transit", FALSE);
        IF Location.FINDSET THEN
            REPEAT
                ItemRes.RESET;
                ItemRes.SETRANGE("No.", ItemNo);
                ItemRes.SETRANGE("Location Filter", Location.Code);
                IF ItemRes.FINDFIRST THEN BEGIN
                    ItemRes.CALCFIELDS(Inventory);
                    ItemRes.CALCFIELDS("Reserved Qty. on Inventory");
                    TotalInventory := ItemRes.Inventory;
                    ReservedInventory := ItemRes."Reserved Qty. on Inventory";
                    IF Location.Code = 'ADE' THEN BEGIN
                        STK_ADE := TotalInventory - ReservedInventory;
                    END ELSE IF Location.Code = 'HOD-HO' THEN BEGIN
                        STK_HO := TotalInventory - ReservedInventory;
                    END ELSE IF Location.Code = 'HOD-SHA' THEN BEGIN
                        STK_HOD := TotalInventory - ReservedInventory;
                    END ELSE IF Location.Code = 'MUK' THEN BEGIN
                        STK_MUK := TotalInventory - ReservedInventory;
                    END ELSE IF Location.Code = 'SAN' THEN BEGIN
                        STK_SAN := TotalInventory - ReservedInventory;
                    END ELSE IF Location.Code = 'TAI' THEN BEGIN
                        STK_TAZ := TotalInventory - ReservedInventory;
                    END ELSE IF Location.Code = 'AFZ-HO' THEN BEGIN
                        STK_ADF := TotalInventory - ReservedInventory;
                    END;
                END;
            UNTIL Location.NEXT = 0;
    end;

    procedure "Return Printer Name"() Printer_NM: Text
    begin
        Printer_NM := Select_Printer;
        EXIT(Printer_NM);
    end;

    procedure Preview_Print(ChosenPrintOptions: Integer)
    begin
        ChosenOption := ChosenPrintOptions;
    end;
}

