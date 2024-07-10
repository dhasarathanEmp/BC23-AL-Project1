report 50024 "Customer sales Quote"
{
    // Fx01 Hiding Row Containing Sales Tax if Sales Tax is 0
    // Cu Valid until date captured instead of BLOB Text
    // IF01 Remove Item Post Fix
    // Fx02 Different total format EPS and AFZ
    // EP9615 All the quote template conten will appear in quotation report
    DefaultLayout = RDLC;
    RDLCLayout = './Customer sales Quote.rdl';


    dataset
    {
        dataitem(DataItem32; "Company Information")
        {
            column(VATRegistrationNo_CompanyInformation; "VAT Registration No.")
            {
            }
            column(Name_CompanyInformation; Name)
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
                column(DocumentType_SalesHeader; "Document Type")
                {
                }
                column(SelltoCustomerNo_SalesHeader; "Sell-to Customer No.")
                {
                }
                column(PaymentDiscount_SalesHeader; "Payment Discount %")
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
                column(OrderDate_SalesHeader; FORMAT("Order Date"))
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
                column(StockAvailable; StockAvailable)
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
                column(Comp; Comp)
                {
                }
                column(BillToContact; BillToContact)
                {
                }
                column(CompInfoPicture; CompanyInformation.Picture)
                {
                }
                column(CountryRegion; CountryRegion1)
                {
                }
                column(TRNO; TRNO)
                {
                }
                column(ItemCategoryDesc; ItemCategoryDesc)
                {
                }
                column(VersionNo_SalesHeader; "Version No.")
                {
                }
                column(LatestVersionDate; FORMAT("Latest Version Date"))
                {
                }
                column(ValidTill; FORMAT("Valid Till"))
                {
                }
                column(VerDate; FORMAT(VerDate))
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
                    column(ItemCategoryCode_SalesLine; "Item Category Code")
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
                    column(BOMItemNo_SalesLine; "BOM Item No.")
                    {
                    }
                    column(LastPartNumber_SalesLine; LastPartNumber)
                    {
                    }
                    column(LocationCode_SalesLine; "Location Code")
                    {
                    }
                    column(PostingGroup_SalesLine; "Posting Group")
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
                    column(TotalStkExcl; TotalStkExcl)
                    {
                    }
                    column(NetWeight; NetWeight)
                    {
                    }
                    column(Tax; Tax)
                    {
                    }
                    column(Netamount; Netamount)
                    {
                    }
                    column(LineAmount_SalesLine; "Line Amount")
                    {
                    }
                    column(ItemNumber; ItemNumber)
                    {
                    }
                    column(OrderedPartNumb; OrderedPartNumb)
                    {
                    }
                    column(CustomerSerialNo_SalesLine; "Customer Serial No")
                    {
                    }
                    column(CustomerSerialNoVisibility; CustomerSerialNoVisibility)
                    {
                    }
                    column(StockStatusVisibility; StockStatusVisibility)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //IF01
                        ItemNumber := "Sales Line"."No.";
                        IF "Sales Line"."Gen. Prod. Posting Group" <> 'CD' THEN BEGIN
                            CompareChr1 := COPYSTR(ItemNumber, 1, 2);
                            CompareChr2 := COPYSTR("Sales Line"."Gen. Prod. Posting Group", 1, 1) + '#';
                            IF CompareChr1 = CompareChr2 THEN
                                ItemNumber := COPYSTR(ItemNumber, 3, STRLEN(ItemNumber));
                        END;
                        //IF01
                        //EAPL-96 for Customer Serial No Visibility
                        IF "Sales Line"."Customer Serial No" <> '' THEN
                            CustomerSerialNoVisibility := TRUE;
                        //EAPL-96 for Customer Serial No VisibilityCLEAR(TotalStockILE);
                        CLEAR(TotalStockRes);
                        CLEAR(TotalStkExcl);
                        CLEAR(TotalPtkStk);
                        "Serial No." += 1;
                        IF ItemNumberVisibility = TRUE THEN BEGIN

                        END ELSE
                            ItemNumber := '';
                        subtotal += "Sales Line".Amount;
                        Tax := ROUND((subtotal * "Sales Line"."VAT %") / 100, 0.01);
                        Total += "Sales Line"."Amount Including VAT";
                        Netamount := subtotal - "Sales Header"."Invoice Discount Amount";
                        InitTextVariables;
                        AmountInWordes := NumberInWords(Total, '', Currcode);
                        //
                        CLEAR(STK_ADE);
                        CLEAR(STK_ADF);
                        CLEAR(STK_HOD);
                        CLEAR(STK_MUK);
                        CLEAR(STK_SAN);
                        CLEAR(STK_TAZ);

                        Location.RESET;
                        IF Location.FINDSET THEN
                            REPEAT
                                IF ExcludeProtectiveStock = FALSE THEN BEGIN
                                    CalculateStk(Location.Code, "Sales Line"."No.");
                                    //StockChecking;
                                END;
                                IF ExcludeProtectiveStock = TRUE THEN BEGIN
                                    IF Location."Use As In-Transit" = FALSE THEN
                                        CalculateStk1(Location.Code, "Sales Line"."No.");
                                END;
                            UNTIL Location.NEXT = 0;
                        TotalStkExcl := TotalStockILE;
                        StockChecking;
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
                            TRNO := Location."Name 2";
                        END;
                        //Cu
                        IF TemplateNo = 1 THEN
                            DescConclText1 := DescConclText;
                        //DescConclText1  :=  INSSTR(DescConclText,LocName,107);
                        //Cu
                        itemCategory.RESET;
                        IF itemCategory.GET("Sales Line"."Item Category Code") THEN
                            ItemCategoryDesc := itemCategory.Description;
                        IF ("Sales Line"."BOM Item No." <> '') AND ("Sales Line".LastPartNumber <> '') THEN
                            OrderedPartNumb := "Sales Line"."BOM Item No." + '(' + "Sales Line".LastPartNumber + ')'
                        ELSE IF "Sales Line"."BOM Item No." <> '' THEN
                            OrderedPartNumb := "Sales Line"."BOM Item No."
                        ELSE
                            OrderedPartNumb := "Sales Line".LastPartNumber;
                    end;

                    trigger OnPreDataItem()
                    begin
                        "Serial No." := 0;
                        Total := 0;
                        TotalStock := 0;
                        NetWeight := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CompanyInformation.GET;
                    CompanyInformation.CALCFIELDS(Picture);

                    IF "Sales Header".Template <> '' THEN BEGIN
                        TemplateRec.RESET;
                        TemplateRec.SETRANGE(Code, "Sales Header".Template);
                        IF TemplateRec.FINDFIRST THEN BEGIN
                            TemplateRec.CALCFIELDS("Document Introduction");
                            TemplateRec.CALCFIELDS("Document Conclusion");
                            DescIntroText := TemplateRec.GetWorkDescription;
                            DescConclText := TemplateRec.GetWorkDescription1;
                            TemplateNo := TemplateRec."Quote Template No";
                        END;
                        /*IF "Sales Header"."Your Reference"  = ''  THEN
                          "Sales Header"."Your Reference" :=  '';*/
                        IF TemplateNo = 1 THEN BEGIN
                            //Cu
                            IF "Sales Header"."Price Validate" <> '' THEN BEGIN
                                EVALUATE(PriceValidateInteger, "Sales Header"."Price Validate");
                                IF "Sales Header"."Latest Version Date" <> 0D THEN
                                    "Valid Till" := "Sales Header"."Latest Version Date" + PriceValidateInteger
                                ELSE
                                    "Valid Till" := "Sales Header"."Order Date" + PriceValidateInteger;
                            END;
                            //Cu
                            DescIntroText1 := INSSTR(DescIntroText, "Sales Header"."Your Reference", 25);
                            //DescConclText := INSSTR(DescConclText,FORMAT("Sales Header"."Price Validate"),127); //Cu
                            DescConclText := INSSTR(DescConclText, FORMAT("Sales Header"."Delivery Terms"), 226);
                        END ELSE BEGIN
                            //EP9615
                            IF "Sales Header"."Price Validate" <> '' THEN BEGIN
                                EVALUATE(PriceValidateInteger, "Sales Header"."Price Validate");
                                IF "Sales Header"."Latest Version Date" <> 0D THEN
                                    "Valid Till" := "Sales Header"."Latest Version Date" + PriceValidateInteger
                                ELSE
                                    "Valid Till" := "Sales Header"."Order Date" + PriceValidateInteger;
                            END;
                            DescIntroText1 := INSSTR(DescIntroText, "Sales Header"."Your Reference", 25);
                            DescConclText1 := DescConclText;
                            //EP9615
                        END;
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
                    //
                    User.RESET;
                    User.SETRANGE("User Name", USERID);
                    IF User.FINDFIRST THEN
                        UserName := User."Full Name";
                    //
                    //Fx02
                    Comp := COMPANYNAME;
                    //Fx02
                    IF "Sales Header"."Bill-to Name" = '' THEN
                        BillToContact := "Sales Header"."Bill-to Contact"
                    ELSE
                        BillToContact := "Sales Header"."Bill-to Name";


                    CountryRegion.RESET;
                    CountryRegion.SETRANGE(Code, "Sales Header"."Sell-to Country/Region Code");
                    IF CountryRegion.FINDFIRST THEN
                        CountryRegion1 := CountryRegion.Name;
                    IF "Sales Header"."Latest Version Date" = 0D THEN
                        VerDate := "Sales Header"."Order Date"
                    ELSE
                        VerDate := "Sales Header"."Latest Version Date";

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
                    Caption = 'Item Visibility';
                    field("Item Number"; ItemNumberVisibility)
                    {
                        Caption = 'Part No Visible';
                    }
                    field("Visible Availability"; StockStatusVisibility)
                    {
                        Caption = 'Visible Availability';
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
        Currency: Record Currency;
        Currcode: Text[50];
        TotalStock: Integer;
        BinContent: Record "Bin Content";
        PtkStkQty: Integer;
        ExcludeProtectiveStock: Boolean;
        TotalPtkStk: Decimal;
        TotalStkExcl: Decimal;
        NetWeight: Decimal;
        RESQTY: Decimal;
        StockAvailable: Text;
        TotalStockILE: Integer;
        TotalStockRes: Integer;
        LocName: Text;
        Netamount: Decimal;
        SalesLine: Record "Sales Line";
        Qty1: Integer;
        Qty2: Integer;
        Qty3: Integer;
        Qty4: Integer;
        Qty5: Integer;
        User: Record User;
        LocAddress: Text;
        LocAddress2: Text;
        LocCity: Text;
        LOCPhone: Text;
        LocFaxNo: Text;
        LocCountry: Text;
        LocPostcode: Text;
        UserName: Text;
        BillToContact: Text;
        ItemNo: Code[10];
        TemplateNo: Integer;
        CompanyInformation: Record "Company Information";
        CountryRegion: Record "Country/Region";
        CountryRegion1: Text;
        TRNO: Text;
        itemCategory: Record "Item Category";
        ItemCategoryDesc: Text[50];
        STK_HO: Integer;
        STK_HOD: Integer;
        ItemNumberVisibility: Boolean;
        ItemNumber: Code[20];
        "Valid Till": Date;
        PriceValidateInteger: Integer;
        OrderedPartNumb: Code[20];
        VerDate: Date;
        CustomerSerialNoVisibility: Boolean;
        CompareChr1: Text;
        CompareChr2: Text;
        StockStatusVisibility: Boolean;
        Comp: Code[10];
        "Sales Header": Record "Sales Header";
        "Sales Line": Record "Sales Line";


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

    local procedure CalculateStk("Code": Code[20]; ItemNo: Code[20])
    begin
        CLEAR(ILE.Quantity);
        ILE.RESET;
        ILE.SETRANGE("Location Code", Code);
        ILE.SETRANGE("Item No.", ItemNo);
        IF ILE.FINDSET THEN BEGIN
            ILE.CALCSUMS(Quantity);
            Item.RESET;
            Item.SETRANGE("No.", "Sales Line"."No.");
            Item.SETRANGE("Location Filter", "Sales Line"."Location Code");
            IF Item.FINDFIRST THEN BEGIN
                Item.CALCFIELDS("Qty. on Sales Order");
                RESQTY := Item."Qty. on Sales Order";
            END;
            CASE Code OF
                'ADE':
                    BEGIN
                        STK_ADE := ILE.Quantity;
                    END;
                'ADF':
                    STK_ADF := 0;
                'HOD-HO':
                    STK_HO := ILE.Quantity;
                'HOD-SHA':
                    BEGIN
                        STK_HOD := ILE.Quantity;
                    END;
                'MUK':
                    BEGIN
                        STK_MUK := ILE.Quantity;
                    END;
                'SAN':
                    BEGIN
                        STK_SAN := ILE.Quantity;
                    END;
                'TAI':
                    BEGIN
                        STK_TAZ := ILE.Quantity;
                    END;

            END;
            TotalStkExcl += ILE.Quantity;
        END;
        IF TotalStkExcl >= "Sales Line".Quantity THEN
            StockAvailable := 'Available'
        ELSE
            IF TotalStkExcl = 0 THEN
                StockAvailable := '-'
            ELSE
                IF TotalStkExcl < "Sales Line".Quantity THEN
                    StockAvailable := 'Partial';
    end;

    local procedure CalculateStk1("Code": Code[20]; ItemNo: Code[20])
    begin
        CLEAR(ILE.Quantity);
        CLEAR(RESQTY);
        CLEAR(PtkStkQty);
        Item.RESET;
        Item.SETRANGE("No.", ItemNo);
        Item.SETRANGE("Location Filter", Code);
        IF Item.FINDFIRST THEN BEGIN
            Item.CALCFIELDS("Reserved Qty. on Inventory");
            RESQTY := Item."Reserved Qty. on Inventory";
        END;
        ILE.RESET;
        ILE.SETRANGE("Location Code", Code);
        ILE.SETRANGE("Item No.", ItemNo);
        IF ILE.FINDSET THEN BEGIN
            ILE.CALCSUMS(Quantity);
            PtkStkQty := 0;
            BinContent.RESET;
            BinContent.SETRANGE("Location Code", Code);
            BinContent.SETRANGE("Item No.", ItemNo);
            IF BinContent.FINDSET THEN
                REPEAT
                    BinContent.CALCFIELDS("Bin Blocks");
                    BinContent.CALCFIELDS("Counter sale");
                    BinContent.CALCFIELDS(Quantity);
                    IF (BinContent."Bin Blocks" = TRUE) OR ((BinContent."Bin Blocks" = TRUE) AND (BinContent."Counter sale" = TRUE)) THEN
                        PtkStkQty += BinContent.Quantity;
                UNTIL BinContent.NEXT = 0;
            CASE Code OF
                'ADE':
                    BEGIN
                        STK_ADE := ILE.Quantity;
                    END;
                'ADF':
                    STK_ADF := 0;
                'HOD-HO':
                    BEGIN
                        STK_HO := ILE.Quantity;
                    END;
                'HOD-SHA':
                    BEGIN
                        STK_HOD := ILE.Quantity;
                    END;
                'MUK':
                    BEGIN
                        STK_MUK := ILE.Quantity;
                    END;
                'SAN':
                    BEGIN
                        STK_SAN := ILE.Quantity;
                    END;
                'TAI':
                    BEGIN
                        STK_TAZ := ILE.Quantity;
                    END;

            END;
            TotalStockILE += ILE.Quantity;
        END;
        IF TotalStkExcl >= "Sales Line".Quantity THEN
            StockAvailable := 'Available'
        ELSE
            IF TotalStkExcl = 0 THEN
                StockAvailable := '-'
            ELSE
                IF TotalStkExcl < "Sales Line".Quantity THEN
                    StockAvailable := 'Partial';
    end;

    local procedure StockChecking()
    begin
        CASE "Sales Line"."Location Code" OF
            'ADE':
                BEGIN
                    IF "Sales Line".Quantity <= STK_ADE THEN
                        StockAvailable := 'Available'
                    ELSE
                        IF STK_ADE = 0 THEN
                            StockAvailable := '-'
                        ELSE
                            IF "Sales Line".Quantity > STK_ADE THEN
                                StockAvailable := 'Partial';
                END;
            'ADF':
                STK_ADF := 0;
            'HOD':
                BEGIN
                    IF "Sales Line".Quantity <= STK_HOD THEN
                        StockAvailable := 'Available'
                    ELSE
                        IF STK_HOD = 0 THEN
                            StockAvailable := '-'
                        ELSE
                            IF "Sales Line".Quantity > STK_HOD THEN
                                StockAvailable := 'Partial';
                END;
            'MUK':
                BEGIN
                    IF "Sales Line".Quantity <= STK_MUK THEN
                        StockAvailable := 'Available'
                    ELSE
                        IF STK_MUK = 0 THEN
                            StockAvailable := '-'
                        ELSE
                            IF "Sales Line".Quantity > STK_MUK THEN
                                StockAvailable := 'Partial';
                END;
            'SAN':
                BEGIN
                    IF "Sales Line".Quantity <= STK_SAN THEN
                        StockAvailable := 'Available'
                    ELSE
                        IF STK_SAN = 0 THEN
                            StockAvailable := '-'
                        ELSE
                            IF "Sales Line".Quantity > STK_SAN THEN
                                StockAvailable := 'Partial';
                END;
            'TAI':
                BEGIN
                    IF "Sales Line".Quantity <= STK_TAZ THEN
                        StockAvailable := 'Available'
                    ELSE
                        IF STK_TAZ = 0 THEN
                            StockAvailable := '-'
                        ELSE
                            IF "Sales Line".Quantity > STK_TAZ THEN
                                StockAvailable := 'Partial';
                END;
        END;
    end;
}

