report 50096 "Customer Invoice"
{
    // IF01  Postfix Remove
    // EP9616 storing service items quantity to exclude it from report total quantity
    DefaultLayout = RDLC;
    RDLCLayout = './Customer Invoice.rdlc';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem1; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(No_SalesInvoiceHeader; "No.")
            {
            }
            column(BilltoCustomerNo_SalesInvoiceHeader; "Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesInvoiceHeader; "Bill-to Name")
            {
            }
            column(BilltoName2_SalesInvoiceHeader; "Bill-to Name 2")
            {
            }
            column(BilltoAddress_SalesInvoiceHeaderS; "Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesInvoiceHeader; "Bill-to Address 2")
            {
            }
            column(SelltoCity_SalesInvoiceHeader; "Sell-to City")
            {
            }
            column(SelltoCounty_SalesInvoiceHeader; "Sell-to County")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Posting Date")
            {
            }
            column(CurrencyCode_SalesInvoiceHeader; "Currency Code")
            {
            }
            column(Company_Logo; CompanyInformation.Picture)
            {
            }
            column(Name_CompanyInformation; CompanyInformation.Name)
            {
            }
            column(VATRegistrationNo_CompanyInformation; CompanyInformation."VAT Registration No.")
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; Address2)
            {
            }
            column(City; City)
            {
            }
            column(PhoneNo; PhoneNo)
            {
            }
            column(FaxNo; FaxNo)
            {
            }
            column(LocName; LocName)
            {
            }
            column(ItemCategoryDesc; ItemCategoryDesc)
            {
            }
            column(Currcode; Currcode)
            {
            }
            column(Country; Country)
            {
            }
            column(TRNo; TRNo)
            {
            }
            column(UserName; UserName)
            {
            }
            column(Curr; Curr)
            {
            }
            column(CountryRegion1; CountryRegion1)
            {
            }
            column(InvoiceNoMod; InvoiceNoMod)
            {
            }
            dataitem(DataItem2; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Applied Doc. No.")
                                    WHERE("Applied Doc. No." = FILTER(<> ''));
                column(SerialNo; SerialNo)
                {
                }
                column(DocumentNo_SalesInvoiceLines; "Document No.")
                {
                }
                column(AppliedDocNo_SalesInvoiceLine; "Applied Doc. No.")
                {
                }
                column(No_SalesInvoiceLine; "No.")
                {
                }
                column(Description_SalesInvoiceLine; Description)
                {
                }
                column(Quantity_SalesInvoiceLine; Quantity)
                {
                }
                column(UnitPrice_SalesInvoiceLine; "Unit Price")
                {
                }
                column(Amount_SalesInvoiceLine; Amount)
                {
                }
                column(PONumber_SalesInvoiceLine; "PO Number")
                {
                }
                column(CustomerSerialNo_SalesInvoiceLine; "Customer Serial No")
                {
                }
                column(SapNo_SalesInvoiceLine; "Sap No")
                {
                }
                column(GrossWeight_SalesInvoiceLine; "Gross Weight")
                {
                }
                column(GrossWeightkG_SalesInvoiceLine; "Gross Weight kG")
                {
                }
                column(AmountInWordes; AmountInWords)
                {
                }
                column(OrderedPartNumb; OrderedPartNumb)
                {
                }
                column(LineCount; LineCount)
                {
                }
                column(PartNo; PartNo)
                {
                }
                column(TotalAmountExpression; TotalAmountExpression)
                {
                }
                column(SaleOrderNo_SalesInvoiceLine; "Sale Order No.")
                {
                }
                column(ServiceItemQty; ServiceItemQty)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //IF01
                    IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item THEN BEGIN
                        IF "Sales Invoice Line"."Gen. Prod. Posting Group" = 'CD' THEN
                            PartNo := "Sales Invoice Line"."No."
                        ELSE BEGIN
                            Compstr1 := COPYSTR("Sales Invoice Line"."No.", STRLEN("Sales Invoice Line"."No.") - 3, STRLEN("Sales Invoice Line"."No."));
                            Compstr2 := '#' + "Sales Invoice Line"."Gen. Prod. Posting Group" + '#';
                            IF Compstr1 = Compstr2 THEN
                                PartNo := COPYSTR("Sales Invoice Line"."No.", 1, STRLEN("Sales Invoice Line"."No.") - 4)
                            ELSE
                                PartNo := "Sales Invoice Line"."No.";
                        END;
                    END;
                    //IF01

                    LineCount += 1;

                    CalculateAmountInWords("Sales Invoice Line"."Sale Order No.");
                    //Reset Invoice No
                    IF SONo <> "Sales Invoice Line"."Sale Order No." THEN BEGIN
                        SerialNo := 0;
                        SerialNo := SerialNo + 1;
                        SONo := "Sales Invoice Line"."Sale Order No.";
                    END ELSE BEGIN
                        SerialNo := SerialNo + 1;
                        SONo := "Sales Invoice Line"."Sale Order No.";
                    END;
                    //Reset Invoice No
                    Location.RESET;
                    Location.SETRANGE(Code, "Sales Invoice Line"."Location Code");
                    IF Location.FINDFIRST THEN BEGIN
                        IF Location.Code = 'HOD-SHA' THEN BEGIN
                            LocName := 'Hodeidah';
                        END ELSE
                            LocName := Location.Name;
                        Country := Location.County;
                        FaxNo := Location."Fax No.";
                        TRNo := Location."Name 2";
                    END;

                    itemCategory.RESET;
                    IF itemCategory.GET("Sales Invoice Line"."Item Category Code") THEN
                        ItemCategoryDesc := itemCategory.Description;

                    IF ("Sales Invoice Line"."BOM Item No" <> '') AND ("Sales Invoice Line".LastPartNumber <> '') THEN
                        OrderedPartNumb := "Sales Invoice Line"."BOM Item No" + '(' + "Sales Invoice Line".LastPartNumber + ')'
                    ELSE IF "Sales Invoice Line"."BOM Item No" <> '' THEN
                        OrderedPartNumb := "Sales Invoice Line"."BOM Item No"
                    ELSE
                        OrderedPartNumb := "Sales Invoice Line".LastPartNumber;

                    IF Loop = 0 THEN BEGIN
                        CompanyInfo.RESET;
                        CompanyInfo.SETRANGE(Name, COMPANYNAME);
                        CompanyInfo.SETRANGE(AFZ, TRUE);
                        IF CompanyInfo.FINDFIRST THEN BEGIN
                            TotalAmountExpression := 'Total Value - CIF' + LocName + ' - ' + Curr;
                            Loop := 1;
                        END ELSE BEGIN
                            Loop := 1;
                            TotalAmountExpression := 'Total Value - ' + Curr + '(EX-Warehouse ' + LocName + ')';
                        END;
                    END;

                    //EP9616 storing service items quantity to exclude it from report total quantity
                    ServiceItem.RESET;
                    ServiceItem.SETRANGE("No.", "Sales Invoice Line"."No.");
                    ServiceItem.SETRANGE(Type, ServiceItem.Type::Service);
                    IF ServiceItem.FINDFIRST THEN
                        ServiceItemQty += "Sales Invoice Line".Quantity;
                    //EP9616 storing service items quantity to exclude it from report total quantity
                end;

                trigger OnPreDataItem()
                begin
                    InvoiceNoMod := '00';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF "Sales Invoice Header"."Currency Code" <> '' THEN
                    Curr := "Sales Invoice Header"."Currency Code"
                ELSE
                    Curr := 'USD';
                //
                Currency.SETRANGE(Code, Curr);
                IF Currency.FINDFIRST THEN
                    Currcode := Currency."Currency Code"
                ELSE
                    Currcode := 'Cents';

                CountryRegion.RESET;
                CountryRegion.SETRANGE(Code, "Sales Invoice Header"."Sell-to Country/Region Code");
                IF CountryRegion.FINDFIRST THEN
                    CountryRegion1 := CountryRegion.Name;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
        Address := CompanyInformation.Address;
        Address2 := CompanyInformation."Address 2";
        PhoneNo := CompanyInformation."Phone No.";
        City := CompanyInformation.City;
        User.RESET;
        User.SETRANGE("User Name", USERID);
        IF User.FINDFIRST THEN
            UserName := User."Full Name";
    end;

    var
        CompanyInformation: Record "Company Information";
        Location: Record Location;
        itemCategory: Record "Item Category";
        Currency: Record Currency;
        User: Record User;
        CountryRegion: Record "Country/Region";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SerialNo: Integer;
        SONo: Code[30];
        Address: Text;
        Address2: Text;
        City: Text;
        PhoneNo: Text;
        FaxNo: Text;
        LocName: Text[50];
        TRNo: Text;
        Country: Text;
        ItemCategoryDesc: Text[50];
        Currcode: Text[50];
        Curr: Code[20];
        UserName: Text;
        OnesText: array[20] of Text[90];
        TensText: array[10] of Text[90];
        ThousText: array[5] of Text[30];
        AmountInWords: Text[300];
        TotalAmount: Decimal;
        OrderedPartNumb: Code[20];
        SaleOrderNoG: Code[20];
        PartiallyShippedorNot: Boolean;
        CountryRegion1: Text;
        InvoiceNoMod: Text;
        LineCount: Integer;
        PageNo: Integer;
        PartNo: Code[20];
        Compstr1: Code[20];
        Compstr2: Code[20];
        TotalAmountExpression: Text;
        CompanyInfo: Record "Company Information";
        Loop: Integer;
        UpperCaseLocName: Text;
        ServiceItem: Record Item;
        ServiceItemQty: Integer;
        "Sales Invoice Header": Record "Sales Invoice Header";
        "Sales Invoice Line": Record "Sales Invoice Line";

    procedure NumberInWords(number: Decimal; CurrencyName: Text[30]; DenomName: Text[30]): Text[300]
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
        WholePart: Integer;
        DecimalPart: Integer;
        AmountInWordes: Text[300];
        WholeInWords: Text[300];
        DecimalInWords: Text[300];
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

    local procedure CalculateAmountInWords(SalesOrderNo: Code[20])
    var
        TotalAmountL: Decimal;
    begin
        IF SaleOrderNoG <> SalesOrderNo THEN BEGIN
            InvoiceNoMod := INCSTR(InvoiceNoMod);
            SalesInvoiceLine.RESET;
            SalesInvoiceLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
            SalesInvoiceLine.SETRANGE("Applied Doc. No.", "Sales Invoice Line"."Sale Order No.");
            //SalesOrderCount := SalesInvoiceLine.COUNT;
            IF SalesInvoiceLine.FINDSET THEN
                REPEAT
                    TotalAmountL += SalesInvoiceLine.Amount;
                UNTIL SalesInvoiceLine.NEXT = 0;
            InitTextVariables;
            AmountInWords := NumberInWords(TotalAmountL, Curr, Currcode);

            SaleOrderNoG := "Sales Invoice Line"."Sale Order No.";
        END;
    end;

    local procedure SaleOrderWisePageNo()
    var
        Page1: Integer;
        Page2: Integer;
        B1Page1: Boolean;
        B2Page2: Boolean;
    begin
        /*B1Page1 := TRUE;
        IF B1Page1 = TRUE THEN BEGIN
          IF Page1 = LineCount THEN BEGIN
            Page1 := LineCount;
            B2Page2 := TRUE;
          END
        PageNo :=1;
        END
         ELSE IF B1Page1 = TRUE THEN BEGIN
          IF Page1 = LineCount THEN BEGIN
            Page1 := LineCount;
            B2Page2 := TRUE;
          END
        END*/

    end;
}

