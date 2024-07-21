report 70001 CounterSalesHisToSalesInvoice
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemName; "Sales Header")
        {
            column(No_; "No.")
            {

            }
            trigger OnPostDataItem()
            begin
                ModifySalesInvoiceHeader(DataItemName);
                InsertCounterLinesToInvoice(DataItemName);
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group("Customer&Counter_Details")
                {
                    field("Customer No."; "Customer No.")
                    {
                        ApplicationArea = All;
                        TableRelation = Customer."No.";
                        Importance = Promoted;
                    }
                    field("Counter Document No."; "Counter Document No.")
                    {
                        ApplicationArea = All;
                        TableRelation = "Cancelled CounterSales History"."CashDocument No.";
                        Importance = Promoted;
                        Visible = Counter_Field_Visibility;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            CSHistory: Record "Cancelled CounterSales History";
                        begin
                            CSHistory.Reset();
                            CSHistory.SetRange("CustomerNo.", "Customer No.");
                            CSHistory.SetRange(Cash, true);
                            if CSHistory.FindSet() then begin
                                if Page.RunModal(55002, CSHistory) = Action::LookupOK then begin
                                    Selected_Counter_SalesHistory_DocNo := CSHistory."Document No.";
                                    "Counter Document No." := Selected_Counter_SalesHistory_DocNo;
                                end;
                            end else
                                Error('There is no Counter Sales document were posted for this customer');
                        end;
                    }
                    field("Job Order No"; "Job_Order_No")
                    {
                        Visible = TD_Field_Visibility;
                        Importance = Promoted;
                        ApplicationArea = all;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            TDHistory: Record "Temporary Delivery History";
                            SalesInvoiceLines: Record "Sales Invoice Line";
                            SalesLine: Record "Sales Line";
                        begin
                            TDHistory.CLEARMARKS;
                            TDHistory.RESET;
                            IF TDHistory.FINDSET THEN
                                REPEAT
                                    SalesInvoiceLines.RESET;
                                    SalesInvoiceLines.SETRANGE("Location Code", TDHistory."Location Code");
                                    SalesInvoiceLines.SETRANGE("Document No.1", TDHistory."Job Order No.");
                                    SalesLine.RESET;
                                    SalesLine.SETRANGE("Location Code", TDHistory."Location Code");
                                    SalesLine.SETRANGE("Document No.1", TDHistory."Job Order No.");
                                    IF (SalesInvoiceLines.ISEMPTY) AND (SalesLine.ISEMPTY) THEN
                                        TDHistory.MARK(TRUE);
                                UNTIL TDHistory.NEXT = 0;
                            TDHistory.MARKEDONLY(TRUE);
                            IF PAGE.RUNMODAL(55066, TDHistory) = ACTION::LookupOK THEN
                                Selected_Job_Order_No := TDHistory."Job Order No.";
                            Job_Order_No := Selected_Job_Order_No;
                            //ModifyandInsertInvoiceLinesandHeader_TempDelivery(Selected_Job_Order_No);
                        end;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = Excel;
            LayoutFile = 'mySpreadsheet.xlsx';
        }
    }

    var
        myInt: Integer;
        UserSetup: Record "User Setup";
        "Customer No.": Code[30];
        "Counter Document No.": Code[30];
        Selected_Counter_SalesHistory_DocNo: Code[30];
        Job_Order_No: Code[30];
        Chosen_DocumentType: Integer;
        Counter_Field_Visibility: Boolean;
        TD_Field_Visibility: Boolean;
        Selected_Job_Order_No: Code[30];

    procedure ModifySalesInvoiceHeader(SIH: Record "Sales Header")
    var
        CSHistory1: Record "Cancelled CounterSales History";
        SalesHeader1: Record "Sales Header";
    begin
        CSHistory1.RESET;
        CSHistory1.SETRANGE("Document No.", Selected_Counter_SalesHistory_DocNo);
        CSHistory1.SETRANGE(Status, CSHistory1.Status::Approved);
        CSHistory1.SETRANGE(Contact, CSHistory1."CustomerNo.");
        IF CSHistory1.FINDFIRST THEN BEGIN
            SalesHeader1.RESET;
            SalesHeader1.SETRANGE("No.", SIH."No.");
            SalesHeader1.SETRANGE("Document Type", SIH."Document Type");
            IF SalesHeader1.FINDFIRST THEN BEGIN
                SalesHeader1.VALIDATE("Currency Code", CSHistory1."Currency Code");
                SalesHeader1.VALIDATE("Applies-to Doc. Type", SalesHeader1."Applies-to Doc. Type"::Payment);
                SalesHeader1.VALIDATE("Applies-to Doc. No.", CSHistory1."CashDocument No.");
                SalesHeader1.VALIDATE("VIN No.", CSHistory1."VIN No.");
                SalesHeader1.VALIDATE("Vehicle Model No.", CSHistory1."Vehicle Model No.");
                SalesHeader1.VALIDATE("Vehicle Plate No.", CSHistory1."Vehicle Plate No.");
                SalesHeader1.VALIDATE("Service Item No.", CSHistory1."Service Item No.");
                SalesHeader1.VALIDATE("Service Item Name", CSHistory1."Service Item Name");
                SalesHeader1.VALIDATE("VAT Bus. Posting Group", CSHistory1."VAT Bus");
                SalesHeader1.VALIDATE("CR Document No.", CSHistory1."CashDocument No.");
                SalesHeader1.VALIDATE("CR External Reference No.", CSHistory1."CR External Reference No.");
                SalesHeader1."Document Type." := SalesHeader1."Document Type."::"Counter Sales";
                SalesHeader1.MODIFY;
            END;
        END;
    end;

    procedure InsertCounterLinesToInvoice(SIH: Record "Sales Header")
    var
        CSHistory1: Record "Cancelled CounterSales History";
        CSHistory2: Record "Cancelled CounterSales History";
        SalesHeader1: Record "Sales Header";
        SalesLine1: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        Item: Record Item;
        InvoiceDiscount: Decimal;
        LineNo: Integer;
    begin
        CSHistory1.RESET;
        CSHistory1.SETRANGE("Document No.", Selected_Counter_SalesHistory_DocNo);
        CSHistory1.SETRANGE(Status, CSHistory1.Status::Approved);
        CSHistory1.SETRANGE("CustomerNo.", "Customer No.");
        IF CSHistory1.FINDFIRST THEN
            repeat
                SalesLine1.RESET;
                SalesLine1.SETRANGE("No.", SIH."No.");
                SalesLine1.SETRANGE("Document Type", SIH."Document Type");
                IF SalesLine1.FindLast() THEN
                    LineNo := SalesLine1."Line No.";
                SalesLine2.INIT;
                SalesLine2."Document Type" := SIH."Document Type";
                SalesLine2."Document No." := SIH."No.";
                SalesLine2."Line No." := LineNo + 10000;
                SalesLine2.Type := SalesLine2.Type::Item;
                SalesLine2.VALIDATE(Type, SalesLine2.Type::Item);
                Item.Reset();
                if Item.Get(CSHistory1."Item No.") then begin
                    SalesLine2.VALIDATE("No.", CSHistory1."Item No.");
                    SalesLine2.Description := Item.Description;
                end;
                SalesLine2.Quantity := CSHistory1.Quantity;
                SalesLine2."Qty. to Ship" := CSHistory1.Quantity;
                SalesLine2."Qty. to Invoice" := CSHistory1.Quantity;
                SalesLine2."Unit of Measure Code" := CSHistory1."Unit of Measure Code";
                SalesLine2.VALIDATE("Unit of Measure Code");
                SalesLine2.VALIDATE(Quantity, CSHistory1.Quantity);
                SalesLine2."Location Code" := CSHistory1."Location Code";
                SalesLine2."Bin Code" := CSHistory1."Location Code";
                //SalesLine2."Shortcut Dimension 1 Code" := GetAgencyCode(CSHistory1."Item No.");
                SalesLine2.VALIDATE("Unit Price", CSHistory1."Unit Price");
                SalesLine2."Document No.1" := CSHistory1."Document No.";
                SalesLine2."Sales Type" := SalesLine2."Sales Type"::Sales;
                //SalesLine2."Applied Doc. No." := SH."No.";
                SalesLine2.INSERT;

            UNTIL CSHistory1.NEXT = 0;
        /*CLEAR(InvoiceDiscount);
        CSHistory2.RESET;
        CSHistory2.SETRANGE("Document No.", CSHDocNo);
        CSHistory2.SETRANGE(Status, CSHistory2.Status::Approved);
        IF CSHistory2.FINDSET THEN
            REPEAT
                InvoiceDiscount += CSHistory2.DiscountAmount1;
            UNTIL CSHistory2.NEXT = 0;

        CSHistory2.RESET;
        CSHistory2.SETRANGE("Document No.", CSHDocNo);
        CSHistory2.SETRANGE(Status, CSHistory2.Status::Approved);
        CSHistory2.SETRANGE(Contact, SIH."Sell-to Contact No.");
        IF CSHistory2.FINDFIRST THEN BEGIN
            // SalesSubform.ValidateInvoiceDiscountAmount1(SH, InvoiceDiscount);
        END;*/
    end;

    procedure ModifyandInsertInvoiceLinesandHeader_TempDelivery(JobOrderNumber: code[30]; SalesHeader: Record "Sales Header")
    var
        TemporaryDeliveryHistory: Record "Temporary Delivery History";
        SalesHeader1: Record "Sales Header";
    begin
        // Sales Invoice Header Modify
        TemporaryDeliveryHistory.RESET;
        TemporaryDeliveryHistory.SETRANGE("Job Order No.", JobOrderNumber);
        IF TemporaryDeliveryHistory.FINDFIRST THEN BEGIN
            SalesHeader1.RESET;
            SalesHeader1.SETRANGE("No.", SalesHeader."No.");
            SalesHeader1.SETRANGE("Document Type", SalesHeader."Document Type");
            IF SalesHeader1.FINDFIRST THEN BEGIN
                SalesHeader1.VALIDATE("Applies-to Doc. Type", SalesHeader1."Applies-to Doc. Type"::Payment);
                SalesHeader1.VALIDATE("Service Item No.", TemporaryDeliveryHistory."Service Item No.");
                SalesHeader1.VALIDATE("Service Item Name", TemporaryDeliveryHistory."Service Item Name");
                SalesHeader1."Document Type." := SalesHeader1."Document Type."::"Temporary Delivery";
                SalesHeader1.MODIFY;
            END;
        END;
        // Sales Invioce Header Modification End.

        // Sales Invoice Line Insertion
        /*TemporaryDeliveryHistory.RESET;
        TemporaryDeliveryHistory.SETRANGE("Job Order No.", "DocNo.");
        TemporaryDeliveryHistory.SETFILTER(Quantity, '>=%1', 0);
        IF TemporaryDeliveryHistory.FINDSET THEN
            REPEAT
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", SH."Document Type");
                SalesLine.SETRANGE("Document No.", SH."No.");
                IF SalesLine.ISEMPTY THEN BEGIN
                    SalesLineNew.INIT;
                    SalesLineNew."Document Type" := SH."Document Type";
                    SalesLineNew."Document No." := SH."No.";
                    SalesLineNew."Line No." := 10000;
                    SalesLineNew.Type := SalesLineNew.Type::Item;
                    SalesLineNew.VALIDATE(Type, SalesLineNew.Type::Item);
                    SalesLineNew.VALIDATE("No.", TemporaryDeliveryHistory."Item No.");
                    SalesLineNew.Description := GetItemDescription(TemporaryDeliveryHistory."Item No.");
                    SalesLineNew.Quantity := TemporaryDeliveryHistory.Quantity;
                    SalesLineNew."Qty. to Ship" := TemporaryDeliveryHistory.Quantity;
                    SalesLineNew."Qty. to Invoice" := TemporaryDeliveryHistory.Quantity;
                    SalesLineNew."Unit of Measure Code" := TemporaryDeliveryHistory."Unit of Measure Code";
                    SalesLineNew.VALIDATE("Unit of Measure Code");
                    SalesLineNew.VALIDATE(Quantity, TemporaryDeliveryHistory.Quantity);
                    SalesLineNew."Location Code" := TemporaryDeliveryHistory."Location Code";
                    SalesLineNew."Bin Code" := TemporaryDeliveryHistory."New Bin Code";
                    SalesLineNew."Shortcut Dimension 1 Code" := GetAgencyCode(TemporaryDeliveryHistory."Item No.");
                    SalesLineNew.VALIDATE("Unit Price", TemporaryDeliveryHistory."Unit Price");
                    SalesLineNew."Document No.1" := TemporaryDeliveryHistory."Job Order No.";
                    SalesLineNew."Sales Type" := SalesLineNew."Sales Type"::Sales;
                    SalesLineNew."Applied Doc. No." := SH."No.";
                    SalesLineNew.INSERT;
                END ELSE BEGIN
                    SalesLine1.RESET;
                    SalesLine1.SETRANGE("Document No.1", TemporaryDeliveryHistory."Job Order No.");
                    SalesLine1.SETRANGE("No.", TemporaryDeliveryHistory."Item No.");
                    SalesLine1.SETRANGE("Bin Code", TemporaryDeliveryHistory."New Bin Code");
                    IF SalesLine1.FINDFIRST THEN BEGIN
                        SalesLine1.Quantity := SalesLine1.Quantity + TemporaryDeliveryHistory.Quantity;
                        SalesLine1.VALIDATE(Quantity);
                        SalesLine1."Bin Code" := GetBinCodeTD(TemporaryDeliveryHistory."Location Code");
                        SalesLine1.MODIFY;
                    END ELSE
                        IF SalesLine.FINDLAST THEN BEGIN
                            SalesLineNew.INIT;
                            SalesLineNew."Document Type" := SH."Document Type";
                            SalesLineNew."Document No." := SH."No.";
                            SalesLineNew."Line No." := SalesLine."Line No." + 10000;
                            SalesLineNew.Type := SalesLineNew.Type::Item;
                            SalesLineNew.VALIDATE("No.", TemporaryDeliveryHistory."Item No.");
                            SalesLineNew.Description := GetItemDescription(TemporaryDeliveryHistory."Item No.");
                            SalesLineNew.Quantity := TemporaryDeliveryHistory.Quantity;
                            SalesLineNew."Unit of Measure Code" := TemporaryDeliveryHistory."Unit of Measure Code";
                            SalesLineNew.VALIDATE("Unit of Measure Code");
                            SalesLineNew.VALIDATE(Quantity, TemporaryDeliveryHistory.Quantity);
                            SalesLineNew."Location Code" := TemporaryDeliveryHistory."Location Code";
                            SalesLineNew."Bin Code" := TemporaryDeliveryHistory."New Bin Code";
                            SalesLineNew."Shortcut Dimension 1 Code" := GetAgencyCode(TemporaryDeliveryHistory."Item No.");
                            SalesLineNew.VALIDATE("Unit Price", TemporaryDeliveryHistory."Unit Price");
                            SalesLineNew."Document No.1" := TemporaryDeliveryHistory."Job Order No.";
                            SalesLineNew."Sales Type" := SalesLineNew."Sales Type"::Sales;
                            SalesLineNew."Applied Doc. No." := SH."No.";
                            SalesLineNew.INSERT;
                        END;
                END;
            UNTIL TemporaryDeliveryHistory.NEXT = 0;*/
        // Sales Invoice Line Insertion End.
    end;

    procedure StoreDocumentType(Chosen_DocuType: Integer)
    begin
        Chosen_DocumentType := Chosen_DocumentType;
        if Chosen_DocumentType = 1 then begin
            Counter_Field_Visibility := true;
            TD_Field_Visibility := false;
        end else begin
            TD_Field_Visibility := true;
            Counter_Field_Visibility := false;
        end;
    end;
}