page 55094 "AFZ Unres Stock from Req."
{
    PageType = List;
    SourceTable = "Temp Table For AFZ Free Stock";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LineNo; Rec.LineNo)
                {
                    Editable = false;
                }
                field("Vednor No"; Rec."Vednor No")
                {
                    Caption = '<Vendor No>';
                    Editable = false;
                }
                field("Item Number"; Rec."Item Number")
                {
                    Editable = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Un Reserved Free Stock"; Rec."Un Reserved Free Stock")
                {
                    Caption = 'Un Reserved AFZ Free Stock';
                    Editable = false;
                }
                field("Order Multiple"; Rec."Order Multiple")
                {
                    Editable = false;
                }
                field("Quantity to Cancel"; Rec."Quantity to Cancel")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Auto Fill Qty to cancel")
            {
                Image = AutofillQtyToHandle;

                trigger OnAction()
                begin
                    TempTableForAFZFreeStock.RESET;
                    IF TempTableForAFZFreeStock.FINDSET THEN
                        REPEAT
                            IF (TempTableForAFZFreeStock.Quantity <= TempTableForAFZFreeStock."Un Reserved Free Stock") OR (TempTableForAFZFreeStock."Un Reserved Free Stock" > TempTableForAFZFreeStock.Quantity) THEN
                                TempTableForAFZFreeStock."Quantity to Cancel" := TempTableForAFZFreeStock.Quantity
                            ELSE
                                TempTableForAFZFreeStock."Quantity to Cancel" := ROUND(TempTableForAFZFreeStock."Un Reserved Free Stock" / TempTableForAFZFreeStock."Order Multiple", 1, '<') * TempTableForAFZFreeStock."Order Multiple";
                            TempTableForAFZFreeStock.MODIFY;
                        UNTIL TempTableForAFZFreeStock.NEXT = 0;
                    CurrPage.UPDATE();
                end;
            }
            action("Split Requisition Lines")
            {
                Image = UpdateDescription;

                trigger OnAction()
                begin
                    "Split Req Lines and Demand Line";
                end;
            }
        }
    }

    var
        TempTableForAFZFreeStock: Record "Temp Table For AFZ Free Stock";
        RequisitionLine: Record "Requisition Line";
        ReqLastLineNo: Integer;
        RequisitionLine1: Record "Requisition Line";
        Item: Record Item;
        InsertedReqLineNo: Integer;
        ReqLinkMaintainance: Record "Req Link Maintainance";
        ModifiedQty: Decimal;
        NewQty: Decimal;
        ReqLinkLastSno: Integer;
        ReqLinkMaintainance1: Record "Req Link Maintainance";
        PendingQty: Decimal;
        LoopContrrol: Integer;
        DemandSno: Integer;

    local procedure "Split Req Lines and Demand Line"()
    begin
        ReqLastLineNo := 0;
        InsertedReqLineNo := 0;
        RequisitionLine.RESET;
        IF RequisitionLine.FINDLAST THEN
            ReqLastLineNo := RequisitionLine."Line No.";

        TempTableForAFZFreeStock.RESET;
        TempTableForAFZFreeStock.SETFILTER("Quantity to Cancel", '>%1', 0);
        IF TempTableForAFZFreeStock.FINDSET THEN
            REPEAT
                IF TempTableForAFZFreeStock.Quantity = TempTableForAFZFreeStock."Quantity to Cancel" THEN BEGIN
                    RequisitionLine.RESET;
                    RequisitionLine.SETRANGE("Line No.", TempTableForAFZFreeStock."Doc Line No");
                    IF RequisitionLine.FINDFIRST THEN BEGIN
                        RequisitionLine."Vendor No." := TempTableForAFZFreeStock."Vednor No";
                        RequisitionLine.MODIFY;
                    END;
                END ELSE BEGIN
                    RequisitionLine.RESET;
                    RequisitionLine.SETRANGE("Line No.", TempTableForAFZFreeStock."Doc Line No");
                    IF RequisitionLine.FINDFIRST THEN BEGIN
                        RequisitionLine.Quantity := TempTableForAFZFreeStock.Quantity - TempTableForAFZFreeStock."Quantity to Cancel";
                        ModifiedQty := RequisitionLine.Quantity;

                        RequisitionLine1.RESET;
                        RequisitionLine1.SETRANGE("No.", TempTableForAFZFreeStock."Item Number");
                        RequisitionLine1."Worksheet Template Name" := 'REQ.';
                        RequisitionLine1."Journal Batch Name" := 'DEFAULT';
                        RequisitionLine1."Line No." := ReqLastLineNo + 1000;
                        ReqLastLineNo := RequisitionLine1."Line No.";
                        InsertedReqLineNo := RequisitionLine1."Line No.";
                        RequisitionLine1.Type := RequisitionLine.Type::Item;
                        RequisitionLine1.VALIDATE("No.", TempTableForAFZFreeStock."Item Number");
                        RequisitionLine1."Action Message" := RequisitionLine."Action Message"::New;
                        RequisitionLine1.VALIDATE("Location Code", RequisitionLine."Location Code");
                        RequisitionLine1.VALIDATE("Replenishment System", RequisitionLine1."Replenishment System"::Purchase);
                        Item.GET(TempTableForAFZFreeStock."Item Number");
                        RequisitionLine1.VALIDATE("Vendor No.", Item."Vendor No.");
                        RequisitionLine1.VALIDATE(Quantity, TempTableForAFZFreeStock."Quantity to Cancel");
                        RequisitionLine1."Due Date" := RequisitionLine."Due Date";
                        RequisitionLine.MODIFY;
                        RequisitionLine1.INSERT;
                    END;
                    ReqLinkMaintainance.RESET;
                    IF ReqLinkMaintainance.FINDLAST THEN
                        ReqLinkLastSno := ReqLinkMaintainance."S.No";

                    LoopContrrol := 0;
                    ReqLinkMaintainance.RESET;
                    //ReqLinkMaintainance.SETCURRENTKEY("Req Line No.");
                    ReqLinkMaintainance.SETRANGE("Req Line No.", TempTableForAFZFreeStock."Doc Line No");
                    IF ReqLinkMaintainance.FINDSET THEN
                        REPEAT
                            IF ModifiedQty <> 0 THEN BEGIN
                                IF ReqLinkMaintainance."Demand Required Qty" <= ModifiedQty THEN BEGIN
                                    ModifiedQty := ModifiedQty - ReqLinkMaintainance."Demand Required Qty";
                                    DemandSno := ReqLinkMaintainance."S.No";
                                    LoopContrrol := 2;
                                END ELSE BEGIN
                                    LoopContrrol := 1;
                                    IF LoopContrrol = 1 THEN BEGIN
                                        PendingQty := ReqLinkMaintainance."Demand Required Qty" - ModifiedQty;
                                        ReqLinkMaintainance."Demand Required Qty" := ModifiedQty;
                                        ReqLinkMaintainance1."S.No" := ReqLinkLastSno + 1;
                                        ReqLinkLastSno := ReqLinkMaintainance1."S.No";
                                        ReqLinkMaintainance1."Req Line No." := InsertedReqLineNo;
                                        ReqLinkMaintainance1."Demand Source No." := ReqLinkMaintainance."Demand Source No.";
                                        ReqLinkMaintainance1."Demand Source Ref No." := ReqLinkMaintainance."Demand Source Ref No.";
                                        ReqLinkMaintainance1."Demand Required Qty" := PendingQty;
                                        //
                                        ReqLinkMaintainance1."Item No." := ReqLinkMaintainance."Item No.";
                                        ReqLinkMaintainance1.Description := ReqLinkMaintainance.Description;
                                        //
                                        ModifiedQty := 0;
                                        LoopContrrol += 1;
                                        ReqLinkMaintainance.MODIFY;
                                        ReqLinkMaintainance1.INSERT;
                                    END;
                                END;
                            END;
                            IF LoopContrrol <> 2 THEN BEGIN
                                ReqLinkMaintainance."Req Line No." := InsertedReqLineNo;
                                ReqLinkMaintainance.MODIFY;
                            END;
                            LoopContrrol := 3;
                        UNTIL ReqLinkMaintainance.NEXT = 0;
                END;
            UNTIL TempTableForAFZFreeStock.NEXT = 0;
        CurrPage.CLOSE;
    end;
}

