tableextension 70002 SalesLineExtn extends "Sales Line"
{
    fields
    {
        field(50015; Ordered_Part_No; Code[30])
        {

        }
        field(50026; CoreCharge; Decimal)
        {

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
                myInt: Integer;
            begin
                if (Quantity <> OldQty) then begin
                    if (OldQty <> 0) then begin
                        "Inv. Discount Amount" := Quantity / OldQty * InvDiscAmt;
                        "Inv. Disc. Amount to Invoice" := Quantity / OldQty * InvDiscAmttoInv;
                        UpdateAmounts();
                    end
                    else begin
                        if TotalLineAmt <> 0 then begin
                            "Inv. Discount Amount" := "Line Amount" * TotalDiscAmt / TotalLineAmt;
                            UpdateAmounts();
                        end;
                    end;
                end;
            end;
        }
        modify("Unit Price")
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
            begin
                OldUP := xRec."Unit Price";
                if OldUP <> 0 then begin
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
                myInt: Integer;
            begin
                if ("Unit Price" <> OldUP) then begin
                    if (OldUP <> 0) then begin
                        "Inv. Discount Amount" := "Unit Price" / OldUP * InvDiscAmt;
                        "Inv. Disc. Amount to Invoice" := "Unit Price" / OldUP * InvDiscAmttoInv;
                        UpdateAmounts();
                    end
                    else begin
                        if TotalLineAmt <> 0 then begin
                            "Inv. Discount Amount" := "Line Amount" * TotalDiscAmt / TotalLineAmt;
                            UpdateAmounts();
                        end;
                    end;
                end;
            end;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
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
}