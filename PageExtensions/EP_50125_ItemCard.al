pageextension 50125 EP_50125_ItemCard extends "Item Card"
{
    layout
    {
        addafter(Item)
        {
            group("Parts Price")
            {
                field("Dealers Net Price"; Rec."Dealers Net Price")
                {
                    ApplicationArea = All;
                }
                field("Dealer Net - Core Deposit"; Rec."Dealer Net - Core Deposit")
                {
                    ApplicationArea = All;
                }
                field("Suggested Consumers Price"; Rec."Suggested Consumers Price")
                {
                    ApplicationArea = All;
                }
                field(PPC; Rec."Parts Product Code")
                {
                    ApplicationArea = All;
                }
                field("Major Class"; Rec."Major Class")
                {
                    ApplicationArea = All;
                }
                field("Minor Class"; Rec."Minor Class")
                {
                    ApplicationArea = All;
                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                }
                field("DN - Damaged Core Refund"; Rec."DN - Damaged Core Refund")
                {
                    ApplicationArea = All;
                }
                field("Part Type"; Rec."Part Type")
                {
                    ApplicationArea = All;
                }
                field("Sugstd Consumer Price – C. D."; Rec."Sugstd Consumer Price – C. D.")
                {
                    ApplicationArea = All;
                }
                field("Sugstd Consumer Price – D.C.R."; Rec."Sugstd Consumer Price – D.C.R.")
                {
                    ApplicationArea = All;
                }
                field("Parts Usage Code"; Rec."Parts Usage Code")
                {
                    ApplicationArea = All;
                }
            }
            group("NPR")
            {
                field("Replacement Part No."; Rec."Replacement Part Number")
                {

                }
                field("Parent Item Number"; Rec.ParentReplacementItem)
                {

                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}