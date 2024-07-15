report 50010 "Posted Transfer Shipment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Posted Transfer Shipment.rdlc';

    dataset
    {
        dataitem(DataItem1;Table5744)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "No.";
            column(TransfertoContact_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-to Contact")
            {
            }
            column(TransferfromContact_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-from Contact")
            {
            }
            column(TransferOrderNo_TransferShipmentHeader;"Transfer Shipment Header"."Transfer Order No.")
            {
            }
            column(No_TransferShipmentHeader;"Transfer Shipment Header"."No.")
            {
            }
            column(TransfertoFaxNo_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-to Fax No")
            {
            }
            column(TransferFromFaxNo_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-From Fax No")
            {
            }
            column(TransferfromCode_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-from Code")
            {
            }
            column(TransferfromName_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-from Name")
            {
            }
            column(TransferfromName2_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-from Name 2")
            {
            }
            column(DeliveryOrderNo_TransferShipmentHeader;"Transfer Shipment Header"."Delivery Order No.")
            {
            }
            column(TransferfromAddress_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-from Address")
            {
            }
            column(TransferfromAddress2_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-from Address 2")
            {
            }
            column(TransferfromPostCode_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-from Post Code")
            {
            }
            column(TransferfromCity_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-from City")
            {
            }
            column(TransferfromCounty_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-from County")
            {
            }
            column(TrsffromCountryRegionCode_TransferShipmentHeader;"Transfer Shipment Header"."Trsf.-from Country/Region Code")
            {
            }
            column(TransfertoCode_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-to Code")
            {
            }
            column(TransfertoName_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-to Name")
            {
            }
            column(TransfertoName2_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-to Name 2")
            {
            }
            column(TransfertoAddress_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-to Address")
            {
            }
            column(TransfertoAddress2_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-to Address 2")
            {
            }
            column(TransfertoPostCode_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-to Post Code")
            {
            }
            column(TransfertoCity_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-to City")
            {
            }
            column(TransfertoCounty_TransferShipmentHeader;"Transfer Shipment Header"."Transfer-to County")
            {
            }
            column(TrsftoCountryRegionCode_TransferShipmentHeader;"Transfer Shipment Header"."Trsf.-to Country/Region Code")
            {
            }
            column(TransferOrderDate_TransferShipmentHeader;"Transfer Shipment Header"."Transfer Order Date")
            {
            }
            column(PostingDate_TransferShipmentHeader;"Transfer Shipment Header"."Posting Date")
            {
            }
            column(ShortcutDimension1Code_TransferShipmentHeaders;"Transfer Shipment Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_TransferShipmentHeader;"Transfer Shipment Header"."Shortcut Dimension 2 Code")
            {
            }
            column(ShipmentDate_TransferShipmentHeader;"Transfer Shipment Header"."Shipment Date")
            {
            }
            column(ReceiptDate_TransferShipmentHeader;"Transfer Shipment Header"."Receipt Date")
            {
            }
            column(Curr;Curr)
            {
            }
            column(FromPhoneNo;FromPhoneNo)
            {
            }
            column(FromFaxNo;FromFaxNo)
            {
            }
            column(ToPhoneNo;ToPhoneNo)
            {
            }
            column(ToFaxNo;ToFaxNo)
            {
            }
            column(FromCounty;FromCounty)
            {
            }
            column(ToCounty;ToCounty)
            {
            }
            column(userName;userName)
            {
            }
            column(FromTRNO;FromTRNO)
            {
            }
            column(ToTRNO;ToTRNO)
            {
            }
            column(CompanyInformationPicture;CompanyInformation.Picture)
            {
            }
            dataitem(DataItem23;Table5745)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING(Document No.,Line No.);
                column(TransferOrderNo_TransferShipmentLine;"Transfer Shipment Line"."Transfer Order No.")
                {
                }
                column(SalesOrderNo1_TransferShipmentLine;"Transfer Shipment Line"."Sales Order No")
                {
                }
                column(ItemCategoryCode_TransferShipmentLine;"Transfer Shipment Line"."Item Category Code")
                {
                }
                column(GrossWeight_TransferShipmentLine;"Transfer Shipment Line"."Gross Weight")
                {
                }
                column(NetWeight_TransferShipmentLine;"Transfer Shipment Line"."Net Weight")
                {
                }
                column(UnitVolume_TransferShipmentLine;"Transfer Shipment Line"."Unit Volume")
                {
                }
                column(VariantCode_TransferShipmentLine;"Transfer Shipment Line"."Variant Code")
                {
                }
                column(UnitsperParcel_TransferShipmentLine;"Transfer Shipment Line"."Units per Parcel")
                {
                }
                column(Description2_TransferShipmentLine;"Transfer Shipment Line"."Description 2")
                {
                }
                column(SalesOrder_TransferShipmentLine;"Transfer Shipment Line".SalesOrder)
                {
                }
                column(InTransitCode_TransferShipmentLine;"Transfer Shipment Line"."In-Transit Code")
                {
                }
                column(TransferfromCode_TransferShipmentLine;"Transfer Shipment Line"."Transfer-from Code")
                {
                }
                column(TransfertoCode_TransferShipmentLine;"Transfer Shipment Line"."Transfer-to Code")
                {
                }
                column(ItemShptEntryNo_TransferShipmentLine;"Transfer Shipment Line"."Item Shpt. Entry No.")
                {
                }
                column(ShippingTime_TransferShipmentLine;"Transfer Shipment Line"."Shipping Time")
                {
                }
                column(DimensionSetID_TransferShipmentLine;"Transfer Shipment Line"."Dimension Set ID")
                {
                }
                column(ProductGroupCode_TransferShipmentLine;"Transfer Shipment Line"."Product Group Code")
                {
                }
                column(TransferfromBinCode_TransferShipmentLine;"Transfer Shipment Line"."Transfer-from Bin Code")
                {
                }
                column(DocumentNo_TransferShipmentLine;"Transfer Shipment Line"."Document No.")
                {
                }
                column(LineNo_TransferShipmentLine;"Transfer Shipment Line"."Line No.")
                {
                }
                column(ItemNo_TransferShipmentLine;"Transfer Shipment Line"."Item No.")
                {
                }
                column(Quantity_TransferShipmentLine;"Transfer Shipment Line".Quantity)
                {
                }
                column(UnitofMeasure_TransferShipmentLine;"Transfer Shipment Line"."Unit of Measure")
                {
                }
                column(Description_TransferShipmentLine;"Transfer Shipment Line".Description)
                {
                }
                column(OrderedPartNo_TransferShipmentLine;"Transfer Shipment Line"."Ordered Part No.")
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
                column(DeliveryOrder;DeliveryOrder)
                {
                }
                column(ProdCopName;ProdCopName)
                {
                }
                dataitem(DataItem50;Table79)
                {
                    column(VATRegistrationNo_CompanyInformation;"Company Information"."VAT Registration No.")
                    {
                    }
                    column(Name_CompanyInformation;"Company Information".Name)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    TotalValue :=0;
                    UnitCost :=0;
                    IF ("Transfer Shipment Line"."Item No." <> '') AND ("Transfer Shipment Line".Quantity <> 0) THEN BEGIN
                      CLEAR(DeliveryOrder);
                      SerialNo  +=  1;
                      Item.RESET;
                      Item.SETRANGE("No.","Transfer Shipment Line"."Item No.");
                      IF Item.FINDFIRST THEN BEGIN
                        DefaultPriceFactor.RESET;
                        DefaultPriceFactor.SETRANGE("Agency Code",Item."Global Dimension 1 Code");
                        IF DefaultPriceFactor.FINDFIRST THEN
                          UnitCost  := "Transfer Shipment Line"."Quantity (Base)" *  (Item."Unit Price"-Item."Dealer Net - Core Deposit"*Item."Inventory Factor")*DefaultPriceFactor."Default Price Factor" + Item."Dealer Net - Core Deposit"*Item."Inventory Factor";

                        UnitCost := ROUND(UnitCost,0.01);
                      END;
                      //
                      TotalValue  := UnitCost * "Transfer Shipment Line".Quantity;
                      //
                      IF "Transfer Shipment Line"."Sales Order No" ='' THEN
                        "Transfer Shipment Line"."Sales Order No" :="Transfer Shipment Line"."Sales Order No"
                      ELSE
                        DeliveryOrder := "Transfer Shipment Line"."Sales Order No";


                    END;

                       DimensionValue.RESET;
                       DimensionValue.SETRANGE(Code,"Transfer Shipment Line"."Item Category Code");
                       IF DimensionValue.FINDFIRST THEN
                         ProdCopName := DimensionValue.Name;
                end;

                trigger OnPreDataItem()
                begin
                    SerialNo  :=  0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Curr  :=  'USD';
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);

                Currency.SETRANGE(Code,Curr);
                IF Currency.FINDFIRST THEN
                  Currcode  :=  Currency."Currency Code"
                ELSE
                  Currcode :=  'Cent';
                Location.RESET;
                Location.SETRANGE(Code,"Transfer Shipment Header"."Transfer-from Code");
                IF Location.FINDFIRST THEN BEGIN
                  FromPhoneNo := Location."Phone No.";
                  FromFaxNo := Location."Fax No.";
                  FromCounty := Location.County;
                  FromTRNO := Location."T.R.No";
                END;
                Location.RESET;
                Location.SETRANGE(Code,"Transfer Shipment Header"."Transfer-to Code");
                IF Location.FINDFIRST THEN BEGIN
                  ToPhoneNo := Location."Phone No.";
                  ToFaxNo := Location."Fax No.";
                  ToCounty := Location.County;
                  ToTRNO := Location."T.R.No";
                END;
                User.RESET;
                User.SETRANGE("User Name",USERID);
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
        Item: Record "27";
        UnitCost: Decimal;
        TotalValue: Decimal;
        TransferShipmentLine: Record "5745";
        Curr: Code[20];
        Currency: Record "4";
        Currcode: Text[250];
        DeliveryOrder: Code[60];
        ProdCopName: Text;
        Location: Record "14";
        FromPhoneNo: Text[30];
        ToPhoneNo: Text[30];
        FromFaxNo: Text[30];
        ToFaxNo: Text[30];
        FromCounty: Text[30];
        ToCounty: Text[30];
        User: Record "2000000120";
        userName: Text;
        DimensionValue: Record "349";
        FromTRNO: Text;
        ToTRNO: Text;
        CompanyInformation: Record "79";
        DefaultPriceFactor: Record "60036";
}

