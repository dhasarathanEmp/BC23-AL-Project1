report 50015 "Sales Invoice ADFZ"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Sales Invoice ADFZ.rdlc';

    dataset
    {
        dataitem(DataItem1; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(AmountIncludingVAT_SalesInvoiceHeader; "Amount Including VAT")
            {
            }
            column(ExternalDocumentNo_SalesInvoiceHeader; "External Document No.")
            {
            }
            column(OrderDate_SalesInvoiceHeader; "Order Date")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Posting Date")
            {
            }
            column(No_SalesInvoiceHeader; "No.")
            {
            }
            column(BilltoCustomerNo_SalesInvoiceHeader; "Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesInvoiceHeader; "Bill-to Name")
            {
            }
            column(BilltoName2_SalesInvoiceHeader; "Bill-to Name 2")
            {
            }
            column(BilltoAddress_SalesInvoiceHeader; "Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesInvoiceHeader; "Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesInvoiceHeader; "Bill-to City")
            {
            }
            column(BilltoContact_SalesInvoiceHeader; "Bill-to Contact")
            {
            }
            column(YourReference_SalesInvoiceHeader; "Your Reference")
            {
            }
            column(BilltoPostCode_SalesInvoiceHeader; "Bill-to Post Code")
            {
            }
            column(BilltoCounty_SalesInvoiceHeader; "Bill-to County")
            {
            }
            column(BilltoCountryRegionCode_SalesInvoiceHeader; "Bill-to Country/Region Code")
            {
            }
            column(CustAddr_1; CustAddr[1])
            {
            }
            column(CustAddr_2; CustAddr[2])
            {
            }
            column(CustAddr_3; CustAddr[3])
            {
            }
            column(CustAddr_4; CustAddr[4])
            {
            }
            column(CustAddr_5; CustAddr[5])
            {
            }
            column(CustAddr_6; CustAddr[6])
            {
            }
            column(CustAddr_7; CustAddr[7])
            {
            }
            column(CustAddr_8; CustAddr[8])
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; Address2)
            {
            }
            column(City; City)
            {
            }
            column(PhoneNo; "Phone No")
            {
            }
            column(FaxNo; "Fax No")
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(LocName; LocName)
            {
            }
            column(Curr; Curr)
            {
            }
            column(AmountWordes; AmountWordes)
            {
            }
            dataitem(DataItem16; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Sell-to Customer No." = FIELD("Sell-to Customer No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(CustomerSerialNo_SalesInvoiceLine; "Customer Serial No")
                {
                }
                column(UnitsperParcel_SalesInvoiceLine; "Units per Parcel")
                {
                }
                column(VATBaseAmount_SalesInvoiceLine; "VAT Base Amount")
                {
                }
                column(LineAmount_SalesInvoiceLine; "Line Amount")
                {
                }
                column(Quantity_SalesInvoiceLine; Quantity)
                {
                }
                column(UnitPrice_SalesInvoiceLine; "Unit Price")
                {
                }
                column(UnitCostLCY_SalesInvoiceLine; "Unit Cost (LCY)")
                {
                }
                column(Amount_SalesInvoiceLine; Amount)
                {
                }
                column(AmountIncludingVAT_SalesInvoiceLine; "Amount Including VAT")
                {
                }
                column(GrossWeight_SalesInvoiceLine; "Gross Weight")
                {
                }
                column(NetWeight_SalesInvoiceLine; "Net Weight")
                {
                }
                column(No_SalesInvoiceLine; "No.")
                {
                }
                column(LocationCode_SalesInvoiceLine; "Location Code")
                {
                }
                column(Description_SalesInvoiceLine; Description)
                {
                }
                column(UnitofMeasure_SalesInvoiceLine; "Unit of Measure")
                {
                }
                column(NetWeight; NetWeight)
                {
                }
                column(SerialNo; "S.no")
                {
                }
                dataitem(DataItem31; "Company Information")
                {
                    column(Name_CompanyInformation; Name)
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
                    Location.RESET;
                    Location.SETRANGE(Code, "Sales Invoice Line"."Location Code");
                    IF Location.FINDFIRST THEN BEGIN
                        LocName := Location.Name;
                        Address := Location.Address;
                        Address2 := Location."Address 2";
                        City := Location.City;
                        "Post Code" := Location."Post Code";
                        "Phone No" := Location."Phone No.";
                        "Fax No" := Location."Fax No.";
                    END;
                    "S.no" += 1;
                    NetWeight += "Sales Invoice Line"."Net Weight" * "Sales Invoice Line".Quantity;
                    LineAmount += ROUND("Sales Invoice Line"."Line Amount");
                    AmountInWordes.InitTextVariables;
                    AmountWordes := AmountInWordes.NumberInWords("Sales Invoice Header"."Amount Including VAT", '', Currcode);
                end;

                trigger OnPreDataItem()
                begin
                    "S.no" := 0;
                    LineAmount := 0;
                    NetWeight := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(FormatAddr);
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                IF "Sales Invoice Header"."Currency Code" <> '' THEN
                    Curr := "Sales Invoice Header"."Currency Code"
                ELSE
                    Curr := 'USD';
                //
                Currency.SETRANGE(Code, Curr);
                IF Currency.FINDFIRST THEN
                    Currcode := Currency."Currency Code"
                ELSE
                    Currcode := 'Cent';
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
        "S.no": Integer;
        FormatAddr: Codeunit "Format Address";
        CustAddr: array[8] of Text[50];
        Location: Record Location;
        Address: Text;
        Address2: Text;
        City: Text;
        "Phone No": Text;
        "Fax No": Text;
        "Post Code": Text;
        Curr: Code[20];
        Currcode: Text[50];
        Currency: Record Currency;
        LocName: Text;
        AmountInWordes: Codeunit "Amount In Words";
        AmountWordes: Text;
        NetWeight: Decimal;
        LineAmount: Decimal;
        "Sales Invoice Header": Record "Sales Invoice Header";
        "Sales Invoice Line": Record "Sales Invoice Line";
}

