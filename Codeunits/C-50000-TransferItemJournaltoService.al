codeunit 50000 TransferItemJournaltoService
{
    // CS05 3-2-18 Setitemjournal, TransferJournalLinesToService -Transfer Item Journal lines to Service Order Lines Customization
    // CS02 Setitemjournal1,TransferJournalLinesToCounter - Counter Sale Customization

    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        itemjournalG: Record "Item Journal Line" temporary;
        itemjournal2: Record "Item Journal Line";
        ServiceHeader: Record "Service Header";
        serviceitem: Record "Service Item";
        ServiceLines: Record "Service Line";
        Bool: Boolean;
        TemporaryDeliveryHistory: Record "Temporary Delivery History";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ItemJournalBatch: Record "Item Journal Batch";
        NoSeries: Code[20];
        NoSeriesManagement: Codeunit NoSeriesManagement;
        IJLNO: Code[20];
        NoSeriesLine: Record "No. Series Line";
        "LastUsed No": Code[20];

    procedure Setitemjournal()
    begin
        //  >>  CS05
        IF NOT itemjournalG.ISEMPTY THEN
            itemjournalG.DELETEALL;
        itemjournal2.RESET;
        // Give looping
        itemjournal2.SETRANGE("Journal Template Name", 'ITEM');
        itemjournal2.SETRANGE("Journal Batch Name", 'SERVICE');
        IF itemjournal2.FINDSET THEN
            REPEAT
                itemjournalG.INIT;
                itemjournalG.TRANSFERFIELDS(itemjournal2);
                itemjournalG.INSERT;
            UNTIL itemjournal2.NEXT = 0;
        //  <<  CS05
    end;

    procedure TransferJournalLinesToService()
    begin
        //  >>  CS05
        IF itemjournalG.FINDSET THEN
            REPEAT
                ServiceHeader.RESET;
                IF ServiceHeader.GET(ServiceHeader."Document Type"::Order, itemjournalG."Service Order") THEN BEGIN
                    serviceitem.RESET;
                    //serviceitem.SETRANGE("Document Type", ServiceHeader."Document Type");
                    //serviceitem.SETRANGE("Document No.", ServiceHeader."No.");
                    IF serviceitem.FINDFIRST THEN BEGIN
                        ServiceLines.RESET;
                        ServiceLines.SETRANGE("Document Type", ServiceHeader."Document Type");
                        ServiceLines.SETRANGE("Document No.", ServiceHeader."No.");
                        IF NOT ServiceLines.ISEMPTY THEN BEGIN
                            IF ServiceLines.FINDLAST THEN BEGIN
                                ServiceLines.INIT;
                                ServiceLines."Document Type" := ServiceHeader."Document Type";
                                ServiceLines."Document No." := ServiceHeader."No.";
                                ServiceLines."Line No." := ServiceLines."Line No." + 10000;
                            END;
                        END
                        ELSE BEGIN
                            ServiceLines.INIT;
                            ServiceLines."Document Type" := ServiceHeader."Document Type";
                            ServiceLines."Document No." := ServiceHeader."No.";
                            ServiceLines."Line No." := 10000;
                        END;
                        //ServiceLines."Service Item No." := serviceitem."Service Item No.";
                        //ServiceLines."Service Item Line No." := serviceitem."Line No.";
                        ServiceLines."Service Item Line Description" := serviceitem.Description;
                        ServiceLines.Type := ServiceLines.Type::Item;
                        ServiceLines."No." := itemjournalG."Item No.";
                        ServiceLines.VALIDATE("No.");
                        ServiceLines."Quantity (Base)" := itemjournalG.Quantity;
                        ServiceLines.Quantity := itemjournalG.Quantity;
                        ServiceLines."Outstanding Quantity" := itemjournalG.Quantity;
                        ServiceLines."Outstanding Qty. (Base)" := itemjournalG.Quantity;
                        ServiceLines.Quantity := itemjournalG.Quantity;
                        ServiceLines.VALIDATE(Quantity);
                        ServiceLines."Qty. to Ship" := itemjournalG.Quantity;
                        ServiceLines."Qty. to Ship (Base)" := itemjournalG.Quantity;
                        ServiceLines.VALIDATE("Qty. to Ship");
                        ServiceLines."Unit of Measure Code" := itemjournalG."Unit of Measure Code";
                        //ServiceLines.CusReturns := TRUE;
                        ServiceLines."Location Code" := itemjournalG."Location Code";
                        ServiceLines."Bin Code" := itemjournalG."Bin Code";
                        ServiceLines."Unit Price" := 0;
                        ServiceLines.INSERT(TRUE);
                        MESSAGE('Inserted to %1 Service lines', itemjournalG."Service Order");
                    END;
                END;
            UNTIL itemjournalG.NEXT = 0;
    end;

    procedure Setitemjournal1(IJ: Record "Item Journal Line")
    begin
        //  >>  CS02
        IF NOT itemjournalG.ISEMPTY THEN
            itemjournalG.DELETEALL;
        itemjournal2.RESET;
        // Give looping
        itemjournal2.SETRANGE("Entry Type", itemjournal2."Entry Type"::Transfer);
        itemjournal2.SETRANGE("Journal Batch Name", IJ."Journal Batch Name");
        itemjournal2.SETRANGE(Status, itemjournal2.Status::Approved);
        IF itemjournal2.FINDSET THEN
            REPEAT
                itemjournalG.INIT;
                itemjournalG.TRANSFERFIELDS(itemjournal2);
                itemjournalG.INSERT;
            UNTIL itemjournal2.NEXT = 0;
        //  <<  CS02
    end;

    procedure TransferJournalLinesToCounter()
    var
        CounterSales: Record "Cancelled CounterSales History";
        CounterSales1: Record "Cancelled CounterSales History";
    begin
        // >> CS02
        IF itemjournalG.FINDSET THEN
            REPEAT
                CounterSales.RESET;
                CounterSales1.INIT;
                CounterSales1.TRANSFERFIELDS(itemjournalG);
                CounterSales1."VIN No." := itemjournalG."VIN No.";
                CounterSales1."Vehicle Model No." := itemjournalG."Vehicle Model No.";
                CounterSales1.INSERT(TRUE);
            UNTIL itemjournalG.NEXT = 0;
        //  <<  CS02
    end;

    procedure SetBool(Bool1: Boolean)
    begin
        Bool := Bool1;
    end;

    procedure GetBool() Bool2: Boolean
    begin
        EXIT(Bool);
    end;

    procedure TransferJournalLinesToTD(ItemJournalLine: Record "Item Journal Line"; DocNo: Code[20])
    var
        CounterSales: Record "Cancelled CounterSales History";
        CounterSales1: Record "Cancelled CounterSales History";
    begin
        // >> CS02
        itemjournalG.RESET;
        //itemjournalG.SETRANGE("Document No.",ItemJournalLine."Document No.");
        IF itemjournalG.FINDSET THEN
            REPEAT
                //TemporaryDeliveryHistory.RESET;
                TemporaryDeliveryHistory.INIT;
                TemporaryDeliveryHistory.TRANSFERFIELDS(itemjournalG);
                TemporaryDeliveryHistory.INSERT(TRUE);
            UNTIL itemjournalG.NEXT = 0;
        //  <<  CS02
    end;

    procedure TransfeSalesinvoicetoitemreclassjournal(DOCNO: Code[20])
    begin
        ItemJournalBatch.RESET;
        ItemJournalBatch.SETRANGE("Journal Template Name", 'TRANSFER');
        ItemJournalBatch.SETRANGE(Name, 'DEFAULT');
        ItemJournalBatch.SETRANGE("Template Type", ItemJournalBatch."Template Type"::Transfer);
        IF ItemJournalBatch.FINDFIRST THEN
            NoSeries := ItemJournalBatch."No. Series";
        //
        CLEAR(IJLNO);
        SalesLine.RESET;
        SalesLine.SETRANGE("Document No.", DOCNO);
        IF SalesLine.FINDSET THEN
            REPEAT
                TemporaryDeliveryHistory.RESET;
                //TemporaryDeliveryHistory.SETRANGE("Document No.", SalesLine."Document No.");
                //TemporaryDeliveryHistory.SETRANGE("Line No.", SalesLine."Line No.");
                IF TemporaryDeliveryHistory.FINDFIRST THEN BEGIN
                    IF TemporaryDeliveryHistory.Quantity >= SalesLine.Quantity THEN BEGIN
                        itemjournal2.RESET;
                        itemjournal2."Journal Template Name" := 'TRANSFER';
                        itemjournal2."Entry Type" := itemjournalG."Entry Type"::Transfer;
                        itemjournal2."Source Code" := 'RECLASSJNL';
                        itemjournal2."Journal Batch Name" := 'DEFAULT';
                        IF itemjournal2.FINDLAST THEN
                            IJLNO := itemjournal2."Document No.";
                        IF IJLNO = '' THEN BEGIN
                            IJLNO := NoSeriesManagement.TryGetNextNo(NoSeries, WORKDATE);
                            itemjournalG.INIT;
                            itemjournalG."Journal Template Name" := 'TRANSFER';
                            itemjournalG."Entry Type" := itemjournalG."Entry Type"::Transfer;
                            itemjournalG."Source Code" := 'RECLASSJNL';
                            itemjournalG."Journal Batch Name" := 'DEFAULT';
                            itemjournalG."Document No." := IJLNO;
                            itemjournalG."Posting Date" := WORKDATE;
                            itemjournalG."Item No." := TemporaryDeliveryHistory."Item No.";
                            itemjournalG.VALIDATE("Item No.");
                            itemjournalG."Line No." := TemporaryDeliveryHistory."Line No.";
                            itemjournalG."Location Code" := TemporaryDeliveryHistory."Location Code";
                            itemjournalG.VALIDATE("Location Code");
                            itemjournalG."Bin Code" := TemporaryDeliveryHistory."New Bin Code";
                            itemjournalG."New Bin Code" := TemporaryDeliveryHistory."Bin Code";
                            itemjournalG.Quantity := TemporaryDeliveryHistory.Quantity - SalesLine.Quantity;
                            itemjournalG.VALIDATE(Quantity);
                            itemjournalG.INSERT(TRUE);
                        END ELSE BEGIN
                            itemjournalG.INIT;
                            itemjournalG."Journal Template Name" := 'TRANSFER';
                            itemjournalG."Entry Type" := itemjournalG."Entry Type"::Transfer;
                            itemjournalG."Source Code" := 'RECLASSJNL';
                            itemjournalG."Journal Batch Name" := 'DEFAULT';
                            itemjournalG."Document No." := IJLNO;
                            itemjournalG."Posting Date" := WORKDATE;
                            itemjournalG."Item No." := TemporaryDeliveryHistory."Item No.";
                            itemjournalG.VALIDATE("Item No.");
                            itemjournalG."Line No." := TemporaryDeliveryHistory."Line No.";
                            itemjournalG."Location Code" := TemporaryDeliveryHistory."Location Code";
                            itemjournalG.VALIDATE("Location Code");
                            itemjournalG."Bin Code" := TemporaryDeliveryHistory."New Bin Code";
                            itemjournalG."New Bin Code" := TemporaryDeliveryHistory."Bin Code";
                            itemjournalG.Quantity := TemporaryDeliveryHistory.Quantity - SalesLine.Quantity;
                            itemjournalG.VALIDATE(Quantity);
                            itemjournalG.INSERT(TRUE);
                        END;
                    END;
                END;
            UNTIL SalesLine.NEXT = 0;
    end;

    procedure Setitemjournal2(IJ: Record "Item Journal Line")
    begin
        //  >>  CS02
        IF NOT itemjournalG.ISEMPTY THEN
            itemjournalG.DELETEALL;
        itemjournal2.RESET;
        // Give looping
        itemjournal2.SETRANGE("Journal Batch Name", IJ."Journal Batch Name");
        itemjournal2.SETRANGE("Journal Template Name", IJ."Journal Template Name");
        itemjournal2.SETRANGE("PHY Inventory Status", itemjournal2."PHY Inventory Status"::Approved);
        IF itemjournal2.FINDSET THEN
            REPEAT
                itemjournalG.INIT;
                itemjournalG.TRANSFERFIELDS(itemjournal2);
                itemjournalG.INSERT;
            UNTIL itemjournal2.NEXT = 0;
        //  <<  CS02
    end;
}

