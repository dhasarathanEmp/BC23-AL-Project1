report 50094 "GRN Whse Rcpt2"
{
    // CodeUnit 5750,5760
    DefaultLayout = RDLC;
    RDLCLayout = './GRN Whse Rcpt2.rdlc';


    dataset
    {
        dataitem("Posted Whse. Receipt Header";"Posted Whse. Receipt Header")
        {
            RequestFilterFields = "No.";
            column(PostingDate;"Posted Whse. Receipt Header"."Posting Date")
            {
            }
            column(GRN;"Posted Whse. Receipt Header"."No.")
            {
            }
            column(DiscrepancyNo;"Posted Whse. Receipt Header"."Discrepancy No")
            {
            }
            column(Index;Index)
            {
            }
            column(Qty4;Qty4)
            {
            }
            column(Qty3;Qty3)
            {
            }
            column(VendorInvoiceNo;"Posted Whse. Receipt Header"."Vendor Invoice Number")
            {
            }
            dataitem("Posted Whse. Receipt Line";"Posted Whse. Receipt Line")
            {
                DataItemLink = "No."=FIELD("No.");
                column(No;"Posted Whse. Receipt Line"."No.")
                {
                }
                column(Item;"Posted Whse. Receipt Line"."Item No.")
                {
                }
                column(Description;"Posted Whse. Receipt Line".Description)
                {
                }
                column(PurchaseOrder;"Posted Whse. Receipt Line"."Source No.")
                {
                }
                column(PostingLineDate;"Posted Whse. Receipt Line"."Posting Date")
                {
                }
                column(Quantity;"Posted Whse. Receipt Line".Quantity)
                {
                }
                column(Quantity2;Quantity1)
                {
                }
                column(serial;SerialNo)
                {
                }
                column(BinCode;"Posted Whse. Receipt Line"."Bin Code")
                {
                }
                column(VendorInvoice;"Posted Whse. Receipt Line"."Vendor Invoice Qty")
                {
                }
                column(VendorQtyHdr;VendorQtyHdr)
                {
                }
                column(UnitCost;UnitCost)
                {
                }
                column(Amount;TotalCost)
                {
                }
                column(VendorInvoiceQty;"Posted Whse. Receipt Line"."Vendor Invoice Qty")
                {
                }
                column(ItemNo1;ItemNo1)
                {
                }
                column(Desc1;Desc1)
                {
                }
                column(Quantity1;Qty1)
                {
                }
                column(VenQty1;VenQty1)
                {
                }
                column(SourceNo1;SourceNo1)
                {
                }
                column(Excess;Excess)
                {
                }
                column(Shortage;Shortage)
                {
                }
                column(TotalShortage;TotalShortage)
                {
                }
                column(TotalExcess;TotalExcess)
                {
                }
                column(ItemCatCode;ItemCategoryCode)
                {
                }
                column(RcptAmt;RcptAmt)
                {
                }
                column(InvAmt;InvoiceAmt)
                {
                }
                column(ExcessAmt;ExcessAmt)
                {
                }
                column(ShortageAmt;ShortageAmt)
                {
                }
                column(DisAmt;TotalAmtDis)
                {
                }
                column(VendorInvoiceDate;"Posted Whse. Receipt Header"."Vendor Invoice Date")
                {
                }
                column(TotalCostDis;TotalCostDis)
                {
                }
                column(FinalShortage;FinalShortage)
                {
                }
                column(FinalExcess;FinalExcess)
                {
                }
                column(FS;FS)
                {
                }
                column(CurrCode;CurrCode)
                {
                }
                column(TotRcvdQty;TotRcvdQty)
                {
                }
                column(LineDiscrepancyNo;"Posted Whse. Receipt Line".DiscrepancyNo)
                {
                }
                column(TotalRcpt;TotalRcpt)
                {
                }
                column(VendorNo;VendorNo)
                {
                }
                column(VendName;VendorName)
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
                column(USer;UserName)
                {
                }
                column(Location;LocationName)
                {
                }
                column(ITC;ITCDesc)
                {
                }
                dataitem("Company Information";"Company Information")
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
                    Item.RESET;
                    Item.SETRANGE("No.","Posted Whse. Receipt Line"."Item No.");
                    if Item.FINDFIRST then
                      ItemCategoryCode := Item."Item Category Code";
                    
                    ITC.RESET;
                    ITC.SETRANGE(Code,ItemCategoryCode);
                    if ITC.FINDFIRST then
                      ITCDesc := ITC.Description;
                    
                    TotalCost := 0;
                    UnitCost := 0;
                    SerialNo += 1;
                    //Item.RESET;
                    //Item.SETRANGE("No.","Posted Whse. Receipt Line"."Item No.");
                    //IF Item.FINDFIRST THEN
                    UnitCost := "Posted Whse. Receipt Line"."Unit Price";
                    Quantity1 := "Posted Whse. Receipt Line".Quantity+"Posted Whse. Receipt Line".Excess;
                    TotalCost := UnitCost * Quantity1;
                    RcptAmt += TotalCost;
                    
                    TotInQty += "Posted Whse. Receipt Line"."Vendor Invoice Qty";
                    TotQty += ("Posted Whse. Receipt Line".Quantity+"Posted Whse. Receipt Line".Excess);
                    
                    TotalCostInv := UnitCost * "Posted Whse. Receipt Line"."Vendor Invoice Qty";
                    InvoiceAmt += TotalCostInv;
                    ExcessAmt:="Posted Whse. Receipt Line".Excess*UnitCost;
                    ShortageAmt:=("Posted Whse. Receipt Line"."Vendor Invoice Qty"-"Posted Whse. Receipt Line".Quantity)*UnitCost;
                    FinalExcess+=ExcessAmt;
                    FinalShortage+=ShortageAmt;
                    /*//TotRcvdQty := TotalRcvd("Posted Whse. Receipt Line"."Item No.","Posted Whse. Receipt Line"."Source Line No.","Posted Whse. Receipt Line"."Source No.");
                    
                    IF "Posted Whse. Receipt Line"."Vendor Invoice Qty" > "Posted Whse. Receipt Line".Quantity THEN BEGIN
                    ShortageAmt := 0;
                    Shortage := 0;
                    TotRcvdQty := 0;
                    TotalRcpt := 0;
                    TotRcvdQty := TotalRcvd("Posted Whse. Receipt Line"."Item No.","Posted Whse. Receipt Line"."Source Line No.","Posted Whse. Receipt Line"."Source No.");
                    Shortage :=  ("Posted Whse. Receipt Line"."Vendor Invoice Qty") - ("Posted Whse. Receipt Line".Quantity)-TotRcvdQty;
                    IF Shortage < 0 THEN
                      TotalExcess += ABS(Shortage)
                    ELSE
                      TotalShortage += Shortage;
                    
                    TotalRcpt := TotRcvdQty + "Posted Whse. Receipt Line".Quantity;
                    //Dis Amt Calc
                    ShortageAmt := ABS(Shortage) * UnitCost;
                    FinalShortage += ShortageAmt;
                    ExcessAmt := 0;
                    Excess := 0;
                    END
                    ELSE
                    ShortageAmt := 0;
                    
                    IF "Posted Whse. Receipt Line"."Vendor Invoice Qty" < "Posted Whse. Receipt Line".Quantity THEN BEGIN
                    Excess := 0;
                    TotRcvdQty := 0;
                    TotalRcpt := 0;
                    ExcessAmt := 0;
                    TotRcvdQty := TotalRcvd("Posted Whse. Receipt Line"."Item No.","Posted Whse. Receipt Line"."Source Line No.","Posted Whse. Receipt Line"."Source No.");
                    Excess :=  ("Posted Whse. Receipt Line".Quantity) - ("Posted Whse. Receipt Line"."Vendor Invoice Qty")-TotRcvdQty;
                    TotalExcess += Excess;
                    TotalRcpt := TotRcvdQty + "Posted Whse. Receipt Line".Quantity;
                    //Dis Amt Calc
                    ExcessAmt := Excess * UnitCost;
                    FinalExcess += ExcessAmt;
                    Shortage := 0;
                    ShortageAmt := 0;
                    END
                    ELSE
                    ExcessAmt := 0;
                    
                    VendorNo := '';
                    //ItemCategoryCode := '';
                    VendorName := '';
                    Po.RESET;
                    //Po.GET(Po."Document Type"::Order,"Posted Whse. Receipt Line"."Source No.");
                    Po.SETFILTER("Document Type",'=%1',Po."Document Type"::Order);
                    Po.SETRANGE("No.","Posted Whse. Receipt Line"."Source No.");
                    IF Po.FINDFIRST THEN
                      IF Po."No." <> '' THEN
                        IF Po."No." = "Posted Whse. Receipt Line"."Source No." THEN BEGIN
                          VendorNo := Po."Buy-from Vendor No.";
                          Vendor.RESET;
                          Vendor.GET(VendorNo);
                        // ItemCategoryCode := Vendor."Agency Code";
                          VendorName := Vendor.Name;
                          CurrCode := Po."Currency Code";
                          IF CurrCode = '' THEN
                            CurrCode := 'USD';
                        END;
                    PstPurchInv.RESET;
                    PstPurchInv.SETRANGE("Order No.","Posted Whse. Receipt Line"."Source No.");
                    IF PstPurchInv.FINDFIRST THEN
                      IF PstPurchInv."No." <> '' THEN
                        IF PstPurchInv."Order No." = "Posted Whse. Receipt Line"."Source No." THEN BEGIN
                         VendorNo := PstPurchInv."Buy-from Vendor No.";
                         Vendor.RESET;
                         Vendor.GET(VendorNo);
                          //ItemCategoryCode := Vendor."Item Category Code";
                          VendorName := Vendor.Name;
                          CurrCode := Vendor."Currency Code";
                           IF CurrCode = '' THEN
                            CurrCode := 'USD';
                        END;
                    
                    PstPurchInv.RESET;
                    PstPurchInv.SETRANGE("Prepayment Order No.","Posted Whse. Receipt Line"."Source No.");
                    IF PstPurchInv.FINDFIRST THEN
                        VendorQtyHdr := 'Invoiced Qty'
                      ELSE
                        VendorQtyHdr := 'Order Qty';
                    
                    IF "Posted Whse. Receipt Line"."Vendor Invoice Qty" <> "Posted Whse. Receipt Line".Quantity THEN BEGIN
                      unitcost1 := Item."YER Unit Cost";
                    TotalCostDis := UnitCost;
                    TotalAmtDis += TotalCost;
                    END;
                    {
                    Inc := 0;
                    IF (TotalExcess = 0) AND (TotalShortage = 0) AND ("Posted Whse. Receipt Line"."Vendor Invoice Qty" = "Posted Whse. Receipt Line".Quantity) THEN
                      "Posted Whse. Receipt Line".DiscrepancyNo := '';
                     }
                    */

                end;

                trigger OnPreDataItem()
                begin

                    SerialNo := 0;
                    CLEAR(TotInQty);
                    CLEAR(TotQty);
                    CLEAR(InvoiceAmt);
                    CLEAR(RcptAmt);
                    CLEAR(FinalExcess);
                    CLEAR(FinalShortage);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                
                /*IF "Posted Whse. Receipt Header"."Discrepancy No" <> '' THEN
                  Index := 'DISCREPANCY REPORT'
                ELSE
                  Index := 'THERE ARE NO DISCREPANCY';*/
                
                Location.RESET;
                Location.SETRANGE(Code,"Posted Whse. Receipt Header"."Location Code");
                if Location.FINDFIRST then
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
                if User.FINDFIRST then
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

    trigger OnPreReport()
    begin
        TotalShortage :=0;
        TotalExcess := 0;
    end;

    var
        SerialNo: Integer;
        Item: Record Item;
        UnitCost: Decimal;
        TotalCost: Decimal;
        Qty: Integer;
        TotalValueship: Decimal;
        Quantity1: Integer;
        ItemNo1: Code[20];
        Qty1: Integer;
        Desc: Text[50];
        Amount: Decimal;
        CurrCode: Code[20];
        TotalValue1: Decimal;
        PosWhseRcptLine: Record "Posted Whse. Receipt Line";
        No1: Code[20];
        SerialNo1: Code[20];
        Desc1: Text[50];
        VenQty1: Integer;
        SourceNo1: Code[20];
        Excess: Decimal;
        Shortage: Decimal;
        TotalShortage: Decimal;
        TotalExcess: Decimal;
        InvAmount: Decimal;
        RcptAmount: Decimal;
        Po: Record "Purchase Header";
        Vendor: Record Vendor;
        VendorNo: Code[20];
        ItemCategoryCode: Code[10];
        VendorName: Text[50];
        InvoiceAmt: Decimal;
        RcptAmt: Decimal;
        TotalCostInv: Decimal;
        TotalAmtDis: Decimal;
        ShortageAmt: Decimal;
        ExcessAmt: Decimal;
        PstPurchInv: Record "Purch. Inv. Header";
        TotalCostDis: Decimal;
        unitcost1: Decimal;
        FinalShortage: Decimal;
        FinalExcess: Decimal;
        Fe: Decimal;
        FS: Decimal;
        Index: Text[50];
        TotQty: Decimal;
        TotInQty: Integer;
        Qty3: Decimal;
        Qty4: Decimal;
        VendorQtyHdr: Text[50];
        TotRcvdQty: Integer;
        TotalRcpt: Decimal;
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
        LocationName: Text[20];
        ITC: Record "Item Category";
        ITCName: Text[30];
        ITCDesc: Text[20];

    local procedure TotalRcvd(Item: Code[20];SerialLineNo: Integer;SourceNo: Code[20]) TotRcvd: Decimal
    begin
        PosWhseRcptLine.RESET;
        PosWhseRcptLine.RESET;
        PosWhseRcptLine.SETRANGE("Item No.",Item);
        PosWhseRcptLine.SETRANGE("Source Line No.",SerialLineNo);
        PosWhseRcptLine.SETRANGE("Source No.",SourceNo);
        PosWhseRcptLine.SETFILTER("No.",'<>%1',"Posted Whse. Receipt Line"."No.");
        PosWhseRcptLine.SETFILTER("No.",'<%1',"Posted Whse. Receipt Line"."No.");
        TotRcvd:=0;
        if PosWhseRcptLine.FINDSET then repeat
          TotRcvd += PosWhseRcptLine.Quantity;
        until PosWhseRcptLine.NEXT = 0;
    end;
}

