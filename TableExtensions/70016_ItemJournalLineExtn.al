tableextension 70016 ItemJournalLineExtn extends "Item Journal Line"
{
    fields
    {
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
        field(50002; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
        }
        field(50003; "Service Order"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CS05';
        }
        field(50004; Status; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CS02';
            OptionMembers = " ",Approved,Cancelled;
        }
        field(50005; Contact; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CS02';
            TableRelation = Contact."No.";
        }
        field(50006; "Contact Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CS02';
        }
        field(50008; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            Description = 'CS16';
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                //IF "Currency Factor" <> xRec."Currency Factor" THEN
                //  UpdateSalesLines(FIELDCAPTION("Currency Factor"),FALSE);
            end;
        }
        field(50009; "YER Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CS16';
        }
        field(50010; "YER Unit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CS16';
        }
        field(50013; "Line AmountUP"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CS16';
        }
        field(50014; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()

            begin
                //CS17
                PriceCheck := "Unit Price";
                IF Quantity <> 0 THEN
                    "Line AmountUP" := Quantity * "Unit Price"
                ELSE
                    "Line AmountUP" := Quantity * "Unit Price";
                IF (xRec."Unit Price" <> Rec."Unit Price") AND ("Unit Price" <> 0) THEN BEGIN
                    PriceCheck := "Unit Price";
                    "Unit Price" := PriceCheck;
                    IF Quantity <> 0 THEN
                        "Line AmountUP" := Quantity * "Unit Price"
                    ELSE
                        "Line AmountUP" := Quantity * "Unit Price";
                    VALIDATE("Discount%");
                END
                ELSE
                    //VALIDATE("Discount%");
                    //CalculateDiscount;
                    //"Currency Code" := '';
                    "Unit Price" := PriceCheck;
                //CS17
            end;
        }
        field(50015; Cash; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS008';
        }
        field(50016; "CashDocument No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS008';
        }
        field(50017; "CustomerNo."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CS02';
            TableRelation = Customer."No." where("Gen. Bus. Posting Group" = filter('HOD-HO'));
        }
        field(50019; "Customer Name1"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CS02';
        }
        field(50020; "Unit Price Item"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            Description = 'CS16';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                IF ("Currency Code" <> xRec."Currency Code") AND (("Currency Code" = 'USD') OR ("Currency Code" = '')) THEN BEGIN
                    "Currency Factor" := 1;
                    "Currency Code" := 'USD'
                END ELSE
                    IF (("Currency Code" <> '') OR ("Currency Code" <> 'USD')) THEN BEGIN
                        UpdateCurrencyFactor;
                    END
                    ELSE IF (("Currency Code" = '') OR ("Currency Code" = 'USD')) THEN BEGIN
                        "Currency Factor" := 1;
                        "Currency Code" := 'USD';
                    END;
                CurrLine := Rec."Line No.";
                MapCurrencyCode;
                CalCurrLinePrice;
                SetYERUnitPriceCU;
                SetYERUnitCostCU;
                CalculateDiscount;
            end;
        }
        field(50022; "VIN No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50024; "Service Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50025; "Service Item Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50027; "Required Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Discount%"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'CS17';
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                TotLineAmt1: Decimal;
                Currency: Record Currency;
            begin
                /*
                SalesReceivablesSetup.GET;
                IF "Discount%" > SalesReceivablesSetup."Counter Sales Discount %" THEN BEGIN
                    UserGroup.RESET;
                    UserGroup.SETRANGE(SalesDiscHigh, TRUE);
                    IF UserGroup.FINDFIRST THEN BEGIN
                        UserGroupMember.RESET;
                        UserGroupMember.SETRANGE("User Group Code", UserGroup.Code);
                        UserGroupMember.SETRANGE("User Name", USERID);
                        IF UserGroupMember.FINDFIRST THEN
                            "Discount%" := "Discount%"
                        ELSE
                            ERROR('Discount Percentage cannot exceed %1', SalesReceivablesSetup."Counter Sales Discount %");
                    END ELSE
                        ERROR('Discount Percentage cannot exceed %1', SalesReceivablesSetup."Counter Sales Discount %");
                END;
                */
                TotLineAmt1 := Rec.Quantity * Rec."Unit Price";
                "Discount Amount" :=
                ROUND(
                  ROUND(TotLineAmt1, Currency."Amount Rounding Precision") *
                  "Discount%" / 100, Currency."Amount Rounding Precision");
                Rec."Line AmountUP" := TotLineAmt1 - "Discount Amount";
            end;
        }
        field(50030; PriceCheck; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CS16';
        }
        field(50031; "VAT Bus"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS008';
            TableRelation = "VAT Business Posting Group".Code;
        }
        field(50032; "VAT Prod"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(50034; "Vehicle Model No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "CR External Reference No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Job Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            //TableRelation = "Temporary Job Orders"."Job Order No" WHERE(Job Status=FILTER(<>Completed));
        }
        field(50037; "Job Order Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Job Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Open,On Job,Completed';
            OptionMembers = " ",Open,"On Job",Completed;
        }
        field(50039; "Job Card No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50040; "PHY Inventory Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'None,Approved,Cancelled';
            OptionMembers = "None",Approved,Cancelled;
        }
        field(50041; "Default Price/Unit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50042; Remark; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50043; Bins; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        // Add changes to table fields here
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    procedure GetCurrencyFactorCU()
    begin
        //  >>  CS16
        CurrExchRate.RESET;
        CurrExchRate.SETRANGE("Currency Code", 'YER');
        IF NOT CurrExchRate.ISEMPTY THEN BEGIN
            "Currency Code" := 'YER';
            IF "Currency Code" <> '' THEN BEGIN
                "Currency Factor" := CurrExchRate.ExchangeRate(WORKDATE, "Currency Code");
            END;
        END ELSE
            "Currency Factor" := 0;
        //  << CS16
    end;

    procedure SetYERUnitCostCU()
    begin
        //  >>  CS16
        IF ("Currency Code" <> '') AND ("Currency Factor" <> 0) THEN
            "YER Unit Cost" := CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor("Unit Cost", "Currency Factor");
        //  <<  CS16
    end;

    procedure SetYERUnitPriceCU()
    begin
        //  >>  CS16
        IF (("Currency Code" <> '') OR ("Currency Code" <> 'USD')) THEN BEGIN
            "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
            "Unit Price" := CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor(Rec.PriceCheck, "Currency Factor");
        END
        ELSE
            IF ("Currency Code" <> xRec."Currency Code") AND (("Currency Code" <> '') OR ("Currency Code" <> 'USD')) THEN BEGIN
                "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                "Unit Price" := CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor(Rec.PriceCheck, "Currency Factor");
            END
            ELSE
                IF ("Currency Code" = '') OR ("Currency Code" = 'USD') THEN BEGIN
                    "Currency Factor" := 1;
                    "Unit Price" := CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor(Rec.PriceCheck, "Currency Factor");
                END;

        IF "Unit Price" <> 0 THEN
            "Line AmountUP" := Quantity * "Unit Price"
        ELSE
            "Line AmountUP" := Quantity * "Unit Price";

        CurrLineAmt := Rec."Line AmountUP";
        //  <<  CS16
    end;

    local procedure UpdateCurrencyFactor()
    begin
        IF "Currency Code" <> '' THEN BEGIN
            IF "Posting Date" <> 0D THEN BEGIN
                CurrencyDate := "Posting Date";
                "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code")
            END
            ELSE BEGIN
                CurrencyDate := WORKDATE;
                "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
            END;
        END ELSE
            "Currency Factor" := 1;
    end;

    procedure ShowReservation()
    var
        Reservation: Page Reservation;
    begin
        //CS15
        /*CLEAR(Reservation);
        Reservation.SetItemJnlLine(Rec);
        Reservation.RUNMODAL;
        //CS15*/
    end;

    local procedure MapCurrencyCode()
    var
        ItemJnlLineCU: Record "Item Journal Line";
        ItmJnLn: Record "Item Journal Line";
    begin
        ItemJnlLineCU.RESET;
        ItemJnlLineCU.SETRANGE("Source Code", 'RECLASSJNL');
        ItemJnlLineCU.SETRANGE("Journal Batch Name", "Journal Batch Name");
        ItemJnlLineCU.SETRANGE("Document No.", Rec."Document No.");
        ItemJnlLineCU.SETFILTER("Line No.", '<>%1', Rec."Line No.");
        IF ItemJnlLineCU.FINDSET THEN
            REPEAT
                IF ((Rec."Currency Code" <> '') OR (Rec."Currency Code" <> 'USD')) THEN BEGIN
                    ItemJnlLineCU."Currency Code" := Rec."Currency Code";
                    VarUP := ItemJnlLineCU."Unit Price";
                    ItemJnlLineCU."Unit Price" := UnitPriceCalc(ItemJnlLineCU.PriceCheck);
                    ItemJnlLineCU."Line AmountUP" := ItemJnlLineCU.Quantity * ItemJnlLineCU."Unit Price";
                    ItemJnlLineCU."Discount Amount" := ROUND(ROUND(ItemJnlLineCU."Line AmountUP", Currency."Amount Rounding Precision") *
                                             ItemJnlLineCU."Discount%" / 100, Currency."Amount Rounding Precision");
                    ItemJnlLineCU."Line AmountUP" := ItemJnlLineCU."Line AmountUP" - ItemJnlLineCU."Discount Amount";
                    ItemJnlLineCU.MODIFY;
                END
                ELSE BEGIN
                    ItemJnlLineCU."Currency Code" := 'USD';
                    ItemJnlLineCU."Unit Price" := UnitPriceCalc(ItemJnlLineCU.PriceCheck);
                    ItemJnlLineCU."Line AmountUP" := ItemJnlLineCU.Quantity * ItemJnlLineCU."Unit Price";
                    ItemJnlLineCU."Discount Amount" := ROUND(ROUND(ItemJnlLineCU."Line AmountUP", Currency."Amount Rounding Precision") *
                                             ItemJnlLineCU."Discount%" / 100, Currency."Amount Rounding Precision");
                    ItemJnlLineCU."Line AmountUP" := ItemJnlLineCU."Line AmountUP" - ItemJnlLineCU."Discount Amount";
                    ItemJnlLineCU.MODIFY;
                END;
            UNTIL ItemJnlLineCU.NEXT = 0;
    end;

    procedure UnitPriceCalc(UnitPrice: Decimal) UP: Decimal
    begin
        //  >>  CS16
        IF (("Currency Code" <> 'USD') OR ("Currency Code" <> '')) THEN BEGIN
            "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
            ;
            UP := CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor(UnitPrice, "Currency Factor");
        END
        ELSE
            IF ("Currency Code" <> xRec."Currency Code") AND (("Currency Code" <> 'USD') OR ("Currency Code" <> '')) THEN BEGIN
                "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");
                UP := CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor(UnitPrice, "Currency Factor");
            END
            ELSE
                IF "Currency Code" = 'USD' THEN BEGIN
                    "Currency Factor" := 1;
                    UP := CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor(UnitPrice, "Currency Factor");
                END;
    end;

    local procedure CalculateDiscount()
    begin
        IJL2.RESET;
        IJL2.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        IJL2.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        IJL2.SETRANGE("Document No.", Rec."Document No.");
        IF IJL2.FINDFIRST THEN BEGIN
            IJL2."Currency Code" := Rec."Currency Code";
            IF Rec."Discount Amount" <> 0 THEN BEGIN
                Rec."Discount Amount" := ROUND(ROUND(CurrLineAmt, Currency."Amount Rounding Precision") *
                                         Rec."Discount%" / 100, Currency."Amount Rounding Precision");
                Rec."Line AmountUP" := CurrLineAmt - Rec."Discount Amount";
                // IJL2.MODIFY
            END
            ELSE BEGIN
                IJL2."Discount Amount" := ROUND(ROUND(CurrLineAmt, Currency."Amount Rounding Precision") *
                                        Rec."Discount%" / 100, Currency."Amount Rounding Precision");
                Rec."Line AmountUP" := CurrLineAmt - Rec."Discount Amount";
                // IJL2.MODIFY;
            END
        END;
    end;

    procedure CalCurrLinePrice()
    begin
        ItmJnLn.RESET;
        ItmJnLn.SETRANGE("Source Code", 'RECLASSJNL');
        ItmJnLn.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItmJnLn.SETRANGE("Document No.", Rec."Document No.");
        ItmJnLn.SETFILTER("Line No.", '=%1', CurrLine);
        IF ItmJnLn.FINDFIRST THEN BEGIN
            IF ((Rec."Currency Code" <> '') OR (Rec."Currency Code" <> 'USD')) THEN BEGIN
                ItmJnLn."Currency Code" := Rec."Currency Code";
                VarUP := ItmJnLn."Unit Price";
                Rec."Unit Price" := UnitPriceCalc(Rec.PriceCheck);
                Rec."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price";
            END
            ELSE BEGIN
                ItmJnLn."Currency Code" := 'USD';
                Rec."Unit Price" := UnitPriceCalc(Rec.PriceCheck);
                Rec."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price";
            END;
        END;
    end;

    var
        myInt: Integer;
        IJL2: Record "Item Journal Line";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        VarUP: Decimal;
        CurrencyDate: Date;
        CurrLineAmt: Decimal;
        ItmJnLn: Record "Item Journal Line";
        CurrLine: Integer;
}