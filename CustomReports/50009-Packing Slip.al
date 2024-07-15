report 50009 "Packing Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Packing Slip.rdlc';

    dataset
    {
        dataitem(DataItem1;Table112)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "No.";
            column(ExternalDocumentNo_SalesInvoiceHeader;"Sales Invoice Header"."External Document No.")
            {
            }
            column(OrderDate_SalesInvoiceHeader;"Sales Invoice Header"."Order Date")
            {
            }
            column(PostingDate_SalesInvoiceHeader;"Sales Invoice Header"."Posting Date")
            {
            }
            column(No_SalesInvoiceHeader;"Sales Invoice Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Name")
            {
            }
            column(BilltoName2_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Name 2")
            {
            }
            column(BilltoAddress_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to City")
            {
            }
            column(BilltoContact_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Contact")
            {
            }
            column(YourReference_SalesInvoiceHeader;"Sales Invoice Header"."Your Reference")
            {
            }
            column(BilltoPostCode_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Post Code")
            {
            }
            column(BilltoCounty_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to County")
            {
            }
            column(BilltoCountryRegionCode_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Country/Region Code")
            {
            }
            column(CustAddr_1;CustAddr[1])
            {
            }
            column(CustAddr_2;CustAddr[2])
            {
            }
            column(CustAddr_3;CustAddr[3])
            {
            }
            column(CustAddr_4;CustAddr[4])
            {
            }
            column(CustAddr_5;CustAddr[5])
            {
            }
            column(CustAddr_6;CustAddr[6])
            {
            }
            column(CustAddr_7;CustAddr[7])
            {
            }
            column(CustAddr_8;CustAddr[8])
            {
            }
            column(Address;Address)
            {
            }
            column(Address2;Address2)
            {
            }
            column(City;City)
            {
            }
            column(PhoneNo;"Phone No")
            {
            }
            column(FaxNo;"Fax No")
            {
            }
            column(PostCode;"Post Code")
            {
            }
            column(LocName;LocName)
            {
            }
            column(Curr;Curr)
            {
            }
            column(AmountWordes;AmountWordes)
            {
            }
            dataitem(DataItem16;Table113)
            {
                DataItemLink = Document No.=FIELD(No.),
                               Sell-to Customer No.=FIELD(Sell-to Customer No.);
                DataItemTableView = SORTING(Document No.,Line No.);
                column(CustomerSerialNo_SalesInvoiceLine;"Sales Invoice Line"."Customer Serial No")
                {
                }
                column(DocumentNo_SalesInvoiceLine;"Sales Invoice Line"."Document No.")
                {
                }
                column(SapNo_SalesInvoiceLine;"Sales Invoice Line"."Sap No")
                {
                }
                column(CrossReferenceNo_SalesInvoiceLine;"Sales Invoice Line"."Cross-Reference No.")
                {
                }
                column(UnitsperParcel_SalesInvoiceLine;"Sales Invoice Line"."Units per Parcel")
                {
                }
                column(VATBaseAmount_SalesInvoiceLine;"Sales Invoice Line"."VAT Base Amount")
                {
                }
                column(LineAmount_SalesInvoiceLine;"Sales Invoice Line"."Line Amount")
                {
                }
                column(Quantity_SalesInvoiceLine;"Sales Invoice Line".Quantity)
                {
                }
                column(UnitPrice_SalesInvoiceLine;"Sales Invoice Line"."Unit Price")
                {
                }
                column(UnitCostLCY_SalesInvoiceLine;"Sales Invoice Line"."Unit Cost (LCY)")
                {
                }
                column(Amount_SalesInvoiceLine;"Sales Invoice Line".Amount)
                {
                }
                column(AmountIncludingVAT_SalesInvoiceLine;"Sales Invoice Line"."Amount Including VAT")
                {
                }
                column(GrossWeight_SalesInvoiceLine;"Sales Invoice Line"."Gross Weight")
                {
                }
                column(NetWeight_SalesInvoiceLine;"Sales Invoice Line"."Net Weight")
                {
                }
                column(No_SalesInvoiceLine;"Sales Invoice Line"."No.")
                {
                }
                column(LocationCode_SalesInvoiceLine;"Sales Invoice Line"."Location Code")
                {
                }
                column(Description_SalesInvoiceLine;"Sales Invoice Line".Description)
                {
                }
                column(UnitofMeasure_SalesInvoiceLine;"Sales Invoice Line"."Unit of Measure")
                {
                }
                column(NetWeight;NetWeight1)
                {
                }
                column(CaseNo;CaseNo)
                {
                }
                column(Qty;"Qty.1")
                {
                }
                column(NetWeight2;NetWeight2)
                {
                }
                dataitem(DataItem31;Table79)
                {
                    column(Name_CompanyInformation;"Company Information".Name)
                    {
                    }
                    column(Address_CompanyInformation;"Company Information".Address)
                    {
                    }
                    column(Address2_CompanyInformation;"Company Information"."Address 2")
                    {
                    }
                    column(City_CompanyInformation;"Company Information".City)
                    {
                    }
                    column(PhoneNo_CompanyInformation;"Company Information"."Phone No.")
                    {
                    }
                    column(FaxNo_CompanyInformation;"Company Information"."Fax No.")
                    {
                    }
                    column(VATRegistrationNo_CompanyInformation;"Company Information"."VAT Registration No.")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    Location.RESET;
                    Location.SETRANGE(Code,"Sales Invoice Line"."Location Code");
                    IF Location.FINDFIRST THEN BEGIN
                      LocName := Location.Name;
                      Address := Location.Address;
                      Address2 := Location."Address 2";
                      City := Location.City;
                      "Post Code" := Location."Post Code";
                      "Phone No" := Location."Phone No.";
                      "Fax No" := Location."Fax No.";
                    END;
                    NetWeight += "Sales Invoice Line"."Net Weight" * "Sales Invoice Line".Quantity;
                    NetWeight2 += "Sales Invoice Line"."Net Weight" * "Sales Invoice Line".Quantity;
                    LineAmount +=ROUND("Sales Invoice Line"."Line Amount");
                    AmountInWordes.InitTextVariables;
                    AmountWordes :=AmountInWordes.NumberInWords(LineAmount,'',Currcode);

                    PostedWhseShipmentLine.RESET;
                    PostedWhseShipmentLine.SETRANGE("Source No.","Sales Invoice Header"."Order No.");
                    PostedWhseShipmentLine.SETRANGE("Item No.","Sales Invoice Line"."No.");
                    PostedWhseShipmentLine.SETRANGE("Line No.","Sales Invoice Line"."Line No.");
                    IF PostedWhseShipmentLine.FINDFIRST THEN
                        CaseNo := PostedWhseShipmentLine."Case No";

                    CLEAR("Qty.");
                    NetWeight1:='';
                    "Qty.1":='';
                    PostedWhseShipmentLine1.RESET;
                    PostedWhseShipmentLine1.SETRANGE("Case No",CaseNo);
                    IF PostedWhseShipmentLine1.FINDLAST THEN
                      IF (PostedWhseShipmentLine1."Item No." ="Sales Invoice Line"."No.") AND (PostedWhseShipmentLine1."Source Line No." = "Sales Invoice Line"."Line No.")THEN BEGIN
                        PostedWhseShipmentLine2.RESET;
                        PostedWhseShipmentLine2.SETRANGE("No.",PostedWhseShipmentLine."No.");
                        PostedWhseShipmentLine2.SETRANGE("Case No",CaseNo);
                        IF PostedWhseShipmentLine2.FINDSET THEN REPEAT
                          "Qty." +=(PostedWhseShipmentLine2."Qty. (Base)");
                          NetWeight1 := FORMAT(NetWeight);
                          "Qty.1":= FORMAT("Qty.");
                        UNTIL PostedWhseShipmentLine2.NEXT=0;
                        CLEAR(NetWeight);
                      END;
                end;

                trigger OnPreDataItem()
                begin
                    LineAmount := 0;
                    NetWeight2 := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(FormatAddr);
                FormatAddr.SalesInvBillTo(CustAddr,"Sales Invoice Header");
                IF "Sales Invoice Header"."Currency Code"<>'' THEN
                  Curr  := "Sales Invoice Header"."Currency Code"
                ELSE
                 Curr :=  'USD';
                //
                Currency.SETRANGE(Code,Curr);
                IF Currency.FINDFIRST THEN
                  Currcode  :=  Currency."Currency Code"
                ELSE
                  Currcode :=  'Cent';
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
        FormatAddr: Codeunit "365";
        CustAddr: array [8] of Text[50];
        Location: Record "14";
        Address: Text;
        Address2: Text;
        City: Text;
        "Phone No": Text;
        "Fax No": Text;
        "Post Code": Text;
        Curr: Code[20];
        Currcode: Text[50];
        Currency: Record "4";
        LocName: Text;
        AmountInWordes: Codeunit "50003";
        AmountWordes: Text;
        NetWeight: Decimal;
        LineAmount: Decimal;
        PostedWhseShipmentLine: Record "7323";
        CaseNo: Integer;
        PostedWhseShipmentLine1: Record "7323";
        PostedWhseShipmentLine2: Record "7323";
        "Qty.": Decimal;
        SalesInvoiceLine: Record "113";
        NetWeight1: Text;
        "Qty.1": Text;
        NetWeight2: Decimal;
}

