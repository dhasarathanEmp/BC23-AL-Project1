report 50071 "Gate Pass1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Gate Pass1.rdlc';
    Caption = 'Gate Pass';

    dataset
    {
        dataitem(DataItem1; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(PostingDate_SalesInvoiceHeader; "Posting Date")
            {
            }
            column(BilltoName_SalesInvoiceHeader; "Bill-to Name")
            {
            }
            column(PreAssignedNo_SalesInvoiceHeader; "Pre-Assigned No.")
            {
            }
            column(No_SalesInvoiceHeader; "No.")
            {
            }
            column(ModalNo; "ModalNo.")
            {
            }
            column(LocationCode_SalesInvoiceHeader; "Location Code")
            {
            }
            column(AppliestoDocNo_SalesInvoiceHeader; "Applies-to Doc. No.")
            {
            }
            column(Pakages; Pakages)
            {
            }
            column(CustomerRepresentative; "Customer Representative1")
            {
            }
            column(ContactName; ContactName)
            {
            }
            column(CrjNo; CrjNo)
            {
            }
            column(Name; Name)
            {
            }
            column(GatePass; GatePass)
            {
            }
            column(Address2; Address2)
            {
            }
            column(Address; Address)
            {
            }
            column(City; City)
            {
            }
            column(PhoneNo; PhoneNo)
            {
            }
            column(FaxNo; FaxNo)
            {
            }
            column(County; County)
            {
            }
            column(TRNo; TRNo)
            {
            }
            column(CountryRegion; CountryRegion1)
            {
            }
            dataitem(DataItem4; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(LocationCode_SalesInvoiceLine; "Location Code")
                {
                }
                column(PostingDate_SalesInvoiceLine; "Posting Date")
                {
                }
                column(DocumentNo_SalesInvoiceLine; "Document No.")
                {
                }
                column(DocumentNo1_SalesInvoiceLine; "Document No.1")
                {
                }
                column(Lable; Lable)
                {
                }
                column(OrderNo; OrderNo)
                {
                }
                column(OrderNo1; OrderNo1)
                {
                }
                column(No; "No.")
                {
                }
                column(Date; Date)
                {
                }
                dataitem(DataItem14; "Company Information")
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
                    IF "Sales Invoice Line"."Document No.1" = '' THEN BEGIN
                        SalesShipmentHeader.RESET;
                        SalesShipmentHeader.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
                        IF SalesShipmentHeader.FINDFIRST THEN BEGIN
                            "No." := SalesShipmentHeader."No.";
                            Date := SalesShipmentHeader."Posting Date";
                        END;
                        OrderNo1 := "Sales Invoice Line"."Document No.";
                    END ELSE BEGIN
                        SalesShipmentLine.RESET;
                        SalesShipmentLine.SETRANGE("Document No.1", "Sales Invoice Line"."Document No.1");
                        IF SalesShipmentLine.FINDFIRST THEN BEGIN
                            "No." := SalesShipmentLine."Document No.";
                            Date := SalesShipmentLine."Posting Date";
                            GatePass := SalesShipmentLine."Gate Pass No.";
                        END;
                        OrderNo1 := "Sales Invoice Header"."Pre-Assigned No.";
                    END;
                    //
                    Location.RESET;
                    Location.SETRANGE(Code, "Sales Invoice Line"."Location Code");
                    IF Location.FINDFIRST THEN BEGIN
                        Name := Location.Name;
                        Address := DELCHR(Location.Address, '<>', ' ');
                        Address2 := Location."Address 2";
                        City := Location.City;
                        County := Location.County;
                        PhoneNo := Location."Phone No.";
                        FaxNo := Location."Fax No.";
                        TRNo := Location."Name 2";
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Contact.RESET;
                Contact.SETRANGE("No.", "Sales Invoice Header"."Bill-to Contact No.");
                IF Contact.FINDFIRST THEN
                    ContactName := Contact.Name;
                //
                Company.RESET;
                IF Company.GET(COMPANYNAME) THEN
                    Compname := COMPANYNAME;
                SalesShipmentHeader.RESET;
                SalesShipmentHeader.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
                IF SalesShipmentHeader.FINDFIRST THEN BEGIN
                    IF (SalesShipmentHeader."Customer Representative" = '') OR (SalesShipmentHeader."No. Of Packages" = 0) OR (SalesShipmentHeader."Vehicle Plate No." = '') THEN BEGIN
                        "ModalNo." := "Vehicle Platel  No.";
                        Pakages := "No. of Pakages";
                        "Customer Representative1" := CustomerRepresentative;
                        SalesShipmentLine.RESET;
                        SalesShipmentLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
                        IF SalesShipmentLine.FINDFIRST THEN
                            GatePass := SalesShipmentLine."Gate Pass No.";
                    END;
                END;
                SalesShipmentHeader.RESET;
                SalesShipmentHeader.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
                IF SalesShipmentHeader.FINDFIRST THEN BEGIN
                    SalesShipmentHeader."Vehicle Plate No." := "Vehicle Platel  No.";
                    SalesShipmentHeader."No. Of Packages" := "No. of Pakages";
                    SalesShipmentHeader."Customer Representative" := CustomerRepresentative;
                    SalesShipmentHeader.MODIFY;
                END;
                CountryRegion.RESET;
                CountryRegion.SETRANGE(Code, "Sales Invoice Header"."Sell-to Country/Region Code");
                IF CountryRegion.FINDFIRST THEN
                    CountryRegion1 := CountryRegion.Name;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Vehicle Platel  No."; "Vehicle Platel  No.")
                {
                    Caption = 'Vehicle Platel  No.';
                }
                field("No. of Pakages"; "No. of Pakages")
                {
                    Caption = 'No. of Pakages';
                }
                field(CustomerRepresentative; CustomerRepresentative)
                {
                    Caption = 'Customer Representative';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CancelledCounterSalesHistory: Record "Cancelled CounterSales History";
        CashDocNo: Code[20];
        "Vehicle Platel  No.": Code[20];
        "No. of Pakages": Integer;
        "ModalNo.": Code[20];
        Pakages: Integer;
        CustomerRepresentative: Text;
        "Customer Representative1": Text;
        Contact: Record Contact;
        ContactName: Text;
        Company: Record Company;
        Compname: Text;
        Lable: Text;
        OrderNo: Code[20];
        OrderNo1: Code[20];
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        "No.": Code[20];
        Date: Date;
        CrjNo: Code[20];
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Location: Record Location;
        Name: Text;
        GatePass: Code[20];
        Address: Text;
        Address2: Text;
        City: Text;
        PhoneNo: Text;
        FaxNo: Text;
        County: Text;
        TRNo: Text;
        CountryRegion: Record "Country/Region";
        CountryRegion1: Text;
        DocumentNo: Code[20];
        FieldVisible: Boolean;
        "Sales Invoice Header": Record "Sales Invoice Header";
        "Sales Invoice Line": Record "Sales Invoice Line";
}

