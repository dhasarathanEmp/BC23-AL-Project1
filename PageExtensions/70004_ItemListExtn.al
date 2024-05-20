pageextension 70004 ItemPriceList extends "Item List"
{
    layout
    {

        addafter("Vendor No.")
        {
            field(Agency; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Hose Main item"; Rec."Hose Main item")
            {
                ApplicationArea = All;
            }
        }
        addbefore("Unit Cost")
        {
            field("Dealers Net Price"; Rec."Dealers Net Price")
            {
                ApplicationArea = All;
            }
            field("Dealer Net - Core Deposit"; Rec."Dealer Net - Core Deposit")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(PricesandDiscounts)
        {

            action("Nissan Import")
            {
                Image = Import;
                Visible = Nisson;
                RunObject = codeunit Nissan;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
            }

            action("Nissan Log")
            {
                Image = Log;
                Visible = Nisson;
                RunObject = page "Nissan Header List";
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
            }
            action("Parameter form")
            {
                RunObject = page "Interface Parameter Form";
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
            }
        }
    }
    trigger OnOpenPage()
    begin
        IntegrationParameters.RESET;
        IF IntegrationParameters.FINDFIRST THEN BEGIN
            IF IntegrationParameters.NPR = TRUE THEN
                NPR := TRUE
            ELSE
                NPR := FALSE;
            IF IntegrationParameters."FG-Wilson" = TRUE THEN
                FGWilson := TRUE
            ELSE
                FGWilson := FALSE;
            IF IntegrationParameters.MCFE = TRUE THEN
                MCFE := TRUE
            ELSE
                MCFE := FALSE;
            IF IntegrationParameters.Nissan = TRUE THEN
                Nisson := TRUE
            ELSE
                Nisson := FALSE;
            IF IntegrationParameters.Peugeot = TRUE THEN
                Peugeot := TRUE
            ELSE
                Peugeot := FALSE;
        END;
        //  <<  CS08
    END;

    var

        IntegrationParameters: Record "Integration Parameters";
        NPR: Boolean;
        FGWilson: Boolean;
        MCFE: Boolean;
        Nisson: Boolean;
        Peugeot: Boolean;

}