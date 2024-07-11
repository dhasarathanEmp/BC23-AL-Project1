report 50070 "Picking Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Picking Slip.rdlc';

    dataset
    {
        dataitem(DataItem1; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.";
            column(OrderDate_SalesHeader; "Order Date")
            {
            }
            column(DocumentType_SalesHeader; "Document Type")
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
            column(BilltoName_Address; "Bill-to Address")
            {
            }
            column(CustCity; "Bill-to City")
            {
            }
            column(CustPostCode; "Bill-to Post Code")
            {
            }
            column(DeliveryTerms_SalesHeader; "Delivery Terms")
            {
            }
            column(CustCountry; "Bill-to Country/Region Code")
            {
            }
            column(BilltoContact_SalesHeader; "Bill-to Contact")
            {
            }
            column(CustomerNo; "Sell-to Customer No.")
            {
            }
            column(CustomerAddress; "Sell-to Address")
            {
            }
            column(BillToCounty; "Bill-to County")
            {
            }
            column(CustomerAddress2; "Sell-to Address 2")
            {
            }
            column(CustomerOrderNo; "External Document No.")
            {
            }
            column(CPOD; "Customer PO date")
            {
            }
            column(Location; "Location Code")
            {
            }
            column(Curr; Curr)
            {
            }
            column(CustAddr8; CustAddr[8])
            {
            }
            column(CustAddr7; CustAddr[7])
            {
            }
            column(CustAddr6; CustAddr[6])
            {
            }
            column(CustAddr5; CustAddr[5])
            {
            }
            column(CustAddr4; CustAddr[4])
            {
            }
            column(CustAddr3; CustAddr[3])
            {
            }
            column(CustAddr2; CustAddr[2])
            {
            }
            column(CustAddr1; CustAddr[1])
            {
            }
            column(Reference; "Your Reference")
            {
            }
            column(CustomerName; "Sell-to Customer Name")
            {
            }
            column(InvDiscountPer; "Invoice Discount%")
            {
            }
            column(Discount; "Invoice Discount Value")
            {
            }
            column(YourReference_SalesHeader; "Your Reference")
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; Address1)
            {
            }
            column(City; City)
            {
            }
            column(PostCode; PostCode)
            {
            }
            column(Phone; Phone)
            {
            }
            column(CountryRegion; CountryRegCode)
            {
            }
            column(County; County)
            {
            }
            column(Fax; Fax)
            {
            }
            column(TRNo; TRNo)
            {
            }
            column(LocationName; LocationName)
            {
            }
            column(USer; UserName)
            {
            }
            dataitem(DataItem10; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = WHERE("No." = FILTER(<> ''));
                column(DocumentNo_SalesLine; "Document No.")
                {
                }
                column(LineNo_SalesLine; "Line No.")
                {
                }
                column(Type_SalesLine; Type)
                {
                }
                column(No_SalesLine; "No.")
                {
                }
                column(Description_SalesLine; Description)
                {
                }
                column(Quantity_SalesLine; Quantity)
                {
                }
                column(UnitPrice_SalesLine; "Unit Price")
                {
                }
                column(Amount_SalesLine; Amount)
                {
                }
                column(InvDiscount; "Inv. Discount Amount")
                {
                }
                column(ITC; "Item Category Code")
                {
                }
                column(BinCode_SalesLine; "Bin Code")
                {
                }
                column(SerialNo; "Sl.No")
                {
                }
                column(CustomerPartNo; "Item Reference No.")
                {
                }
                column(AmountIncVat; "Amount Including VAT")
                {
                }
                column("Do"; DoQuantity)
                {
                }
                column("To"; ToQuantity)
                {
                }
                column(Balance; Balance)
                {
                }
                column(LineDisPer; "Line Discount %")
                {
                }
                column(WarehouseNo; WhseNo)
                {
                }
                column(ToQuantity; ToQuantity)
                {
                }
                column(OrderedPart; LastPartNumber)
                {
                }
                column(VatTax; VatTax)
                {
                }
                column(VAT_SalesLine; "VAT %")
                {
                }
                column(LocationHdr; "Location Code")
                {
                }
                column(LineAmount; "Line Amount")
                {
                }
                column(ITCDesc; ITCDesc)
                {
                }
                column(AmountInWords; AmountInWordes)
                {
                }
                dataitem(DataItem77; "Company Information")
                {
                    column(Name_CompanyInformation; Name)
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
                    column(VATRegistrationNo_CompanyInformation; "VAT Registration No.")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    "Sl.No" += 1;
                    SumAmount += SumAmount;
                    Item.RESET;
                    Item.SETFILTER("Location Filter", "Sales Line"."Location Code");
                    Item.SETRANGE("No.", "Sales Line"."No.");
                    IF Item.FINDFIRST THEN BEGIN

                        IF "Sales Header"."Currency Code" <> '' THEN
                            Curr := "Sales Header"."Currency Code"
                        ELSE
                            Curr := 'USD';

                    END;
                    Currency.SETRANGE(Code, Curr);
                    IF Currency.FINDFIRST THEN
                        Currcode := Currency."Currency Code"
                    ELSE
                        Currcode := 'Cent';


                    Item.RESET;
                    Item.SETFILTER("Location Filter", "Sales Line"."Location Code");
                    Item.SETRANGE("No.", "Sales Line"."No.");
                    IF Item.FINDFIRST THEN BEGIN
                        Item.CALCFIELDS(Inventory);
                        Stock := Item.Inventory;
                    END;
                    //
                    IF Exclude = TRUE THEN BEGIN
                        CalculateStk1("Sales Line"."Location Code", "Sales Line"."No.");
                        Stock -= PtkStkQty;
                    END;
                    //
                    Item.RESET;
                    Item.SETRANGE("No.", "Sales Line"."No.");
                    Item.SETRANGE("Location Filter", "Sales Line"."Location Code");
                    IF Item.FINDFIRST THEN BEGIN
                        Item.CALCFIELDS("Reserved Qty. on Inventory");
                        RESQTY := Item."Reserved Qty. on Inventory";
                    END;
                    Stock := Stock - RESQTY;

                    DoQuantity := 0;
                    IF Stock > "Sales Line".Quantity THEN
                        DoQuantity := "Sales Line".Quantity
                    ELSE IF Stock = 0 THEN
                        DoQuantity := 0
                    ELSE IF Stock < "Sales Line".Quantity THEN
                        DoQuantity := Stock
                    ELSE IF Stock = "Sales Line".Quantity THEN
                        DoQuantity := Stock;

                    VatTax += "Sales Line"."Amount Including VAT" - "Sales Line".Amount;

                    Total += "Sales Line"."Amount Including VAT";
                    InitTextVariables;
                    AmountInWordes := NumberInWords(Total, '', Currcode);

                    SalesLine2.RESET;
                    SalesLine2.SETRANGE("Document No.", "Sales Line"."Document No.");
                    IF SalesLine2.FINDFIRST THEN
                        ITCName := SalesLine2."Item Category Code";

                    ITC.RESET;
                    ITC.SETRANGE(Code, ITCName);
                    IF ITC.FINDFIRST THEN
                        ITCDesc := ITC.Description;

                    ItemBinCode();
                end;

                trigger OnPreDataItem()
                begin
                    Discount := 0;
                    SumAmount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                FormatAddressFields("Sales Header");
                Location.RESET;
                Location.SETRANGE(Code, "Sales Header"."Responsibility Center");
                IF Location.FINDFIRST THEN BEGIN
                    LocationName := Location.Name;
                    Address := Location.Address;
                    Address1 := Location."Address 2";
                    City := Location.City;
                    PostCode := Location."Post Code";
                    CountryRegCode := Location."Country/Region Code";
                    Phone := Location."Phone No.";
                    Fax := Location."Fax No.";
                    County := Location.County;
                    LocName := Location.Name;
                    TRNo := Location."Name 2";
                END;
            end;

            trigger OnPreDataItem()
            begin
                //Location.SETRANGE(Code,"Sales Header"."Location Code");
                "Sl.No" := 0;
                Total := 0;
                User.RESET;
                User.SETRANGE("User Security ID", USERSECURITYID);
                IF User.FINDFIRST THEN
                    UserName := User."Full Name";
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Exclude Protective Bin"; Exclude)
                {
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

    trigger OnPreReport()
    begin
        //salesheader.SETRANGE("Document Type","Sales Header"."Document Type"::Order);
        DoQuantity := 0;
    end;

    var
        "Sl.No": Integer;
        SalesType: Code[20];
        salesheader: Record "Sales Header";
        DoQuantity: Decimal;
        ToQuantity: Decimal;
        whseshipline: Record "Warehouse Shipment Line";
        whseshipline1: Record "Warehouse Shipment Line";
        ItemLocation: Page "Item Availability by Location";
        ItemLedEnt: Record "Item Ledger Entry";
        ItemLedEnt1: Record "Item Ledger Entry";
        ToQuantityOrg: Decimal;
        RecCount: Integer;
        Item: Record Item;
        AvailToPromise: Codeunit "Available to Promise";
        ItemFilter: Text;
        BackOrderQty: Decimal;
        InvtReorder: Boolean;
        WhseNo: Code[20];
        Balance: Decimal;
        Curr: Code[20];
        LocationName: Text;
        Stock: Decimal;
        SalesLine: Record "Sales Line";
        VatTax: Decimal;
        AmountInWordes: Text[300];
        OnesText: array[20] of Text[90];
        TensText: array[10] of Text[90];
        ThousText: array[5] of Text[30];
        WholeInWords: Text[300];
        DecimalInWords: Text[300];
        WholePart: Integer;
        DecimalPart: Decimal;
        TotalCost: Text[300];
        RepCheck: Report Check;
        NoText: array[2] of Text;
        Total: Decimal;
        Currency: Record Currency;
        Currcode: Text[50];
        PtkStkQty: Decimal;
        BinContent: Record "Bin Content";
        Exclude: Boolean;
        ILE: Record "Item Ledger Entry";
        RESQTY: Decimal;
        AvlStock: Decimal;
        BillToAddr: array[8] of Text[50];
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        CustAddr: array[8] of Text[50];
        RespCenter: Record "Responsibility Center";
        CompanyInfo: Record "Company Information";
        CompanyAddr: array[8] of Text[50];
        ShowShippingAddr: Boolean;
        ShipToAddr: array[8] of Text[50];
        Salesshipheader: Record "Sales Shipment Header";
        User: Record User;
        UserName: Code[50];
        Location: Record Location;
        Address: Text[50];
        Address1: Text[50];
        City: Text[30];
        PostCode: Code[20];
        Phone: Text[30];
        Fax: Text[30];
        CountryRegCode: Code[10];
        County: Text[30];
        LocName: Code[50];
        SumAmount: Decimal;
        Discount: Decimal;
        TRNo: Text;
        SalesLine2: Record "Sales Line";
        ITC: Record "Item Category";
        ITCName: Text[30];
        ITCDesc: Text[30];
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

    local procedure CalculateStk1("Code": Code[20]; ItemNo: Code[20])
    begin
        /*ILE.RESET;
        ILE.SETRANGE("Location Code",Code);
        ILE.SETRANGE("Item No.",ItemNo);
        IF ILE.FINDSET THEN BEGIN
          ILE.CALCSUMS(Quantity);*/
        PtkStkQty := 0;
        BinContent.RESET;
        BinContent.SETRANGE("Location Code", Code);
        BinContent.SETRANGE("Item No.", ItemNo);
        IF BinContent.FINDSET THEN
            REPEAT
                BinContent.CALCFIELDS("Bin Blocks");
                BinContent.CALCFIELDS("Counter sale");
                BinContent.CALCFIELDS(Quantity);
                IF ((BinContent.DeadBlocks = TRUE) AND (BinContent."Counter sale" = TRUE) AND (BinContent."Bin Blocks" = TRUE)) OR
                    ((BinContent.DeadBlocks = FALSE) AND (BinContent."Counter sale" = FALSE) AND (BinContent."Bin Blocks" = FALSE)) THEN
                    PtkStkQty += BinContent.Quantity;
            UNTIL BinContent.NEXT = 0;
        /*CASE Code OF
           'ADE':
            STK_ADE  := ILE.Quantity-PtkStkQty;
          'ADF':
            STK_ADF  :=  ILE.Quantity-PtkStkQty;
          'HOD':
            STK_HOD  := ILE.Quantity-PtkStkQty;
          'MUK':
            STK_MUK  := ILE.Quantity-PtkStkQty;
          'SAN':
            STK_SAN  := ILE.Quantity-PtkStkQty;
          'TAZ':
            STK_TAZ  := ILE.Quantity-PtkStkQty;
        
        END;
        TotalStock  += ILE.Quantity-PtkStkQty;
        END;*/

    end;

    local procedure FormatAddressFields(salesHeader: Record "Sales Header")
    begin
        FormatAddr.GetCompanyAddr("Sales Header"."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesHeaderSellTo(CustAddr, salesHeader);
        ShowShippingAddr := FormatAddr.SalesShptBillTo(ShipToAddr, CustAddr, Salesshipheader)
    end;

    local procedure ItemBinCode()
    begin
        IF "Sales Line"."Bin Code" = '' THEN BEGIN
            BinContent.RESET;
            BinContent.SETRANGE("Location Code", "Sales Line"."Location Code");
            BinContent.SETRANGE("Item No.", "Sales Line"."No.");
            BinContent.SETRANGE(Default, TRUE);
            IF BinContent.FINDFIRST THEN
                "Sales Line"."Bin Code" := BinContent."Bin Code";
        END
    end;
}

