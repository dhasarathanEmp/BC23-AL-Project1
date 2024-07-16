report 50011 "Posted Transfer Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Posted Transfer Receipt.rdlc';

    dataset
    {
        dataitem(DataItem1; "Transfer Receipt Header")
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
            column(TransfertoFaxNo_TransferReceiptHeader; "Transfer-to Fax No")
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
            dataitem(DataItem23; "Transfer Receipt Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                RequestFilterFields = "Document No.";
                column(QuantityBase_TransferReceiptLine; "Transfer Receipt Line"."Quantity (Base)")
                {
                }
                column(QtyperUnitofMeasure_TransferReceiptLine; "Transfer Receipt Line"."Qty. per Unit of Measure")
                {
                }
                column(UnitofMeasureCode_TransferReceiptLine; "Transfer Receipt Line"."Unit of Measure Code")
                {
                }
                column(GrossWeight_TransferReceiptLine; "Transfer Receipt Line"."Gross Weight")
                {
                }
                column(NetWeight_TransferReceiptLine; "Transfer Receipt Line"."Net Weight")
                {
                }
                column(UnitVolume_TransferReceiptLine; "Transfer Receipt Line"."Unit Volume")
                {
                }
                column(VariantCode_TransferReceiptLine; "Transfer Receipt Line"."Variant Code")
                {
                }
                column(UnitsperParcel_TransferReceiptLine; "Transfer Receipt Line"."Units per Parcel")
                {
                }
                column(Description2_TransferReceiptLine; "Transfer Receipt Line"."Description 2")
                {
                }
                column(TransferOrderNo_TransferReceiptLine; "Transfer Receipt Line"."Transfer Order No.")
                {
                }
                column(ReceiptDate_TransferReceiptLine; "Transfer Receipt Line"."Receipt Date")
                {
                }
                column(ShippingAgentCode_TransferReceiptLine; "Transfer Receipt Line"."Shipping Agent Code")
                {
                }
                column(ShippingAgentServiceCode_TransferReceiptLine; "Transfer Receipt Line"."Shipping Agent Service Code")
                {
                }
                column(InTransitCode_TransferReceiptLine; "Transfer Receipt Line"."In-Transit Code")
                {
                }
                column(TransferfromCode_TransferReceiptLine; "Transfer Receipt Line"."Transfer-from Code")
                {
                }
                column(TransfertoCode_TransferReceiptLine; "Transfer Receipt Line"."Transfer-to Code")
                {
                }
                column(ItemRcptEntryNo_TransferReceiptLine; "Transfer Receipt Line"."Item Rcpt. Entry No.")
                {
                }
                column(ShippingTime_TransferReceiptLine; "Transfer Receipt Line"."Shipping Time")
                {
                }
                column(DimensionSetID_TransferReceiptLine; "Transfer Receipt Line"."Dimension Set ID")
                {
                }
                column(ItemCategoryCode_TransferReceiptLine; "Transfer Receipt Line"."Item Category Code")
                {
                }
                column(TransferToBinCode_TransferReceiptLine; "Transfer Receipt Line"."Transfer-To Bin Code")
                {
                }
                column(DocumentNo_TransferReceiptLine; "Transfer Receipt Line"."Document No.")
                {
                }
                column(LineNo_TransferReceiptLine; "Transfer Receipt Line"."Line No.")
                {
                }
                column(ItemNo_TransferReceiptLine; "Transfer Receipt Line"."Item No.")
                {
                }
                column(Quantity_TransferReceiptLine; "Transfer Receipt Line".Quantity)
                {
                }
                column(UnitofMeasure_TransferReceiptLine; "Transfer Receipt Line"."Unit of Measure")
                {
                }
                column(Description_TransferReceiptLine; "Transfer Receipt Line".Description)
                {
                }
                column(OrderedPartNo_TransferReceiptLine; "Transfer Receipt Line"."Ordered Part No.")
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
                column(OriginalTransferOrderQty_TransferReceiptLine; "Transfer Receipt Line"."Original Transfer Order Qty.")
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
                dataitem(DataItem77; "Company Information")
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
                    SerialNo += 1;
                    CLEAR(UnitCost);
                    CLEAR(Curr);
                    Item.RESET;
                    Item.SETRANGE("No.", "Transfer Receipt Line"."Item No.");
                    IF Item.FINDFIRST THEN
                        UnitCost1 := Item."Standard Cost";
                    Curr := 'YER';
                    IF (Curr <> '') THEN
                        "Currency Factor" := CurrExchRate.ExchangeRate(WORKDATE, Curr);
                    UnitCost := CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor(UnitCost1, "Currency Factor");
                    //
                    TotalValue := UnitCost * "Transfer Receipt Line".Quantity;
                    TotalValue1 += ROUND((TotalValue), 0.01);
                    //
                    TransferShipmentLine.RESET;
                    TransferShipmentLine.SETRANGE("Transfer Order No.", "Transfer Receipt Line"."Transfer Order No.");
                    TransferShipmentLine.SETRANGE("Item No.", "Transfer Receipt Line"."Item No.");
                    TransferShipmentLine.SETRANGE("Line No.", "Transfer Receipt Line"."Line No.");
                    IF TransferShipmentLine.FINDSET THEN BEGIN
                        TRQty := TransferShipmentLine.Quantity;
                    END;
                    //
                    TotalValueship += UnitCost * TRQty;
                    Qty := TRQty;
                    Qty4 += "Transfer Receipt Line".Quantity;
                    Quantity1 := 0;
                    Quantity2 := 0;
                    Qty3 := 0;
                    Qty1 := 0;
                    ItemNo1 := '';

                    IF "Transfer Receipt Line".Quantity < TRQty THEN BEGIN
                        ItemNo1 := "Transfer Receipt Line"."Item No.";
                        Quantity1 := TRQty - "Transfer Receipt Line".Quantity;
                        Qty1 := "Transfer Receipt Line".Quantity;
                        Qty3 := TRQty;
                        Qty5 += Quantity1;
                        SerialNo1 := SerialNo;
                        Desc := "Transfer Receipt Line".Description;
                        Amount := Quantity1 * UnitCost;
                        Amount1 += ROUND(Amount, 0.01);
                        Cost := ROUND((UnitCost), 0.01);
                        DisplayInfo := 'DISCREPANCY REPORT';
                    END ELSE
                        IF "Transfer Receipt Line".Quantity > TRQty THEN BEGIN
                            ItemNo1 := "Transfer Receipt Line"."Item No.";
                            Quantity2 := "Transfer Receipt Line".Quantity - TRQty;
                            Qty1 := "Transfer Receipt Line".Quantity;
                            Qty3 := TRQty;
                            SerialNo1 := SerialNo;
                            Desc := "Transfer Receipt Line".Description;
                            Amount := Quantity2 * UnitCost;
                            Amount1 += ROUND(Amount, 0.01);
                            Cost := ROUND((UnitCost), 0.01);
                            Qty6 += Quantity2;
                            DisplayInfo := 'DISCREPANCY REPORT';
                        END;
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE(Code, "Transfer Receipt Line"."Item Category Code");
                    IF DimensionValue.FINDFIRST THEN
                        Agency := DimensionValue.Name;
                    PostedWhseShipmentLine.RESET;
                    PostedWhseShipmentLine.SETRANGE("Source No.", "Transfer Receipt Line"."Transfer Order No.");
                    IF PostedWhseShipmentLine.FINDFIRST THEN
                        WhseNo := PostedWhseShipmentLine."Whse. Shipment No.";
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
                IF Location.FINDFIRST THEN BEGIN
                    ToCounty := Location.County;
                    ToPhoneno := Location."Phone No.";
                    ToFaxno := Location."Fax No.";
                    TRNO := Location."Name 2";
                END;
                //
                User.RESET;
                User.SETRANGE("User Name", USERID);
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
        "Transfer Receipt Header": Record "Transfer Receipt Header";
        "Transfer Receipt Line": Record "Transfer Receipt Line";
}

