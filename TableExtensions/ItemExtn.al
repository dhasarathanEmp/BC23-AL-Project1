tableextension 50112 ItemExtn extends Item
{
    // CS08 3-2-18 New field created- Item Type [50004] for Item Restriction Customization
    // CS19 - 03/13/2018 Added fields and functions in OnInsert(),Unit Amount - OnValidate() & Unit Price  - OnValidate()
    // CD02 - 30/11/2020 Added for standerd cost and unit price
    fields
    {

        modify("Unit Price")
        {
            trigger OnAfterValidate()
            var

            begin
                //  >>  CS19
                SetYERUnitPriceCU;
                //  <<  CS19
            end;
        }

        modify("Price/Profit Calculation")
        {
            trigger OnAfterValidate()
            var

            begin
                //  >>  CS19
                SetYERUnitPriceCU;
                //  <<  CS19 
            end;
        }
        modify("Unit Cost")
        {
            trigger OnAfterValidate()
            var

            begin
                //  >>  CS19
                SetYERUnitPriceCU;
                //  <<  CS19
            end;
        }

        field(50000; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                GetCurrencyFactorCU;
                SetYERUnitCostCU;
                SetYERUnitPriceCU;
            end;
        }
        field(50001; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            Description = 'YER';
            Editable = false;
            MinValue = 0;
        }
        field(50002; "YER Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'YER';
        }
        field(50003; "YER Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            DataClassification = ToBeClassified;
            Description = 'YER';
        }
        field(50004; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CS08';
            OptionCaption = ' ,E-PS Parts,Auto Parts,Prime Product';
            OptionMembers = " ","E-PS Parts","Auto Parts","Prime Product";
        }
        field(50005; "Model Year"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CS09';
        }
        field(50006; "Sales Price Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                IF Rec."Dealers Net Price" <> 0 THEN BEGIN
                    Rec."Standard Cost" := (Rec."Dealers Net Price" + Rec."Dealer Net - Core Deposit") * "Inventory Factor";
                    Rec.VALIDATE("Standard Cost");
                    Rec."Unit Price" := (Rec."Dealers Net Price" * "Sales Price Factor") + (Rec."Dealer Net - Core Deposit" * "Inventory Factor");
                    Rec.VALIDATE("Unit Price");
                END;
                //CurrPage.UPDATE;
                StockkeepingUnit.RESET;
                StockkeepingUnit.SETRANGE("Item No.", Rec."No.");
                IF StockkeepingUnit.FINDSET THEN
                    REPEAT
                        StockkeepingUnit."Standard Cost" := Rec."Standard Cost";
                        StockkeepingUnit.VALIDATE("Standard Cost");
                        StockkeepingUnit.MODIFY;
                    UNTIL StockkeepingUnit.NEXT = 0;
            end;
        }
        field(50007; "Part Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'k';
        }
        field(50008; "Dealers Net Price"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                IF Rec."Dealers Net Price" <> 0 then begin
                    Rec."Standard Cost" := (Rec."Dealers Net Price" + Rec."Dealer Net - Core Deposit") * "Inventory Factor";
                    Rec.VALIDATE("Standard Cost");
                    Rec."Unit Price" := (Rec."Dealers Net Price" * "Sales Price Factor") + (Rec."Dealer Net - Core Deposit" * "Inventory Factor");
                    Rec.VALIDATE("Unit Price");
                END;
                //CurrPage.UPDATE;
                StockkeepingUnit.RESET;
                StockkeepingUnit.SETRANGE("Item No.", Rec."No.");
                IF StockkeepingUnit.FINDSET THEN
                    REPEAT
                        StockkeepingUnit."Standard Cost" := Rec."Standard Cost";
                        StockkeepingUnit.VALIDATE("Standard Cost");
                        StockkeepingUnit.MODIFY;
                    UNTIL StockkeepingUnit.NEXT = 0;
            end;
        }
        field(50009; "Suggested Consumers Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Parts Product Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Major Class"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Minor Class"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Dealer Net - Core Deposit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "DN - Damaged Core Refund"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Dealer Net - Damaged Core Refund';
        }
        field(50016; "Sugstd Consumer Price – C. D."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Suggested Consumer Price – Core Deposit';
        }
        field(50017; "Sugstd Consumer Price – D.C.R."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Suggested Consumer Price – Damaged Core Refund';
        }
        field(50018; "Parts Usage Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Suggested Consumer Price(ces)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Suggested Consumer Price (CES Export in USD)             K';
        }
        field(50020; "Engine Indicator"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; NonReturnableIndicator; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Assembly Only Indicator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Replacement Part Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(50024; "Business Economic Commdty code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Package Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Two Digit Commdty Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Nested Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Non Current Date"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Hazardous Material Indicator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Replacement Remarks"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Made as Ordered Indicator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Change Description Indicator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Part Dimension – Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 1 : 4;
        }
        field(50034; "Part Dimensions –Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 1 : 4;
        }
        field(50035; "Part Dimensions – Height"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 1 : 4;
        }
        field(50036; "Buildable Component Indicator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Trailer Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Activity Indicator"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Service Publication Indicator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Remanufactured Part Indicator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Fluid Carrier Indicator"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "MO qty Indicator"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "NPR Column 3 Indicator"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "Change Indicator"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Metric Indicator"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50046; RemanufacturedNumber; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Service Publication Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Replacement Part"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50049; "Remanufactured Part"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Replacement Type"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Replacement Indicator"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; ParentReplacementItem; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(50053; "Remanufactured Part Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Sales Model"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Part Number Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Second Level Distribution"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",T,"0","3";
        }
        field(50057; RInd; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "Stem Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'K';
        }
        field(50059; "Stem Part Number(Reusable)"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Seal Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "Seal Part Number(Required)"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Sleeve Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50063; "Sleeve Part Number(Required)"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Hose Inner Diameter"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 3;
        }
        field(50065; "Bulk Hose Part Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "Hose Length"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50067; Angle; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Armor Guard Part Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50069; "Armor Length"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50070; "Special Instruction"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50071; "Permanent Stem Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "Permanent Stem Part Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "Identifier(Hose Type)"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50074; "Note Reference"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50075; "Sequence Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Service Rep. per.Coupling Part"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'Service Replacement Permanent Coupling Part';
        }
        field(50077; "Hose Length for ser. rep. perm"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Hose Length for Service Replacement Permanent Coupling Part (K)';
        }
        field(50078; "Retail Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50079; "Discount Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50080; "Unit Of Issue"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50081; "Exchange Part Indicator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50082; "Exchange Surcharge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50083; "OptiStock Indicator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "NLA Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50085; PMC; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50086; "Product Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50087; "Key Part Indicator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50088; "Trade Part Indicator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50089; "10+ Part Indicator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50090; Comments; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50091; Region; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,EAME,FENDT,"North America","South America";
        }
        field(50092; Brand; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ," Massey Ferguson"," Fendt Tractor",Challenger;
        }
        field(50093; "File Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Pricing," SuperSession";
        }
        field(50094; "Curr Code"; Code[20])
        {
            TableRelation = Currency;
        }
        field(50096; "Inventory Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;

            trigger OnValidate()
            begin
                IF Rec."Dealers Net Price" <> 0 THEN BEGIN
                    Rec."Standard Cost" := (Rec."Dealers Net Price" + Rec."Dealer Net - Core Deposit") * "Inventory Factor";
                    Rec.VALIDATE("Standard Cost");
                    Rec."Unit Price" := (Rec."Dealers Net Price" * "Sales Price Factor") + (Rec."Dealer Net - Core Deposit" * "Inventory Factor");
                    Rec.VALIDATE("Unit Price");
                END;
                //CurrPage.UPDATE;
                StockkeepingUnit.RESET;
                StockkeepingUnit.SETRANGE("Item No.", Rec."No.");
                IF StockkeepingUnit.FINDSET THEN
                    REPEAT
                        StockkeepingUnit."Standard Cost" := Rec."Standard Cost";
                        StockkeepingUnit.VALIDATE("Standard Cost");
                        StockkeepingUnit.MODIFY;
                    UNTIL StockkeepingUnit.NEXT = 0;
            end;
        }
        field(50108; "Net Weight (kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 4;
        }
        field(50109; "Gross Weight (kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 4;
        }
        field(50126; UOI; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50127; "Net Stock Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50128; "Net VOR Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50129; "Power Exchange Part Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50130; "Tariff Code"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50131; "PMC Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50133; "Landing Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50134; Qty; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50135; "Part_Country of Origin"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50136; "Parent RemanufacturedItem"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50137; "Not Available"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50138; "Nissan File Type"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50139; "purchase Price Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50140; "Stock Keeping Unit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50141; "Hose Main item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu011';
        }
        field(50142; "Hose Price Update Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu011';
        }
        field(50143; "Hose Cost Update Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu011';
        }
        field(50144; "Actual Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9605';
        }
        field(50145; "Applicable Model 1"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50146; "Applicable Model 2"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50147; "Applicable Model 3"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50148; "Applicable Model 4"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50149; "Applicable Model 5"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50150; "Applicable Model 6"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50151; "HS Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50152; "Purchase Price Exist"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Purchase Price" WHERE("Item No." = field("No.")));
        }
        field(50153; "S.No For Price Export"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50154; "Ledger Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Item Ledger Entry" WHERE("Item No." = FIELD("No."),
                                                           "Posting Date" = FILTER(>= 0D)));
        }
    }

    trigger OnInsert()
    var

    begin
        //  >>  CS19
        GetCurrencyFactorCU;
        SetYERUnitCostCU();
        SetYERUnitPriceCU();
        //  <<  CS19
        "Unit Price" := ("Dealers Net Price" * "Sales Price Factor") + "Dealer Net - Core Deposit";
        "Standard Cost" := (Item."Dealers Net Price" + "Dealer Net - Core Deposit") * "Inventory Factor";
    end;

    procedure GetCurrencyFactorCU()
    begin
        //  >>  CS19
        CurrExchRate.RESET;
        CurrExchRate.SETRANGE("Currency Code", 'YER');
        IF NOT CurrExchRate.ISEMPTY THEN BEGIN
            "Currency Code" := 'YER';

            IF "Currency Code" <> '' THEN BEGIN
                "Currency Factor" := CurrExchRate.ExchangeRate(WORKDATE, "Currency Code");
            END;
        END ELSE
            "Currency Factor" := 0;
        //  <<  CS19
    end;

    procedure SetYERUnitCostCU()
    begin
        //  >>  CS19
        IF ("Currency Code" <> '') AND ("Currency Factor" <> 0) THEN
            "YER Unit Cost" := CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor("Unit Cost", "Currency Factor");
        VALIDATE("YER Unit Cost", "YER Unit Cost");
        //MODIFY;
        //  <<  CS19
    end;

    procedure SetYERUnitPriceCU()
    begin
        //  >>  CS19
        IF ("Currency Code" <> '') AND ("Currency Factor" <> 0) THEN
            "YER Unit Price" := CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor("Unit Price", "Currency Factor");
        VALIDATE("YER Unit Cost", "YER Unit Cost");
        //MODIFY;
        //  <<  CS19
    end;

    var
        CurrExchRate: Record "Currency Exchange Rate";
        CurrencyDate: Date;
        Item: Record Item;
        StockkeepingUnit: Record "Stockkeeping Unit";
}

