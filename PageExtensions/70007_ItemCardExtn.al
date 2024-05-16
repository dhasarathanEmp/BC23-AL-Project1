pageextension 70007 ItemCardExtn extends "Item Card"
{
    layout
    {

        addafter("Automatic Ext. Texts")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = All;
            }
            field("Model Year"; Rec."Model Year")
            {
                ApplicationArea = All;
            }
        }

        addafter(Item)
        {
            group("Parts Price")
            {
                Caption = 'Parts Price';
                field("Part Type"; Rec."Part Type")
                {
                }
                field("Dealers Net Price"; Rec."Dealers Net Price")
                {

                    trigger OnValidate()
                    begin
                        IF Rec."Dealers Net Price" <> 0 THEN BEGIN
                            Rec."Standard Cost" := (Rec."Dealers Net Price" + Rec."Dealer Net - Core Deposit") * Rec."Inventory Factor";
                            Rec.VALIDATE("Standard Cost");
                            Rec."Unit Price" := (Rec."Dealers Net Price" * Rec."Sales Price Factor") + (Rec."Dealer Net - Core Deposit" * Rec."Inventory Factor");
                            Rec.VALIDATE("Unit Price");
                        END;
                        CurrPage.UPDATE;
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
                field("Suggested Consumers Price"; Rec."Suggested Consumers Price")
                {
                }
                field("Parts Product Code"; Rec."Parts Product Code")
                {
                    TableRelation = "Parts Product Code Listing";
                }
                field("Major Class"; Rec."Major Class")
                {
                    TableRelation = "Major Class";
                }
                field("Minor Class"; Rec."Minor Class")
                {
                    TableRelation = "Minor Class";
                }
                field("Effective Date"; Rec."Effective Date")
                {
                }
                field("Dealer Net - Core Deposit"; Rec."Dealer Net - Core Deposit")
                {
                    trigger OnValidate()
                    begin
                        IF Rec."Dealers Net Price" <> 0 THEN BEGIN
                            Rec."Standard Cost" := (Rec."Dealers Net Price" + Rec."Dealer Net - Core Deposit") * Rec."Inventory Factor";
                            Rec.VALIDATE("Standard Cost");
                            Rec."Unit Price" := (Rec."Dealers Net Price" * Rec."Sales Price Factor") + (Rec."Dealer Net - Core Deposit" * Rec."Inventory Factor");
                            Rec.VALIDATE("Unit Price");
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("DN - Damaged Core Refund"; Rec."DN - Damaged Core Refund")
                {
                }
                field("Sugstd Consumer Price – C. D."; Rec."Sugstd Consumer Price – C. D.")
                {
                    Caption = 'Suggested Consumer Price - Core Deposit';
                }
                field("Sugstd Consumer Price – D.C.R."; Rec."Sugstd Consumer Price – D.C.R.")
                {
                    Caption = 'Suggested Consumer Price - Damaged Core Refund';
                }
                field("Parts Usage Code"; Rec."Parts Usage Code")
                {
                    Editable = false;
                }
                field("Suggested Consumer Price(ces)"; Rec."Suggested Consumer Price(ces)")
                {
                }
                field("Net Stock Price"; Rec."Net Stock Price")
                {
                }
                field(Qty; Rec.Qty)
                {
                }
                field("Landing Cost"; Rec."Landing Cost")
                {
                }
                field("Unit Of Issue"; Rec."Unit Of Issue")
                {
                }
                field("Power Exchange Part Number"; Rec."Power Exchange Part Number")
                {
                }
                field(UOI; Rec.UOI)
                {
                }
                field("Part_Country of Origin"; Rec."Part_Country of Origin")
                {
                    TableRelation = "Country/Region".Code;
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                }
                field("Exchange Surcharge"; Rec."Exchange Surcharge")
                {
                }
                field("Curr Code"; Rec."Curr Code")
                {
                    Caption = 'Currency Code';
                }
                field("Inventory Factor"; Rec."Inventory Factor")
                {

                    trigger OnValidate()
                    begin
                        IF Rec."Dealers Net Price" <> 0 THEN BEGIN
                            Rec."Standard Cost" := (Rec."Dealers Net Price" + Rec."Dealer Net - Core Deposit") * Rec."Inventory Factor";
                            Rec.VALIDATE("Standard Cost");
                            Rec."Unit Price" := (Rec."Dealers Net Price" * Rec."Sales Price Factor") + (Rec."Dealer Net - Core Deposit" * Rec."Inventory Factor");
                            Rec.VALIDATE("Unit Price");
                        END;
                        CurrPage.UPDATE;
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
                field("Sales Price Factor"; Rec."Sales Price Factor")
                {

                    trigger OnValidate()
                    begin
                        IF Rec."Dealers Net Price" <> 0 THEN BEGIN
                            Rec."Standard Cost" := (Rec."Dealers Net Price" + Rec."Dealer Net - Core Deposit") * Rec."Inventory Factor";
                            Rec.VALIDATE("Standard Cost");
                            Rec."Unit Price" := (Rec."Dealers Net Price" * Rec."Sales Price Factor") + (Rec."Dealer Net - Core Deposit" * Rec."Inventory Factor");
                            Rec.VALIDATE("Unit Price");
                        END;
                        CurrPage.UPDATE;
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
                field("purchase Price Factor"; Rec."purchase Price Factor")
                {
                }
                field("Nissan File Type"; Rec."Nissan File Type")
                {
                }
            }
            group(NPR)
            {
                Caption = 'NPR';
                field("Engine Indicator"; Rec."Engine Indicator")
                {
                }
                field(NonReturnableIndicator; Rec.NonReturnableIndicator)
                {
                }
                field("Assembly Only Indicator"; Rec."Assembly Only Indicator")
                {
                }
                field("Replacement Part Number"; Rec."Replacement Part Number")
                {
                }
                field("Business Economic Commdty code"; Rec."Business Economic Commdty code")
                {
                }
                field("Package Qty"; Rec."Package Qty")
                {
                }
                field("Two Digit Commdty Code"; Rec."Two Digit Commdty Code")
                {
                }
                field("Nested Quantity"; Rec."Nested Quantity")
                {
                }
                field("Non Current Date"; Rec."Non Current Date")
                {
                }
                field("Hazardous Material Indicator"; Rec."Hazardous Material Indicator")
                {
                }
                field("Replacement Remarks"; Rec."Replacement Remarks")
                {
                }
                field("Made as Ordered Indicator"; Rec."Made as Ordered Indicator")
                {
                }
                field("Part Dimension – Length"; Rec."Part Dimension – Length")
                {
                }
                field("Part Dimensions –Width"; Rec."Part Dimensions –Width")
                {
                }
                field("Part Dimensions – Height"; Rec."Part Dimensions – Height")
                {
                }
                field("Buildable Component Indicator"; Rec."Buildable Component Indicator")
                {
                }
                field("Trailer Count"; Rec."Trailer Count")
                {
                }
                field("Activity Indicator"; Rec."Activity Indicator")
                {
                }
                field("Service Publication Indicator"; Rec."Service Publication Indicator")
                {
                }
                field("Remanufactured Part Indicator"; Rec."Remanufactured Part Indicator")
                {
                }
                field("Fluid Carrier Indicator"; Rec."Fluid Carrier Indicator")
                {
                }
                field("MO qty Indicator"; Rec."MO qty Indicator")
                {
                }
                field("NPR Column 3 Indicator"; Rec."NPR Column 3 Indicator")
                {
                }
                field("Change Indicator"; Rec."Change Indicator")
                {
                }
                field("Metric Indicator"; Rec."Metric Indicator")
                {
                }
                field(RemanufacturedNumber; Rec.RemanufacturedNumber)
                {
                    Caption = 'Remanufactured Part Number';
                }
                field("Service Publication Number"; Rec."Service Publication Number")
                {
                }
                field("Replacement Part"; Rec."Replacement Part")
                {
                }
                field("Replacement Indicator"; Rec."Replacement Indicator")
                {
                }
                field("Replacement Type"; Rec."Replacement Type")
                {
                }
                field("Parent RemanufacturedItem"; Rec."Parent RemanufacturedItem")
                {
                }
                field(ParentReplacementItem; Rec.ParentReplacementItem)
                {
                }
                field(RInd; Rec.RInd)
                {
                }
            }
            group("MF Details")
            {
                Caption = 'MF Details';
                field("Discount Code"; Rec."Discount Code")
                {
                }
                field("Exchange Part Indicator"; Rec."Exchange Part Indicator")
                {
                }
                field("OptiStock Indicator"; Rec."OptiStock Indicator")
                {
                }
                field("NLA Code"; Rec."NLA Code")
                {
                }
                field(PMC; Rec.PMC)
                {
                }
                field("Product Code"; Rec."Product Code")
                {
                }
                field("Key Part Indicator"; Rec."Key Part Indicator")
                {
                }
                field("Trade Part Indicator"; Rec."Trade Part Indicator")
                {
                }
                field("10+ Part Indicator"; Rec."10+ Part Indicator")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
            group("Hose Assembly")
            {
                Caption = 'Hose Assembly';
                field("Hose Inner Diameter"; Rec."Hose Inner Diameter")
                {
                    DecimalPlaces = 0 : 3;
                }
                field("Hose Length"; Rec."Hose Length")
                {
                    DecimalPlaces = 0 : 3;
                }
                field(Angle; Rec.Angle)
                {
                }
                field("Armor Length"; Rec."Armor Length")
                {
                    DecimalPlaces = 0 : 1;
                }
                field("Identifier(Hose Type)"; Rec."Identifier(Hose Type)")
                {
                }
                field("Note Reference"; Rec."Note Reference")
                {
                }
                field("Hose Length for ser. rep. perm"; Rec."Hose Length for ser. rep. perm")
                {
                    DecimalPlaces = 0 : 1;
                }
                field("Hose Main item"; Rec."Hose Main item")
                {
                    Editable = false;
                }
            }

            group("Applicable Models")
            {
                Caption = 'Applicable Models';
                field("Applicable Model 1"; Rec."Applicable Model 1")
                {
                }
                field("Applicable Model 2"; Rec."Applicable Model 2")
                {
                }
                field("Applicable Model 3"; Rec."Applicable Model 3")
                {
                }
                field("Applicable Model 4"; Rec."Applicable Model 4")
                {
                }
                field("Applicable Model 5"; Rec."Applicable Model 5")
                {
                }
                field("Applicable Model 6"; Rec."Applicable Model 6")
                {
                }
            }
        }

        addafter("Gross Weight")
        {
            field("Net Weight (kg)"; Rec."Net Weight (kg)")
            {
                ApplicationArea = All;
            }
            field("Gross Weight (kg)"; Rec."Gross Weight (kg)")
            {
                ApplicationArea = All;
            }

        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        StockkeepingUnit: Record "Stockkeeping Unit";


}