report 50074 "Temporary Delivery Invoice"
{
    // IF01 Postfix Removal
    DefaultLayout = RDLC;
    RDLCLayout = './Temporary Delivery Invoice.rdlc';

    Caption = 'Parts Invoice';

    dataset
    {
        dataitem(DataItem1; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(InvoiceDiscount_SalesInvoiceHeader; "Invoice Discount%")
            {
            }
            column(Company_Division; CompanyInformation.Division)
            {
            }
            column(ExternalDocumentNo_SalesInvoiceHeader; "External Document No.")
            {
            }
            column(VehiclePlateNo_SalesInvoiceHeader; "Vehicle Plate No.")
            {
            }
            column(InvoiceDiscountAmount_SalesInvoiceHeader; "Invoice Discount Amount")
            {
            }
            column(VINNo_SalesInvoiceHeader; "VIN No.")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Posting Date")
            {
            }
            column(LocationCode_SalesInvoiceHeader; "Location Code")
            {
            }
            column(BilltoContactNo_SalesInvoiceHeader; "Bill-to Contact No.")
            {
            }
            column(SelltoCustomerName_SalesInvoiceHeader; "Sell-to Customer Name")
            {
            }
            column(CustomerPOdate_SalesInvoiceHeader; "Customer PO date")
            {
            }
            column(SelltoAddress_SalesInvoiceHeader; "Sell-to Address")
            {
            }
            column(SelltoAddress2_SalesInvoiceHeader; "Sell-to Address 2")
            {
            }
            column(SelltoCity_SalesInvoiceHeader; "Sell-to City")
            {
            }
            column(SelltoContact_SalesInvoiceHeader; "Sell-to Contact")
            {
            }
            column(SelltoPostCode_SalesInvoiceHeader; "Sell-to Post Code")
            {
            }
            column(SelltoCounty_SalesInvoiceHeader; "Sell-to County")
            {
            }
            column(SelltoCountryRegionCode_SalesInvoiceHeader; "Sell-to Country/Region Code")
            {
            }
            column(YourReference_SalesInvoiceHeader; "Your Reference")
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
            column(PaymentTermsCode_SalesInvoiceHeader; "Payment Terms Code")
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
            column(BilltoAddress_SalesInvoiceHeaderS; "Bill-to Address")
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
            column(LocName; LocName)
            {
            }
            column(Curr; Curr)
            {
            }
            column(Number; Number)
            {
            }
            column(Model; Model)
            {
            }
            column(DoNo; "DoNo.")
            {
            }
            column(Address2; Address2)
            {
            }
            column(Address; Address)
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
            column(County; County)
            {
            }
            column(UserName; UserName)
            {
            }
            column(TRNo; TRNo)
            {
            }
            column(CountryRegion; CountryRegion1)
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
            column(CRDocumentNo_SalesInvoiceHeader; "CR  Document No.")
            {
            }
            column(CRExternalReferenceNo_SalesInvoiceHeader; "CR External Reference No.")
            {
            }
            column(NissanVisible; NissanVisible)
            {
            }
            dataitem(DataItem23; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(VATBaseAmount_SalesInvoiceLine; "VAT Base Amount")
                {
                }
                column(LocationCode_SalesInvoiceLine; "Location Code")
                {
                }
                column(LastPartNumber_SalesInvoiceLine; LastPartNumber)
                {
                }
                column(InvDiscountAmount_SalesInvoiceLine; "Inv. Discount Amount")
                {
                }
                column(LineDiscount_SalesInvoiceLine; "Line Discount %")
                {
                }
                column(ItemCategoryCode_SalesInvoiceLine; "Item Category Code")
                {
                }
                column(CrossReferenceNo_SalesInvoiceLine; "Item Reference No.")
                {
                }
                column(DocumentNo1_SalesInvoiceLine; "Document No.1")
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
                column(PartNo; PartNo)
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
                column(Division; Division)
                {
                }
                column(InvoiceType; InvoiceType)
                {
                }
                column(Dec; Dec)
                {
                }
                column(paymentAmount1; paymentAmount1)
                {
                }
                column(Cash; Cash)
                {
                }
                column(paymentAmount2; paymentAmount2)
                {
                }
                column(Dec1; Dec1)
                {
                }
                column(Tax; Tax)
                {
                }
                column(paymentAmount3; paymentAmount3)
                {
                }
                column(InvoiceDisc; InvoiceDisc)
                {
                }
                column(LineAmount_SalesInvoiceLine; "Line Amount")
                {
                }
                column(ItemCategoryDesc; ItemCategoryDesc)
                {
                }
                column(SumAmount; SumAmount)
                {
                }
                column(TotalTax; TotalTax)
                {
                }
                column(TotalAmount1; TotalAmount1)
                {
                }
                column(Discount1; Discount1)
                {
                }
                column(Netamount; Netamount)
                {
                }
                column(JobCardNo; JobCardNo)
                {
                }
                column(CustomerName; CustomerName)
                {
                }
                column(VehiclePlateNo; VehiclePlateNo)
                {
                }
                column(ModelNo; ModelNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" THEN BEGIN
                        SumAmount := -ROUND("Sales Invoice Line"."Line Amount" - "Sales Invoice Header"."Invoice Discount Amount");
                        Discount1 := "Sales Invoice Header"."Invoice Discount Amount";
                        Netamount := SumAmount - Discount1;
                        TotalTax := (("Sales Invoice Line"."Amount Including VAT" * -1) + "Sales Invoice Line".Amount);
                        TotalAmount1 := ROUND((Netamount + TotalTax), 0.01);
                    END ELSE BEGIN
                        "S.no" += 1;
                        TotalAmountinTaxable += "Sales Invoice Line"."Line Amount";
                        SumAmount := ROUND(TotalAmountinTaxable);
                        Discount1 := "Sales Invoice Header"."Invoice Discount Amount";
                        Netamount := ROUND(SumAmount - Discount1);
                        TotalTax := ROUND((Netamount * "Sales Invoice Line"."VAT %") / 100);
                        TotalAmount1 := ROUND(Netamount + TotalTax);
                    END;
                    InitTextVariables;
                    AmountInWordes := NumberInWords(TotalAmount1, '', Currcode);
                    //
                    Location.RESET;
                    Location.SETRANGE(Code, "Sales Invoice Line"."Location Code");
                    IF Location.FINDFIRST THEN BEGIN
                        LocName := Location.Name;
                        Address := DELCHR(Location.Address, '<>', ' ');
                        Address2 := Location."Address 2";
                        City := Location.City;
                        County := Location.County;
                        PhoneNo := Location."Phone No.";
                        FaxNo := Location."Fax No.";
                        TRNo := Location."Name 2";
                    END;


                    itemCategory.RESET;
                    IF itemCategory.GET("Sales Invoice Line"."Item Category Code") THEN
                        ItemCategoryDesc := itemCategory.Description;
                    TemporaryJobOrders.RESET;
                    TemporaryJobOrders.SETRANGE("Job Order No", "Sales Invoice Line"."Document No.1");
                    IF TemporaryJobOrders.FINDFIRST THEN BEGIN
                        JobCardNo := TemporaryJobOrders."Job Crad No";
                        CustomerName := TemporaryJobOrders."Customer Name";
                        VehiclePlateNo := TemporaryJobOrders."Vehicle Plate No";
                        ModelNo := TemporaryJobOrders."Model No";
                    END;

                    //IF01
                    PartNo := "Sales Invoice Line"."No.";
                    IF "Sales Invoice Line"."Gen. Prod. Posting Group" <> 'CD' THEN BEGIN
                        Compstr1 := COPYSTR(PartNo, 1, 2);
                        Compstr2 := COPYSTR("Sales Invoice Line"."Gen. Prod. Posting Group", 1, 1) + '#';
                        IF Compstr1 = Compstr2 THEN
                            PartNo := COPYSTR(PartNo, 3, STRLEN(PartNo));
                    END;
                    //IF01
                end;

                trigger OnPreDataItem()
                begin
                    "S.no" := 0;
                    TotalAmount := 0;
                    TotalAmountinclodingVat := 0;
                    TotalAmountinTaxable := 0;
                    AmtInclVAT := 0;
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
                        Division := FORMAT(CompanyInformation.Division);
                    END;
                END;

                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(CompanyInformation.Picture);


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

                CompanyInfo.RESET;
                IF CompanyInfo.GET(COMPANYNAME) THEN BEGIN
                    IF CompanyInfo.Division = CompanyInfo.Division::Auto THEN BEGIN
                        Number := "Sales Invoice Header"."Vehicle Plate No.";
                        Model := "Sales Invoice Header"."VIN No.";
                    END ELSE BEGIN
                        IF CompanyInfo.Division = CompanyInfo.Division::"E-PS" THEN BEGIN
                            Number := '';
                            Model := '';
                        END;
                    END;
                END;
                //
                SalesShipmentHeader.RESET;
                SalesShipmentHeader.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
                IF SalesShipmentHeader.FINDFIRST THEN
                    "DoNo." := SalesShipmentHeader."No.";
                //
                User.RESET;
                User.SETRANGE("User Name", USERID);
                IF User.FINDFIRST THEN
                    UserName := User."Full Name";

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
            area(content)
            {
                group("Nissan Rport")
                {
                    field(Nissan; NissanVisible)
                    {
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
        CompanyRec: Record Company;
        Division: Text;
        Contact: Record Contact;
        ContAddress: Text[50];
        Cont_Address: Text[50];
        InvoiceType: Text;
        Location: Record Location;
        LocName: Text[50];
        Curr: Code[20];
        Cash: Boolean;
        GLEntry: Record "G/L Entry";
        Currcode: Text[50];
        Currency: Record Currency;
        paymentAmount: Decimal;
        paymentAmount1: Text;
        CompanyInfo: Record "Company Information";
        Number: Code[20];
        Model: Code[20];
        SalesShipmentHeader: Record "Sales Shipment Header";
        "DoNo.": Code[20];
        paymentAmount2: Text;
        Dec: Text;
        Dec1: Text;
        Address: Text;
        Address2: Text;
        City: Text;
        PhoneNo: Text;
        FaxNo: Text;
        TotalAmountinTaxable: Decimal;
        paymentAmount3: Text;
        InvoiceDisc: Decimal;
        AmtInclVAT: Decimal;
        itemCategory: Record "Item Category";
        ItemCategoryDesc: Text[50];
        SumAmount: Decimal;
        Discount: Decimal;
        TotalTax: Decimal;
        TotalAmount1: Decimal;
        Discount1: Decimal;
        Netamount: Decimal;
        County: Text;
        User: Record User;
        UserName: Text;
        TRNo: Text;
        CountryRegion: Record "Country/Region";
        CountryRegion1: Text;
        JobCardNo: Text;
        CustomerName: Text;
        VehiclePlateNo: Text;
        ModelNo: Text;
        TemporaryJobOrders: Record "Temporary Job Orders";
        NissanVisible: Boolean;
        PartNo: Code[20];
        Compstr1: Code[20];
        Compstr2: Code[20];
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

    local procedure CaashReceipt()
    begin
    end;
}

