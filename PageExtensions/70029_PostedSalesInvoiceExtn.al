pageextension 70029 PostedSalesInvoiceExtn extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Your Reference")
        {
            field("Price Validate"; Rec."Price Validate")
            {

            }
            field("Delivery Terms"; Rec."Delivery Terms")
            {

            }
        }
    }

    actions
    {
        addafter(CreateCreditMemo)
        {
            group("Report")
            {
                action("Parts Invoice")
                {
                    Image = Print;

                    trigger OnAction()
                    begin
                        CompanyInfo.RESET;
                        CompanyInfo.SETRANGE(Name, CURRENTCOMPANY);
                        CompanyInfo.SETRANGE(AFZ, TRUE);
                        IF CompanyInfo.FINDFIRST THEN BEGIN
                            SalesInvoiceHeader.RESET;
                            SalesInvoiceHeader.SETRANGE("No.", Rec."No.");
                            REPORT.RUNMODAL(REPORT::"Parts Invoice_AFZ", TRUE, TRUE, SalesInvoiceHeader);
                        END ELSE BEGIN
                            SalesInvoiceHeader.RESET;
                            SalesInvoiceHeader.SETRANGE("No.", Rec."No.");
                            IF (Rec."Document Type." = Rec."Document Type."::Credit) OR (Rec."Document Type." = Rec."Document Type."::Prepayment) THEN BEGIN
                                //Cu110
                                CLEAR(PartsInvoice);
                                PartsInvoice.SETTABLEVIEW(SalesInvoiceHeader);
                                Temp := PartsInvoice.RUNREQUESTPAGE;
                                IF PartsInvoice.ReturnOutOp = 1 THEN BEGIN
                                    PrinterName := PartsInvoice.ReturnPrinter;
                                    REPORT.PRINT(50054, Temp, PrinterName);
                                END ELSE
                                    REPORT.EXECUTE(50054, Temp);
                                //Cu110
                            END ELSE
                                IF Rec."Document Type." = Rec."Document Type."::"Counter Sales" THEN
                                    REPORT.RUNMODAL(REPORT::"Cash Invoice- Parts", TRUE, TRUE, SalesInvoiceHeader)
                                ELSE
                                    IF Rec."Document Type." = Rec."Document Type."::"Temporary Delivery" THEN
                                        REPORT.RUNMODAL(REPORT::"Temporary Delivery Invoice", TRUE, TRUE, SalesInvoiceHeader);
                        END

                    end;
                }
            }
        }
    }

    var
        CompanyInfo: Record "Company Information";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PartsInvoice: Report "Parts Invoice";
        Temp: Text;
        PrinterName: Text;

}