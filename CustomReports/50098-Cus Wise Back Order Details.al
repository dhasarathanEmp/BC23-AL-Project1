report 50098 "Cus Wise Back Order Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Cus Wise Back Order Details.rdlc';
    Caption = 'Sales Reservation Avail.';

    dataset
    {
        dataitem(DataItem2844; "Sales Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                WHERE(Type = CONST(Item));
            RequestFilterFields = "Document Type", "Document No.", "No.", "Location Code", "Sell-to Customer No.";
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(StrsubstnoDocTypeDocNo; STRSUBSTNO('%1', "Document No."))
            {
            }
            column(ShowSalesLineGrHeader2; ShowSalesLineGrHeader2)
            {
            }
            column(No_SalesLine; "No.")
            {
                IncludeCaption = true;
            }
            column(Description_SalesLine; Description)
            {
                IncludeCaption = true;
            }
            column(ShpmtDt__SalesLine; FORMAT("Shipment Date"))
            {
            }
            column(Reserve__SalesLine; Reserve)
            {
                IncludeCaption = true;
            }
            column(OutstdngQtyBase_SalesLine; "Outstanding Qty. (Base)")
            {
                IncludeCaption = true;
            }
            column(ResrvdQtyBase_SalesLine; "Reserved Qty. (Base)")
            {
                IncludeCaption = true;
            }
            column(LineStatus; LineStatus)
            {
                OptionCaption = ' ,Shipped,Full Shipment,Partial Shipment,No Shipment';
            }
            column(LineReceiptDate; FORMAT(LineReceiptDate))
            {
            }
            column(LineQuantityOnHand; LineQuantityOnHand)
            {
                DecimalPlaces = 0 : 5;
            }
            column(ShowSalesLineBody; ShowSalesLines)
            {
            }
            column(DocumentReceiptDate; FORMAT(DocumentReceiptDate))
            {
            }
            column(DocumentStatus; DocumentStatus)
            {
                OptionCaption = ' ,Shipped,Full Shipment,Partial Shipment,No Shipment';
            }
            column(ShipmentDt_SalesHeader; FORMAT("Shipment Date"))
            {
            }
            column(Reserve_SalesHeader; STRSUBSTNO('%1', Reserve))
            {
            }
            column(DocType__SalesLine; "Document Type")
            {
            }
            column(DoctNo_SalesLine; "Document No.")
            {
            }
            column(LineNo_SalesLine; "Line No.")
            {
            }
            column(SalesResrvtnAvalbtyCaption; SalesResrvtnAvalbtyCaptionLbl)
            {
            }
            column(CurrRepPageNoCaption; CurrRepPageNoCaptionLbl)
            {
            }
            column(SalesLineShpmtDtCaption; SalesLineShpmtDtCaptionLbl)
            {
            }
            column(LineReceiptDateCaption; LineReceiptDateCaptionLbl)
            {
            }
            column(LineStatusCaption; LineStatusCaptionLbl)
            {
            }
            column(LineQuantityOnHandCaption; LineQuantityOnHandCaptionLbl)
            {
            }
            column(SLUnitPrice; SLUnitPrice)
            {
            }
            column(Quantity_SalesLine; Quantity)
            {
            }
            column(QuantityShipped_SalesLine; "Quantity Shipped")
            {
            }
            column(SelltoCustomerNo_SalesLine; "Sell-to Customer No.")
            {
            }
            column(LocationCode_SalesLine; "Location Code")
            {
            }
            column(ResType; ResType)
            {
            }
            column(GenProdPostingGroup_SalesLine; "Gen. Prod. Posting Group")
            {
            }
            column(QtyperUnitofMeasure_SalesLine; "Qty. per Unit of Measure")
            {
            }
            column(UnitofMeasure_SalesLine; "Unit of Measure")
            {
            }
            column(UnitofMeasureCode_SalesLine; "Unit of Measure Code")
            {
            }
            dataitem(DataItem4003; "Reservation Entry")
            {
                DataItemLink = "Source ID" = FIELD("Document No."),
                               "Source Ref. No." = FIELD("Line No.");
                DataItemTableView = SORTING("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date")
                                    WHERE("Reservation Status" = CONST(Reservation),
                                          "Source Type" = CONST(37),
                                          "Source Batch Name" = CONST(),
                                          "Source Prod. Order Line" = CONST(0));
                column(ReservText; ReservText)
                {
                }
                column(ShowReservDate; FORMAT(ShowReservDate))
                {
                }
                column(Qty_ReservationEntry; Quantity)
                {
                }
                column(EntryQuantityOnHand; EntryQuantityOnHand)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(ShowResEntryBody; ShowReservationEntries)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ResType := '';
                    IF "Source Type" = DATABASE::"Item Ledger Entry" THEN
                        ShowReservDate := 0D
                    ELSE
                        ShowReservDate := "Expected Receipt Date";
                    ReservText := ReservEngineMgt.CreateFromText("Reservation Entry");

                    CpyStr := COPYSTR(ReservText, 1, 3);

                    IF CpyStr = 'Ite' THEN
                        ResType := 'Ledger'
                    ELSE IF CpyStr = 'Tra' THEN
                        ResType := 'Transfer'
                    ELSE IF CpyStr = 'Pur' THEN
                        ResType := 'Purchase'
                    ELSE IF CpyStr = 'Ass' THEN
                        ResType := 'Assembly';

                    IF "Source Type" <> DATABASE::"Item Ledger Entry" THEN BEGIN
                        IF "Expected Receipt Date" > DocumentReceiptDate THEN
                            DocumentReceiptDate := "Expected Receipt Date";
                        EntryQuantityOnHand := 0;
                    END ELSE
                        EntryQuantityOnHand := Quantity;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Source Subtype", "Sales Line"."Document Type");
                end;
            }

            trigger OnAfterGetRecord()
            var
                QtyToReserve: Decimal;
                QtyToReserveBase: Decimal;
            begin
                IF Reserve <> Reserve::Never THEN BEGIN
                    LineReceiptDate := 0D;
                    LineQuantityOnHand := 0;
                    IF "Outstanding Qty. (Base)" = 0 THEN
                        LineStatus := LineStatus::Shipped
                    ELSE BEGIN
                        ReserveSalesLine.ReservQuantity("Sales Line", QtyToReserve, QtyToReserveBase);
                        IF QtyToReserveBase > 0 THEN BEGIN
                            ReservEntry.RESET;
                            ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry, TRUE);
                            //ReserveSalesLine.FilterReservFor(ReservEntry, "Sales Line");
                            IF ReservEntry.FINDSET THEN
                                REPEAT
                                    ReservEntryFrom.RESET;
                                    ReservEntryFrom.GET(ReservEntry."Entry No.", NOT ReservEntry.Positive);
                                    IF ReservEntryFrom."Source Type" = DATABASE::"Item Ledger Entry" THEN
                                        LineQuantityOnHand := LineQuantityOnHand + ReservEntryFrom.Quantity;
                                UNTIL ReservEntry.NEXT = 0;
                            CALCFIELDS("Reserved Qty. (Base)");
                            IF ("Outstanding Qty. (Base)" = LineQuantityOnHand) AND ("Outstanding Qty. (Base)" <> 0) THEN
                                LineStatus := LineStatus::"Full Shipment"
                            ELSE
                                IF LineQuantityOnHand = 0 THEN
                                    LineStatus := LineStatus::"No Shipment"
                                ELSE
                                    LineStatus := LineStatus::"Partial Shipment"
                        END ELSE
                            LineStatus := LineStatus::"Full Shipment";
                    END;
                END ELSE BEGIN
                    LineReceiptDate := 0D;
                    ReserveSalesLine.ReservQuantity("Sales Line", QtyToReserve, QtyToReserveBase);
                    LineQuantityOnHand := QtyToReserveBase;
                    IF "Outstanding Qty. (Base)" = 0 THEN
                        LineStatus := LineStatus::Shipped
                    ELSE
                        LineStatus := LineStatus::"Full Shipment";
                END;

                IF ModifyQtyToShip AND ("Document Type" = "Document Type"::Order) AND
                   ("Qty. to Ship (Base)" <> LineQuantityOnHand)
                THEN BEGIN
                    IF "Qty. per Unit of Measure" = 0 THEN
                        "Qty. per Unit of Measure" := 1;
                    VALIDATE("Qty. to Ship",
                      ROUND(LineQuantityOnHand / "Qty. per Unit of Measure", 0.00001));
                    MODIFY;
                    OnAfterSalesLineModify("Sales Line");
                END;

                IF ClearDocumentStatus THEN BEGIN
                    DocumentReceiptDate := 0D;
                    DocumentStatus := DocumentStatus::" ";
                    ClearDocumentStatus := FALSE;
                    SalesHeader.GET("Document Type", "Document No.");
                END;

                IF LineReceiptDate > DocumentReceiptDate THEN
                    DocumentReceiptDate := LineReceiptDate;

                CASE DocumentStatus OF
                    DocumentStatus::" ":
                        DocumentStatus := LineStatus;
                    DocumentStatus::Shipped:
                        CASE LineStatus OF
                            LineStatus::Shipped:
                                DocumentStatus := DocumentStatus::Shipped;
                            LineStatus::"Full Shipment",
                          LineStatus::"Partial Shipment":
                                DocumentStatus := DocumentStatus::"Partial Shipment";
                            LineStatus::"No Shipment":
                                DocumentStatus := DocumentStatus::"No Shipment";
                        END;
                    DocumentStatus::"Full Shipment":
                        CASE LineStatus OF
                            LineStatus::Shipped,
                          LineStatus::"Full Shipment":
                                DocumentStatus := DocumentStatus::"Full Shipment";
                            LineStatus::"Partial Shipment",
                          LineStatus::"No Shipment":
                                DocumentStatus := DocumentStatus::"Partial Shipment";
                        END;
                    DocumentStatus::"Partial Shipment":
                        DocumentStatus := DocumentStatus::"Partial Shipment";
                    DocumentStatus::"No Shipment":
                        CASE LineStatus OF
                            LineStatus::Shipped,
                          LineStatus::"No Shipment":
                                DocumentStatus := DocumentStatus::"No Shipment";
                            LineStatus::"Full Shipment",
                          LineStatus::"Partial Shipment":
                                DocumentStatus := DocumentStatus::"Partial Shipment";
                        END;
                END;

                ShowSalesLineGrHeader2 := FALSE;
                IF ((OldDocumentType <> "Document Type") OR
                    (OldDocumentNo <> "Document No."))
                THEN
                    IF ShowSalesLines THEN
                        ShowSalesLineGrHeader2 := TRUE;

                OldDocumentNo := "Document No.";
                OldDocumentType := "Document Type";

                TempSalesLines := "Sales Line";
                ClearDocumentStatus := TRUE;

                IF TempSalesLines.NEXT <> 0 THEN
                    ClearDocumentStatus := (TempSalesLines."Document No." <> OldDocumentNo) OR (TempSalesLines."Document Type" <> OldDocumentType);

                SLUnitPrice := 0;
                IF "Sales Line"."Inv. Discount Amount" <> 0 THEN
                    SLUnitPrice := "Sales Line"."Unit Price" - ("Sales Line"."Inv. Discount Amount" / "Sales Line".Quantity)
                ELSE
                    SLUnitPrice := "Sales Line"."Unit Price";
            end;

            trigger OnPreDataItem()
            begin
                ClearDocumentStatus := TRUE;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowSalesLines; ShowSalesLines)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Show Sales Lines';
                        ToolTip = 'Specifies if you want the report to include a line for each sales line. If you do not place a check mark in the check box, the report will include one line for each document.';

                        trigger OnValidate()
                        begin
                            IF NOT ShowSalesLines THEN
                                ShowReservationEntries := FALSE;
                        end;
                    }
                    field(ShowReservationEntries; ShowReservationEntries)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Show Reservation Entries';
                        ToolTip = 'Specifies if you want the report to include reservation entries. The reservation entry will be printed below the line for which the items have been reserved. You can only use this option if you have also placed a check mark in the Show Sales Lines check box.';

                        trigger OnValidate()
                        begin
                            IF ShowReservationEntries AND NOT ShowSalesLines THEN
                                ERROR(Text000);
                        end;
                    }
                    field(ModifyQuantityToShip; ModifyQtyToShip)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Modify Qty. to Ship in Order Lines';
                        MultiLine = true;
                        ToolTip = 'Specifies if you want the program to enter the quantity that is available for shipment in the Qty. to Ship field on the sales lines.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            ShowSalesLines := TRUE;
        end;
    }

    labels
    {
    }

    var
        Text000: Label 'Sales lines must be shown.';
        SalesHeader: Record "Sales Header";
        ReservEntry: Record "Reservation Entry";
        ReservEntryFrom: Record "Reservation Entry";
        TempSalesLines: Record "Sales Line";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        OldDocumentNo: Code[20];
        OldDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        ShowSalesLineGrHeader2: Boolean;
        ShowSalesLines: Boolean;
        ShowReservationEntries: Boolean;
        ModifyQtyToShip: Boolean;
        ClearDocumentStatus: Boolean;
        ReservText: Text[80];
        ShowReservDate: Date;
        LineReceiptDate: Date;
        DocumentReceiptDate: Date;
        LineStatus: Option " ",Shipped,"Full Shipment","Partial Shipment","No Shipment";
        DocumentStatus: Option " ",Shipped,"Full Shipment","Partial Shipment","No Shipment";
        LineQuantityOnHand: Decimal;
        EntryQuantityOnHand: Decimal;
        SalesResrvtnAvalbtyCaptionLbl: Label 'Sales Reservation Availability';
        CurrRepPageNoCaptionLbl: Label 'Page';
        SalesLineShpmtDtCaptionLbl: Label 'Shipment Date';
        LineReceiptDateCaptionLbl: Label 'Expected Receipt Date';
        LineStatusCaptionLbl: Label 'Shipment Status';
        LineQuantityOnHandCaptionLbl: Label 'Quantity on Hand (Base)';
        SLUnitPrice: Decimal;
        CpyStr: Text;
        ResType: Text;
        "Sales Line": Record "Sales Line";
        "Reservation Entry": Record "Reservation Entry";

    procedure InitializeRequest(NewShowSalesLines: Boolean; NewShowReservationEntries: Boolean; NewModifyQtyToShip: Boolean)
    begin
        ShowSalesLines := NewShowSalesLines;
        ShowReservationEntries := NewShowReservationEntries;
        ModifyQtyToShip := NewModifyQtyToShip;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSalesLineModify(var SalesLine: Record "Sales Line")
    begin
    end;
}

