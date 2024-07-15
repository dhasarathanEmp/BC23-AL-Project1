report 50072 "Discrepancy Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Discrepancy Report.rdlc';

    dataset
    {
        dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
        {
            RequestFilterFields = "No.";
            column(DiscrepancyNo_TransferReceiptHeader; "Discrepancy No")
            {
            }
            column(ShippingAgentCode_TransferReceiptHeader; "Shipping Agent Code")
            {
            }
            column(TransferfromContact_TransferReceiptHeader; "Transfer-from Contact")
            {
            }
            column(TransfertoContact_TransferReceiptHeader; "Transfer-to Contact")
            {
            }
            column(No_TransferReceiptHeader; "No.")
            {
            }
            column(TransferfromCode_TransferReceiptHeader; "Transfer-from Code")
            {
            }
            column(TransferfromName_TransferReceiptHeader; "Transfer-from Name")
            {
            }
            column(TransferfromName2_TransferReceiptHeader; "Transfer-from Name 2")
            {
            }
            column(TransferfromAddress_TransferReceiptHeader; "Transfer-from Address")
            {
            }
            column(TransferfromAddress2_TransferReceiptHeader; "Transfer-from Address 2")
            {
            }
            column(TransferfromPostCode_TransferReceiptHeader; "Transfer-from Post Code")
            {
            }
            column(TransferfromCity_TransferReceiptHeader; "Transfer-from City")
            {
            }
            column(TransferfromCounty_TransferReceiptHeader; "Transfer-from County")
            {
            }
            column(TransfertoFaxNo_TransferReceiptHeaders; "Transfer-to Fax No")
            {
            }
            column(TransferFromFaxNo_TransferReceiptHeader; "Transfer-From Fax No")
            {
            }
            column(TrsffromCountryRegionCode_TransferReceiptHeader; "Trsf.-from Country/Region Code")
            {
            }
            column(TransfertoCode_TransferReceiptHeader; "Transfer-to Code")
            {
            }
            column(TransfertoName_TransferReceiptHeader; "Transfer-to Name")
            {
            }
            column(TransfertoName2_TransferReceiptHeader; "Transfer-to Name 2")
            {
            }
            column(TransfertoAddress_TransferReceiptHeader; "Transfer-to Address")
            {
            }
            column(TransfertoAddress2_TransferReceiptHeader; "Transfer-to Address 2")
            {
            }
            column(TransfertoPostCode_TransferReceiptHeader; "Transfer-to Post Code")
            {
            }
            column(TransfertoCity_TransferReceiptHeader; "Transfer-to City")
            {
            }
            column(TransfertoCounty_TransferReceiptHeader; "Transfer-to County")
            {
            }
            column(TrsftoCountryRegionCode_TransferReceiptHeader; "Trsf.-to Country/Region Code")
            {
            }
            column(TransferOrderDate_TransferReceiptHeader; "Transfer Order Date")
            {
            }
            column(PostingDate_TransferReceiptHeader; "Posting Date")
            {
            }
            column(ShortcutDimension1Code_TransferReceiptHeader; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_TransferReceiptHeader; "Shortcut Dimension 2 Code")
            {
            }
            column(TransferOrderNo_TransferReceiptHeader; "Transfer Order No.")
            {
            }
            column(ShipmentDate_TransferReceiptHeader; "Shipment Date")
            {
            }
            column(ReceiptDate_TransferReceiptHeader; "Receipt Date")
            {
            }
            column(InTransitCode_TransferReceiptHeader; "In-Transit Code")
            {
            }
            column(DiscrepancyReportNo; DiscrepancyReportNo)
            {
            }
            column(DisplayInfo; DisplayInfo)
            {
            }
            column(ToPhoneno; ToPhoneno)
            {
            }
            column(ToFaxno; ToFaxno)
            {
            }
            column(ToCounty; ToCounty)
            {
            }
            column(UserName; UserName)
            {
            }
            column(CompanyInformationPicture; CompanyInformation.Picture)
            {
            }
            column(TRNO; TRNO)
            {
            }
            column(DiscrepancyQty; DiscrepancyQty)
            {
            }
            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
            {
                DataItemLink = "Transfer Order No." = FIELD("Transfer Order No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                RequestFilterFields = "Document No.";
                column(QuantityBase_TransferReceiptLine; "Quantity (Base)")
                {
                }
                column(QtyperUnitofMeasure_TransferReceiptLine; "Qty. per Unit of Measure")
                {
                }
                column(UnitofMeasureCode_TransferReceiptLine; "Unit of Measure Code")
                {
                }
                column(GrossWeight_TransferReceiptLine; "Gross Weight")
                {
                }
                column(NetWeight_TransferReceiptLine; "Net Weight")
                {
                }
                column(UnitVolume_TransferReceiptLine; "Unit Volume")
                {
                }
                column(VariantCode_TransferReceiptLine; "Variant Code")
                {
                }
                column(UnitsperParcel_TransferReceiptLine; "Units per Parcel")
                {
                }
                column(Description2_TransferReceiptLine; "Description 2")
                {
                }
                column(TransferOrderNo_TransferReceiptLine; "Transfer Order No.")
                {
                }
                column(ReceiptDate_TransferReceiptLine; "Receipt Date")
                {
                }
                column(ShippingAgentCode_TransferReceiptLine; "Shipping Agent Code")
                {
                }
                column(ShippingAgentServiceCode_TransferReceiptLine; "Shipping Agent Service Code")
                {
                }
                column(InTransitCode_TransferReceiptLine; "In-Transit Code")
                {
                }
                column(TransferfromCode_TransferReceiptLine; "Transfer-from Code")
                {
                }
                column(TransfertoCode_TransferReceiptLine; "Transfer-to Code")
                {
                }
                column(ItemRcptEntryNo_TransferReceiptLine; "Item Rcpt. Entry No.")
                {
                }
                column(ShippingTime_TransferReceiptLine; "Shipping Time")
                {
                }
                column(DimensionSetID_TransferReceiptLine; "Dimension Set ID")
                {
                }
                column(ItemCategoryCode_TransferReceiptLine; "Item Category Code")
                {
                }
                column(TransferToBinCode_TransferReceiptLine; "Transfer-To Bin Code")
                {
                }
                column(DocumentNo_TransferReceiptLine; "Document No.")
                {
                }
                column(LineNo_TransferReceiptLine; "Line No.")
                {
                }
                column(ItemNo_TransferReceiptLine; "Item No.")
                {
                }
                column(Quantity_TransferReceiptLine; Quantity)
                {
                }
                column(UnitofMeasure_TransferReceiptLine; "Unit of Measure")
                {
                }
                column(Description_TransferReceiptLine; Description)
                {
                }
                column(OrderedPartNo_TransferReceiptLine; "Ordered Part No.")
                {
                }
                column(SerialNo; SerialNo)
                {
                }
                column(UnitCost; UnitCost)
                {
                }
                column(TotalValuerec; TotalValue)
                {
                }
                column(Qtyship; Qty)
                {
                }
                column(TotalValueship; TotalValueship)
                {
                }
                column(Quantity1; Quantity1)
                {
                }
                column(ItemNo1; ItemNo1)
                {
                }
                column(Qty1; Qty1)
                {
                }
                column(Qty2; Qty2)
                {
                }
                column(Qty3; Qty3)
                {
                }
                column(Qty4; Qty4)
                {
                }
                column(SerialNo1; SerialNo1)
                {
                }
                column(Quantity2; Quantity2)
                {
                }
                column(Desc; Desc)
                {
                }
                column(Amount; Amount)
                {
                }
                column(OriginalTransferOrderQty_TransferReceiptLine; "Original Transfer Order Qty.")
                {
                }
                column(Curr; Curr)
                {
                }
                column(TotalValue1; TotalValue1)
                {
                }
                column(Cost; Cost)
                {
                }
                column(Qty6; Qty6)
                {
                }
                column(Qty5; Qty5)
                {
                }
                column(Qty7; Qty7)
                {
                }
                column(Amount1; Amount1)
                {
                }
                column(Warehouseshipment; WhseNo)
                {
                }
                column(Agency; Agency)
                {
                }
                column(Remarks_TransferReceiptLine; Remarks)
                {
                }
                column(Excess_TransferReceiptLine; Excess)
                {
                }
                column(DamageQty; DamageQty)
                {
                }
                column(MissingQty; MissingQty)
                {
                }
                column(NormalQty; NormalQty)
                {
                }
                dataitem("Company Information"; "Company Information")
                {
                    column(Name_CompanyInformation; "Company Information".Name)
                    {
                    }
                    column(VATRegistrationNo_CompanyInformation; "Company Information"."VAT Registration No.")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if "Transfer Receipt Line".Remarks = "Transfer Receipt Line".Remarks::"None " then begin
                        SerialNo += 1;
                        CLEAR(UnitCost);
                        CLEAR(Curr);
                        Item.RESET;
                        Item.SETRANGE("No.", "Transfer Receipt Line"."Item No.");
                        if Item.FINDFIRST then
                            UnitCost1 := Item."Standard Cost";
                        DefaultPriceFactor.RESET;
                        if DefaultPriceFactor.GET(Item."Global Dimension 1 Code") then
                            UnitCost := "Transfer Receipt Line"."Quantity (Base)" * (Item."Unit Price" - Item."Dealer Net - Core Deposit" * Item."Inventory Factor") * DefaultPriceFactor."Default Price Factor" + Item."Dealer Net - Core Deposit" * Item."Inventory Factor";
                        TRQty := 0;
                        TransferShipmentLine.RESET;
                        TransferShipmentLine.SETRANGE("Transfer Order No.", "Transfer Receipt Line"."Transfer Order No.");
                        TransferShipmentLine.SETRANGE("Item No.", "Transfer Receipt Line"."Item No.");
                        TransferShipmentLine.SETRANGE("Line No.", "Transfer Receipt Line"."Line No.");
                        if TransferShipmentLine.FINDSET then
                            repeat
                                TRQty += TransferShipmentLine.Quantity;
                            until TransferShipmentLine.NEXT = 0;
                        //
                        TotalValueship += UnitCost * TRQty;
                        Qty := TRQty;
                        Qty4 += "Transfer Receipt Line".Quantity;
                        Quantity1 := 0;
                        Quantity2 := 0;
                        Qty3 := 0;
                        Qty1 := 0;
                        ItemNo1 := '';
                        NormalQty := "Transfer Receipt Line".Quantity;
                        ItemNo1 := "Transfer Receipt Line"."Item No.";
                        Quantity1 := TRQty - "Transfer Receipt Line".Quantity;
                        Qty1 := "Transfer Receipt Line".Quantity;
                        Qty3 := TRQty;
                        Qty5 += Quantity1;
                        SerialNo1 := SerialNo;
                        Desc := "Transfer Receipt Line".Description;
                        Amount := Qty1 * UnitCost;
                        Amount1 += ROUND(Amount, 0.01);
                        Cost := ROUND((UnitCost), 0.01);
                        CLEAR(DamageQty);
                        CLEAR(MissingQty);

                    end;

                    if "Transfer Receipt Line".Remarks = "Transfer Receipt Line".Remarks::Missing then begin
                        SerialNo += 1;
                        CLEAR(UnitCost);
                        CLEAR(Curr);
                        Item.RESET;
                        Item.SETRANGE("No.", "Transfer Receipt Line"."Item No.");
                        if Item.FINDFIRST then
                            UnitCost1 := Item."Standard Cost";
                        Curr := 'USD';
                        if (Curr <> '') then
                            "Currency Factor" := CurrExchRate.ExchangeRate(WORKDATE, Curr);
                        UnitCost := CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor(UnitCost1, "Currency Factor");

                        TransferShipmentLine.RESET;
                        TransferShipmentLine.SETRANGE("Transfer Order No.", "Transfer Receipt Line"."Transfer Order No.");
                        TransferShipmentLine.SETRANGE("Item No.", "Transfer Receipt Line"."Item No.");
                        TransferShipmentLine.SETRANGE("Line No.", "Transfer Receipt Line"."Line No.");
                        if TransferShipmentLine.FINDSET then begin
                            TRQty := TransferShipmentLine.Quantity;
                        end;
                        //
                        TotalValueship += UnitCost * TRQty;
                        Qty := TRQty;
                        Qty4 += "Transfer Receipt Line".Quantity;
                        Quantity1 := 0;
                        Quantity2 := 0;
                        Qty3 := 0;
                        Qty1 := 0;
                        ItemNo1 := '';
                        MissingQty := "Transfer Receipt Line".Quantity;
                        ItemNo1 := "Transfer Receipt Line"."Item No.";
                        Quantity1 := TRQty - "Transfer Receipt Line".Quantity;
                        Qty1 := "Transfer Receipt Line".Quantity;
                        Qty3 := TRQty;
                        Qty5 += Quantity1;
                        SerialNo1 := SerialNo;
                        Desc := "Transfer Receipt Line".Description;
                        Amount := Qty1 * UnitCost;
                        Amount1 += ROUND(Amount, 0.01);
                        Cost := ROUND((UnitCost), 0.01);
                        DiscrepancyQty += MissingQty;
                        CLEAR(NormalQty);
                        CLEAR(DamageQty);

                    end;

                    if "Transfer Receipt Line".Remarks = "Transfer Receipt Line".Remarks::Damage then begin
                        SerialNo += 1;
                        CLEAR(UnitCost);
                        CLEAR(Curr);
                        Item.RESET;
                        Item.SETRANGE("No.", "Transfer Receipt Line"."Item No.");
                        if Item.FINDFIRST then
                            UnitCost1 := Item."Standard Cost";
                        Curr := 'YER';
                        if (Curr <> '') then
                            "Currency Factor" := CurrExchRate.ExchangeRate(WORKDATE, Curr);
                        UnitCost := CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor(UnitCost1, "Currency Factor");

                        TransferShipmentLine.RESET;
                        TransferShipmentLine.SETRANGE("Transfer Order No.", "Transfer Receipt Line"."Transfer Order No.");
                        TransferShipmentLine.SETRANGE("Item No.", "Transfer Receipt Line"."Item No.");
                        TransferShipmentLine.SETRANGE("Line No.", "Transfer Receipt Line"."Line No.");
                        if TransferShipmentLine.FINDSET then begin
                            TRQty := TransferShipmentLine.Quantity;
                        end;
                        //
                        TotalValueship += UnitCost * TRQty;
                        Qty := TRQty;
                        Qty4 += "Transfer Receipt Line".Quantity;
                        Quantity1 := 0;
                        Quantity2 := 0;
                        Qty3 := 0;
                        Qty1 := 0;
                        ItemNo1 := '';
                        DamageQty := "Transfer Receipt Line".Quantity;
                        ItemNo1 := "Transfer Receipt Line"."Item No.";
                        Quantity1 := TRQty - "Transfer Receipt Line".Quantity;
                        Qty1 := "Transfer Receipt Line".Quantity;
                        Qty3 := TRQty;
                        Qty5 += Quantity1;
                        SerialNo1 := SerialNo;
                        Desc := "Transfer Receipt Line".Description;
                        Amount := Qty1 * UnitCost;
                        Amount1 += ROUND(Amount, 0.01);
                        Cost := ROUND((UnitCost), 0.01);
                        DiscrepancyQty += DamageQty;
                        CLEAR(NormalQty);
                        CLEAR(MissingQty);

                    end;

                    //TotalValue  := UnitCost*"Transfer Receipt Line".Quantity;
                    //TotalValue1 += ROUND((TotalValue),0.01);

                    DimensionValue.RESET;
                    DimensionValue.SETRANGE(Code, "Transfer Receipt Line"."Item Category Code");
                    if DimensionValue.FINDFIRST then
                        Agency := DimensionValue.Name;

                    PostedWhseShipmentLine.RESET;
                    PostedWhseShipmentLine.SETRANGE("Source No.", "Transfer Receipt Line"."Transfer Order No.");
                    if PostedWhseShipmentLine.FINDFIRST then
                        WhseNo := PostedWhseShipmentLine."Whse. Shipment No.";
                    Curr := 'YER';
                end;

                trigger OnPreDataItem()
                begin
                    SerialNo := 0;
                    TotalValueship := 0;
                    Quantity1 := 0;
                    Quantity2 := 0;
                    Qty := 0;
                    Qty4 := 0;
                    TotalValue1 := 0;
                    Qty5 := 0;
                    Qty6 := 0;
                    Amount1 := 0;
                    DisplayInfo := 'NO DISCREPANCY';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);
                Location.RESET;
                Location.SETRANGE(Code, "Transfer Receipt Header"."Transfer-to Code");
                if Location.FINDFIRST then begin
                    ToCounty := Location.County;
                    ToPhoneno := Location."Phone No.";
                    ToFaxno := Location."Fax No.";
                    TRNO := Location."Name 2";
                end;
                //
                User.RESET;
                User.SETRANGE("User Name", USERID);
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

    var
        SerialNo: Integer;
        Item: Record Item;
        TotalValue: Decimal;
        TransferShipmentLine: Record "Transfer Shipment Line";
        Qty: Integer;
        TotalValueship: Decimal;
        TransferReceiptLine: Record "Transfer Receipt Line";
        Quantity1: Integer;
        Quantity2: Integer;
        TransferReceiptLine1: Record "Transfer Receipt Line";
        ItemNo1: Code[20];
        Qty1: Integer;
        Qty2: Integer;
        Qty3: Integer;
        Qty4: Integer;
        SerialNo1: Integer;
        Desc: Text[50];
        Amount: Decimal;
        Curr: Code[20];
        TotalValue1: Decimal;
        DiscrepancyReportNo: Code[20];
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cost: Decimal;
        Qty5: Integer;
        Qty6: Integer;
        Qty7: Integer;
        Amount1: Decimal;
        Qty8: Integer;
        Qty9: Integer;
        DisplayInfo: Text;
        Agency: Code[20];
        TRQty: Integer;
        ToPhoneno: Text[30];
        ToFaxno: Text[30];
        Location: Record Location;
        ToCounty: Text;
        User: Record User;
        UserName: Text;
        UnitCost1: Decimal;
        UnitCost: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        "Currency Code": Code[20];
        "Currency Factor": Decimal;
        DimensionValue: Record "Dimension Value";
        PostedWhseShipmentLine: Record "Posted Whse. Shipment Line";
        WhseNo: Code[20];
        CompanyInformation: Record "Company Information";
        TRNO: Text;
        TransferReceiptLine2: Record "Transfer Receipt Line";
        DamageQty: Integer;
        MissingQty: Integer;
        NormalQty: Integer;
        DiscrepancyQty: Integer;
        DefaultPriceFactor: Record "Default Price Factor";
}

