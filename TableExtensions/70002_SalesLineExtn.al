tableextension 70002 SalesLineExtn extends "Sales Line"
{
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                IF (Rec.Type = Rec.Type::Item) AND ("No." <> xRec."No.") AND ((Rec."Document Type" = Rec."Document Type"::Quote) OR (Rec."Document Type" = Rec."Document Type"::Order)) THEN BEGIN
                    ItemBuf.GET("No.");
                    IF ItemBuf."Hose Main item" = TRUE THEN
                        Rec."Unit Price" := 0.0;
                END;

            end;
        }

        modify(Quantity)
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
            begin
                OldQty := xRec.Quantity;
                if OldQty <> 0 then begin
                    InvDiscAmt := "Inv. Discount Amount";
                    InvDiscAmttoInv := "Inv. Disc. Amount to Invoice";
                end
                else begin
                    SalesLine.RESET;
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."Document No.");
                    SalesLine.SetFilter("Line No.", '<>%1', Rec."Line No.");
                    IF SalesLine.FindSet() then;
                    SalesLine.CalcSums("Line Amount", "Inv. Discount Amount");
                    TotalLineAmt := SalesLine."Line Amount";
                    TotalDiscAmt := SalesLine."Inv. Discount Amount";
                end;
            end;

            trigger OnAfterValidate()
            var
                SalesH: Record "Sales Header";
                Item: Record Item;
                SalesSetup: Record "Sales & Receivables Setup";
            begin
                if (Quantity <> OldQty) then begin
                    if (OldQty <> 0) then begin
                        "Inv. Discount Amount" := Quantity / OldQty * InvDiscAmt;
                        "Inv. Disc. Amount to Invoice" := Quantity / OldQty * InvDiscAmttoInv;
                        UpdateAmounts();
                    end
                    else begin
                        SalesSetup.GetRecordOnce();
                        SalesH.GET(Rec."Document Type", Rec."Document No.");
                        "Inv. Discount Amount" := "Line Amount" * SalesH."Invoice Discount%" / 100;
                        UpdateAmounts();
                    end;
                end;
            end;
        }
        modify("Unit Price")
        {
            trigger OnBeforeValidate()
            var
                Item: Record Item;
            begin
                OldUP := xRec."Unit Price";
                if OldUP > 0 then begin
                    InvDiscAmt := "Inv. Discount Amount";
                    InvDiscAmttoInv := "Inv. Disc. Amount to Invoice";
                end
                else begin
                    SalesLine.RESET;
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."Document No.");
                    SalesLine.SetFilter("Line No.", '<>%1', Rec."Line No.");
                    IF SalesLine.FindSet() then;
                    SalesLine.CalcSums("Line Amount", "Inv. Discount Amount");
                    TotalLineAmt := SalesLine."Line Amount";
                    TotalDiscAmt := SalesLine."Inv. Discount Amount";
                end;
            end;

            trigger OnAfterValidate()
            var
                SalesH: Record "Sales Header";
                Item: Record Item;
                SalesSetup: Record "Sales & Receivables Setup";
                NewUP: Decimal;
                LineCore: Decimal;
            begin
                NewUP := "Unit Price";
                if (NewUP <> OldUP) then begin
                    if (OldUP <> 0) then begin
                        "Inv. Discount Amount" := NewUP / OldUP * InvDiscAmt;
                        "Inv. Disc. Amount to Invoice" := NewUP / OldUP * InvDiscAmttoInv;
                        UpdateAmounts();
                    end
                    else begin
                        SalesH.GET(Rec."Document Type", Rec."Document No.");
                        "Inv. Discount Amount" := "Line Amount" * SalesH."Invoice Discount%" / 100;
                        UpdateAmounts();

                    end;
                end;
            end;
        }
        field(50000; "Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
            OptionMembers = " ",Sales,Service,Purchase;
        }
        field(50001; "Applied Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
        }
        field(50002; "Document No.1"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS009';
        }
        field(50003; InvoiceDiscountAmount1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; VATAmount1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Sales Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS013';
        }
        field(50006; SaleInvNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CS90';
        }
        field(50007; "VIN No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50008; "Vehicle Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50009; SaleInvLineNo; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CS90';
        }
        field(50010; "Service Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50011; "Service Item Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50013; "Sap No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS022';
        }
        field(50014; "Customer Serial No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS022';
        }
        field(50015; LastPartNumber; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50016; "Sale Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Core Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "PO Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Case Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Gross Weight kG"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Sale Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'AFZ001';
        }
        field(50032; "BOM Item No"; Code[20])
        {
            Caption = 'BOM Item No.';
            DataClassification = ToBeClassified;
            Description = 'Cu009';
            TableRelation = Item;
        }
        field(50033; "BOM Quantity Per"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu009';
        }
        field(50034; "BOM Main Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu009';
        }
        field(50037; "Qty to cancel"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                MainQty := Quantity - "Cancelled Quantity";
                Quantity := MainQty;
                */

            end;
        }
        field(50038; "Cancelled Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50039; OrgUnitPriceAFZ; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    local procedure ExchangeRateRestriction()
    begin
        E := 0;
        ExcgRte.RESET;
        ExcgRte.SETRANGE("Currency Code", 'YER');
        IF ExcgRte.FINDSET THEN
            REPEAT BEGIN
                IF ExcgRte."Starting Date" = WORKDATE THEN
                    E := 1;
            END;
            UNTIL ExcgRte.NEXT = 0;
        IF E = 0 THEN
            ERROR('Update exchange rate in YER');
    end;

    local procedure AgencyValidation()
    begin
        //EP9609 Adding validation for agency check up
        SalesHeader2.GET("Document Type", "Document No.");
        IF ((SalesHeader2."Document Type" = SalesHeader2."Document Type"::Order) OR (SalesHeader2."Document Type" = SalesHeader2."Document Type"::Quote)) AND (SalesHeader2."Order Date" > 20220209D) THEN BEGIN
            IF ((Rec.Type = Rec.Type::Item) AND (Rec."No." <> '')) THEN
                SalesHeader2.TESTFIELD("Agency Code")
        END;

        IF ((SalesHeader2."Document Type" = SalesHeader2."Document Type"::Order) OR (SalesHeader2."Document Type" = SalesHeader2."Document Type"::Quote)) AND (SalesHeader2."Order Date" > 20220209D) THEN BEGIN
            IF ((Rec.Type = Rec.Type::Item) AND (Rec."No." <> '')) THEN BEGIN
                ItemAG.RESET;
                ItemAG.GET(Rec."No.");
                IF ItemAG."Global Dimension 1 Code" <> SalesHeader2."Agency Code" THEN
                    ERROR('Please add the Same Agency Item, which Selected in Header');
            END;
        END
        //EP9609 Adding validation for agency check up
    end;

    var
        SalesHeaderBuf: Record "Sales Header";
        ItemTable: Record "Item";

    var
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Gpass: Code[20];
        ExcgRte: Record "Currency Exchange Rate";
        E: Integer;
        SalesHdr: Record "Sales Header";
        BinContents: Record "BIn Content";
        Bool: Boolean;
        ItemC: Record "Item";
        SaleHdr1: Record "Sales Header";
        SalesLne1: Record "Sales Line";
        QuoteNo: Code[20];
        SaleQte: Record "Sales Header Archive";
        CurrCode: Code[20];
        SaleHdr2: Record "Sales Header";
        SalesLne2: Record "Sales Line";
        Itm1: Record "Item";
        Agency: Code[20];
        SameItemCount: Integer;
        SalesHeaderBuf1: Record "Sales Header";
        CustomerBuf: Record "Customer";
        ItemforBOMCheck: Record "Item";
        Text061: Label 'Do you want to Explode BOM?';
        WeeklyNPRPriceUpdateStatus: Record "Weekly NPR Price Update Status";
        SalesHeader2: Record "Sales Header";
        ItemAG: Record "Item";
        MainQty: Decimal;
        ServiceItem: Record "Item";
        myInt: Integer;
        InvDiscAmt: Decimal;
        OldQty: Decimal;
        NewQty: Decimal;
        OldUP: Decimal;
        NewUP: Decimal;
        InvDiscAmttoInv: Decimal;
        SalesLine: Record "Sales Line";
        TotalLineAmt: Decimal;
        TotalDiscAmt: Decimal;
        TotalDiscAmttoInv: Decimal;
        ItemBuf: Record Item;
}

