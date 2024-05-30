pageextension 70026 ReservationEntriesExtn extends "Reservation Entries"
{
    layout
    {
        // Add changes to page layout here
        modify("Quantity (Base)")
        {
            Editable = false;
        }
        addafter("Quantity (Base)")
        {
            field("Quantity to Cancel"; Quantity_to_Cancel)
            {
                Caption = 'Qty to Cancel';

                trigger OnValidate()
                begin
                    //>>EMP108.11 - This is for sale order reservation restriction
                    SalesHeader.RESET;
                    SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SETRANGE("No.", Rec."Source ID");
                    IF SalesHeader.FINDFIRST THEN
                        IF SalesHeader.Status = SalesHeader.Status::Released THEN
                            ERROR('Status must be equal to "Open" in Sales Header (%1). The current status is Released', Rec."Source ID");
                    //<<EMP108.11 - This is for sale order reservation restriction


                    //>>EMP108.12 - can't able to do cancel reservation if status is accepted in Transfer order
                    TransferHeader.RESET;
                    TransferHeader.SETRANGE("No.", Rec."Source ID");
                    TransferHeader.SETRANGE(Status, TransferHeader.Status::Released);
                    IF TransferHeader.FINDFIRST THEN
                        ERROR('Status must be equal to Open in Transfer Header (%1). Current value of status is Realesed', Rec."Source ID");
                    //>>EMP108.12 - can't able to do cancel reservation if status is accepted in Transfer order


                    //>>EMP108.13 - can't able to do cancel reservation in Transfer order
                    ReservationEntry.RESET;
                    ReservationEntry.SETRANGE("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
                    ReservationEntry.SETRANGE("Entry No.", Rec."Entry No.");
                    ReservationEntry.SETRANGE("Source Type", 37);
                    IF ReservationEntry.FINDSET THEN
                        REPEAT
                            SalesLine.RESET;
                            SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                            SalesLine.SETRANGE("Document No.", ReservationEntry."Source ID");
                            IF SalesLine.FINDSET THEN
                                SalesHeader.RESET;
                            SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                            SalesHeader.SETRANGE("No.", SalesLine."Document No.");
                            IF SalesHeader.FINDSET THEN
                                IF SalesHeader.Status = SalesHeader.Status::Released THEN
                                    ERROR('Status must be equal to Open in Sales Header (%1). The current status is Released', SalesHeader."No.");
                        UNTIL ReservationEntry.NEXT = 0;
                    //>>EMP108.13 - can't able to do cancel reservation in Transfer order

                    //EP9617
                    InsertCancellationHistory_Partial;
                    //EP9617
                    CurrPage.UPDATE;
                end;
            }
            field("Reason Code."; "Reason Code.")
            {
                Caption = 'Reason to Cancel';
                OptionCaption = ' ,For Sales Order,For Transfer Order,For Assembly Order,Having Free Stock to process,Replacement';

                trigger OnValidate()
                begin
                    Quantity_to_Cancel := 0;
                    "Document No" := '';
                    //EP9617
                    IF "Reason Code." <> 0 THEN
                        EnableDocNo := TRUE;
                    IF "Reason Code." = 4 THEN BEGIN
                        ReasontoCancel := 'Having Free Stock to process';
                        "Document No" := 'Having Free Stock to process';
                    END ELSE BEGIN
                        ReasontoCancel := 'Replacement';
                        "Document No" := 'Replacement';
                    END
                    //EP9617
                end;
            }
            field("Document No"; "Document No")
            {
                Caption = 'Document No';
                Editable = EnableDocNo;
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    //EP9617
                    IF "Reason Code." = 1 THEN BEGIN
                        ReasontoCancel := 'For Sales Order';
                        SalesHeader.RESET;
                        SalesHeader.SETRANGE("Location Code", Rec."Location Code");
                        IF SalesHeader.FINDSET THEN BEGIN
                            IF PAGE.RUNMODAL(PAGE::"Sales Order List", SalesHeader) = ACTION::LookupOK THEN BEGIN
                                "Document No" := SalesHeader."No.";
                            END;
                        END ELSE
                            ERROR('There is no Sales Order Created in your current location, Please Choose Exact Reason For Your Cancellation');
                    END ELSE IF "Reason Code." = 2 THEN BEGIN
                        ReasontoCancel := 'For Transfer Order';
                        TransferHeader.RESET;
                        TransferHeader.SETRANGE("Transfer-from Code", Rec."Location Code");
                        IF TransferHeader.FINDSET THEN BEGIN
                            IF PAGE.RUNMODAL(PAGE::"Transfer Orders", TransferHeader) = ACTION::LookupOK THEN BEGIN
                                "Document No" := TransferHeader."No.";
                            END;
                        END ELSE
                            ERROR('There is no Transfer Order Created in your current location, Please choose exact reason for your cancellation');
                    END ELSE IF "Reason Code." = 3 THEN BEGIN
                        ReasontoCancel := 'For Assembly Order';
                        AssemblyHeader.RESET;
                        AssemblyHeader.SETRANGE("Location Code", Rec."Location Code");
                        IF AssemblyHeader.FINDSET THEN BEGIN
                            IF PAGE.RUNMODAL(PAGE::"Assembly Orders", AssemblyHeader) = ACTION::LookupOK THEN BEGIN
                                "Document No" := AssemblyHeader."No.";
                            END;
                        END ELSE
                            ERROR('There is no Assembly Order Created in your current location, Please Choose Exact Reason For Your Cancellation');
                    END ELSE IF "Reason Code." = 0 THEN BEGIN
                        ERROR('Please choose the reason for this Reservation cancellation');
                    END
                    //EP9617
                end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(CancelReservation)
        {
            trigger OnBeforeAction()
            var

            begin
                //>>EMP108.11
                SalesHeader.RESET;
                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SETRANGE("No.", Rec."Source ID");
                IF SalesHeader.FINDFIRST THEN
                    IF SalesHeader.Status = SalesHeader.Status::Released THEN
                        ERROR('Status must be equal to "Open" in Sales Header (%1). The current status is Released', Rec."Source ID");
                //<<EMP108.11
                IF (("Reason Code." = 0) OR ("Document No" = '')) THEN
                    ERROR('To cancel the Reservation "Reason Code and Document No." is Mandatory')
                else
                    InsertCancellationHistory_Full();
            end;

            trigger OnAfterAction()
            var

            begin
                "Reason Code." := 0;
                Quantity_to_Cancel := 0;
                "Document No" := '';
            end;
        }
    }
    trigger OnOpenPage()
    begin
        //EP9625
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER("Sales Resp. Ctr. Filter", '<>%1', '');
        IF UserSetup.FINDFIRST THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Location Code", '=%1', UserSetup."Sales Resp. Ctr. Filter");
            Rec.FILTERGROUP(0);
        END
        //EP9625
    end;

    var
        Text001: Label 'Cancel reservation of %1 of item number %2, reserved for %3 from %4?';
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        "Document No": Text;
        "Reason Code.": Option;
        SalesHeader: Record "Sales Header";
        SalesOrderList: Page "Sales Order List";
        TransferHeader: Record "Transfer Header";
        TransferOrders: Page "Transfer Orders";
        AssemblyHeader: Record "Assembly Header";
        AssemblyOrders: Page "Assembly Orders";
        EnableDocNo: Boolean;
        "EnableQtyBase&CancelQtyAction": Boolean;
        Quantity_to_Cancel: Decimal;
        TempQuantityBase: Decimal;
        CancelQtyFreeze: Boolean;
        ReservationCancellationHist: Record "Reservation Cancellation Hist.";
        ReasontoCancel: Text;
        ReservationEntry: Record "Reservation Entry";
        SalesLine: Record "Sales Line";
        Temp: Integer;
        TempLine: Integer;
        UserSetup: Record "User Setup";

    local procedure InsertCancellationHistory_Full()
    begin
        //EP9617
        ReservationCancellationHist.RESET;
        //IF ReservationCancellationHist.FINDLAST THEN BEGIN
        GetLastLineNo;
        ReservationCancellationHist."Line No." := TempLine;
        ReservationCancellationHist."Cancelled By" := USERID;
        ReservationCancellationHist."Reservation Cancelled On." := TODAY;
        ReservationCancellationHist."Item No." := Rec."Item No.";
        ReservationCancellationHist."Cancelled Qty." := Rec."Quantity (Base)";
        ReservationCancellationHist."Location Code" := Rec."Location Code";
        ReservationCancellationHist."Reason Code" := ReasontoCancel;
        ReservationCancellationHist."Reservation Cancelled For" := "Document No";
        ReservationEntry.RESET;
        IF Rec.Positive = TRUE THEN BEGIN
            IF ReservationEntry.GET(Rec."Entry No.", FALSE) THEN BEGIN
                ReservationCancellationHist."Reservation Cancelled From" := Rec."Source ID";
                ReservationCancellationHist."Reserved In" := ReservationEntry."Source ID";
            END;
        END ELSE IF Rec.Positive = FALSE THEN BEGIN
            IF ReservationEntry.GET(Rec."Entry No.", TRUE) THEN BEGIN
                ReservationCancellationHist."Reservation Cancelled From" := ReservationEntry."Source ID";
                ReservationCancellationHist."Reserved In" := Rec."Source ID";
            END;
        END;
        ReservationCancellationHist.INSERT;
        Quantity_to_Cancel := 0;
        "Document No" := '';
        //END ;
        //EP9617
    end;

    local procedure InsertCancellationHistory_Partial()
    begin
        //EP9617
        IF ("Reason Code." <> 0) AND ("Document No" <> '') THEN BEGIN
            IF Rec.Positive = FALSE THEN BEGIN
                IF Quantity_to_Cancel <= 0 THEN BEGIN
                    TempQuantityBase := Rec."Quantity (Base)" * -1;
                    Quantity_to_Cancel := Quantity_to_Cancel * -1;
                    IF Quantity_to_Cancel < TempQuantityBase THEN BEGIN
                        TempQuantityBase := TempQuantityBase - Quantity_to_Cancel;
                        Rec."Quantity (Base)" := (TempQuantityBase * -1);
                        Quantity_to_Cancel := Quantity_to_Cancel * -1;
                        Rec.VALIDATE(Rec."Quantity (Base)");
                        IF Quantity_to_Cancel < 0 THEN BEGIN
                            ReservationCancellationHist.RESET;
                            GetLastLineNo;
                            ReservationCancellationHist."Line No." := TempLine;
                            ReservationCancellationHist."Cancelled By" := USERID;
                            ReservationCancellationHist."Reservation Cancelled On." := TODAY;
                            ReservationCancellationHist."Item No." := Rec."Item No.";
                            ReservationCancellationHist."Cancelled Qty." := Quantity_to_Cancel;
                            ReservationCancellationHist."Location Code" := Rec."Location Code";
                            ReservationCancellationHist."Reason Code" := ReasontoCancel;
                            ReservationCancellationHist."Reservation Cancelled For" := "Document No";
                            ReservationEntry.RESET;
                            IF ReservationEntry.GET(Rec."Entry No.", TRUE) THEN BEGIN
                                ReservationCancellationHist."Reservation Cancelled From" := ReservationEntry."Source ID";
                                ReservationCancellationHist."Reserved In" := Rec."Source ID";
                            END;
                            ReservationCancellationHist.INSERT;
                            Quantity_to_Cancel := 0;
                            "Reason Code." := 0;
                            "Document No" := '';
                        END;
                    END ELSE
                        ERROR('Quantity Must be Less than Quantity Base.');
                END ELSE
                    ERROR('Qty to Cancel value should be Less than Quantity Base, You have entered %1', Quantity_to_Cancel);
            END ELSE BEGIN
                IF Quantity_to_Cancel >= 0 THEN BEGIN
                    IF Quantity_to_Cancel < Rec."Quantity (Base)" THEN BEGIN
                        Rec."Quantity (Base)" := Rec."Quantity (Base)" - Quantity_to_Cancel;
                        Rec.VALIDATE(Rec."Quantity (Base)");
                        IF Quantity_to_Cancel > 0 THEN BEGIN
                            ReservationCancellationHist.RESET;
                            GetLastLineNo;
                            ReservationCancellationHist."Line No." := TempLine;
                            ReservationCancellationHist."Cancelled By" := USERID;
                            ReservationCancellationHist."Reservation Cancelled On." := TODAY;
                            ReservationCancellationHist."Item No." := Rec."Item No.";
                            ReservationCancellationHist."Cancelled Qty." := Quantity_to_Cancel;
                            ReservationCancellationHist."Location Code" := Rec."Location Code";
                            ReservationCancellationHist."Reason Code" := ReasontoCancel;
                            ReservationCancellationHist."Reservation Cancelled For" := "Document No";
                            IF ReservationEntry.GET(Rec."Entry No.", FALSE) THEN BEGIN
                                ReservationCancellationHist."Reservation Cancelled From" := Rec."Source ID";
                                ReservationCancellationHist."Reserved In" := ReservationEntry."Source ID";
                            END;
                            ReservationCancellationHist.INSERT;
                            Quantity_to_Cancel := 0;
                            "Reason Code." := 0;
                            "Document No" := '';
                        END;
                    END ELSE
                        ERROR('Quantity Must be Less than Quantity Base.');
                END ELSE
                    ERROR('Qty to Cancel value should be Greater than or Equals to 0, You have entered %1', Quantity_to_Cancel);
            END;
        END ELSE
            ERROR('To Cancel the Reservation " Reason to Cancel and Document No " is Mandatory');
        //EP9617
    end;

    local procedure GetLastLineNo()
    begin
        //EP9617
        ReservationCancellationHist.RESET;
        IF ReservationCancellationHist.FINDLAST THEN
            TempLine := ReservationCancellationHist."Line No." + 1
        ELSE
            TempLine := 1;
    end;
}