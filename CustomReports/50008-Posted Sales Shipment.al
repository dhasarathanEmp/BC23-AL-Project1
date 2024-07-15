report 50008 "Posted Sales Shipment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Posted Sales Shipment.rdlc';
    Caption = 'Delivery Order';

    dataset
    {
        dataitem(DataItem1; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(SelltoCustomerNo_SalesShipmentHeader; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerName_SalesShipmentHeader; "Sell-to Customer Name")
            {
            }
            column(SelltoCustomerName2_SalesShipmentHeader; "Sell-to Customer Name 2")
            {
            }
            column(SelltoAddress_SalesShipmentHeader; "Sell-to Address")
            {
            }
            column(SelltoAddress2_SalesShipmentHeader; "Sell-to Address 2")
            {
            }
            column(SelltoCity_SalesShipmentHeader; "Sell-to City")
            {
            }
            column(SelltoContact_SalesShipmentHeader; "Sell-to Contact")
            {
            }
            column(SelltoPostCode_SalesShipmentHeader; "Sell-to Post Code")
            {
            }
            column(SelltoCounty_SalesShipmentHeader; "Sell-to County")
            {
            }
            column(SelltoCountryRegionCode_SalesShipmentHeader; "Sell-to Country/Region Code")
            {
            }
            column(ExternalDocumentNo_SalesShipmentHeader; "External Document No.")
            {
            }
            column(CustomerPOdate_SalesShipmentHeader; "Customer PO date")
            {
            }
            column(SourceCode_SalesShipmentHeader; "Source Code")
            {
            }
            column(BilltoCountryRegionCode_SalesShipmentHeader; "Bill-to Country/Region Code")
            {
            }
            column(No_SalesShipmentHeader; "No.")
            {
            }
            column(BilltoCustomerNo_SalesShipmentHeader; "Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesShipmentHeader; "Bill-to Name")
            {
            }
            column(BilltoName2_SalesShipmentHeader; "Bill-to Name 2")
            {
            }
            column(BilltoAddress_SalesShipmentHeader; "Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesShipmentHeader; "Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesShipmentHeader; "Bill-to City")
            {
            }
            column(BilltoContact_SalesShipmentHeader; "Bill-to Contact")
            {
            }
            column(LocationCode_SalesShipmentHeader; "Location Code")
            {
            }
            column(OrderDate_SalesShipmentHeader; "Order Date")
            {
            }
            column(PostingDate_SalesShipmentHeader; "Posting Date")
            {
            }
            column(LocName; LocName)
            {
            }
            column(CurrencyCode_SalesShipmentHeader; "Currency Code")
            {
            }
            column(Curr; Curr)
            {
            }
            column(DocNo; DocNo)
            {
            }
            column(Division; Division)
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
            column(CountryRegion; CountryRegion1)
            {
            }
            dataitem(DataItem14; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Sell-to Customer No." = FIELD("Sell-to Customer No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE(Quantity = FILTER(<> 0));
                column(CurrencyCode_SalesShipmentLine; "Currency Code")
                {
                }
                column(CrossReferenceNo_SalesShipmentLine; "Item Reference No.")
                {
                }
                column(OrderNo_SalesShipmentLine; "Order No.")
                {
                }
                column(ItemCategoryCode_SalesShipmentLine; "Item Category Code")
                {
                }
                column(BinCode_SalesShipmentLine; "Bin Code")
                {
                }
                column(LocationCode_SalesShipmentLine; "Location Code")
                {
                }
                column(Quantity_SalesShipmentLine; Quantity)
                {
                }
                column(UnitPrice_SalesShipmentLine; "Unit Price")
                {
                }
                column(NetWeight_SalesShipmentLine; "Net Weight")
                {
                }
                column(LastPartNumber_SalesShipmentLine; LastPartNumber)
                {
                }
                column(SelltoCustomerNo_SalesShipmentLine; "Sell-to Customer No.")
                {
                }
                column(DocumentNo_SalesShipmentLine; "Document No.")
                {
                }
                column(LineNo_SalesShipmentLine; "Line No.")
                {
                }
                column(No_SalesShipmentLine; "No.")
                {
                }
                column(ShipmentDate_SalesShipmentLine; "Shipment Date")
                {
                }
                column(Description_SalesShipmentLine; Description)
                {
                }
                column(UnitofMeasure_SalesShipmentLine; "Unit of Measure")
                {
                }
                column(Amount; Amount)
                {
                }
                column(SerialNo; SerialNo)
                {
                }
                column(OrderedPartNumb; OrderedPartNumb)
                {
                }
                column(SapNo_SalesShipmentLine; "Sap No")
                {
                }
                dataitem(DataItem29; "Company Information")
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
                    column(VATRegistrationNo_CompanyInformation; "VAT Registration No.")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    SerialNo += 1;
                    Amount := "Sales Shipment Line".Quantity * "Sales Shipment Line"."Unit Price";
                    Location.RESET;
                    Location.SETRANGE(Code, "Sales Shipment Line"."Location Code");
                    IF Location.FINDFIRST THEN BEGIN
                        LocName := Location.Name;
                        LocAddress := Location.Address;
                        LocAddress2 := Location."Address 2";
                        LocCity := Location.City;
                        LOCPhone := Location."Phone No.";
                        LocFaxNo := Location."Fax No.";
                        LocCountry := Location.County;
                        LocPostcode := Location."Post Code";
                    END;

                    IF ("Sales Shipment Line"."BOM Item No" <> '') AND ("Sales Shipment Line".LastPartNumber <> '') THEN
                        OrderedPartNumb := "Sales Shipment Line"."BOM Item No" + '(' + "Sales Shipment Line".LastPartNumber + ')'
                    ELSE IF "Sales Shipment Line"."BOM Item No" <> '' THEN
                        OrderedPartNumb := "Sales Shipment Line"."BOM Item No"
                    ELSE
                        OrderedPartNumb := "Sales Shipment Line".LastPartNumber;
                end;

                trigger OnPreDataItem()
                begin
                    SerialNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                IF "Sales Shipment Header"."Currency Code" <> '' THEN
                    Curr := "Sales Shipment Header"."Currency Code"
                ELSE
                    Curr := 'USD';
                Company.RESET;
                IF Company.GET(COMPANYNAME) THEN
                    Division := FORMAT(Company.Division);

                PostedWhseShipmentLine.RESET;
                PostedWhseShipmentLine.SETRANGE("Posted Source No.", "Sales Shipment Header"."No.");
                PostedWhseShipmentLine.SETRANGE("Source No.", "Sales Shipment Header"."Order No.");
                IF PostedWhseShipmentLine.FINDFIRST THEN
                    DocNo := PostedWhseShipmentLine."Whse. Shipment No.";
                //
                User.RESET;
                User.SETRANGE("User Name", USERID);
                IF User.FINDFIRST THEN
                    UserName := User."Full Name";

                CountryRegion.RESET;
                CountryRegion.SETRANGE(Code, "Sales Shipment Header"."Sell-to Country/Region Code");
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

    var
        Amount: Decimal;
        Location: Record Location;
        LocName: Text[50];
        SerialNo: Integer;
        Curr: Code[20];
        PostedWhseShipmentLine: Record "Posted Whse. Shipment Line";
        DocNo: Code[20];
        Company: Record "Company Information";
        Division: Text;
        User: Record User;
        LocAddress: Text;
        LocAddress2: Text;
        LocCity: Text;
        LOCPhone: Text;
        LocFaxNo: Text;
        LocCountry: Text;
        LocPostcode: Text;
        UserName: Text;
        CountryRegion: Record "Country/Region";
        CountryRegion1: Text;
        OrderedPartNumb: Code[20];
        "Sales Shipment Line": Record "Sales Shipment Line";
        "Sales Shipment Header": Record "Sales Shipment Header";
}

