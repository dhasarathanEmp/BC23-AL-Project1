report 50027 "GRN Sales return"
{
    // IF01 Removing Postfix from Part No
    DefaultLayout = RDLC;
    RDLCLayout = './GRN Sales return.rdlc';


    dataset
    {
        dataitem(DataItem1;Table7318)
        {
            RequestFilterFields = "No.";
            column(PostingDate;"Posted Whse. Receipt Header"."Posting Date")
            {
            }
            column(GRN;"Posted Whse. Receipt Header"."No.")
            {
            }
            column(VendorInvoiceNo;"Posted Whse. Receipt Header"."Vendor Invoice Number")
            {
            }
            dataitem(DataItem3;Table7319)
            {
                DataItemLink = No.=FIELD(No.);
                column(No;"Posted Whse. Receipt Line"."No.")
                {
                }
                column(Item;"Posted Whse. Receipt Line"."Item No.")
                {
                }
                column(Description;"Posted Whse. Receipt Line".Description)
                {
                }
                column(SalesOrder;"Posted Whse. Receipt Line"."Source No.")
                {
                }
                column(Quantity;"Posted Whse. Receipt Line".Quantity)
                {
                }
                column(serial;SerialNo)
                {
                }
                column(BinCode;"Posted Whse. Receipt Line"."Bin Code")
                {
                }
                column(UnitCost;UnitCost)
                {
                }
                column(CustomerName;CustomerName)
                {
                }
                column(OrderNo;OrderNo)
                {
                }
                column(SoldQty;soldQty)
                {
                }
                column(LineAmount;TotalCost)
                {
                }
                column(InvoiceDate;InvoiceDate)
                {
                }
                column(InvoiceNo;InvoiceNo)
                {
                }
                column(CurrCode;CurrCode)
                {
                }
                column(Topic;Topic)
                {
                }
                column(TotalCost;TotalCost)
                {
                }
                column(TotalAmount;TotalAmount)
                {
                }
                column(VendorInvoice;"Posted Whse. Receipt Line"."Vendor Invoice Qty")
                {
                }
                column(UnitPrice;"Posted Whse. Receipt Line"."Unit Price")
                {
                }
                column(Amount;"Posted Whse. Receipt Line".Amount)
                {
                }
                column(LocAddress;Address)
                {
                }
                column(LocAddress1;Address1)
                {
                }
                column(LocCity;City)
                {
                }
                column(LocPostCode;PostCode)
                {
                }
                column(LocPhone;Phone)
                {
                }
                column(LocCountryRegion;CountryRegCode)
                {
                }
                column(LocCountry;County)
                {
                }
                column(LocFax;Fax)
                {
                }
                column(Location;LocationName)
                {
                }
                column(ITC;ITCDesc)
                {
                }
                column(USer;UserName)
                {
                }
                column(PartNo;PartNo)
                {
                }
                dataitem(DataItem77;Table79)
                {
                    column(CompName;"Company Information".Name)
                    {
                    }
                    column(Address;"Company Information".Address)
                    {
                    }
                    column(Address1;"Company Information"."Address 2")
                    {
                    }
                    column(City;"Company Information".City)
                    {
                    }
                    column(PhoneNo;"Company Information"."Phone No.")
                    {
                    }
                    column(FaxNo;"Company Information"."Fax No.")
                    {
                    }
                    column(VatRegNo;"Company Information"."VAT Registration No.")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //IF01
                    PartNo := "Posted Whse. Receipt Line"."Item No.";
                    Item.GET("Posted Whse. Receipt Line"."Item No.");
                    IF Item."Global Dimension 1 Code" <> 'CD' THEN BEGIN
                      CompareChr1 := COPYSTR(PartNo,1,2);
                      CompareChr2 := COPYSTR(Item."Global Dimension 1 Code",1,1)+'#';
                      IF CompareChr1 = CompareChr2 THEN
                        PartNo := COPYSTR(PartNo,3,STRLEN(PartNo));
                    END;
                    //IF01
                    SerialNo += 1;
                    soldQty := 0;
                    ItemShipentry := 0;
                    Item.RESET;
                    Item.SETRANGE("No.","Posted Whse. Receipt Line"."Item No.");
                    IF Item.FINDFIRST THEN
                    UnitCost := Item."Unit Price";
                    Quantity := "Posted Whse. Receipt Line".Quantity;
                    TotalCost := "Posted Whse. Receipt Line".Amount;
                    TotalAmount += TotalCost;

                    InvItemNo := "Posted Whse. Receipt Line"."Item No.";
                    InvLineNo := "Posted Whse. Receipt Line".SaleInvLineNo;
                    InvoiceNo := "Posted Whse. Receipt Line".SalesInvNo;
                    PostSalesInvHdr.RESET;
                    PostSalesInvHdr.SETRANGE("No.",InvoiceNo);
                    IF PostSalesInvHdr.FINDFIRST THEN BEGIN
                        CustomerName := PostSalesInvHdr."Bill-to Name";
                        OrderNo := PostSalesInvHdr."Order No.";
                        CurrCode := PostSalesInvHdr."Currency Code";
                        InvoiceDate := PostSalesInvHdr."Posting Date";
                        IF CurrCode = '' THEN
                          CurrCode := 'USD';
                      PostSalesInvLine.RESET;
                      PostSalesInvLine.SETRANGE("Document No.",InvoiceNo);
                      PostSalesInvLine.SETRANGE("No.",InvItemNo);
                      PostSalesInvLine.SETRANGE("Line No.",InvLineNo);
                      IF PostSalesInvLine.FINDFIRST THEN BEGIN
                        Countersale := PostSalesInvLine."Document No.1";
                        IF Countersale <> '' THEN
                        BEGIN
                          Topic := 'CASH SALES';
                          PostSalesShptLine.RESET;
                          PostSalesShptLine.SETRANGE("Document No.1",Countersale);
                          PostSalesShptLine.SETRANGE("No.","Posted Whse. Receipt Line"."Item No.");
                          IF PostSalesShptLine.FINDFIRST THEN
                          ItemShipentry := PostSalesShptLine."Item Shpt. Entry No.";
                        END
                        ELSE
                        BEGIN
                          ItemShipentry := "Posted Whse. Receipt Line".ApplyFromItemEntry;
                          Topic := 'SALES RETURN';
                        END;
                        END;

                      ILE.RESET;
                      ILE.SETRANGE("Entry No.",ItemShipentry);
                      IF ILE.FINDFIRST THEN
                      soldQty := ABS(ILE."Invoiced Quantity");
                    END
                    ELSE
                    BEGIN
                    PostSalesShptHdr1.RESET;
                    PostSalesShptHdr1.SETRANGE("No.",InvoiceNo);
                    IF PostSalesShptHdr1.FINDFIRST THEN BEGIN
                        CustomerName := PostSalesShptHdr1."Bill-to Name";
                        OrderNo := PostSalesShptHdr1."Order No.";
                        CurrCode := PostSalesShptHdr1."Currency Code";
                        InvoiceDate := PostSalesShptHdr1."Posting Date";
                        IF CurrCode = '' THEN
                          CurrCode := 'USD';
                    END;
                      InvItemNo := "Posted Whse. Receipt Line"."Item No.";
                      InvLineNo := "Posted Whse. Receipt Line".SaleInvLineNo;
                      InvoiceNo := "Posted Whse. Receipt Line".SalesInvNo;
                      PostSalesShptLine1.RESET;
                      PostSalesShptLine1.SETRANGE("Document No.",InvoiceNo);
                      PostSalesShptLine1.SETRANGE("No.",InvItemNo);
                      PostSalesShptLine1.SETRANGE("Line No.",InvLineNo);
                      IF PostSalesShptLine1.FINDFIRST THEN BEGIN
                        ItemShipentry := "Posted Whse. Receipt Line".ApplyFromItemEntry;
                        Topic := 'SALES RETURN';
                      END;
                      ILE.RESET;
                      ILE.SETRANGE("Entry No.",ItemShipentry);
                      IF ILE.FINDFIRST THEN
                      soldQty := ABS(ILE.Quantity);
                    END;
                    Item.RESET;
                    Item.SETRANGE("No.","Posted Whse. Receipt Line"."Item No.");
                    IF Item.FINDFIRST THEN
                      ITCName := Item."Item Category Code";

                    ITC.RESET;
                    ITC.SETRANGE(Code,ITCName);
                    IF ITC.FINDFIRST THEN
                      ITCDesc := ITC.Description;
                end;

                trigger OnPreDataItem()
                begin
                    CheckDec := 0;
                    SerialNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Location.RESET;
                Location.SETRANGE(Code,"Posted Whse. Receipt Header"."Location Code");
                IF Location.FINDFIRST THEN
                  LocationName := Location.Name;
                  Address := Location.Address;
                  Address1 := Location."Address 2";
                  City := Location.City;
                  PostCode := Location."Post Code";
                  CountryRegCode := Location."Country/Region Code";
                  Phone := Location."Phone No.";
                  Fax := Location."Fax No.";
                  County := Location.County;
            end;

            trigger OnPreDataItem()
            begin
                User.RESET;
                User.SETRANGE("User Security ID",USERSECURITYID);
                IF User.FINDFIRST THEN
                  UserName := User."Full Name";
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
        SerialNo: Integer;
        Item: Record "27";
        UnitCost: Decimal;
        TotalCost: Decimal;
        Quantity: Integer;
        Desc: Text[50];
        Curr: Code[20];
        PosWhseRcptHdr: Record "7318";
        PosWhseRcptLine: Record "7319";
        ItemCategoryCode: Code[10];
        InvoiceAmt: Decimal;
        RcptAmt: Decimal;
        TotalCostInv: Decimal;
        TotalAmtDis: Decimal;
        ShortageAmt: Decimal;
        ExcessAmt: Decimal;
        PstPurchInv: Record "122";
        TotalCostDis: Decimal;
        PosRetRcptLne: Record "6661";
        PosRetRcptHdr: Record "6660";
        DescRcptLine: Text[50];
        SalesInv: Code[20];
        PostSalesInvHdr: Record "112";
        PostSalesInvLine: Record "113";
        CustomerName: Text[50];
        OrderNo: Code[20];
        soldQty: Decimal;
        InvoiceNo: Code[20];
        InvoiceDate: Date;
        CurrCode: Code[10];
        TotalAmount: Decimal;
        ILE: Record "32";
        Topic: Text[100];
        PstSaleInvceLne: Record "113";
        CheckDec: Decimal;
        PostSalesShptHdr: Record "110";
        PostSalesShptLine: Record "111";
        Countersale: Code[20];
        ItemShipentry: Integer;
        SalesLine: Record "37";
        InvItemNo: Code[20];
        InvLineNo: Integer;
        PostSalesShptHdr1: Record "110";
        PostSalesShptLine1: Record "111";
        User: Record "2000000120";
        UserName: Code[50];
        Location: Record "14";
        Address: Text[50];
        Address1: Text[50];
        City: Text[30];
        PostCode: Code[20];
        Phone: Text[30];
        Fax: Text[30];
        CountryRegCode: Code[10];
        County: Text[30];
        ITC: Record "5722";
        ITCName: Text[30];
        ITCDesc: Text[20];
        LocationName: Text[50];
        PartNo: Code[20];
        CompareChr1: Text;
        CompareChr2: Text;
}

