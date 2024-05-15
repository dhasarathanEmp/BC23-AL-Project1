page 50037 "Interface Parameter Form"
{
    PageType = Card;
    SourceTable = "Integration Parameters";

    layout
    {
        area(content)
        {
            group("General ")
            {
                field("<NPR Setup>"; Rec.NPR)
                {
                    Caption = 'NPR Setup';
                }
                field("<FG-Wilson Setup>"; Rec."FG-Wilson")
                {
                    Caption = 'FG-Wilson Setup';
                }
                field("<MCFE Setup>"; Rec.MCFE)
                {
                    Caption = 'MCFE Setup';
                }
                field("<Nissan Setup>"; Rec.Nissan)
                {
                    Caption = 'Nissan Setup';
                }
                field("<Peugeot Setup>"; Rec.Peugeot)
                {
                    Caption = 'Peugeot Setup';
                }
                field("<MF Setup>"; Rec.MF)
                {
                    Caption = 'MF Setup';
                }
            }
            group(NPR)
            {
                Caption = 'NPR';
                Visible = Rec.NPR;
                field("General Product Posting Group"; Rec."General Product Posting Group")
                {
                }
                field("VAT Product Posting Group"; Rec."VAT Product Posting Group")
                {
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                }
                field("Item Type"; Rec."Item Type")
                {
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                }
                field("Price/ Profit Calculation"; Rec."Price/ Profit Calculation")
                {
                }
                field("Agency Code"; Rec."Agency Code")
                {
                }
                field("Reordering Policy"; Rec."Reordering Policy")
                {

                    trigger OnValidate()
                    begin
                        IF Rec."Reordering Policy" = Rec."Reordering Policy"::"Fixed Reorder Qty." THEN
                            Isvisible := TRUE
                        ELSE BEGIN
                            IF Rec."Reordering Policy" = Rec."Reordering Policy"::"Lot-for-Lot" THEN BEGIN
                                Rec."Reorder Quantity" := 0;
                                Rec."Reordering Point" := 0;
                                Isvisible := FALSE;
                            END;
                        END;
                        Rec.MODIFY;
                    end;
                }
                field("Order Tracking Policy"; Rec."Order Tracking Policy")
                {
                }
                field("Reordering Point"; Rec."Reordering Point")
                {
                    Editable = Isvisible;
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                    Editable = Isvisible;
                }
                field("Costing Method"; Rec."Costing Method")
                {
                }
                field("Sales Price Factor"; Rec."Sales Price Factor")
                {
                }
                field("Inventory Factor"; Rec."Inventory Factor")
                {
                }
                field("Vendor No.1"; Rec."Vendor No.1")
                {
                }
                field("Vendor No.2"; Rec."Vendor No.2")
                {
                }
                field("IC Vendor No."; Rec."IC Vendor No.")
                {
                }
                field("Prevent Negative Inventory"; Rec."Prevent Negative Inventory")
                {
                }
                field("Weekly Price Update File Path"; Rec."Weekly Price Update File Path")
                {
                }
                field("Weekly Price Update Archives"; Rec."Weekly Price Update Archives")
                {
                    Caption = 'Weekly Price Update File Archives Path';
                }
                field("Weekly Price Update Day"; Rec."Weekly Price Update Day")
                {
                }
            }
            group(Nissan)
            {
                Visible = Rec.Nissan;
                field("Nissan Base Unit of Measure"; Rec."Nissan Base Unit of Measure")
                {
                }
                field("Nissan Purch. Unit of Measure"; Rec."Nissan Purch. Unit of Measure")
                {
                }
                field("Nissan Sales Unit of Measure"; Rec."Nissan Sales Unit of Measure")
                {
                }
                field("NissanGeneral Prod. Post Group"; Rec."NissanGeneral Prod. Post Group")
                {
                }
                field("Nissan VAT Prod. Posting Group"; Rec."Nissan VAT Prod. Posting Group")
                {
                }
                field("Nissan Inventory Posting Group"; Rec."Nissan Inventory Posting Group")
                {
                }
                field("Nissan Item Type"; Rec."Nissan Item Type")
                {
                }
                field("Nissan Item Category Code"; Rec."Nissan Item Category Code")
                {
                }
                field("NissanPrice/ ProfitCalculation"; Rec."NissanPrice/ ProfitCalculation")
                {
                }
                field("Nissan Agency Code"; Rec."Nissan Agency Code")
                {
                }
                field("Nissan Reordering Policy"; Rec."Nissan Reordering Policy")
                {

                    trigger OnValidate()
                    begin
                        IF Rec."Nissan Reordering Policy" = Rec."Nissan Reordering Policy"::"Fixed Reorder Qty." THEN
                            Isvisible1 := TRUE
                        ELSE BEGIN
                            IF Rec."Nissan Reordering Policy" = Rec."Nissan Reordering Policy"::"Lot-for-Lot" THEN BEGIN
                                Rec."Reorder Quantity" := 0;
                                Rec."Reordering Point" := 0;
                                Isvisible1 := FALSE;
                            END;
                        END;
                        Rec.MODIFY;
                    end;
                }
                field("Nissan Order Tracking Policy"; Rec."Nissan Order Tracking Policy")
                {
                }
                field("Nissan Reordering Point"; Rec."Nissan Reordering Point")
                {
                    Editable = Isvisible1;
                }
                field("Nissan Reorder Quantity"; Rec."Nissan Reorder Quantity")
                {
                    Editable = Isvisible1;
                }
                field("Nissan Costing Method"; Rec."Nissan Costing Method")
                {
                }
                field("Nissan Sales Price Factor"; Rec."Nissan Sales Price Factor")
                {
                }
                field("Nissan Inventory Factor"; Rec."Nissan Inventory Factor")
                {
                }
                field("Nissan Purchase Price Factor"; Rec."Nissan Purchase Price Factor")
                {
                }
                field("Nissan Vendor No."; Rec."Nissan Vendor No.")
                {
                }
                field("Nissan Prevent Negative Int."; Rec."Nissan Prevent Negative Int.")
                {
                }
            }
            group("FG-Wilson")
            {
                Visible = Rec."FG-Wilson";
                field("FGW  Base Unit of Measure"; Rec."FGW  Base Unit of Measure")
                {
                    Caption = 'FGW Base Unit of Measure';
                }
                field("FGW Purch. Unit of Measure"; Rec."FGW Purch. Unit of Measure")
                {
                }
                field("FGW Sales Unit of Measure"; Rec."FGW Sales Unit of Measure")
                {
                }
                field("FGW General Prod. Post Group"; Rec."FGW General Prod. Post Group")
                {
                }
                field("FGW VAT Prod. Posting Group"; Rec."FGW VAT Prod. Posting Group")
                {
                }
                field("FGW Inventory Posting Group"; Rec."FGW Inventory Posting Group")
                {
                }
                field("FGW Item Type"; Rec."FGW Item Type")
                {
                }
                field("FGW Item Category Code"; Rec."FGW Item Category Code")
                {
                }
                field("FGW Price/ ProfitCalculation"; Rec."FGW Price/ ProfitCalculation")
                {
                }
                field("FGW Agency Code"; Rec."FGW Agency Code")
                {
                }
                field("FGW Reordering Policy"; Rec."FGW Reordering Policy")
                {

                    trigger OnValidate()
                    begin
                        IF Rec."FGW Reordering Policy" = Rec."FGW Reordering Policy"::"Fixed Reorder Qty." THEN
                            Isvisible2 := TRUE
                        ELSE BEGIN
                            IF Rec."FGW Reordering Policy" = Rec."FGW Reordering Policy"::"Lot-for-Lot" THEN BEGIN
                                Rec."Reorder Quantity" := 0;
                                Rec."Reordering Point" := 0;
                                Isvisible2 := FALSE;
                            END;
                        END;
                        Rec.MODIFY;
                    end;
                }
                field("FGW Order Tracking Policy"; Rec."FGW Order Tracking Policy")
                {
                }
                field("FGW Reordering Point"; Rec."FGW Reordering Point")
                {
                    Editable = Isvisible2;
                }
                field("FGW Reorder Quantity"; Rec."FGW Reorder Quantity")
                {
                    Editable = Isvisible2;
                }
                field("FGW Costing Method"; Rec."FGW Costing Method")
                {
                }
                field("FGW Sales Price Factor"; Rec."FGW Sales Price Factor")
                {
                }
                field("FGW Inventory Factor"; Rec."FGW Inventory Factor")
                {
                }
                field("FGW Vendor No."; Rec."FGW Vendor No.")
                {
                }
                field("FGW Prevent Negative Int."; Rec."FGW Prevent Negative Int.")
                {
                }
            }
            group(Peugeot)
            {
                Visible = Rec.Peugeot;
                field("Pgt  Base Unit of Measure"; Rec."Pgt  Base Unit of Measure")
                {
                    Caption = 'Pgt Base Unit of Measure';
                }
                field("Pgt  Purch. Unit of Measure"; Rec."Pgt  Purch. Unit of Measure")
                {
                }
                field("Pgt Sales Unit of Measure"; Rec."Pgt Sales Unit of Measure")
                {
                }
                field("Pgt General Prod. Post Group"; Rec."Pgt General Prod. Post Group")
                {
                }
                field("Pgt VAT Prod. Posting Group"; Rec."Pgt VAT Prod. Posting Group")
                {
                }
                field("Pgt Inventory Posting Group"; Rec."Pgt Inventory Posting Group")
                {
                }
                field("Pgt Item Type"; Rec."Pgt Item Type")
                {
                }
                field("Pgt Item Category Code"; Rec."Pgt Item Category Code")
                {
                }
                field("Pgt Price/ ProfitCalculation"; Rec."Pgt Price/ ProfitCalculation")
                {
                }
                field("Pgt Agency Code"; Rec."Pgt Agency Code")
                {
                }
                field("Pgt  Reordering Policy"; Rec."Pgt  Reordering Policy")
                {

                    trigger OnValidate()
                    begin
                        IF Rec."Pgt  Reordering Policy" = Rec."Pgt  Reordering Policy"::"Fixed Reorder Qty." THEN
                            Isvisible3 := TRUE
                        ELSE BEGIN
                            IF Rec."Pgt  Reordering Policy" = Rec."Pgt  Reordering Policy"::"Lot-for-Lot" THEN BEGIN
                                Rec."Reorder Quantity" := 0;
                                Rec."Reordering Point" := 0;
                                Isvisible3 := FALSE;
                            END;
                        END;
                        Rec.MODIFY;
                    end;
                }
                field("Pgt Order Tracking Policy"; Rec."Pgt Order Tracking Policy")
                {
                }
                field("Pgt  Reordering Point"; Rec."Pgt  Reordering Point")
                {
                    Editable = Isvisible3;
                }
                field("Pgt  Reorder Quantity"; Rec."Pgt  Reorder Quantity")
                {
                    Editable = Isvisible3;
                }
                field("pgt Costing Method"; Rec."pgt Costing Method")
                {
                }
                field("Pgt Sales Price Factor"; Rec."Pgt Sales Price Factor")
                {
                }
                field("Pgt  Inventory Factor"; Rec."Pgt  Inventory Factor")
                {
                }
                field("Pgt Vendor No."; Rec."Pgt Vendor No.")
                {
                }
                field("Pgt Prevent Negative Int."; Rec."Pgt Prevent Negative Int.")
                {
                }
            }
            group(MCFE)
            {
                Visible = Rec.MCFE;
                field("MCFE Base unit of Measure"; Rec."MCFE Base unit of Measure")
                {
                }
                field("MCFE Purch. Unit of Measure"; Rec."MCFE Purch. Unit of Measure")
                {
                }
                field("MCFE Sales Unit of Measure"; Rec."MCFE Sales Unit of Measure")
                {
                }
                field("MCFE General Prod. Post Group"; Rec."MCFE General Prod. Post Group")
                {
                }
                field("MCFE VAT Prod. Posting Group"; Rec."MCFE VAT Prod. Posting Group")
                {
                }
                field("MCFE Inventory Posting Group"; Rec."MCFE Inventory Posting Group")
                {
                }
                field("MCFE Item Type"; Rec."MCFE Item Type")
                {
                }
                field("MCFE Item Category Code"; Rec."MCFE Item Category Code")
                {
                }
                field("MCFE Price/ ProfitCalculation"; Rec."MCFE Price/ ProfitCalculation")
                {
                }
                field("MCFE Agency Code"; Rec."MCFE Agency Code")
                {
                }
                field("MCFE  Reordering Policy"; Rec."MCFE  Reordering Policy")
                {

                    trigger OnValidate()
                    begin
                        IF Rec."MCFE  Reordering Policy" = Rec."MCFE  Reordering Policy"::"Fixed Reorder Qty." THEN
                            Isvisible4 := TRUE
                        ELSE BEGIN
                            IF Rec."MCFE  Reordering Policy" = Rec."MCFE  Reordering Policy"::"Lot-for-Lot" THEN BEGIN
                                Rec."Reorder Quantity" := 0;
                                Rec."Reordering Point" := 0;
                                Isvisible4 := FALSE;
                            END;
                        END;
                        Rec.MODIFY;
                    end;
                }
                field("MCFE Order Tracking Policy"; Rec."MCFE Order Tracking Policy")
                {
                }
                field("MCFE  Reordering Point"; Rec."MCFE  Reordering Point")
                {
                    Editable = Isvisible4;
                }
                field("MCFE  Reorder Quantity"; Rec."MCFE  Reorder Quantity")
                {
                    Editable = Isvisible4;
                }
                field("MCFE Costing Method"; Rec."MCFE Costing Method")
                {
                }
                field("MCFE Sales Price Factor"; Rec."MCFE Sales Price Factor")
                {
                }
                field("MCFE Inventory Factor"; Rec."MCFE Inventory Factor")
                {
                }
                field("MCFE Vendor No."; Rec."MCFE Vendor No.")
                {
                }
                field("MCF Prevent Negative Inventory"; Rec."MCF Prevent Negative Inventory")
                {
                }
            }
            group(MF)
            {
                Visible = Rec.MF;
                field("MF Base unit of Measure"; Rec."MF Base unit of Measure")
                {
                }
                field("MF Purch. Unit of Measure"; Rec."MF Purch. Unit of Measure")
                {
                }
                field("MF Sales Unit of Measure"; Rec."MF Sales Unit of Measure")
                {
                }
                field("MF General Prod Posting Group"; Rec."MF General Prod Posting Group")
                {
                }
                field("MF VAT Product Posting Group"; Rec."MF VAT Product Posting Group")
                {
                }
                field("MF Inventory Posting Group"; Rec."MF Inventory Posting Group")
                {
                }
                field("MF Item Type"; Rec."MF Item Type")
                {
                }
                field("MF Item Category Code"; Rec."MF Item Category Code")
                {
                }
                field("MF Price/ Profit Calculation"; Rec."MF Price/ Profit Calculation")
                {
                }
                field("MF Agency Code"; Rec."MF Agency Code")
                {
                }
                field("MF Reordering Policy"; Rec."MF Reordering Policy")
                {
                }
                field("MF Order Tracking Policy"; Rec."MF Order Tracking Policy")
                {
                }
                field("MF Reordering Point"; Rec."MF Reordering Point")
                {
                    Editable = Isvisible5;
                }
                field("MF Reorder Quantity"; Rec."MF Reorder Quantity")
                {
                    Editable = Isvisible5;
                }
                field("MF Costing Method"; Rec."MF Costing Method")
                {
                }
                field("MF Inventory Factor"; Rec."MF Inventory Factor")
                {
                }
                field("MF Sales Price Factor"; Rec."MF Sales Price Factor")
                {
                }
                field("MF Vendor No."; Rec."MF Vendor No.")
                {
                }
                field("MF Prevent Negative Inventory"; Rec."MF Prevent Negative Inventory")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        IF Rec."Reordering Policy" = Rec."Reordering Policy"::"Fixed Reorder Qty." THEN
            Isvisible := TRUE
        ELSE BEGIN
            IF Rec."Reordering Policy" = Rec."Reordering Policy"::"Lot-for-Lot" THEN BEGIN
                Rec."Reorder Quantity" := 0;
                Rec."Reordering Point" := 0;
                Isvisible := FALSE;
            END;
        END;
        //Rec. MODIFY;
        //
        IF Rec."Nissan Reordering Policy" = Rec."Nissan Reordering Policy"::"Fixed Reorder Qty." THEN
            Isvisible1 := TRUE
        ELSE BEGIN
            IF Rec."Nissan Reordering Policy" = Rec."Nissan Reordering Policy"::"Lot-for-Lot" THEN BEGIN
                Rec."Reorder Quantity" := 0;
                Rec."Reordering Point" := 0;
                Isvisible1 := FALSE;
            END;
        END;
        //Rec. MODIFY;
        //
        IF Rec."FGW Reordering Policy" = Rec."FGW Reordering Policy"::"Fixed Reorder Qty." THEN
            Isvisible2 := TRUE
        ELSE BEGIN
            IF Rec."FGW Reordering Policy" = Rec."FGW Reordering Policy"::"Lot-for-Lot" THEN BEGIN
                Rec."Reorder Quantity" := 0;
                Rec."Reordering Point" := 0;
                Isvisible2 := FALSE;
            END;
        END;
        //Rec. MODIFY;
        //
        IF Rec."Pgt  Reordering Policy" = Rec."Pgt  Reordering Policy"::"Fixed Reorder Qty." THEN
            Isvisible3 := TRUE
        ELSE BEGIN
            IF Rec."Pgt  Reordering Policy" = Rec."Pgt  Reordering Policy"::"Lot-for-Lot" THEN BEGIN
                Rec."Reorder Quantity" := 0;
                Rec."Reordering Point" := 0;
                Isvisible3 := FALSE;
            END;
        END;
        //Rec. MODIFY;
        //
        IF Rec."MCFE  Reordering Policy" = Rec."MCFE  Reordering Policy"::"Fixed Reorder Qty." THEN
            Isvisible4 := TRUE
        ELSE BEGIN
            IF Rec."MCFE  Reordering Policy" = Rec."MCFE  Reordering Policy"::"Lot-for-Lot" THEN BEGIN
                Rec."Reorder Quantity" := 0;
                Rec."Reordering Point" := 0;
                Isvisible4 := FALSE;
            END;
        END;
        //Rec. MODIFY;
        IF Rec."MF Reordering Policy" = Rec."MF Reordering Policy"::"Fixed Reorder Qty." THEN
            Isvisible5 := TRUE
        ELSE BEGIN
            IF Rec."MF Reordering Policy" = Rec."MF Reordering Policy"::"Lot-for-Lot" THEN BEGIN
                Rec."Reorder Quantity" := 0;
                Rec."Reordering Point" := 0;
                Isvisible5 := FALSE;
            END;
        END;
    end;

    var
        Isvisible: Boolean;
        Isvisible1: Boolean;
        Isvisible2: Boolean;
        Isvisible3: Boolean;
        Isvisible4: Boolean;
        FileMgt: Codeunit "File Management";
        FileName: Text;
        Isvisible5: Boolean;
}

