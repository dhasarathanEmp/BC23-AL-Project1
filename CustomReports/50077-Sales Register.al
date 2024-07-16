report 50077 "Sales Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Sales Register.rdlc';
    Caption = 'Sales Register';

    dataset
    {
        dataitem(DataItem1; "VAT Entry")
        {
            DataItemTableView = WHERE("No. Series" = FILTER(<> 'S-PPSI'));
            RequestFilterFields = "Document No.", "Gen. Bus. Posting Group", Type;
            column(DocumentType_VATEntry; "Document Type")
            {
            }
            column(BilltoPaytoNo_VATEntry; "Bill-to/Pay-to No.")
            {
            }
            column(Amount_VATEntry; Amount)
            {
            }
            column(Base_VATEntry; Base)
            {
            }
            column(DocumentNo_VATEntry; "Document No.")
            {
            }
            column(PostingDate_VATEntry; "Posting Date")
            {
            }
            column(GenBusPostingGroup_VATEntry; "Gen. Bus. Posting Group")
            {
            }
            column(GenProdPostingGroup_VATEntry; "Gen. Prod. Posting Group")
            {
            }
            column(Type_VATEntry; Type)
            {
            }
            column(FromDate; FromDate)
            {
            }
            column(ToDate; ToDate)
            {
            }
            column(Location; Location)
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            column(InvoiceAmount; InvoiceAmount)
            {
            }
            column(VATAmount; VATAmount)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(Month; Month)
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
            }

            trigger OnAfterGetRecord()
            begin
                Customer.RESET;
                Customer.SETRANGE("No.", "VAT Entry"."Bill-to/Pay-to No.");
                IF Customer.FINDFIRST THEN
                    CustomerName := Customer.Name;

                IF "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::Invoice THEN BEGIN
                    IF "VAT Entry".Base < 0 THEN BEGIN
                        InvoiceAmount := ABS("VAT Entry".Base);
                        VATAmount := ABS("VAT Entry".Amount);
                        TotalAmount := InvoiceAmount + VATAmount;
                    END ELSE BEGIN
                        InvoiceAmount := 0;
                        VATAmount := 0;
                        TotalAmount := 0;
                    END;
                END;

                IF "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::"Credit Memo" THEN BEGIN
                    InvoiceAmount := -ABS("VAT Entry".Base);
                    VATAmount := -ABS("VAT Entry".Amount);
                    TotalAmount := InvoiceAmount + VATAmount;

                END;
                Month := DATE2DMY("VAT Entry"."Posting Date", 2);
            end;

            trigger OnPreDataItem()
            begin

                IF ToDate = 0D THEN BEGIN
                    ToDate := WORKDATE;
                END;
                FromDate := FromDate;
                ToDate := ToDate;
                "VAT Entry".SETRANGE("Posting Date", FromDate, ToDate);
                "VAT Entry".SETRANGE(Type, "VAT Entry".Type::Sale);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Date)
                {
                    field("From Date"; FromDate)
                    {

                        trigger OnValidate()
                        begin
                            FromDate := FromDate;
                        end;
                    }
                    field("To Date"; ToDate)
                    {

                        trigger OnValidate()
                        begin
                            ToDate := ToDate;
                        end;
                    }
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

    trigger OnPreReport()
    begin
        FromDate := FromDate;
        ToDate := ToDate;
        Location := Location;
    end;

    var
        FromDate: Date;
        ToDate: Date;
        Location: Code[10];
        Customer: Record Customer;
        CustomerName: Text[50];
        InvoiceAmount: Decimal;
        VATAmount: Decimal;
        TotalAmount: Decimal;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Month: Integer;
        "VAT Entry": Record "VAT Entry";
}

