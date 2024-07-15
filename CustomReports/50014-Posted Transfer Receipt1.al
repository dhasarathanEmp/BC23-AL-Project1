report 50014 "Posted Transfer Receipt1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Posted Transfer Receipt1.rdlc';
    Caption = 'Posted Transfer Receipt';

    dataset
    {
        dataitem(DataItem1;Table5746)
        {
            DataItemTableView = SORTING(No.)
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(DiscrepancyNo_TransferReceiptHeader;"Transfer Receipt Header"."Discrepancy No")
            {
            }
            column(ShippingAgentCode_TransferReceiptHeader;"Transfer Receipt Header"."Shipping Agent Code")
            {
            }
            column(TransferfromContact_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-from Contact")
            {
            }
            column(TransfertoContact_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-to Contact")
            {
            }
            column(No_TransferReceiptHeader;"Transfer Receipt Header"."No.")
            {
            }
            column(TransferfromCode_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-from Code")
            {
            }
            column(TransferfromName_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-from Name")
            {
            }
            column(TransferfromName2_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-from Name 2")
            {
            }
            column(TransferfromAddress_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-from Address")
            {
            }
            column(TransferfromAddress2_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-from Address 2")
            {
            }
            column(TransferfromPostCode_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-from Post Code")
            {
            }
            column(TransferfromCity_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-from City")
            {
            }
            column(TransferfromCounty_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-from County")
            {
            }
            column(TransfertoFaxNo_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-to Fax No")
            {
            }
            column(TransferFromFaxNo_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-From Fax No")
            {
            }
            column(TrsffromCountryRegionCode_TransferReceiptHeader;"Transfer Receipt Header"."Trsf.-from Country/Region Code")
            {
            }
            column(TransfertoCode_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-to Code")
            {
            }
            column(TransfertoName_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-to Name")
            {
            }
            column(TransfertoName2_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-to Name 2")
            {
            }
            column(TransfertoAddress_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-to Address")
            {
            }
            column(TransfertoAddress2_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-to Address 2")
            {
            }
            column(TransfertoPostCode_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-to Post Code")
            {
            }
            column(TransfertoCity_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-to City")
            {
            }
            column(TransfertoCounty_TransferReceiptHeader;"Transfer Receipt Header"."Transfer-to County")
            {
            }
            column(TrsftoCountryRegionCode_TransferReceiptHeader;"Transfer Receipt Header"."Trsf.-to Country/Region Code")
            {
            }
            column(TransferOrderDate_TransferReceiptHeader;"Transfer Receipt Header"."Transfer Order Date")
            {
            }
            column(PostingDate_TransferReceiptHeader;"Transfer Receipt Header"."Posting Date")
            {
            }
            column(ShortcutDimension1Code_TransferReceiptHeader;"Transfer Receipt Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_TransferReceiptHeader;"Transfer Receipt Header"."Shortcut Dimension 2 Code")
            {
            }
            column(TransferOrderNo_TransferReceiptHeader;"Transfer Receipt Header"."Transfer Order No.")
            {
            }
            column(ShipmentDate_TransferReceiptHeader;"Transfer Receipt Header"."Shipment Date")
            {
            }
            column(ReceiptDate_TransferReceiptHeader;"Transfer Receipt Header"."Receipt Date")
            {
            }
            column(InTransitCode_TransferReceiptHeader;"Transfer Receipt Header"."In-Transit Code")
            {
            }
            column(DiscrepancyReportNo;DiscrepancyReportNo)
            {
            }
            column(DisplayInfo;DisplayInfo)
            {
            }
            column(ToPhoneno;ToPhoneno)
            {
            }
            column(ToFaxno;ToFaxno)
            {
            }
            column(ToCounty;ToCounty)
            {
            }
            column(UserName;UserName)
            {
            }
            column(CompanyInformationPicture;CompanyInformation.Picture)
            {
            }
            column(TRNO;TRNO)
            {
            }
            column(PTSQTY;PTSQty)
            {
            }
            column(PTSQty1;PTSQty1)
            {
            }
            column(TotalShipAmount;TotalShipAmount)
            {
            }
            column(DamageQty;DamageQty)
            {
            }
            dataitem(DataItem23;Table5747)
            {
                DataItemLink = Transfer Order No.=FIELD(Transfer Order No.);
                DataItemTableView = SORTING(Document No.,Line No.);
                column(QuantityBase_TransferReceiptLine;"Transfer Receipt Line"."Quantity (Base)")
                {
                }
                column(QtyperUnitofMeasure_TransferReceiptLine;"Transfer Receipt Line"."Qty. per Unit of Measure")
                {
                }
                column(UnitofMeasureCode_TransferReceiptLine;"Transfer Receipt Line"."Unit of Measure Code")
                {
                }
                column(GrossWeight_TransferReceiptLine;"Transfer Receipt Line"."Gross Weight")
                {
                }
                column(NetWeight_TransferReceiptLine;"Transfer Receipt Line"."Net Weight")
                {
                }
                column(UnitVolume_TransferReceiptLine;"Transfer Receipt Line"."Unit Volume")
                {
                }
                column(VariantCode_TransferReceiptLine;"Transfer Receipt Line"."Variant Code")
                {
                }
                column(UnitsperParcel_TransferReceiptLine;"Transfer Receipt Line"."Units per Parcel")
                {
                }
                column(Description2_TransferReceiptLine;"Transfer Receipt Line"."Description 2")
                {
                }
                column(TransferOrderNo_TransferReceiptLine;"Transfer Receipt Line"."Transfer Order No.")
                {
                }
                column(ReceiptDate_TransferReceiptLine;"Transfer Receipt Line"."Receipt Date")
                {
                }
                column(ShippingAgentCode_TransferReceiptLine;"Transfer Receipt Line"."Shipping Agent Code")
                {
                }
                column(ShippingAgentServiceCode_TransferReceiptLine;"Transfer Receipt Line"."Shipping Agent Service Code")
                {
                }
                column(InTransitCode_TransferReceiptLine;"Transfer Receipt Line"."In-Transit Code")
                {
                }
                column(TransferfromCode_TransferReceiptLine;"Transfer Receipt Line"."Transfer-from Code")
                {
                }
                column(TransfertoCode_TransferReceiptLine;"Transfer Receipt Line"."Transfer-to Code")
                {
                }
                column(ItemRcptEntryNo_TransferReceiptLine;"Transfer Receipt Line"."Item Rcpt. Entry No.")
                {
                }
                column(ShippingTime_TransferReceiptLine;"Transfer Receipt Line"."Shipping Time")
                {
                }
                column(DimensionSetID_TransferReceiptLine;"Transfer Receipt Line"."Dimension Set ID")
                {
                }
                column(ItemCategoryCode_TransferReceiptLine;"Transfer Receipt Line"."Item Category Code")
                {
                }
                column(ProductGroupCode_TransferReceiptLine;"Transfer Receipt Line"."Product Group Code")
                {
                }
                column(TransferToBinCode_TransferReceiptLine;"Transfer Receipt Line"."Transfer-To Bin Code")
                {
                }
                column(DocumentNo_TransferReceiptLine;"Transfer Receipt Line"."Document No.")
                {
                }
                column(LineNo_TransferReceiptLine;"Transfer Receipt Line"."Line No.")
                {
                }
                column(ItemNo_TransferReceiptLine;"Transfer Receipt Line"."Item No.")
                {
                }
                column(Quantity_TransferReceiptLine;"Transfer Receipt Line".Quantity)
                {
                }
                column(UnitofMeasure_TransferReceiptLine;"Transfer Receipt Line"."Unit of Measure")
                {
                }
                column(Description_TransferReceiptLine;"Transfer Receipt Line".Description)
                {
                }
                column(OrderedPartNo_TransferReceiptLine;"Transfer Receipt Line"."Ordered Part No.")
                {
                }
                column(SerialNo;SerialNo)
                {
                }
                column(UnitCost;UnitCost)
                {
                }
                column(TotalValuerec;TotalValue)
                {
                }
                column(Qtyship;Qty)
                {
                }
                column(TotalValueship;TotalValueship)
                {
                }
                column(Quantity1;Quantity1)
                {
                }
                column(ItemNo1;ItemNo1)
                {
                }
                column(SerialNo1;SerialNo1)
                {
                }
                column(Quantity2;Quantity2)
                {
                }
                column(Desc;Desc)
                {
                }
                column(Amount;Amount)
                {
                }
                column(OriginalTransferOrderQty_TransferReceiptLine;"Transfer Receipt Line"."Original Transfer Order Qty.")
                {
                }
                column(Curr;Curr)
                {
                }
                column(TotalValue1;TotalValue1)
                {
                }
                column(Cost;Cost)
                {
                }
                column(Amount1;Amount1)
                {
                }
                column(Warehouseshipment;WhseNo)
                {
                }
                column(Agency;Agency)
                {
                }
                column(Excess_TransferReceiptLine;"Transfer Receipt Line".Excess)
                {
                }
                column(Bincode;BINCODE)
                {
                }
                dataitem(DataItem77;Table79)
                {
                    column(Name_CompanyInformation;"Company Information".Name)
                    {
                    }
                    column(VATRegistrationNo_CompanyInformation;"Company Information"."VAT Registration No.")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    SerialNo  +=  1;
                    CLEAR(UnitCost);
                    CLEAR(Curr);
                    Item.RESET;
                    Item.SETRANGE("No.","Transfer Receipt Line"."Item No.");
                    IF Item.FINDFIRST THEN BEGIN
                      UnitCost1  :=  Item."Standard Cost";
                      DefaultPriceFactor.RESET;
                      IF DefaultPriceFactor.GET(Item."Global Dimension 1 Code") THEN
                        UnitCost :="Transfer Receipt Line"."Quantity (Base)" * (Item."Unit Price"-Item."Dealer Net - Core Deposit"*Item."Inventory Factor")*DefaultPriceFactor."Default Price Factor" + Item."Dealer Net - Core Deposit"*Item."Inventory Factor";
                    END;
                    CLEAR(Quantity1);
                    CLEAR(Amount1);
                    IF "Transfer Receipt Line".Remarks = "Transfer Receipt Line".Remarks::"None " THEN BEGIN
                         TotalValue  := UnitCost * "Transfer Receipt Line".Quantity;
                         TotalValue1 += ROUND((TotalValue),0.01);
                         Quantity1 := "Transfer Receipt Line".Quantity;
                         Quantity2 += "Transfer Receipt Line".Quantity;
                         Amount1 := UnitCost  * "Transfer Receipt Line".Quantity;
                         BINCODE := "Transfer Receipt Line"."Transfer-To Bin Code";
                    END;
                    IF "Transfer Receipt Line".Remarks <> "Transfer Receipt Line".Remarks::"None " THEN
                      DamageQty += "Transfer Receipt Line"."Quantity (Base)";
                    //
                    TRQty:=0;
                    TransferShipmentLine.RESET;
                    TransferShipmentLine.SETRANGE("Transfer Order No.","Transfer Receipt Line"."Transfer Order No.");
                    TransferShipmentLine.SETRANGE("Item No.","Transfer Receipt Line"."Item No.");
                    //TransferShipmentLine.SETRANGE("Line No.","Transfer Receipt Line"."Line No.");
                    IF TransferShipmentLine.FINDSET THEN REPEAT
                      TRQty += TransferShipmentLine.Quantity;
                    UNTIL TransferShipmentLine.NEXT=0;
                    //
                    TotalValueship  += UnitCost * TRQty;
                    Qty :=TRQty;
                    Qty4 += "Transfer Receipt Line".Quantity;

                     DimensionValue.RESET;
                     DimensionValue.SETRANGE(Code,"Transfer Receipt Line"."Item Category Code");
                     IF DimensionValue.FINDFIRST THEN
                       Agency := DimensionValue.Name;

                     PostedWhseShipmentLine.RESET;
                     PostedWhseShipmentLine.SETRANGE("Source No.","Transfer Receipt Line"."Transfer Order No.");
                     IF PostedWhseShipmentLine.FINDFIRST THEN
                       WhseNo := PostedWhseShipmentLine."Whse. Shipment No.";
                end;

                trigger OnPreDataItem()
                begin
                    SerialNo  :=  0;
                    TotalValueship:=0;
                    Quantity1 :=0;
                    Quantity2 := 0;
                    TotalValue1 :=0;
                    Amount1:=0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);
                Location.RESET;
                Location.SETRANGE(Code,"Transfer Receipt Header"."Transfer-to Code");
                IF Location.FINDFIRST THEN BEGIN
                  ToCounty := Location.County;
                  ToPhoneno := Location."Phone No.";
                  ToFaxno := Location."Fax No.";
                  TRNO := Location."T.R.No";
                END;
                //
                User.RESET;
                User.SETRANGE("User Name",USERID);
                IF User.FINDFIRST THEN
                  UserName := User."Full Name";
                //
                CLEAR(PTSQty);
                CLEAR(TotalShipAmount);
                TransferShipmentLine.RESET;
                TransferShipmentLine.SETRANGE("Transfer Order No.","Transfer Receipt Header"."Transfer Order No.");
                IF TransferShipmentLine.FINDSET THEN REPEAT
                  Item.RESET;
                Item.SETRANGE("No.",TransferShipmentLine."Item No.");
                IF Item.FINDFIRST THEN
                  DefaultPriceFactor.RESET;
                  IF DefaultPriceFactor.GET(Item."Global Dimension 1 Code") THEN
                    UnitCost :=TransferShipmentLine."Quantity (Base)" * (Item."Unit Price"-Item."Dealer Net - Core Deposit"*Item."Inventory Factor")*DefaultPriceFactor."Default Price Factor" + Item."Dealer Net - Core Deposit"*Item."Inventory Factor";
                    PTSQty1 := TransferShipmentLine."ShippedQty.";
                    PTSQty += TransferShipmentLine.Quantity;
                    TotalShipAmount += UnitCost * TransferShipmentLine.Quantity;
                UNTIL TransferShipmentLine.NEXT = 0;
                //
                /*TransferReceiptLine.RESET;
                TransferReceiptLine.SETRANGE("Transfer Order No.","Transfer Receipt Header"."Transfer Order No.");
                IF TransferReceiptLine.FINDSET THEN REPEAT
                  IF (TransferReceiptLine.Remarks = TransferReceiptLine.Remarks::Damage) OR (TransferReceiptLine.Remarks = TransferReceiptLine.Remarks::Missing) THEN
                    DamageQty += TransferReceiptLine.Quantity;
                UNTIL TransferReceiptLine.NEXT = 0;*/

            end;

            trigger OnPreDataItem()
            begin
                PTSQty := 0;
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
        TotalValue: Decimal;
        TransferShipmentLine: Record "5745";
        Qty: Decimal;
        TotalValueship: Decimal;
        TransferReceiptLine: Record "5747";
        Quantity1: Decimal;
        Quantity2: Decimal;
        TransferReceiptLine1: Record "5747";
        ItemNo1: Code[20];
        Qty1: Decimal;
        Qty2: Decimal;
        Qty3: Decimal;
        Qty4: Decimal;
        SerialNo1: Integer;
        Desc: Text[50];
        Amount: Decimal;
        Curr: Code[20];
        TotalValue1: Decimal;
        DiscrepancyReportNo: Code[20];
        InventorySetup: Record "313";
        NoSeriesMgt: Codeunit "396";
        Cost: Decimal;
        Qty5: Decimal;
        Qty6: Decimal;
        Qty7: Decimal;
        Amount1: Decimal;
        Qty8: Integer;
        Qty9: Decimal;
        DisplayInfo: Text;
        Agency: Code[20];
        TRQty: Decimal;
        ToPhoneno: Text[30];
        ToFaxno: Text[30];
        Location: Record "14";
        ToCounty: Text;
        User: Record "2000000120";
        UserName: Text;
        UnitCost1: Decimal;
        UnitCost: Decimal;
        CurrExchRate: Record "330";
        "Currency Code": Code[20];
        "Currency Factor": Decimal;
        DimensionValue: Record "349";
        PostedWhseShipmentLine: Record "7323";
        WhseNo: Code[20];
        CompanyInformation: Record "79";
        TRNO: Text;
        PTSQty: Decimal;
        TotalShipAmount: Decimal;
        DamageQty: Decimal;
        BINCODE: Code[20];
        DefaultPriceFactor: Record "60036";
        PTSQty1: Decimal;
}

