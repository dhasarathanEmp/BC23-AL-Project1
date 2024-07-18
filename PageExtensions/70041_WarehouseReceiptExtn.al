pageextension 70041 WarehouseReceiptExtn extends "Warehouse Receipt"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sorting Method")
        {
            field("Vendor Invoice Number"; Rec."Vendor Invoice Number")
            {
                ApplicationArea = All;
            }
            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;
            }
            field("Vendor Invoice Total Quantity"; Rec."Vendor Invoice Total Quantity")
            {
                ApplicationArea = All;
            }
            field("Vendor Invoice Total Amount"; Rec."Vendor Invoice Total Amount")
            {
                ApplicationArea = All;
            }
            field(Validated; Rec.Validated)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify("Post Receipt")
        {
            trigger OnBeforeAction()
            var
                WarehouseReceiptLine2: Record "Warehouse Receipt Line";
                Vendor: Record Vendor;
                WarehouseReceiptLine3: Record "Warehouse Receipt Line";
                WhseRcptLne: Record "Warehouse Receipt Line";
                SourceNo: Code[20];
                PurchHdr: Record "Purchase Header";
                CurrCode: Code[10];
                Bin: Record Bin;
                WarehouseReceiptLine1: Record "Warehouse Receipt Line";
                WarehouseReceiptLine4: Record "Warehouse Receipt Line";
                WarehouseReceiptHeader2: Record "Warehouse Receipt Header";
                PurchaseHeader: Record "Purchase Header";
            begin
                //Cu012

                WarehouseReceiptLine2.RESET;
                WarehouseReceiptLine2.SETRANGE("No.", Rec."No.");
                WarehouseReceiptLine2.SETRANGE("Source Document", WarehouseReceiptLine2."Source Document"::"Purchase Order");
                IF WarehouseReceiptLine2.FINDFIRST THEN BEGIN
                    IF Rec."Vendor Invoice Number" = '' THEN
                        ERROR('Vendor Invoice Number is mandatory to post the Purchase Receipt')
                END;

                CLEAR(Vendor);
                WarehouseReceiptLine3.RESET;
                WarehouseReceiptLine3.SETRANGE("No.", Rec."No.");
                WarehouseReceiptLine3.SETRANGE("Source Document", WarehouseReceiptLine2."Source Document"::"Purchase Order");
                IF WarehouseReceiptLine3.FINDFIRST THEN
                    Vendor.GET(WarehouseReceiptLine3.VendorNo);
                IF Vendor."Whse Receipt Validation" THEN BEGIN
                    IF NOT Rec.Validated THEN
                        ERROR(' Validate before posting');

                    WarehouseReceiptLine2.RESET;
                    WarehouseReceiptLine2.SETRANGE("No.", Rec."No.");
                    WarehouseReceiptLine2.SETRANGE("Source Document", WarehouseReceiptLine2."Source Document"::"Purchase Order");
                    WarehouseReceiptLine2.SETRANGE(Received, FALSE);
                    IF WarehouseReceiptLine2.FINDFIRST THEN
                        ERROR('Remove unreceived lines');

                    WarehouseReceiptLine2.RESET;
                    WarehouseReceiptLine2.SETRANGE("No.", Rec."No.");
                    WarehouseReceiptLine2.SETRANGE("Source Document", WarehouseReceiptLine2."Source Document"::"Purchase Order");
                    WarehouseReceiptLine2.SETRANGE(Received, TRUE);
                    WarehouseReceiptLine2.SETRANGE("Vendor Invoice Qty", 0);
                    IF WarehouseReceiptLine2.FINDFIRST THEN
                        ERROR('Remove lines with zero Vendor Invoice Quantity');
                END;
                //Cu012
                WhseRcptLne.RESET;
                WhseRcptLne.SETRANGE("No.", Rec."No.");
                IF WhseRcptLne.FINDFIRST THEN
                    SourceNo := WhseRcptLne."Source No.";

                PurchHdr.RESET;
                PurchHdr.SETRANGE("No.", SourceNo);
                IF PurchHdr.FINDFIRST THEN BEGIN
                    CurrCode := PurchHdr."Currency Code";
                    IF (CurrCode <> '') AND (CurrCode <> 'USD') THEN BEGIN
                        //ExchangeRateRestriction(CurrCode);
                    END;
                END;
                //AFZ008
                WhseRcptLne.RESET;
                WhseRcptLne.SETRANGE("No.", Rec."No.");
                IF WhseRcptLne.FINDSET THEN
                    REPEAT
                        Bin.RESET;
                        Bin.SETRANGE(Code, WhseRcptLne."Bin Code");
                        Bin.SETRANGE(Discrepancy, TRUE);
                        IF Bin.FINDFIRST THEN BEGIN
                            IF WhseRcptLne.Remarks = WhseRcptLne.Remarks::"None " THEN
                                ERROR('For receiving items to "Discrepancy Bin" reason code must be selected');
                        END ELSE BEGIN
                            Bin.RESET;
                            Bin.SETRANGE(Code, WhseRcptLne."Bin Code");
                            IF Bin.FINDFIRST THEN BEGIN
                                IF WhseRcptLne.Remarks <> WhseRcptLne.Remarks::"None " THEN
                                    ERROR('Reason code "Damage" or "Missing" applicable only for discrepancy bin');
                            END;
                        END;
                    UNTIL WhseRcptLne.NEXT = 0;
                //AFZ008

                //>>EMP108.23
                WarehouseReceiptLine1.RESET;
                WarehouseReceiptLine1.SETRANGE("Source Type", 39);
                WarehouseReceiptLine1.SETRANGE("Source Subtype", 1);
                WarehouseReceiptLine1.SETRANGE("No.", Rec."No.");
                IF WarehouseReceiptLine1.FINDSET THEN
                    REPEAT
                        IF WarehouseReceiptLine1."Bin Code" = '' THEN
                            ERROR('Bin Code does not exist on the Line No is %1', WarehouseReceiptLine1."Line No.");
                    UNTIL WarehouseReceiptLine1.NEXT = 0;
                //<<EMP108.23

                WarehouseReceiptLine4.RESET;
                WarehouseReceiptLine4.SETRANGE("Source Document", WarehouseReceiptLine4."Source Document"::"Purchase Order");
                WarehouseReceiptLine4.SETRANGE("No.", Rec."No.");
                IF WarehouseReceiptLine4.FINDFIRST THEN BEGIN
                    WarehouseReceiptHeader2.RESET;
                    WarehouseReceiptHeader2.SETRANGE("No.", WarehouseReceiptLine4."No.");
                    IF WarehouseReceiptHeader2.FINDFIRST THEN BEGIN
                        PurchaseHeader.RESET;
                        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
                        PurchaseHeader.SETRANGE("No.", WarehouseReceiptLine4."Source No.");
                        IF PurchaseHeader.FINDFIRST THEN BEGIN
                            PurchaseHeader."Vendor Invoice No." := WarehouseReceiptHeader2."Vendor Invoice Number";
                            PurchaseHeader.MODIFY;
                        END;
                    END;
                END;
            end;
        }
        addafter("&Print")
        {
            action("Data Export")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    TempExcelBuf: Record "Excel Buffer";
                    ExFileName: Text;
                begin
                    ExFileName := Rec."No." + '-' + CompanyName;
                    TempExcelBuf.CreateNewBook(ExFileName);
                    FillExcelBuffer1(TempExcelBuf);
                    TempExcelBuf.WriteSheet(Rec."No.", CompanyName(), UserId());
                    TempExcelBuf.CloseBook();
                    TempExcelBuf.SetFriendlyFilename(ExFileName);
                    TempExcelBuf.OpenExcel();
                end;
            }
            action("Data Import")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
            action(Validate)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    WarehouseReceiptLineBuf: Record "Warehouse Receipt Line";
                    WarehouseReceiptLine: Record "Warehouse Receipt Line";
                    WRAmount: Decimal;
                    WRQuantity: Decimal;
                begin
                    //Cu012
                    IF (Rec."Vendor Invoice Total Quantity" = 0) OR (Rec."Vendor Invoice Total Amount" = 0) THEN
                        ERROR('Enter Vendor Invoice total quantity and Vendor Invoice total Amount');
                    WarehouseReceiptLineBuf.RESET;
                    WarehouseReceiptLineBuf.SETRANGE("No.", Rec."No.");
                    IF WarehouseReceiptLineBuf.FINDFIRST THEN BEGIN
                        IF WarehouseReceiptLineBuf."Source Document" = WarehouseReceiptLine."Source Document"::"Purchase Order" THEN BEGIN
                            CLEAR(WRAmount);
                            CLEAR(WRQuantity);
                            WarehouseReceiptLine.RESET;
                            WarehouseReceiptLine.SETRANGE("No.", Rec."No.");
                            WarehouseReceiptLine.SETRANGE(Received, TRUE);
                            IF WarehouseReceiptLine.FINDSET THEN
                                REPEAT
                                    IF WarehouseReceiptLine."Vendor Invoice Qty" < WarehouseReceiptLine."Qty. to Receive" THEN
                                        ERROR('Qty. to Receive greater than Vendor Invoice Quantity for PO Number %1, Serial No %2, Item No. %3', WarehouseReceiptLine."Source No.", WarehouseReceiptLine."Serial No", WarehouseReceiptLine."Item No.");
                                    WRAmount := WRAmount + (WarehouseReceiptLine."Vendor Invoice Qty" * WarehouseReceiptLine."Unit Price");
                                    WRQuantity := WRQuantity + WarehouseReceiptLine."Vendor Invoice Qty";
                                UNTIL WarehouseReceiptLine.NEXT = 0;

                            IF (WRQuantity <> Rec."Vendor Invoice Total Quantity") THEN
                                ERROR('Vendor Invoice Total Quantity and Warehouse Receipt lines Quantity Total are not matched');

                            IF (WRAmount <> Rec."Vendor Invoice Total Amount") THEN
                                ERROR('Vendor Invoice Total Amount and Warehouse Receipt lines Amount Total are not matched');
                        END;
                    END;
                    Rec.Validated := TRUE;
                    Rec.MODIFY;
                    MESSAGE('Validate Successfully');
                    //Cu012
                    Commit();
                    Message('Unreceiveld lines will be deleted');
                    WarehouseReceiptLine.RESET;
                    WarehouseReceiptLine.SetRange("No.", Rec."No.");
                    WarehouseReceiptLine.SetRange(Received, false);
                    if WarehouseReceiptLine.FindSet() then
                        WarehouseReceiptLine.DeleteAll();
                end;
            }
        }
    }
    procedure FillExcelBuffer1(var ExcelBuffer: Record "Excel Buffer")
    var
        WhseRecLine: Record "Warehouse Receipt Line";
    begin
        ExcelBuffer.AddColumn('PO Number', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Internal Line No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PO Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vendor Inv Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty to Receive', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Unit Cost', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Excess', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PO Serial No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Received Status', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Country of Origin', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('HS Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Bin Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        WhseRecLine.Reset();
        WhseRecLine.SetRange("No.", Rec."No.");
        IF WhseRecLine.FindSet() then
            repeat
                ExcelBuffer.NewRow;
                ExcelBuffer.AddColumn(WhseRecLine."Source No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(WhseRecLine."Source Line No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(WhseRecLine."Item No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(WhseRecLine.Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                IF WhseRecLine.Received THEN
                    ExcelBuffer.AddColumn(WhseRecLine."Vendor Invoice Qty", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text)
                ELSE
                    ExcelBuffer.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                IF WhseRecLine.Received THEN
                    ExcelBuffer.AddColumn(WhseRecLine."Qty. to Receive", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text)
                ELSE
                    ExcelBuffer.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(WhseRecLine."Unit Price", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(WhseRecLine.Excess, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(WhseRecLine."Serial No", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                IF WhseRecLine.Received THEN
                    ExcelBuffer.AddColumn('Y', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text)
                ELSE
                    ExcelBuffer.AddColumn('N', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(WhseRecLine."Country/Region Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(WhseRecLine."HS Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(WhseRecLine."Bin Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            until WhseRecLine.NEXT = 0;
    end;

    var
        myInt: Integer;
}