tableextension 70009 TransferLineExtn extends "Transfer Line"
{
    fields
    {

        //Unsupported feature: Property Modification (Editable) on ""Outstanding Qty. (Base)"(Field 17)".

        //Unsupported feature: Property Modification (Editable) on ""Outstanding Quantity"(Field 24)".

        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                //EP9613
                IF Item1.GET(Rec."Item No.") THEN BEGIN
                    DefaultPriceFactor.RESET;
                    DefaultPriceFactor.SETRANGE("Agency Code", Item1."Global Dimension 1 Code");
                    IF DefaultPriceFactor.FINDFIRST THEN
                        "Default Price/Unit" := (Item1."Unit Price" - Item1."Dealer Net - Core Deposit" * Item1."Inventory Factor") * DefaultPriceFactor."Default Price Factor" + Item1."Dealer Net - Core Deposit" * Item1."Inventory Factor";
                    "Default Price/Unit" := ROUND("Default Price/Unit", 0.01);
                    "Agency Code" := Item1."Global Dimension 1 Code";
                END;
                //EP9613
            end;
        }
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            var

            begin
                //Cu106
                CALCFIELDS("Reserved Quantity Inbnd.", "Reserved Quantity Outbnd.");
                IF ((Quantity - "Quantity Shipped") < "Reserved Quantity Outbnd.") OR ((Quantity - "Quantity Received") < "Reserved Quantity Inbnd.") THEN
                    ERROR('Outstanding Quantity cannot be lesser than reserved Quantity');
                //Cu106
            end;
        }
        //Unsupported feature: Code Insertion on ""Transfer-from Bin Code"(Field 7300)".
        field(50000; "Original Transfer Order Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS010';
        }
        field(50001; "ShippedQty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS010';

            trigger OnValidate()
            begin
                Quantity := "ShippedQty.";
                Validate(Quantity);
            end;
        }
        field(50002; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Order";
        }
        field(50004; "Indent No."; Code[250])
        {
            DataClassification = ToBeClassified;
            Description = 'CS14/Indent No.';
        }
        field(50005; "Sales Order No"; Code[250])
        {
            DataClassification = ToBeClassified;
            Description = ' CUS013,CUS015';
        }
        field(50008; SalesOrder; Code[250])
        {
            DataClassification = ToBeClassified;
            Description = 'CS14';
        }
        field(50009; "Required By"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Default Price/Unit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50019; "Agency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50021; "Ordered Part No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Cu104';
        }
        field(50022; "Sales Order Number"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EP9619';
        }
        field(50023; "Sales Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    trigger OnInsert()
    begin
        //EP9613
        IF Item1.GET(Rec."Item No.") THEN BEGIN
            DefaultPriceFactor.RESET;
            DefaultPriceFactor.SETRANGE("Agency Code", Item1."Global Dimension 1 Code");
            IF DefaultPriceFactor.FINDFIRST THEN
                "Default Price/Unit" := (Item1."Unit Price" - Item1."Dealer Net - Core Deposit" * Item1."Inventory Factor") * DefaultPriceFactor."Default Price Factor" + Item1."Dealer Net - Core Deposit" * Item1."Inventory Factor";
            "Default Price/Unit" := ROUND("Default Price/Unit", 0.01);
            "Agency Code" := Item1."Global Dimension 1 Code";
        END;
        //EP9613 
    end;

    var
        BinContent: Record "Bin Content";
        TransferReceiptLine: Record "Transfer Receipt Line";
        ReQty: Decimal;
        TransferLine: Record "Transfer Line";
        Item1: Record Item;
        DefaultPriceFactor: Record "Default Price Factor";
        ItemReplaceCheck: Boolean;

    procedure ItemReplacementCheck(ReplacementCheck: Boolean)
    begin
        ItemReplaceCheck := ReplacementCheck;
    end;
}
