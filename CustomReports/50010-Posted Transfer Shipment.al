report 50010 "Posted Transfer Shipment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Posted Transfer Shipment.rdlc';

    dataset
    {
        dataitem(DataItem1; "Transfer Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(TransfertoContact_TransferShipmentHeader; "Transfer-to Contact")
            {
            }
            column(TransferfromContact_TransferShipmentHeader; "Transfer-from Contact")
            {
            }
            column(TransferOrderNo_TransferShipmentHeader; "Transfer Order No.")
            {
            }
            column(No_TransferShipmentHeader; "No.")
            {
            }
            column(TransfertoFaxNo_TransferShipmentHeader; "Transfer-to Fax No")
            {
            }
            column(TransferFromFaxNo_TransferShipmentHeader; "Transfer-From Fax No")
            {
            }
            column(TransferfromCode_TransferShipmentHeader; "Transfer-from Code")
            {
            }
            column(TransferfromName_TransferShipmentHeader; "Transfer-from Name")
            {
            }
            column(TransferfromName2_TransferShipmentHeader; "Transfer-from Name 2")
            {
            }
            column(DeliveryOrderNo_TransferShipmentHeader; "Delivery Order No.")
            {
            }
            column(TransferfromAddress_TransferShipmentHeader; "Transfer-from Address")
            {
            }
            column(TransferfromAddress2_TransferShipmentHeader; "Transfer-from Address 2")
            {
            }
            column(TransferfromPostCode_TransferShipmentHeader; "Transfer-from Post Code")
            {
            }
            column(TransferfromCity_TransferShipmentHeader; "Transfer-from City")
            {
            }
            column(TransferfromCounty_TransferShipmentHeader; "Transfer-from County")
            {
            }
            column(TrsffromCountryRegionCode_TransferShipmentHeader; "Trsf.-from Country/Region Code")
            {
            }
            column(TransfertoCode_TransferShipmentHeader; "Transfer-to Code")
            {
            }
            column(TransfertoName_TransferShipmentHeader; "Transfer-to Name")
            {
            }
            column(TransfertoName2_TransferShipmentHeader; "Transfer-to Name 2")
            {
            }
            column(TransfertoAddress_TransferShipmentHeader; "Transfer-to Address")
            {
            }
            column(TransfertoAddress2_TransferShipmentHeader; "Transfer-to Address 2")
            {
            }
            column(TransfertoPostCode_TransferShipmentHeader; "Transfer-to Post Code")
            {
            }
            column(TransfertoCity_TransferShipmentHeader; "Transfer-to City")
            {
            }
            column(TransfertoCounty_TransferShipmentHeader; "Transfer-to County")
            {
            }
            column(TrsftoCountryRegionCode_TransferShipmentHeader; "Trsf.-to Country/Region Code")
            {
            }
            column(TransferOrderDate_TransferShipmentHeader; "Transfer Order Date")
            {
            }
            column(PostingDate_TransferShipmentHeader; "Posting Date")
            {
            }
            column(ShortcutDimension1Code_TransferShipmentHeaders; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_TransferShipmentHeader; "Shortcut Dimension 2 Code")
            {
            }
            column(ShipmentDate_TransferShipmentHeader; "Shipment Date")
            {
            }
            column(ReceiptDate_TransferShipmentHeader; "Receipt Date")
            {
            }
            column(Curr; Curr)
            {
            }
            column(FromPhoneNo; FromPhoneNo)
            {
            }
            column(FromFaxNo; FromFaxNo)
            {
            }
            column(ToPhoneNo; ToPhoneNo)
            {
            }
            column(ToFaxNo; ToFaxNo)
            {
            }
            column(FromCounty; FromCounty)
            {
            }
            column(ToCounty; ToCounty)
            {
            }
            column(userName; userName)
            {
            }
            column(FromTRNO; FromTRNO)
            {
            }
            column(ToTRNO; ToTRNO)
            {
            }
            column(CompanyInformationPicture; CompanyInformation.Picture)
            {
            }
            dataitem(DataItem23; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(TransferOrderNo_TransferShipmentLine; "Transfer Order No.")
                {
                }
                column(SalesOrderNo1_TransferShipmentLine; "Sales Order No")
                {
                }
                column(ItemCategoryCode_TransferShipmentLine; "Item Category Code")
                {
                }
                column(GrossWeight_TransferShipmentLine; "Gross Weight")
                {
                }
                column(NetWeight_TransferShipmentLine; "Net Weight")
                {
                }
                column(UnitVolume_TransferShipmentLine; "Unit Volume")
                {
                }
                column(VariantCode_TransferShipmentLine; "Variant Code")
                {
                }
                column(UnitsperParcel_TransferShipmentLine; "Units per Parcel")
                {
                }
                column(Description2_TransferShipmentLine; "Description 2")
                {
                }
                column(SalesOrder_TransferShipmentLine; SalesOrder)
                {
                }
                column(InTransitCode_TransferShipmentLine; "In-Transit Code")
                {
                }
                column(TransferfromCode_TransferShipmentLine; "Transfer-from Code")
                {
                }
                column(TransfertoCode_TransferShipmentLine; "Transfer-to Code")
                {
                }
                column(ItemShptEntryNo_TransferShipmentLine; "Item Shpt. Entry No.")
                {
                }
                column(ShippingTime_TransferShipmentLine; "Shipping Time")
                {
                }
                column(DimensionSetID_TransferShipmentLine; "Dimension Set ID")
                {
                }
                column(TransferfromBinCode_TransferShipmentLine; "Transfer-from Bin Code")
                {
                }
                column(DocumentNo_TransferShipmentLine; "Document No.")
                {
                }
                column(LineNo_TransferShipmentLine; "Line No.")
                {
                }
                column(ItemNo_TransferShipmentLine; "Item No.")
                {
                }
                column(Quantity_TransferShipmentLine; Quantity)
                {
                }
                column(UnitofMeasure_TransferShipmentLine; "Unit of Measure")
                {
                }
                column(Description_TransferShipmentLine; Description)
                {
                }
                column(OrderedPartNo_TransferShipmentLine; "Ordered Part No.")
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
                column(DeliveryOrder; DeliveryOrder)
                {
                }
                column(ProdCopName; ProdCopName)
                {
                }
                dataitem(DataItem50; "Company Information")
                {
                    column(VATRegistrationNo_CompanyInformation; "VAT Registration No.")
                    {
                    }
                    column(Name_CompanyInformation; Name)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    TotalValue := 0;
                    UnitCost := 0;
                    IF ("Transfer Shipment Line"."Item No." <> '') AND ("Transfer Shipment Line".Quantity <> 0) THEN BEGIN
                        CLEAR(DeliveryOrder);
                        SerialNo += 1;
                        Item.RESET;
                        Item.SETRANGE("No.", "Transfer Shipment Line"."Item No.");
                        IF Item.FINDFIRST THEN BEGIN
                            DefaultPriceFactor.RESET;
                            DefaultPriceFactor.SETRANGE("Agency Code", Item."Global Dimension 1 Code");
                            IF DefaultPriceFactor.FINDFIRST THEN
                                UnitCost := "Transfer Shipment Line"."Quantity (Base)" * (Item."Unit Price" - Item."Dealer Net - Core Deposit" * Item."Inventory Factor") * DefaultPriceFactor."Default Price Factor" + Item."Dealer Net - Core Deposit" * Item."Inventory Factor";

                            UnitCost := ROUND(UnitCost, 0.01);
                        END;
                        //
                        TotalValue := UnitCost * "Transfer Shipment Line".Quantity;
                        //
                        IF "Transfer Shipment Line"."Sales Order No" = '' THEN
                            "Transfer Shipment Line"."Sales Order No" := "Transfer Shipment Line"."Sales Order No"
                        ELSE
                            DeliveryOrder := "Transfer Shipment Line"."Sales Order No";


                    END;

                    DimensionValue.RESET;
                    DimensionValue.SETRANGE(Code, "Transfer Shipment Line"."Item Category Code");
                    IF DimensionValue.FINDFIRST THEN
                        ProdCopName := DimensionValue.Name;
                end;

                trigger OnPreDataItem()
                begin
                    SerialNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Curr := 'USD';
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);

                Currency.SETRANGE(Code, Curr);
                IF Currency.FINDFIRST THEN
                    Currcode := Currency."Currency Code"
                ELSE
                    Currcode := 'Cent';
                Location.RESET;
                Location.SETRANGE(Code, "Transfer Shipment Header"."Transfer-from Code");
                IF Location.FINDFIRST THEN BEGIN
                    FromPhoneNo := Location."Phone No.";
                    FromFaxNo := Location."Fax No.";
                    FromCounty := Location.County;
                    FromTRNO := Location."Name 2";
                END;
                Location.RESET;
                Location.SETRANGE(Code, "Transfer Shipment Header"."Transfer-to Code");
                IF Location.FINDFIRST THEN BEGIN
                    ToPhoneNo := Location."Phone No.";
                    ToFaxNo := Location."Fax No.";
                    ToCounty := Location.County;
                    ToTRNO := Location."Name 2";
                END;
                User.RESET;
                User.SETRANGE("User Name", USERID);
                IF User.FINDFIRST THEN
                    userName := User."Full Name";
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
        UnitCost: Decimal;
        TotalValue: Decimal;
        TransferShipmentLine: Record "Transfer Shipment Line";
        Curr: Code[20];
        Currency: Record Currency;
        Currcode: Text[250];
        DeliveryOrder: Code[60];
        ProdCopName: Text;
        Location: Record Location;
        FromPhoneNo: Text[30];
        ToPhoneNo: Text[30];
        FromFaxNo: Text[30];
        ToFaxNo: Text[30];
        FromCounty: Text[30];
        ToCounty: Text[30];
        User: Record User;
        userName: Text;
        DimensionValue: Record "Dimension Value";
        FromTRNO: Text;
        ToTRNO: Text;
        CompanyInformation: Record "Company Information";
        DefaultPriceFactor: Record "Default Price Factor";
        "Transfer Shipment Header": Record "Transfer Shipment Header";
        "Transfer Shipment Line": Record "Transfer Shipment Line";
}

