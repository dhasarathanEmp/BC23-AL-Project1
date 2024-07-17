report 50022 "CreditNoteCustomerReturn Auto"
{
    // IF01 Removing Postfix from Part No.
    DefaultLayout = RDLC;
    RDLCLayout = './CreditNoteCustomerReturn Auto.rdlc';


    dataset
    {
        dataitem(DataItem1; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(CustomerPOdate_SalesCrMemoHeader; "Customer PO date")
            {
            }
            column(InvoiceDiscount_SalesCrMemoHeader; "Invoice Discount%")
            {
            }
            column(Company_Division; CompanyInfo.Division)
            {
            }
            column(PaymentDiscount_SalesCrMemoHeader; "Payment Discount %")
            {
            }
            column(InvoiceDiscountAmount_SalesCrMemoHeader; "Invoice Discount Amount")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_VATRegistratioNNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(BilltoContactNo_SalesCrMemoHeader; "Bill-to Contact No.")
            {
            }
            column(CurrencyCode_SalesCrMemoHeader; "Currency Code")
            {
            }
            column(GetReturnReceiptUsed_SalesCrMemoHeader; "Get Return Receipt Used")
            {
            }
            column(AppliestoDocNo_SalesCrMemoHeader; "Applies-to Doc. No.")
            {
            }
            column(PostingDate_SalesCrMemoHeader; "Posting Date")
            {
            }
            column(BilltoPostCode_SalesCrMemoHeader; "Bill-to Post Code")
            {
            }
            column(BilltoCounty_SalesCrMemoHeader; "Bill-to County")
            {
            }
            column(BilltoCountryRegionCode_SalesCrMemoHeader; "Bill-to Country/Region Code")
            {
            }
            column(ShipmentDate_SalesCrMemoHeader; "Shipment Date")
            {
            }
            column(SelltoCustomerNo_SalesCrMemoHeader; "Sell-to Customer No.")
            {
            }
            column(No_SalesCrMemoHeader; "No.")
            {
            }
            column(YourReference_SalesCrMemoHeader; "Your Reference")
            {
            }
            column(BilltoCustomerNo_SalesCrMemoHeader; "Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesCrMemoHeader; "Bill-to Name")
            {
            }
            column(BilltoName2_SalesCrMemoHeader; "Bill-to Name 2")
            {
            }
            column(BilltoAddress_SalesCrMemoHeader; "Bill-to Address")
            {
            }
            column(DueDate_SalesCrMemoHeader; "Due Date")
            {
            }
            column(BilltoAddress2_SalesCrMemoHeader; "Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesCrMemoHeader; "Bill-to City")
            {
            }
            column(BilltoContact_SalesCrMemoHeader; "Bill-to Contact")
            {
            }
            column(Amount_SalesCrMemoHeader; Amount)
            {
            }
            column(AmountIncludingVAT_SalesCrMemoHeader; "Amount Including VAT")
            {
            }
            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyAddress7; CompanyAddr[7])
            {
            }
            column(CompanyAddress8; CompanyAddr[8])
            {
            }
            column(CustomerAddress1; CustAddr[1])
            {
            }
            column(CustomerAddress2; CustAddr[2])
            {
            }
            column(CustomerAddress3; CustAddr[3])
            {
            }
            column(CustomerAddress4; CustAddr[4])
            {
            }
            column(CustomerAddress5; CustAddr[5])
            {
            }
            column(CustomerAddress6; CustAddr[6])
            {
            }
            column(CustomerAddress7; CustAddr[7])
            {
            }
            column(CustomerAddress8; CustAddr[8])
            {
            }
            column(AmountWordes; AmountWordes)
            {
            }
            column(InvoiceDate; InvoiceDate)
            {
            }
            column(GRNNUMBER; GRNNUMBER)
            {
            }
            column(Number; Number)
            {
            }
            column(Model; Model)
            {
            }
            column(SalesInv; SalesInv)
            {
            }
            column(GrnNumber1; GrnNumber1)
            {
            }
            column(Vinnum; Vinnum)
            {
            }
            column(VehiclePlateNo; VehiclePlateNo)
            {
            }
            column(ReportName; ReportName)
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
            column(CompanyInformationPicture; CompanyInformation.Picture)
            {
            }
            column(TRNO; TRNo)
            {
            }
            column(CountryRegion; CountryRegion1)
            {
            }
            column(ContName; ContName)
            {
            }
            column(ContAddress; ContAddress)
            {
            }
            column(Cont_Address; Cont_Address)
            {
            }
            column(ContPostalCode; ContPostalCode)
            {
            }
            column(ContCity; ContCity)
            {
            }
            column(ContCountry; ContCountry)
            {
            }
            column(WarehouseName; WarehouseName)
            {
            }
            column(ExternalDocumentNo_SalesCrMemoHeader; "External Document No.")
            {
            }
            column(ItemCategoryDesc; ItemCategoryDesc)
            {
            }
            dataitem(DataItem20; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Sell-to Customer No." = FIELD("Sell-to Customer No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(SelltoCustomerNo_SalesCrMemoLine; "Sell-to Customer No.")
                {
                }
                column(LastPartNumber_SalesCrMemoLine; LastPartNumber)
                {
                }
                column(DocumentNo_SalesCrMemoLine; "Document No.")
                {
                }
                column(LineNo_SalesCrMemoLine; "Line No.")
                {
                }
                column(Type_SalesCrMemoLine; Type)
                {
                }
                column(No_SalesCrMemoLine; "No.")
                {
                }
                column(LocationCode_SalesCrMemoLine; "Location Code")
                {
                }
                column(PostingGroup_SalesCrMemoLine; "Posting Group")
                {
                }
                column(ShipmentDate_SalesCrMemoLine; "Shipment Date")
                {
                }
                column(Description_SalesCrMemoLine; Description)
                {
                }
                column(Description2_SalesCrMemoLine; "Description 2")
                {
                }
                column(CrossReferenceNo_SalesCrMemoLine; "Item Reference No.")
                {
                }
                column(UnitofMeasure_SalesCrMemoLine; "Unit of Measure")
                {
                }
                column(Quantity_SalesCrMemoLine; Quantity)
                {
                }
                column(UnitPrice_SalesCrMemoLine; "Unit Price")
                {
                }
                column(UnitCostLCY_SalesCrMemoLine; "Unit Cost (LCY)")
                {
                }
                column(VAT_SalesCrMemoLine; "VAT %")
                {
                }
                column(LineDiscount_SalesCrMemoLine; "Line Discount %")
                {
                }
                column(ItemCategoryCode_SalesCrMemoLine; "Item Category Code")
                {
                }
                column(LineDiscountAmount_SalesCrMemoLine; "Line Discount Amount")
                {
                }
                column(Amount_SalesCrMemoLine; Amount)
                {
                }
                column(AmountIncludingVAT_SalesCrMemoLine; "Amount Including VAT")
                {
                }
                column(LineAmount_SalesCrMemoLine; "Line Amount")
                {
                }
                column(SerialNo; SerialNo)
                {
                }
                column(Curr; Curr)
                {
                }
                column(SubTotal; SubTotal)
                {
                }
                column(SubTotal1; SubTotal1)
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(Tax; Tax)
                {
                }
                column(SalesInv1; SalesInv1)
                {
                }
                column(SaleInvNo_SalesCrMemoLine; SaleInvNo)
                {
                }
                column(InvoiceDate1; InvoiceDate1)
                {
                }
                column(InvoiceNo; InvoiceNo)
                {
                }
                column(Agency; Agency)
                {
                }
                column(PartNo; PartNo)
                {
                }
                column(PONumber_SalesCrMemoLine; "PO Number")
                {
                }
                column(CustomerSerialNo_SalesCrMemoLine; "Customer Serial No")
                {
                }
                dataitem(DataItem82; "Company Information")
                {
                    column(Name_CompanyInformation; Name)
                    {
                    }
                    column(VATRegistrationNo_CompanyInformation; "VAT Registration No.")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //IF01
                    PartNo := "Sales Cr.Memo Line"."No.";
                    IF "Sales Cr.Memo Line"."Gen. Prod. Posting Group" <> 'CD' THEN BEGIN
                        CompareChr1 := COPYSTR(PartNo, 1, 2);
                        CompareChr2 := COPYSTR("Sales Cr.Memo Line"."Gen. Prod. Posting Group", 1, 1) + '#';
                        IF CompareChr1 = CompareChr2 THEN
                            PartNo := COPYSTR(PartNo, 3, STRLEN(PartNo));
                    END;
                    //IF01
                    SerialNo += 1;
                    SubTotal += "Sales Cr.Memo Line".Amount;
                    SubTotal1 := SubTotal;
                    Tax := SubTotal1 * "Sales Cr.Memo Line"."VAT %" / 100;
                    TotalAmount := ROUND((SubTotal1 + Tax), 0.01);
                    AmountInWordes.InitTextVariables;
                    AmountWordes := AmountInWordes.NumberInWords(TotalAmount, '', Currcode);


                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE("No.", "Sales Cr.Memo Line".SaleInvNo);
                    IF SalesInvoiceHeader.FINDFIRST THEN
                        InvoiceDate1 := SalesInvoiceHeader."Posting Date";

                    COmpanyInf.RESET;
                    IF COmpanyInf.GET(COMPANYNAME) THEN BEGIN
                        IF COmpanyInf.Division = COmpanyInf.Division::Auto THEN BEGIN
                            SalesInvoiceHeader.RESET;
                            SalesInvoiceHeader.SETRANGE("No.", "Sales Cr.Memo Line".SaleInvNo);
                            IF SalesInvoiceHeader.FINDFIRST THEN
                                IF Vinnum = '' THEN BEGIN
                                    Vinnum := SalesInvoiceHeader."VIN No.";
                                    GrnNumber1 := SalesInvoiceHeader."Vehicle Plate No.";
                                END ELSE BEGIN
                                    Vinnum := SalesInvoiceHeader."VIN No.";
                                    GrnNumber1 := SalesInvoiceHeader."Vehicle Plate No.";
                                END;
                        END;
                    END;
                    IF "Sales Cr.Memo Line"."Document No.1" = '' THEN BEGIN
                        ReportName := 'CREDIT NOTE CUSTOMER RETURN';
                        InvoiceNo := "Sales Cr.Memo Line".SaleInvNo;
                    END ELSE BEGIN
                        ReportName := 'CREDIT NOTE CASH SALES';
                        /* SalesShipmentLine.RESET;
                         SalesShipmentLine.SETRANGE("Document No.","Sales Cr.Memo Line".SaleInvNo);
                         IF SalesShipmentLine.FINDFIRST THEN BEGIN
                         SalesInvoiceLine.RESET;
                         SalesInvoiceLine.SETRANGE("Document No.1",SalesShipmentLine."Document No.1");
                         IF SalesInvoiceLine.FINDFIRST THEN
                           InvoiceNo :=SalesInvoiceLine."Document No.";
                           InvoiceDate1:=SalesInvoiceLine."Posting Date";*/
                        InvoiceNo := "Sales Cr.Memo Line".SaleInvNo;
                        //END;
                    END;
                    IF "Sales Cr.Memo Line"."Item Category Code" = 'CD' THEN
                        Agency := 'CAT';
                    //
                    Location.RESET;
                    Location.SETRANGE(Code, "Sales Cr.Memo Line"."Location Code");
                    IF Location.FINDFIRST THEN BEGIN
                        LocName := Location.Name;
                        LocAddress := Location.Address;
                        LocAddress2 := Location."Address 2";
                        LocCity := Location.City;
                        LOCPhone := Location."Phone No.";
                        LocFaxNo := Location."Fax No.";
                        LocCountry := Location.County;
                        LocPostcode := Location."Post Code";
                        TRNo := Location."Name 2";
                    END;
                    itemCategory.RESET;
                    IF itemCategory.GET("Sales Cr.Memo Line"."Item Category Code") THEN
                        ItemCategoryDesc := itemCategory.Description;

                    WarehouseName := '';
                    COmpanyInf.RESET;
                    COmpanyInf.SETRANGE(Name, CURRENTCOMPANY);
                    COmpanyInf.SETRANGE(AFZ, TRUE);
                    IF COmpanyInf.FINDFIRST THEN BEGIN
                        WarehouseName := 'CIF Aden Free Zone ' + 'USD'
                    END ELSE
                        WarehouseName := ' USD ' + 'EX-Warehouse ' + LocName;

                end;

                trigger OnPreDataItem()
                begin
                    SerialNo := 0;
                    SubTotal := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                Customer.RESET;
                Customer.SETRANGE("No.", "Sales Cr.Memo Header"."Bill-to Customer No.");
                Customer.SETRANGE("One Time Customer", TRUE);
                IF Customer.FINDFIRST THEN BEGIN
                    Contact.RESET;
                    Contact.SETRANGE("No.", "Sales Cr.Memo Header"."Bill-to Contact No.");
                    IF Contact.FINDFIRST THEN BEGIN
                        ContName := Contact.Name;
                        ContAddress := Contact.Address;
                        Cont_Address := Contact."Address 2";
                        ContPostalCode := Contact."Post Code";
                        ContCity := Contact.City;
                        ContCountry := Contact."Country/Region Code";
                    END;
                END ELSE BEGIN
                    ContName := "Sales Cr.Memo Header"."Bill-to Name";
                    ContAddress := "Sales Cr.Memo Header"."Bill-to Address";
                    Cont_Address := "Sales Cr.Memo Header"."Bill-to Address 2";
                    ContPostalCode := "Sales Cr.Memo Header"."Bill-to Post Code";
                    ContCity := "Sales Cr.Memo Header"."Bill-to City";
                    ContCountry := "Sales Cr.Memo Header"."Bill-to Country/Region Code";
                END;

                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);
                FormatAddressFields("Sales Cr.Memo Header");
                IF "Sales Cr.Memo Header"."Currency Code" <> '' THEN
                    Curr := "Sales Cr.Memo Header"."Currency Code"
                ELSE
                    Curr := 'USD';
                Currency.SETRANGE(Code, Curr);
                IF Currency.FINDFIRST THEN
                    Currcode := Currency."Currency Code"
                ELSE
                    Currcode := 'Cent';


                COmpanyInf.RESET;
                IF COmpanyInf.GET(COMPANYNAME) THEN BEGIN
                    IF COmpanyInf.Division = COmpanyInf.Division::Auto THEN BEGIN
                        Number := 'Vehicle Plate No.';
                        Model := 'Model /VIN';
                    END ELSE BEGIN
                        IF COmpanyInf.Division = COmpanyInf.Division::"E-PS" THEN BEGIN
                            Number := '';
                            Model := '';
                            Vinnum := '';
                        END;
                    END;
                END;
                //
                User.RESET;
                User.SETRANGE("User Name", USERID);
                IF User.FINDFIRST THEN
                    UserName := User."Full Name";

                CountryRegion.RESET;
                CountryRegion.SETRANGE(Code, "Sales Cr.Memo Header"."Sell-to Country/Region Code");
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
        CompanyInfo.GET;
        CompanyInfo.VerifyAndSetPaymentInfo;
    end;

    var
        CompanyInfo: Record "Company Information";
        FormatAddr: Codeunit "Format Address";
        CustAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        RespCenter: Record "Responsibility Center";
        ShowShippingAddr: Boolean;
        ShipToAddr: array[8] of Text[50];
        SerialNo: Integer;
        Curr: Code[20];
        Currency: Record Currency;
        Currcode: Text[50];
        AmountInWordes: Codeunit "Amount In Words";
        AmountWordes: Text;
        SubTotal: Decimal;
        Tax: Decimal;
        Discount: Decimal;
        SubTotal1: Decimal;
        TotalAmount: Decimal;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ReturnReceiptHeader: Record "Return Receipt Header";
        GRNNUMBER: Code[20];
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        DescRcptLine: Text[50];
        SalesInv: Code[20];
        CompanyInf: Record "Company Information";
        Number: Text[50];
        Model: Text[50];
        SalesInv1: Code[20];
        InvoiceDate1: Date;
        InvoiceDate: Date;
        "Line No.": Integer;
        "Line No.1": Integer;
        GrnNumber1: Code[20];
        Vinnum: Code[20];
        VehiclePlateNo: Code[20];
        ReportName: Text;
        InvoiceNo: Code[20];
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvoiceLine1: Record "Sales Invoice Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        Agency: Text;
        LocName: Text;
        User: Record User;
        LocAddress: Text;
        LocAddress2: Text;
        LocCity: Text;
        LOCPhone: Text;
        LocFaxNo: Text;
        LocCountry: Text;
        LocPostcode: Text;
        UserName: Text;
        Location: Record Location;
        CompanyInformation: Record "Company Information";
        CountryRegion: Record "Country/Region";
        CountryRegion1: Text;
        itemCategory: Record "Item Category";
        ItemCategoryDesc: Text[50];
        Address: Text;
        Address2: Text;
        City: Text;
        PhoneNo: Text;
        FaxNo: Text;
        County: Text;
        TRNo: Text;
        ContAddress: Text[50];
        Cont_Address: Text[50];
        ContPostalCode: Code[20];
        ContCity: Text;
        ContCountry: Code[20];
        ContName: Text;
        Customer: Record Customer;
        Contact: Record Contact;
        PartNo: Code[20];
        CompareChr1: Text;
        CompareChr2: Text;
        WarehouseName: Text;
        "Sales Cr.Memo Line": Record "Sales Cr.Memo Line";
        "Sales Cr.Memo Header": Record "Sales Cr.Memo Header";

    local procedure FormatAddressFields(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        FormatAddr.GetCompanyAddr(SalesCrMemoHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesCrMemoBillTo(CustAddr, SalesCrMemoHeader);
        ShowShippingAddr := FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, SalesCrMemoHeader);
    end;
}

