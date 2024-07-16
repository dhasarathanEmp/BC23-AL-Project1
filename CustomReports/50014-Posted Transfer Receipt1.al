report 50014 "Posted Transfer Receipt1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Posted Transfer Receipt1.rdlc';
    Caption = 'Posted Transfer Receipt';

    dataset
    {
        dataitem(DataItem1; "Transfer Receipt Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
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
            column(PTSQTY; PTSQty)
            {
            }
            column(PTSQty1; PTSQty1)
            {
            }
            column(TotalShipAmount; TotalShipAmount)
            {
            }
            column(DamageQty; DamageQty)
            {
            }
            dataitem(DataItem23; "Transfer Receipt Line")
            {
                DataItemLink = "Transfer Order No." = FIELD("Transfer Order No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
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
                column(Amount1; Amount1)
                {
                }
                column(Warehouseshipment; WhseNo)
                {
                }
                column(Agency; Agency)
                {
                }
                column(Excess_TransferReceiptLine; Excess)
                {
                }
                column(Bincode; BINCODE)
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
                    IF Item.FINDFIRST THEN BEGIN
                        UnitCost1 := Item."Standard Cost";
                        DefaultPriceFactor.RESET;
                        IF DefaultPriceFactor.GET(Item."Global Dimension 1 Code") THEN
                            UnitCost := "Transfer Receipt Line"."Quantity (Base)" * (Item."Unit Price" - Item."Dealer Net - Core Deposit" * Item."Inventory Factor") * DefaultPriceFactor."Default Price Factor" + Item."Dealer Net - Core Deposit" * Item."Inventory Factor";
                    END;
                    CLEAR(Quantity1);
                    CLEAR(Amount1);
                    IF "Transfer Receipt Line".Remarks = "Transfer Receipt Line".Remarks::"None " THEN BEGIN
                        TotalValue := UnitCost * "Transfer Receipt Line".Quantity;
                        TotalValue1 += ROUND((TotalValue), 0.01);
                        Quantity1 := "Transfer Receipt Line".Quantity;
                        Quantity2 += "Transfer Receipt Line".Quantity;
                        Amount1 := UnitCost * "Transfer Receipt Line".Quantity;
                        BINCODE := "Transfer Receipt Line"."Transfer-To Bin Code";
                    END;
                    IF "Transfer Receipt Line".Remarks <> "Transfer Receipt Line".Remarks::"None " THEN
                        DamageQty += "Transfer Receipt Line"."Quantity (Base)";
                    //
                    TRQty := 0;
                    TransferShipmentLine.RESET;
                    TransferShipmentLine.SETRANGE("Transfer Order No.", "Transfer Receipt Line"."Transfer Order No.");
                    TransferShipmentLine.SETRANGE("Item No.", "Transfer Receipt Line"."Item No.");
                    //TransferShipmentLine.SETRANGE("Line No.","Transfer Receipt Line"."Line No.");
                    IF TransferShipmentLine.FINDSET THEN
                        REPEAT
                            TRQty += TransferShipmentLine.Quantity;
                        UNTIL TransferShipmentLine.NEXT = 0;
                    //
                    TotalValueship += UnitCost * TRQty;
                    Qty := TRQty;
                    Qty4 += "Transfer Receipt Line".Quantity;

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
                    TotalValue1 := 0;
                    Amount1 := 0;
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
                //
                CLEAR(PTSQty);
                CLEAR(TotalShipAmount);
                TransferShipmentLine.RESET;
                TransferShipmentLine.SETRANGE("Transfer Order No.", "Transfer Receipt Header"."Transfer Order No.");
                IF TransferShipmentLine.FINDSET THEN
                    REPEAT
                        Item.RESET;
                        Item.SETRANGE("No.", TransferShipmentLine."Item No.");
                        IF Item.FINDFIRST THEN
                            DefaultPriceFactor.RESET;
                        IF DefaultPriceFactor.GET(Item."Global Dimension 1 Code") THEN
                            UnitCost := TransferShipmentLine."Quantity (Base)" * (Item."Unit Price" - Item."Dealer Net - Core Deposit" * Item."Inventory Factor") * DefaultPriceFactor."Default Price Factor" + Item."Dealer Net - Core Deposit" * Item."Inventory Factor";
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
        Item: Record Item;
        TotalValue: Decimal;
        TransferShipmentLine: Record "Transfer Shipment Line";
        Qty: Decimal;
        TotalValueship: Decimal;
        TransferReceiptLine: Record "Transfer Receipt Line";
        Quantity1: Decimal;
        Quantity2: Decimal;
        TransferReceiptLine1: Record "Transfer Receipt Line";
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
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
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
        PTSQty: Decimal;
        TotalShipAmount: Decimal;
        DamageQty: Decimal;
        BINCODE: Code[20];
        DefaultPriceFactor: Record "Default Price Factor";
        PTSQty1: Decimal;
        "Transfer Receipt Header": Record "Transfer Receipt Header";
        "Transfer Receipt Line": Record "Transfer Receipt Line";
}

