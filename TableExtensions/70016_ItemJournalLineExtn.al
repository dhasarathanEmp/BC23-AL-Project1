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
            var
                CurrLine: Integer;
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
    Procedure UpdateCurrencyFactor()
    begin

    end;

    Procedure MapCurrencyCode()
    begin

    end;

    Procedure CalCurrLinePrice()
    begin

    end;

    Procedure SetYERUnitPriceCU()
    begin

    end;

    Procedure SetYERUnitCostCU()
    begin

    end;

    Procedure CalculateDiscount()
    begin

    end;

    var
        myInt: Integer;
}