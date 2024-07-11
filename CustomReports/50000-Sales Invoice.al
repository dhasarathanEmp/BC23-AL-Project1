report 50000 "Sales Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Sales Invoice.rdlc';

    dataset
    {
        dataitem(DataItem1; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(BilltoContactNo_SalesInvoiceHeader; "Bill-to Contact No.")
            {
            }
            column(CurrencyCode_SalesInvoiceHeader; "Currency Code")
            {
            }
            column(BilltoPostCode_SalesInvoiceHeader; "Bill-to Post Code")
            {
            }
            column(BilltoCounty_SalesInvoiceHeader; "Bill-to County")
            {
            }
            column(BilltoCountryRegionCode_SalesInvoiceHeader; "Bill-to Country/Region Code")
            {
            }
            column(SelltoCustomerNo_SalesInvoiceHeader; "Sell-to Customer No.")
            {
            }
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
            column(BilltoAddress_SalesInvoiceHeader; "Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesInvoiceHeader; "Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesInvoiceHeader; "Bill-to City")
            {
            }
            column(BilltoContact_SalesInvoiceHeader; "Bill-to Contact")
            {
            }
            column(CustAddr_1; CustAddr[1])
            {
            }
            column(CustAddr_2; CustAddr[2])
            {
            }
            column(CustAddr_3; CustAddr[3])
            {
            }
            column(CustAddr_4; CustAddr[4])
            {
            }
            column(CustAddr_5; CustAddr[5])
            {
            }
            column(CustAddr_6; CustAddr[6])
            {
            }
            column(CustAddr_7; CustAddr[7])
            {
            }
            column(CustAddr_8; CustAddr[8])
            {
            }
            column(INvoiceNo_1; INvoiceNo[1])
            {
            }
            column(INvoiceNo_2; INvoiceNo[2])
            {
            }
            column(AmountIncludingVAT_SalesInvoiceHeader; "Amount Including VAT")
            {
            }
            column(TotalAmountinclodingVat; TotalAmountinclodingVat)
            {
            }
            column(Amount_SalesInvoiceHeader; Amount)
            {
            }
            column(AmountInWordes; AmountInWordes)
            {
            }
            column(ContAddress; ContAddress)
            {
            }
            column(Cont_Address; Cont_Address)
            {
            }
            column(Curr; Curr)
            {
            }
            column(Logo; Logo)
            {
            }
            dataitem(DataItem23; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ItemCategoryCode_SalesInvoiceLine; "Item Category Code")
                {
                }
                column(DocumentNo1_SalesInvoiceLine; "Document No.1")
                {
                }
                column(LocationCode_SalesInvoiceLine; "Location Code")
                {
                }
                column(DocumentNo_SalesInvoiceLine; "Document No.")
                {
                }
                column(LineNo_SalesInvoiceLine; "Line No.")
                {
                }
                column(Type_SalesInvoiceLine; Type)
                {
                }
                column(No_SalesInvoiceLine; "No.")
                {
                }
                column(ShipmentDate_SalesInvoiceLine; "Shipment Date")
                {
                }
                column(Description_SalesInvoiceLine; Description)
                {
                }
                column(UnitofMeasure_SalesInvoiceLine; "Unit of Measure")
                {
                }
                column(Quantity_SalesInvoiceLine; Quantity)
                {
                }
                column(UnitPrice_SalesInvoiceLine; "Unit Price")
                {
                }
                column(VAT_SalesInvoiceLine; "VAT %")
                {
                }
                column(LineDiscount_SalesInvoiceLine; "Line Discount %")
                {
                }
                column(LineDiscountAmount_SalesInvoiceLine; "Line Discount Amount")
                {
                }
                column(Amount_SalesInvoiceLine; Amount)
                {
                }
                column(AmountIncludingVAT_SalesInvoiceLine; "Amount Including VAT")
                {
                }
                column(Serialno; "S.no")
                {
                }
                column(Tax; Tax)
                {
                }
                column(Division; Division)
                {
                }
                column(InvoiceType; InvoiceType)
                {
                }
                dataitem(DataItem39; "Company Information")
                {
                    column(Name_CompanyInformation; Name)
                    {
                    }
                    column(VATRegistrationNo_CompanyInformation; "VAT Registration No.")
                    {
                    }
                    column(Name2_CompanyInformation; "Name 2")
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
                    column(FaxNo_CompanyInformation; "Fax No.")
                    {
                    }
                    column(PostCode_CompanyInformation; "Post Code")
                    {
                    }
                    column(CountryRegionCode_CompanyInformation; "Country/Region Code")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Sales Invoice Line"."Document No.1" <> '' THEN
                        InvoiceType := 'CASH'
                    ELSE
                        InvoiceType := 'SALES';

                    "S.no" += 1;
                    Subtotal += "Sales Invoice Line"."Amount Including VAT";
                    InitTextVariables;
                    AmountInWordes := NumberInWords(Subtotal, Curr, Currcode);
                end;

                trigger OnPreDataItem()
                begin
                    "S.no" := 0;
                    TotalAmount := 0;
                    TotalAmountinclodingVat := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(FormatAddr);
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                //
                Contact.RESET;
                Contact.SETRANGE("No.", "Sales Invoice Header"."Bill-to Contact No.");
                IF Contact.FINDFIRST THEN BEGIN
                    ContAddress := Contact.Address;
                    Cont_Address := Contact."Address 2";
                END;

                IF CompanyInformation.GET THEN BEGIN
                    CompanyRec.RESET;
                    CompanyRec.SETRANGE(Name, CompanyInformation.Name);
                    IF CompanyRec.FINDFIRST THEN BEGIN
                        Division := FORMAT(CompanyRec.Division);
                    END;
                END;

                IF "Sales Invoice Header"."Currency Code" <> '' THEN
                    Curr := "Sales Invoice Header"."Currency Code"
                ELSE
                    Curr := 'USD';
                //
                Currency.SETRANGE(Code, Curr);
                IF Currency.FINDFIRST THEN
                    Currcode := Currency."Currency Code"
                ELSE
                    Currcode := 'Cent';
                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                IF SalesInvoiceLine.FINDFIRST THEN
                    Logo := SalesInvoiceLine."Item Category Code"
                ELSE
                    Logo := '';
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

    var
        CompanyInformation: Record "Company Information";
        "S.no": Integer;
        FormatAddr: Codeunit "Format Address";
        CustAddr: array[8] of Text[50];
        INvoiceNo: array[2] of Text;
        TotalAmount: Decimal;
        Tax: Decimal;
        TotalAmountinclodingVat: Decimal;
        AmountInWordes: Text[300];
        OnesText: array[20] of Text[90];
        TensText: array[10] of Text[90];
        ThousText: array[5] of Text[30];
        WholeInWords: Text[300];
        DecimalInWords: Text[300];
        WholePart: Integer;
        DecimalPart: Integer;
        TotalCost: Text[300];
        RepCheck: Report Check;
        NoText: array[2] of Text;
        AmountVendor: Decimal;
        Text: Text[250];
        "Vat Amount": Decimal;
        Subtotal: Decimal;
        CompanyRec: Record "Company Information";
        Division: Text;
        Contact: Record Contact;
        ContAddress: Text[50];
        Cont_Address: Text[50];
        InvoiceType: Text;
        Curr: Code[20];
        Currcode: Text[50];
        Currency: Record Currency;
        SalesInvoiceLine: Record "Sales Invoice Line";
        Logo: Code[10];
        "Sales Invoice Line": Record "Sales Invoice Line";
        "Sales Invoice Header": Record "Sales Invoice Header";

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
            WholeInWords := WholeInWords + ' and ' + DecimalInWords;
        END;
        //AmountInWordes := '****' + WholeInWords + ' Only';
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
}

