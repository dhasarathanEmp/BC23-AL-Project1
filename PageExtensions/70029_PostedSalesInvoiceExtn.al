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
        addafter(Correct)
        {
            group("Report")
            {
                action("Parts Invoice")
                {
                    Image = Print;

                    trigger OnAction()
                    begin
                        CompanyInfo.RESET;
                        CompanyInfo.SETRANGE(Name, Rec.CurrentCompany);
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
                action("Gate Pass")
                {
                    Image = Report;

                    trigger OnAction()
                    begin
                        SalesShipmentHeader.RESET;
                        SalesShipmentHeader.SETRANGE("Order No.", Rec."Order No.");
                        IF SalesShipmentHeader.FINDFIRST THEN BEGIN
                            IF (SalesShipmentHeader."Vehicle Plate No." = '') OR (SalesShipmentHeader."No. Of Packages" = 0) OR (SalesShipmentHeader."Customer Representative" = '') THEN BEGIN
                                SalesInvoiceHeader.RESET;
                                SalesInvoiceHeader.SETRANGE("No.", Rec."No.");
                                REPORT.RUNMODAL(REPORT::"Gate Pass1", TRUE, TRUE, SalesInvoiceHeader);
                            END ELSE BEGIN
                                SalesInvoiceHeader.RESET;
                                SalesInvoiceHeader.SETRANGE("No.", Rec."No.");
                                REPORT.RUNMODAL(REPORT::"Gate Pass1", TRUE, TRUE, SalesInvoiceHeader);
                            END;
                        END;
                    end;
                }
                action("Temporary Delivery Invoice")
                {
                    Image = Report;

                    trigger OnAction()
                    begin
                        SalesInvoiceHeader.RESET;
                        SalesInvoiceHeader.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(REPORT::"Temporary Delivery Invoice", TRUE, TRUE, SalesInvoiceHeader);
                    end;
                }
                action("Label")
                {
                    Image = Report;

                    trigger OnAction()
                    begin
                        SalesInvoiceHeader.RESET;
                        SalesInvoiceHeader.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(REPORT::"Label Print", TRUE, TRUE, SalesInvoiceHeader);
                    end;
                }
                action("Customer Invoice")
                {
                    Image = Report;

                    trigger OnAction()
                    begin
                        //EP96 Sending Current posted sales invoice document to print parts invoice report
                        SalesInvoiceHeader.RESET;
                        SalesInvoiceHeader.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(Report::"Customer Invoice", TRUE, true, SalesInvoiceHeader);
                        //EP96
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
        SalesShipmentHeader: Record "Sales Shipment Header";

}