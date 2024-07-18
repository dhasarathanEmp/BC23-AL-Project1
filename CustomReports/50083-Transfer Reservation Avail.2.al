report 50083 "Transfer Reservation Avail.2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Transfer Reservation Avail.2.rdlc';
    Caption = 'Transfer Reservation Avail.';

    dataset
    {
        dataitem(DataItem2844; "Transfer Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.");
            RequestFilterFields = "Document No.", "Item No.";
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(DocumentNo_TransferLine; "Document No.")
            {
            }
            column(ShowSalesLineGrHeader2; ShowSalesLineGrHeader2)
            {
            }
            column(ItemNo_TransferLine; "Item No.")
            {
                IncludeCaption = true;
            }
            column(Description_TransferLine; Description)
            {
            }
            column(ShpmtDt__TransferLine; FORMAT("Shipment Date"))
            {
            }
            column(OutstandingQtyBase_TransferLine; "Outstanding Qty. (Base)")
            {
            }
            column(ReservedQtyOutbndBase_TransferLine; "Reserved Qty. Outbnd. (Base)")
            {
            }
            column(TransferfromCode_TransferLine; "Transfer-from Code")
            {
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
            column(DoctNo_SalesLine; "Document No.")
            {
            }
            column(LineNo_TransferLine; "Line No.")
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
            column(UnReservedFreeStock; UnReservedFreeStock)
            {
            }
            dataitem(DataItem4003; "Reservation Entry")
            {
                DataItemLink = "Source ID" = FIELD("Document No."),
                               "Source Ref. No." = FIELD("Line No.");
                DataItemTableView = SORTING("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date")
                                    WHERE("Reservation Status" = CONST(Reservation),
                                          "Source Type" = CONST(5741),
                                          "Source Batch Name" = CONST(),
                                          "Source Prod. Order Line" = CONST(0),
                                          "Source Subtype" = CONST(0));
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
                    IF "Source Type" = DATABASE::"Item Ledger Entry" THEN
                        ShowReservDate := 0D
                    ELSE
                        ShowReservDate := "Expected Receipt Date";
                    ReservText := ReservEngineMgt.CreateFromText("Reservation Entry");

                    IF "Source Type" <> DATABASE::"Item Ledger Entry" THEN BEGIN
                        IF "Expected Receipt Date" > DocumentReceiptDate THEN
                            DocumentReceiptDate := "Expected Receipt Date";
                        EntryQuantityOnHand := 0;
                    END ELSE
                        EntryQuantityOnHand := Quantity;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Source Subtype", 0);
                end;
            }

            trigger OnAfterGetRecord()
            var
                QtyToReserve: Decimal;
                QtyToReserveBase: Decimal;
            begin
                //IF Reserve <> Reserve::Never THEN BEGIN
                Location.GET("Transfer Line"."Transfer-from Code");
                IF Location."Use As In-Transit" = TRUE THEN
                    CurrReport.SKIP;
                LineReceiptDate := 0D;
                LineQuantityOnHand := 0;
                IF "Outstanding Qty. (Base)" = 0 THEN
                    LineStatus := LineStatus::Shipped
                ELSE BEGIN
                    //ReserveSalesLine.ReservQuantity("Sales Line",QtyToReserve,QtyToReserveBase);
                    QtyToReserve := "Transfer Line"."Outstanding Quantity";
                    QtyToReserveBase := "Transfer Line"."Outstanding Qty. (Base)";
                    IF QtyToReserveBase > 0 THEN BEGIN
                        ReservEntry.RESET;
                        ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry, TRUE);
                        //ReserveSalesLine.FilterReservFor(ReservEntry,"Sales Line");
                        ReservEntry.SetSourceFilter(5741, 0, "Transfer Line"."Document No.", "Transfer Line"."Line No.", FALSE);
                        ReservEntry.SetSourceFilter2('', 0);
                        IF ReservEntry.FINDSET THEN
                            REPEAT
                                ReservEntryFrom.RESET;
                                ReservEntryFrom.GET(ReservEntry."Entry No.", NOT ReservEntry.Positive);
                                IF ReservEntryFrom."Source Type" = DATABASE::"Item Ledger Entry" THEN
                                    LineQuantityOnHand := LineQuantityOnHand + ReservEntryFrom.Quantity;
                            UNTIL ReservEntry.NEXT = 0;
                        CALCFIELDS("Reserved Qty. Outbnd. (Base)");
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
                /*END ELSE BEGIN
                  LineReceiptDate := 0D;
                  ReserveSalesLine.ReservQuantity("Sales Line",QtyToReserve,QtyToReserveBase);
                  LineQuantityOnHand := QtyToReserveBase;
                  IF "Outstanding Qty. (Base)" = 0 THEN
                    LineStatus := LineStatus::Shipped
                  ELSE
                    LineStatus := LineStatus::"Full Shipment";
                END;*/

                /*IF ModifyQtyToShip AND ("Document Type" = "Document Type"::Order) AND
                   ("Qty. to Ship (Base)" <> LineQuantityOnHand)
                THEN BEGIN
                  IF "Qty. per Unit of Measure" = 0 THEN
                    "Qty. per Unit of Measure" := 1;
                  VALIDATE("Qty. to Ship",
                    ROUND(LineQuantityOnHand / "Qty. per Unit of Measure",0.00001));
                  MODIFY;
                  OnAfterSalesLineModify("Sales Line");
                END;*/

                IF ClearDocumentStatus THEN BEGIN
                    DocumentReceiptDate := 0D;
                    DocumentStatus := DocumentStatus::" ";
                    ClearDocumentStatus := FALSE;
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

                TempTransferLine := "Transfer Line";
                ClearDocumentStatus := TRUE;

                IF TempTransferLine.NEXT <> 0 THEN
                    ClearDocumentStatus := (TempTransferLine."Document No." <> OldDocumentNo) OR (TempTransferLine."Document Type" <> OldDocumentType);

                // Calculating Unreserved free stock to show in the report
                UnReservedFreeStock := 0;
                Item.RESET;
                Item.SETRANGE("No.", "Transfer Line"."Item No.");
                Item.SETRANGE("Location Filter", "Transfer Line"."Transfer-from Code");
                IF Item.FINDFIRST THEN BEGIN
                    Item.CALCFIELDS("Reserved Qty. on Inventory");
                    Item.CALCFIELDS(Inventory);
                    UnReservedFreeStock := Item.Inventory - Item."Reserved Qty. on Inventory";
                END
                // Calculating Unreserved free stock to show in the report

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
                        Caption = 'Show Transfer Lines';
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
    }

    labels
    {
    }

    var
        Text000: Label 'Sales lines must be shown.';
        SalesHeader: Record "Sales Header";
        ReservEntry: Record "Reservation Entry";
        ReservEntryFrom: Record "Reservation Entry";
        TempTransferLine: Record "Transfer Line";
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
        Location: Record Location;
        Item: Record Item;
        UnReservedFreeStock: Decimal;
        "Reservation Entry": Record "Reservation Entry";
        "Transfer Line": Record "Transfer Line";



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

