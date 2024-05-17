codeunit 50004 Nissan
{
    // EP96-01 Updating Order Mutiple
    // IF01 Adding agency code as Postfix with Part No
    // EP9608-SuperSeded Part No
    // Cu020 Applicable models
    // EP9615 Ending Existing Purchase Price
    trigger OnRun()
    begin
        UploadIntoStream('Please Choose the Text File', '', 'All Files (*.*)|*.*', FilePath, StreamInTest);
        Clear(FileManagement);
        if FilePath <> '' then
            ClientFileName := FileManagement.GetFileName(FilePath);
        SerialNum := 0;
        Inserted := 0;
        Modified := 0;
        ErrorsCount := 0;
        FirstRec := 0;
        Skipped := 0;
        ItemCount := 0;
        ErrorItem := 0;
        User.RESET;
        User.SETRANGE("User Name", USERID);
        IF User.FINDFIRST then
            UserName := User."Full Name";
        NissonLogHeader.INIT;
        SalesSetup.RESET;
        SalesSetup.GET;
        NissonLogHeader."No." := NoSeriesManagement.GetNextNo('CUST', WORKDATE, TRUE);
        NissonLogHeader."Start Time" := TIME;
        NissonLogHeader.Status := NissonLogHeader.Status::Processing;
        NissonLogHeader."Log Status" := NissonLogHeader."Log Status"::Nissan;
        NissonLogHeader.INSERT;
        ProgressWindow.OPEN('Processing Item No. #1#######');
        WHILE NOT StreamInTest.EOS DO BEGIN
            StreamInTest.READTEXT(Buffer);
            SerialNum += 1;
            CurrencyCode := COPYSTR(Buffer, 147, 3);
            FileName := COPYSTR(Buffer, 141, 4);
            IF SerialNum = 1 THEN BEGIN
                IntegrationParameters.RESET;
                IF IntegrationParameters.FINDFIRST THEN BEGIN
                    Vendor.RESET;
                    Vendor.SETRANGE("No.", IntegrationParameters."Nissan Vendor No.");
                    IF Vendor.FINDFIRST THEN BEGIN
                        IF Vendor."Currency Code" = CurrencyCode THEN
                            Vendor."Currency Code" := CurrencyCode
                        ELSE
                            ERROR('Change vendor in the interface parameter as per the currency in nissan import file');
                    END;
                END;
                IF (FileName = 'NML') OR (FileName = 'NNA') THEN
                    FileName := FileName
                ELSE
                    ERROR('InCorrect File Format');
            END;
            position1 := STRLEN(Buffer);
            position := FORMAT(position1);
            IF position = '241' THEN BEGIN
                PartNumber := COPYSTR(Buffer, 1, 12);
                PartNumber := 'N#' + PartNumber;//IF01
                ProgressWindow.UPDATE(1, PartNumber);
                IF FileName = 'NML' THEN
                    NMLPriceUpdateLogic(Buffer)
                ELSE
                    IF FileName = 'NNA' THEN
                        NNAPriceUpdateLogic(Buffer);
            END ELSE BEGIN
                ItemNo := COPYSTR(Buffer, 1, 12);
                ItemNo := 'N#' + ItemNo;//IF01
                ErrorMessage := ('Data Length mismatch');
                ErrorLogInfo(UserName, ClientFileName, ItemNo, SerialNum, ErrorMessage, NissonLogHeader."No.");
            END;
        END;
        //SFile.CLOSE;
        ProgressWindow.CLOSE;
        IF ErrorsCount = 0 THEN BEGIN
            NissonLogHeader1.RESET;
            NissonLogHeader1.SETRANGE("No.", NissonLogHeader."No.");
            IF NissonLogHeader1.FINDFIRST THEN BEGIN
                NissonLogHeader1."No." := NissonLogHeader."No.";
                NissonLogHeader1."User Id" := USERID;
                NissonLogHeader1.UserName := UserName;
                NissonLogHeader1.Description := 'Nisson Price and Part Update';
                NissonLogHeader1."CreationDate&Time" := CURRENTDATETIME;
                NissonLogHeader1."End Time" := TIME;
                NissonLogHeader1."Total No. of Items Updated" := Modified;
                NissonLogHeader1."Record Inserted" := Inserted;
                NissonLogHeader1."Total No. Of Records" := SerialNum;
                NissonLogHeader1."Total No of Errors" := ErrorsCount;
                NissonLogHeader1.Status := NissonLogHeader1.Status::Success;
                NissonLogHeader1.MODIFY;
                //
                NissonErrorLogLine.RESET;
                NissonErrorLogLine.SETRANGE("File Name", ClientFileName);
                NissonErrorLogLine.SETRANGE(Status, NissonErrorLogLine.Status::Error);
                NissonErrorLogLine."Log Status" := NissonLogHeader."Log Status"::Nissan;
                IF NissonErrorLogLine.FINDSET THEN
                    REPEAT
                        NissonErrorLogLine.DELETE;
                    UNTIL NissonErrorLogLine.NEXT = 0;
                MESSAGE('Data Import successful\Total No of Records:%1\Total No of items updated:%2\New items inserted:%3\Total No of Error Items:%4\Skipped records:%5\For more information check the error log', SerialNum, Modified, Inserted, ErrorItem, Skipped);
            END;
        END ELSE BEGIN
            NissonLogHeader1.RESET;
            NissonLogHeader1.SETRANGE("No.", NissonLogHeader."No.");
            IF NissonLogHeader1.FINDFIRST THEN BEGIN
                NissonLogHeader1."No." := NissonLogHeader."No.";
                NissonLogHeader1."User Id" := USERID;
                NissonLogHeader1.UserName := UserName;
                NissonLogHeader1.Description := 'Nisson Price and Part Update';
                NissonLogHeader1."CreationDate&Time" := CURRENTDATETIME;
                NissonLogHeader1."End Time" := TIME;
                NissonLogHeader1."Record Inserted" := Inserted;
                NissonLogHeader1."Total No. of Items Updated" := Modified;
                NissonLogHeader1."Total No. Of Records" := SerialNum;
                NissonLogHeader1."Total No of Errors" := ErrorsCount;
                NissonLogHeader1.Status := NissonLogHeader1.Status::Error;
                NissonLogHeader1.MODIFY;
            END;
            MESSAGE('Data Import Error\Total No. of Records:%1\Total No. of items updated:%2\New items inserted:%3\Total No. of Error Items:%4\Skipped records:%5\For more information check the error log', SerialNum, Modified, Inserted, ErrorItem, Skipped);
        END;
    end;

    var
        FilePath: Text;
        Instr: InStream;
        vstring: Text;
        SFile: File;
        Item: Record Item;
        SelectedFile: Text;
        FileManagement: Codeunit "File Management";
        Item1: Record Item;
        ClientFileName: Text;
        NetWeight: Decimal;
        ListDate: Text;
        ListDate1: Date;
        DealerNetprice: Text;
        DealerNetprice1: Decimal;
        CountryOfOrigin: Code[20];
        NetWeight1: Text;
        PartNumber: Code[20];
        PkgQty: Text;
        PkgQty1: Integer;
        ListDate2: Text;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sales & Receivables Setup";
        User: Record User;
        UserName: Text;
        NissonErrorLogLine: Record "Semiannual Error Log Line";
        NissonLogHeader: Record "Semiannual Log Header";
        NissonLogHeader1: Record "Semiannual Log Header";
        ErrorsCount: Integer;
        ErrorMessage: Text;
        SerialNum: Integer;
        Inserted: Integer;
        Modified: Integer;
        CurrencyCode: Code[10];
        "Currency Factor": Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        AmountinUSD: Decimal;
        AmountinUSD1: Decimal;
        SuggestedCustomerPrice: Text;
        SuggestedCustomerPrice1: Decimal;
        IntegrationParameters: Record "Integration Parameters";
        position: Text;
        position1: Integer;
        FirstRec: Integer;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        Skipped: Integer;
        FileName: Code[10];
        Vendor: Record Vendor;
        PurchasePrice: Record "Purchase Price";
        ItemNo: Code[20];
        Startingtime: Time;
        StreamInTest: InStream;
        Buffer: Text[250];
        ProgressWindow: Dialog;
        DateInfo: Date;
        ErrorItem: Integer;
        Effective: Date;
        StockkeepingUnit: Record "Stockkeeping Unit";
        ItemCount: Integer;
        List1: Text;
        List2: Text;
        List3: Text;
        SuperSededPN: Text;
        RepBool: Boolean;
        ParentItemUpdate: Record Item;
        ApplicableModel: Record "Applicable Model";
        PurchasePriceVendorNo: Code[20];
        LastRec: Integer;
        Startdate: Date;
        PurchasePriceEnding: Record "Purchase Price";

    local procedure ErrorLogInfo(UserName: Text; SelectedFile: Text; ItemNo: Code[20]; Serialno: Integer; ErrorMessage: Text; HeadeNo: Code[20])
    begin
        SalesSetup.RESET;
        SalesSetup.GET;
        NissonErrorLogLine.INIT;
        ErrorsCount += 1;
        NissonErrorLogLine.No := NoSeriesManagement.GetNextNo(SalesSetup."Nisson Line", WORKDATE, TRUE);
        NissonErrorLogLine."User Id" := USERID;
        NissonErrorLogLine."User Name" := UserName;
        NissonErrorLogLine."File Name" := SelectedFile;
        NissonErrorLogLine."Item No." := ItemNo;
        NissonErrorLogLine."Line No." := Serialno;
        NissonErrorLogLine."Import Date & Time" := CURRENTDATETIME;
        NissonErrorLogLine."Exception Message" := ErrorMessage;
        NissonErrorLogLine.Status := NissonErrorLogLine.Status::Error;
        NissonErrorLogLine."Header No" := NissonLogHeader."No.";
        NissonErrorLogLine."Log Status" := NissonLogHeader."Log Status"::Nissan;
        NissonErrorLogLine.INSERT;
    end;

    procedure ConvertJPY2USDCurrency(Amount: Decimal; CurrencyInfo: Code[10])
    begin
        IF "Currency Factor" = 0 THEN
            "Currency Factor" := CurrExchRate.ExchangeRate(WORKDATE, CurrencyCode)
        ELSE
            "Currency Factor" := "Currency Factor";
        AmountinUSD := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE, CurrencyCode, Amount, "Currency Factor"), 0.01);
    end;

    procedure ConvertJPY2USDCurrency1(Amount: Decimal; CurrencyInfo: Code[10])
    begin
        IF "Currency Factor" = 0 THEN
            "Currency Factor" := CurrExchRate.ExchangeRate(WORKDATE, CurrencyCode)
        ELSE
            "Currency Factor" := "Currency Factor";
        AmountinUSD1 := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE, CurrencyCode, Amount, "Currency Factor"), 0.01);
    end;

    local procedure PurchasePriceUpdate()
    begin
        Vendor.RESET;
        Vendor.SETRANGE("No.", IntegrationParameters."Nissan Vendor No.");
        IF Vendor.FINDSET THEN BEGIN
            PurchasePrice.RESET;
            PurchasePrice.SETRANGE("Item No.", Item."No.");
            PurchasePrice.SETRANGE("Vendor No.", Vendor."No.");
            PurchasePrice.SETRANGE("Currency Code", CurrencyCode);
            PurchasePrice.SETRANGE("Starting Date", WORKDATE);
            IF PurchasePrice.FINDFIRST THEN BEGIN
                PurchasePrice."Vendor No." := Vendor."No.";
                PurchasePrice.VALIDATE("Vendor No.");
                PurchasePrice."Item No." := Item."No.";
                PurchasePrice.VALIDATE("Item No.");
                PurchasePrice."Currency Code" := CurrencyCode;
                PurchasePrice."Unit of Measure Code" := Item."Base Unit of Measure";
                PurchasePrice."Direct Unit Cost" := DealerNetprice1 * IntegrationParameters."Nissan Purchase Price Factor";
                PurchasePrice.VALIDATE("Direct Unit Cost");
                PurchasePrice.MODIFY;
            END ELSE BEGIN
                PurchasePrice.INIT;
                PurchasePrice."Vendor No." := Vendor."No.";
                PurchasePrice.VALIDATE("Vendor No.");
                PurchasePrice."Item No." := Item."No.";
                PurchasePrice.VALIDATE("Item No.");
                PurchasePrice."Starting Date" := WORKDATE;
                PurchasePrice."Currency Code" := CurrencyCode;
                PurchasePrice."Unit of Measure Code" := Item."Base Unit of Measure";
                PurchasePrice."Direct Unit Cost" := DealerNetprice1 * IntegrationParameters."Nissan Purchase Price Factor";
                PurchasePrice.VALIDATE("Direct Unit Cost");
                PurchasePrice.INSERT;
            END;
        END;
        //EP9615
        EndingPreviousPurchasePrice(Vendor."No.", Item."No.");
        //EP9615
    end;

    local procedure Parameter(ItemNo: Code[20])
    begin
        Item.RESET;
        Item.SETRANGE("No.", ItemNo);
        IF Item.FINDFIRST THEN BEGIN
            IntegrationParameters.RESET;
            IF IntegrationParameters.FINDFIRST THEN BEGIN
                Item.VALIDATE("Base Unit of Measure", IntegrationParameters."Nissan Base Unit of Measure");
                Item.VALIDATE("Sales Unit of Measure", IntegrationParameters."Nissan Sales Unit of Measure");
                Item.VALIDATE("Purch. Unit of Measure", IntegrationParameters."Nissan Purch. Unit of Measure");
                Item."Gen. Prod. Posting Group" := IntegrationParameters."NissanGeneral Prod. Post Group";
                Item.VALIDATE("Gen. Prod. Posting Group");
                Item."VAT Prod. Posting Group" := IntegrationParameters."Nissan VAT Prod. Posting Group";
                Item.VALIDATE("VAT Prod. Posting Group");
                Item."Inventory Posting Group" := IntegrationParameters."Nissan Inventory Posting Group";
                Item.VALIDATE("Inventory Posting Group");
                Item."Item Type" := IntegrationParameters."Nissan Item Type";
                Item."Item Category Code" := IntegrationParameters."Nissan Item Category Code";
                Item."Price/Profit Calculation" := IntegrationParameters."NissanPrice/ ProfitCalculation";
                Item."Global Dimension 1 Code" := IntegrationParameters."Nissan Agency Code";
                Item."Reordering Policy" := IntegrationParameters."Nissan Reordering Policy";
                Item."Order Tracking Policy" := IntegrationParameters."Nissan Order Tracking Policy";
                Item."Reorder Point" := IntegrationParameters."Nissan Reordering Point";
                Item."Reorder Quantity" := IntegrationParameters."Nissan Reorder Quantity";
                Item."Inventory Factor" := IntegrationParameters."Nissan Inventory Factor";
                Item."Sales Price Factor" := IntegrationParameters."Nissan Sales Price Factor";
                Item."Costing Method" := IntegrationParameters."Nissan Costing Method";
                Item.VALIDATE("Costing Method");
                Item."Vendor No." := IntegrationParameters."Nissan Vendor No.";
                Item."Prevent Negative Inventory" := IntegrationParameters."Nissan Prevent Negative Int.";
                Item."Standard Cost" := Item."Dealers Net Price" * IntegrationParameters."Nissan Inventory Factor";
                Item.VALIDATE("Standard Cost");
                Item."Unit Price" := Item."Dealers Net Price" * IntegrationParameters."Nissan Sales Price Factor";
                Item.VALIDATE("Unit Price");
                PurchasePriceUpdate;
                StockkeepingUnit.RESET;
                StockkeepingUnit.SETRANGE("Item No.", Item."No.");
                IF StockkeepingUnit.FINDSET THEN
                    REPEAT
                        StockkeepingUnit."Standard Cost" := Item."Standard Cost";
                        StockkeepingUnit.VALIDATE("Standard Cost");
                        StockkeepingUnit."Vendor No." := IntegrationParameters."Nissan Vendor No.";
                        StockkeepingUnit.MODIFY;
                    UNTIL StockkeepingUnit.NEXT = 0;
                Item.MODIFY(TRUE);
            END;
        END;
    end;

    local procedure NMLPriceUpdateLogic(Buffer: Text[250])
    begin
        ItemCount += 1;
        ListDate := COPYSTR(Buffer, 41, 6);
        ListDate2 := COPYSTR(ListDate, 3, 2) + '/' + COPYSTR(ListDate, 5, 2) + '/' + COPYSTR(ListDate, 1, 2);
        IF EVALUATE(ListDate1, ListDate2) AND EVALUATE(Day, COPYSTR(ListDate, 6, 2)) AND EVALUATE(Month, COPYSTR(ListDate, 3, 2)) AND EVALUATE(Year, COPYSTR(ListDate, 1, 2)) THEN
            Effective := ListDate1
        ELSE BEGIN
            ErrorMessage := STRSUBSTNO('The value "%1" given for Effective Date format is incorrect', ListDate2);
            ErrorLogInfo(UserName, ClientFileName, PartNumber, SerialNum, ErrorMessage, NissonLogHeader."No.");
        END;
        Item1.RESET;
        Item1.SETRANGE("No.", PartNumber);
        IF Item1.FINDFIRST THEN BEGIN
            IF Effective > Item1."Effective Date" THEN BEGIN
                Item1."No." := PartNumber;
                Item1.VALIDATE("No.");
                Item1.Description := COPYSTR(Buffer, 13, 15);
                CurrencyCode := COPYSTR(Buffer, 147, 3);
                SuggestedCustomerPrice := COPYSTR(Buffer, 28, 10);
                IF EVALUATE(SuggestedCustomerPrice1, SuggestedCustomerPrice) THEN BEGIN
                    ConvertJPY2USDCurrency(SuggestedCustomerPrice1, CurrencyCode);
                    Item1."Suggested Consumers Price" := AmountinUSD;
                END ELSE
                    IF SuggestedCustomerPrice = '' THEN
                        Item1."Suggested Consumers Price" := 0
                    ELSE BEGIN
                        ErrorMessage := STRSUBSTNO('The value "%1" given for Suggested Customer Price is not an integer', SuggestedCustomerPrice);
                        ErrorLogInfo(UserName, ClientFileName, Item1."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                    END;
                DealerNetprice := COPYSTR(Buffer, 53, 10);
                IF EVALUATE(DealerNetprice1, DealerNetprice) THEN BEGIN
                    ConvertJPY2USDCurrency1(DealerNetprice1, CurrencyCode);
                    Item1."Dealers Net Price" := AmountinUSD1;
                END ELSE BEGIN
                    IF DealerNetprice = '' THEN
                        Item1."Dealers Net Price" := 0
                    ELSE BEGIN
                        ErrorMessage := STRSUBSTNO('The value "%1" given for  Dealer Net price is not an integer', DealerNetprice);
                        ErrorLogInfo(UserName, ClientFileName, Item1."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                    END;
                END;
                PkgQty := COPYSTR(Buffer, 38, 3);
                IF EVALUATE(PkgQty1, PkgQty) THEN
                    Item1."Units per Parcel" := PkgQty1
                ELSE BEGIN
                    IF PkgQty = '' THEN
                        Item1."Units per Parcel" := 0
                    ELSE BEGIN
                        ErrorMessage := STRSUBSTNO('The value "%1" given for Package Quantity is not an integer', PkgQty);
                        ErrorLogInfo(UserName, ClientFileName, Item1."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                    END;
                END;
                Item1."Effective Date" := ListDate1;
                NetWeight1 := COPYSTR(Buffer, 63, 7);
                IF EVALUATE(NetWeight, NetWeight1) THEN
                    Item1."Net Weight (kg)" := NetWeight
                ELSE BEGIN
                    IF NetWeight1 = '' THEN
                        Item1."Net Weight (kg)" := 0
                    ELSE BEGIN
                        ErrorMessage := STRSUBSTNO('The value "%1" given for Net Weight is not an integer', NetWeight1);
                        ErrorLogInfo(UserName, ClientFileName, Item1."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                    END;
                END;
                Item1."Nissan File Type" := COPYSTR(Buffer, 141, 4);
                Item1."Part_Country of Origin" := COPYSTR(Buffer, 91, 3);
                Item1."HS Code" := COPYSTR(Buffer, 94, 18);
                //Cu020
                Item1."Applicable Model 1" := DELCHR(COPYSTR(Buffer, 206, 6), '=', ' ');
                IF NOT ApplicableModel.GET(Item1."Applicable Model 1") THEN BEGIN
                    ApplicableModel.INIT;
                    ApplicableModel."Applicable Model" := Item1."Applicable Model 1";
                    ApplicableModel.INSERT;
                END;
                Item1."Applicable Model 2" := DELCHR(COPYSTR(Buffer, 212, 6), '=', ' ');
                IF NOT ApplicableModel.GET(Item1."Applicable Model 2") THEN BEGIN
                    ApplicableModel.INIT;
                    ApplicableModel."Applicable Model" := Item1."Applicable Model 2";
                    ApplicableModel.INSERT;
                END;
                Item1."Applicable Model 3" := DELCHR(COPYSTR(Buffer, 218, 6), '=', ' ');
                IF NOT ApplicableModel.GET(Item1."Applicable Model 3") THEN BEGIN
                    ApplicableModel.INIT;
                    ApplicableModel."Applicable Model" := Item1."Applicable Model 3";
                    ApplicableModel.INSERT;
                END;
                Item1."Applicable Model 4" := DELCHR(COPYSTR(Buffer, 224, 6), '=', ' ');
                IF NOT ApplicableModel.GET(Item1."Applicable Model 4") THEN BEGIN
                    ApplicableModel.INIT;
                    ApplicableModel."Applicable Model" := Item1."Applicable Model 4";
                    ApplicableModel.INSERT;
                END;
                Item1."Applicable Model 5" := DELCHR(COPYSTR(Buffer, 230, 6), '=', ' ');
                IF NOT ApplicableModel.GET(Item1."Applicable Model 5") THEN BEGIN
                    ApplicableModel.INIT;
                    ApplicableModel."Applicable Model" := Item1."Applicable Model 5";
                    ApplicableModel.INSERT;
                END;
                Item1."Applicable Model 6" := DELCHR(COPYSTR(Buffer, 236, 6), '=', ' ');
                IF NOT ApplicableModel.GET(Item1."Applicable Model 6") THEN BEGIN
                    ApplicableModel.INIT;
                    ApplicableModel."Applicable Model" := Item1."Applicable Model 6";
                    ApplicableModel.INSERT;
                END;
                //Cu020
                NissonErrorLogLine.RESET;
                NissonErrorLogLine.SETRANGE("Item No.", PartNumber);
                NissonErrorLogLine.SETRANGE("Header No", NissonLogHeader."No.");
                NissonErrorLogLine.SETRANGE(Status, NissonErrorLogLine.Status::Error);
                NissonErrorLogLine."Log Status" := NissonLogHeader."Log Status"::Nissan;
                IF NissonErrorLogLine.FINDFIRST THEN
                    ErrorItem += 1
                ELSE BEGIN
                    IntegrationParameters.RESET;
                    IF IntegrationParameters.FINDFIRST THEN
                        IF Item1."Base Unit of Measure" = IntegrationParameters."Nissan Base Unit of Measure" THEN BEGIN
                            ReplacementUpdate;
                            Item1.MODIFY;
                            Modified += 1;
                            Parameter1(Item1."No.");
                        END ELSE
                            Skipped += 1;
                END;
            END ELSE
                Skipped += 1;
        END ELSE BEGIN
            Item.INIT;
            Item."No." := PartNumber;
            Item.VALIDATE("No.");
            Item.Description := COPYSTR(Buffer, 13, 15);
            CurrencyCode := COPYSTR(Buffer, 147, 3);
            SuggestedCustomerPrice := COPYSTR(Buffer, 28, 10);
            IF EVALUATE(SuggestedCustomerPrice1, SuggestedCustomerPrice) THEN BEGIN
                ConvertJPY2USDCurrency(SuggestedCustomerPrice1, CurrencyCode);
                Item."Suggested Consumers Price" := AmountinUSD;
            END ELSE
                IF SuggestedCustomerPrice = '' THEN
                    Item."Suggested Consumers Price" := 0
                ELSE BEGIN
                    ErrorMessage := STRSUBSTNO('The value "%1" given for Suggested Customer Price is not an integer', SuggestedCustomerPrice);
                    ErrorLogInfo(UserName, ClientFileName, Item."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                END;
            DealerNetprice := COPYSTR(Buffer, 53, 10);
            IF EVALUATE(DealerNetprice1, DealerNetprice) THEN BEGIN
                ConvertJPY2USDCurrency1(DealerNetprice1, CurrencyCode);
                Item."Dealers Net Price" := AmountinUSD1;
            END ELSE
                IF DealerNetprice = '' THEN
                    Item."Dealers Net Price" := 0
                ELSE BEGIN
                    ErrorMessage := STRSUBSTNO('The value "%1" given for  Dealer Net price is not an integer', DealerNetprice);
                    ErrorLogInfo(UserName, ClientFileName, Item."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                END;
            PkgQty := COPYSTR(Buffer, 38, 3);
            IF EVALUATE(PkgQty1, PkgQty) THEN
                Item."Units per Parcel" := PkgQty1
            ELSE BEGIN
                IF PkgQty = '' THEN
                    Item."Units per Parcel" := 0
                ELSE BEGIN
                    ErrorMessage := STRSUBSTNO('The value "%1" given for Package Quantity is not an integer', PkgQty);
                    ErrorLogInfo(UserName, ClientFileName, Item."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                END;
            END;
            Item."Effective Date" := ListDate1;
            NetWeight1 := COPYSTR(Buffer, 63, 7);
            IF EVALUATE(NetWeight, NetWeight1) THEN
                Item."Net Weight (kg)" := NetWeight
            ELSE BEGIN
                IF NetWeight1 = '' THEN
                    Item."Net Weight (kg)" := 0
                ELSE BEGIN
                    ErrorMessage := STRSUBSTNO('The value "%1" given for Net Weight is not an integer', NetWeight1);
                    ErrorLogInfo(UserName, ClientFileName, Item."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                END;
            END;
            Item."Nissan File Type" := COPYSTR(Buffer, 141, 4);
            Item."Part_Country of Origin" := COPYSTR(Buffer, 91, 3);
            Item."HS Code" := COPYSTR(Buffer, 94, 18);
            //Cu020
            Item."Applicable Model 1" := DELCHR(COPYSTR(Buffer, 206, 6), '=', ' ');
            IF NOT ApplicableModel.GET(Item."Applicable Model 1") THEN BEGIN
                ApplicableModel.INIT;
                ApplicableModel."Applicable Model" := Item."Applicable Model 1";
                ApplicableModel.INSERT;
            END;
            Item."Applicable Model 2" := DELCHR(COPYSTR(Buffer, 212, 6), '=', ' ');
            IF NOT ApplicableModel.GET(Item."Applicable Model 2") THEN BEGIN
                ApplicableModel.INIT;
                ApplicableModel."Applicable Model" := Item."Applicable Model 2";
                ApplicableModel.INSERT;
            END;
            Item."Applicable Model 3" := DELCHR(COPYSTR(Buffer, 218, 6), '=', ' ');
            IF NOT ApplicableModel.GET(Item."Applicable Model 3") THEN BEGIN
                ApplicableModel.INIT;
                ApplicableModel."Applicable Model" := Item."Applicable Model 3";
                ApplicableModel.INSERT;
            END;
            Item."Applicable Model 4" := DELCHR(COPYSTR(Buffer, 224, 6), '=', ' ');
            IF NOT ApplicableModel.GET(Item."Applicable Model 4") THEN BEGIN
                ApplicableModel.INIT;
                ApplicableModel."Applicable Model" := Item."Applicable Model 4";
                ApplicableModel.INSERT;
            END;
            Item."Applicable Model 5" := DELCHR(COPYSTR(Buffer, 230, 6), '=', ' ');
            IF NOT ApplicableModel.GET(Item."Applicable Model 5") THEN BEGIN
                ApplicableModel.INIT;
                ApplicableModel."Applicable Model" := Item."Applicable Model 5";
                ApplicableModel.INSERT;
            END;
            Item."Applicable Model 6" := DELCHR(COPYSTR(Buffer, 236, 6), '=', ' ');
            IF NOT ApplicableModel.GET(Item."Applicable Model 6") THEN BEGIN
                ApplicableModel.INIT;
                ApplicableModel."Applicable Model" := Item."Applicable Model 6";
                ApplicableModel.INSERT;
            END;
            //Cu020
            NissonErrorLogLine.RESET;
            NissonErrorLogLine.SETRANGE("Item No.", PartNumber);
            NissonErrorLogLine.SETRANGE("Header No", NissonLogHeader."No.");
            NissonErrorLogLine.SETRANGE(Status, NissonErrorLogLine.Status::Error);
            NissonErrorLogLine."Log Status" := NissonLogHeader."Log Status"::Nissan;
            IF NissonErrorLogLine.FINDFIRST THEN
                Skipped += 1
            ELSE BEGIN
                ReplacementInsert;
                Item.INSERT(TRUE);
                Inserted += 1;
                Parameter(Item."No.");
            END;
        END;
    end;

    local procedure NNAPriceUpdateLogic(Buffer: Text[250])
    begin
        ListDate := COPYSTR(Buffer, 41, 6);
        ListDate2 := COPYSTR(ListDate, 3, 2) + '/' + COPYSTR(ListDate, 6, 2) + '/' + COPYSTR(ListDate, 1, 2);
        IF EVALUATE(ListDate1, ListDate2) AND EVALUATE(Day, COPYSTR(ListDate, 6, 2)) AND EVALUATE(Month, COPYSTR(ListDate, 3, 2)) AND EVALUATE(Year, COPYSTR(ListDate, 1, 2)) THEN
            Effective := ListDate1
        ELSE BEGIN
            ErrorMessage := STRSUBSTNO('The value "%1" given for Effective Date format is incorrect', ListDate2);
            ErrorLogInfo(UserName, ClientFileName, PartNumber, SerialNum, ErrorMessage, NissonLogHeader."No.");
        END;
        Item1.RESET;
        Item1.SETRANGE("No.", PartNumber);
        IF Item1.FINDFIRST THEN BEGIN
            IF Effective > Item1."Effective Date" THEN BEGIN
                IF (Item1."Nissan File Type" = FileName) OR (Item1."Nissan File Type" = '') THEN BEGIN
                    Item1."No." := PartNumber;
                    Item1.VALIDATE("No.");
                    Item1.Description := COPYSTR(Buffer, 13, 15);
                    CurrencyCode := COPYSTR(Buffer, 147, 3);
                    DealerNetprice := COPYSTR(Buffer, 53, 10);
                    IF EVALUATE(DealerNetprice1, DealerNetprice) THEN BEGIN
                        Item1."Dealers Net Price" := DealerNetprice1;
                        Item1."Suggested Consumers Price" := DealerNetprice1 * 2;
                    END ELSE BEGIN
                        IF DealerNetprice = '' THEN
                            Item1."Dealers Net Price" := 0
                        ELSE BEGIN
                            ErrorMessage := STRSUBSTNO('The value "%1" given for Dealer Net price is not an integer', DealerNetprice);
                            ErrorLogInfo(UserName, ClientFileName, Item1."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                        END;
                    END;

                    PkgQty := COPYSTR(Buffer, 38, 3);
                    IF EVALUATE(PkgQty1, PkgQty) THEN
                        Item1."Units per Parcel" := PkgQty1
                    ELSE BEGIN
                        IF PkgQty = '' THEN
                            Item1."Units per Parcel" := 0
                        ELSE BEGIN
                            ErrorMessage := STRSUBSTNO('The value "%1" given for Package Quantity is not an integer', PkgQty);
                            ErrorLogInfo(UserName, ClientFileName, Item1."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                        END;
                    END;
                    Item1."Effective Date" := ListDate1;
                    NetWeight1 := COPYSTR(Buffer, 63, 7);
                    IF EVALUATE(NetWeight, NetWeight1) THEN
                        Item1."Net Weight (kg)" := NetWeight
                    ELSE BEGIN
                        IF NetWeight1 = '' THEN
                            Item1."Net Weight (kg)" := 0
                        ELSE BEGIN
                            ErrorMessage := STRSUBSTNO('The value "%1" given for Net Weight is not an integer', NetWeight1);
                            ErrorLogInfo(UserName, ClientFileName, Item1."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                        END;
                    END;
                    Item1."Nissan File Type" := COPYSTR(Buffer, 141, 4);
                    Item1."Part_Country of Origin" := COPYSTR(Buffer, 91, 3);
                    //Cu020
                    /*Item1."Applicable Model 1" := DELCHR(COPYSTR(Buffer,206,6),'=',' ');
                    IF NOT ApplicableModel.GET(Item1."Applicable Model 1") THEN BEGIN
                      ApplicableModel.INIT;
                      ApplicableModel."Applicable Model":=Item1."Applicable Model 1";
                      ApplicableModel.INSERT;
                    END;
                    Item1."Applicable Model 2" := DELCHR(COPYSTR(Buffer,212,6),'=',' ');
                    IF NOT ApplicableModel.GET(Item1."Applicable Model 2") THEN BEGIN
                      ApplicableModel.INIT;
                      ApplicableModel."Applicable Model":=Item1."Applicable Model 2";
                      ApplicableModel.INSERT;
                    END;
                    Item1."Applicable Model 3" := DELCHR(COPYSTR(Buffer,218,6),'=',' ');
                    IF NOT ApplicableModel.GET(Item1."Applicable Model 3") THEN BEGIN
                      ApplicableModel.INIT;
                      ApplicableModel."Applicable Model":=Item1."Applicable Model 3";
                      ApplicableModel.INSERT;
                    END;
                    Item1."Applicable Model 4" := DELCHR(COPYSTR(Buffer,224,6),'=',' ');
                    IF NOT ApplicableModel.GET(Item1."Applicable Model 4") THEN BEGIN
                      ApplicableModel.INIT;
                      ApplicableModel."Applicable Model":=Item1."Applicable Model 4";
                      ApplicableModel.INSERT;
                    END;
                    Item1."Applicable Model 5" := DELCHR(COPYSTR(Buffer,230,6),'=',' ');
                    IF NOT ApplicableModel.GET(Item1."Applicable Model 5") THEN BEGIN
                      ApplicableModel.INIT;
                      ApplicableModel."Applicable Model":=Item1."Applicable Model 5";
                      ApplicableModel.INSERT;
                    END;
                    Item1."Applicable Model 6" := DELCHR(COPYSTR(Buffer,236,6),'=',' ');
                    IF NOT ApplicableModel.GET(Item1."Applicable Model 6") THEN BEGIN
                      ApplicableModel.INIT;
                      ApplicableModel."Applicable Model":=Item1."Applicable Model 6";
                      ApplicableModel.INSERT;
                    END;*/
                    //Cu020
                    NissonErrorLogLine.RESET;
                    NissonErrorLogLine.SETRANGE("Item No.", PartNumber);
                    NissonErrorLogLine.SETRANGE("Header No", NissonLogHeader."No.");
                    NissonErrorLogLine.SETRANGE(Status, NissonErrorLogLine.Status::Error);
                    NissonErrorLogLine."Log Status" := NissonLogHeader."Log Status"::Nissan;
                    IF NissonErrorLogLine.FINDFIRST THEN
                        ErrorItem += 1
                    ELSE BEGIN
                        IntegrationParameters.RESET;
                        IF IntegrationParameters.FINDFIRST THEN
                            IF Item1."Base Unit of Measure" = IntegrationParameters."Nissan Base Unit of Measure" THEN BEGIN
                                //ReplacementUpdate;
                                Item1.MODIFY;
                                Modified += 1;
                                Parameter12(Item1."No.");
                            END ELSE
                                Skipped += 1;
                    END;
                END ELSE
                    Skipped += 1;
            END ELSE
                Skipped += 1;
        END ELSE BEGIN
            Item.INIT;
            Item."No." := PartNumber;
            Item.VALIDATE("No.");
            Item.Description := COPYSTR(Buffer, 13, 15);
            CurrencyCode := COPYSTR(Buffer, 147, 3);
            DealerNetprice := COPYSTR(Buffer, 53, 10);
            IF EVALUATE(DealerNetprice1, DealerNetprice) THEN BEGIN
                Item."Dealers Net Price" := DealerNetprice1;
                Item."Suggested Consumers Price" := DealerNetprice1 * 2;
            END ELSE
                IF DealerNetprice = '' THEN
                    Item."Dealers Net Price" := 0
                ELSE BEGIN
                    ErrorMessage := STRSUBSTNO('The value "%1" given for Dealer Net price is not an integer', DealerNetprice);
                    ErrorLogInfo(UserName, ClientFileName, Item."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                END;
            PkgQty := COPYSTR(Buffer, 38, 3);
            IF EVALUATE(PkgQty1, PkgQty) THEN
                Item."Units per Parcel" := PkgQty1
            ELSE BEGIN
                IF PkgQty = '' THEN
                    Item."Units per Parcel" := 0
                ELSE BEGIN
                    ErrorMessage := STRSUBSTNO('The value "%1" given for Package Quantity is not an integer', PkgQty);
                    ErrorLogInfo(UserName, ClientFileName, Item."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                END;
            END;
            Item."Effective Date" := ListDate1;
            NetWeight1 := COPYSTR(Buffer, 63, 7);
            IF EVALUATE(NetWeight, NetWeight1) THEN
                Item."Net Weight (kg)" := NetWeight
            ELSE BEGIN
                IF NetWeight1 = '' THEN
                    Item."Net Weight (kg)" := 0
                ELSE BEGIN
                    ErrorMessage := STRSUBSTNO('The value "%1" given for Net Weight is not an integer', NetWeight1);
                    ErrorLogInfo(UserName, ClientFileName, Item."No.", SerialNum, ErrorMessage, NissonLogHeader."No.");
                END;
            END;
            Item."Nissan File Type" := COPYSTR(Buffer, 141, 4);
            Item."Part_Country of Origin" := COPYSTR(Buffer, 91, 3);
            //Cu020
            /*Item."Applicable Model 1" := DELCHR(COPYSTR(Buffer,206,6),'=',' ');
            IF NOT ApplicableModel.GET(Item."Applicable Model 1") THEN BEGIN
              ApplicableModel.INIT;
              ApplicableModel."Applicable Model":=Item."Applicable Model 1";
              ApplicableModel.INSERT;
            END;
            Item."Applicable Model 2" := DELCHR(COPYSTR(Buffer,212,6),'=',' ');
            IF NOT ApplicableModel.GET(Item."Applicable Model 2") THEN BEGIN
              ApplicableModel.INIT;
              ApplicableModel."Applicable Model":=Item."Applicable Model 2";
              ApplicableModel.INSERT;
            END;
            Item."Applicable Model 3" := DELCHR(COPYSTR(Buffer,218,6),'=',' ');
            IF NOT ApplicableModel.GET(Item."Applicable Model 3") THEN BEGIN
              ApplicableModel.INIT;
              ApplicableModel."Applicable Model":=Item."Applicable Model 3";
              ApplicableModel.INSERT;
            END;
            Item."Applicable Model 4" := DELCHR(COPYSTR(Buffer,224,6),'=',' ');
            IF NOT ApplicableModel.GET(Item."Applicable Model 4") THEN BEGIN
              ApplicableModel.INIT;
              ApplicableModel."Applicable Model":=Item."Applicable Model 4";
              ApplicableModel.INSERT;
            END;
            Item."Applicable Model 5" := DELCHR(COPYSTR(Buffer,230,6),'=',' ');
            IF NOT ApplicableModel.GET(Item."Applicable Model 5") THEN BEGIN
              ApplicableModel.INIT;
              ApplicableModel."Applicable Model":=Item."Applicable Model 5";
              ApplicableModel.INSERT;
            END;
            Item."Applicable Model 6" := DELCHR(COPYSTR(Buffer,236,6),'=',' ');
            IF NOT ApplicableModel.GET(Item."Applicable Model 6") THEN BEGIN
              ApplicableModel.INIT;
              ApplicableModel."Applicable Model":=Item."Applicable Model 6";
              ApplicableModel.INSERT;
            END;*/
            //Cu020
            NissonErrorLogLine.RESET;
            NissonErrorLogLine.SETRANGE("Item No.", PartNumber);
            NissonErrorLogLine.SETRANGE("Header No", NissonLogHeader."No.");
            NissonErrorLogLine.SETRANGE(Status, NissonErrorLogLine.Status::Error);
            NissonErrorLogLine."Log Status" := NissonLogHeader."Log Status"::Nissan;
            IF NissonErrorLogLine.FINDFIRST THEN
                Skipped += 1
            ELSE BEGIN
                //ReplacementInsert;
                Item.INSERT(TRUE);
                Inserted += 1;
                Parameter11(Item."No.");
            END;
        END;

    end;

    local procedure Parameter1(ItemNo: Code[20])
    begin
        Item.RESET;
        Item.SETRANGE("No.", ItemNo);
        IF Item.FINDFIRST THEN BEGIN
            IntegrationParameters.RESET;
            IF IntegrationParameters.FINDFIRST THEN BEGIN
                Item."Item Type" := IntegrationParameters."Nissan Item Type";
                Item."Item Category Code" := IntegrationParameters."Nissan Item Category Code";
                Item."Price/Profit Calculation" := IntegrationParameters."NissanPrice/ ProfitCalculation";
                Item."Global Dimension 1 Code" := IntegrationParameters."Nissan Agency Code";
                Item."Reordering Policy" := IntegrationParameters."Nissan Reordering Policy";
                Item."Order Tracking Policy" := IntegrationParameters."Nissan Order Tracking Policy";
                Item."Reorder Point" := IntegrationParameters."Nissan Reordering Point";
                Item."Reorder Quantity" := IntegrationParameters."Nissan Reorder Quantity";
                Item."Inventory Factor" := IntegrationParameters."Nissan Inventory Factor";
                Item."Sales Price Factor" := IntegrationParameters."Nissan Sales Price Factor";
                Item."Costing Method" := IntegrationParameters."Nissan Costing Method";
                Item."Vendor No." := IntegrationParameters."Nissan Vendor No.";
                Item."Prevent Negative Inventory" := IntegrationParameters."Nissan Prevent Negative Int.";
                Item."Standard Cost" := Item."Dealers Net Price" * IntegrationParameters."Nissan Inventory Factor";
                Item.VALIDATE("Standard Cost");
                Item."Unit Price" := Item."Dealers Net Price" * IntegrationParameters."Nissan Sales Price Factor";
                Item.VALIDATE("Unit Price");
                PurchasePriceUpdate;
                StockkeepingUnit.RESET;
                StockkeepingUnit.SETRANGE("Item No.", Item."No.");
                IF StockkeepingUnit.FINDSET THEN
                    REPEAT
                        StockkeepingUnit."Standard Cost" := Item."Standard Cost";
                        StockkeepingUnit.VALIDATE("Standard Cost");
                        StockkeepingUnit."Vendor No." := IntegrationParameters."Nissan Vendor No.";
                        StockkeepingUnit.MODIFY;
                    UNTIL StockkeepingUnit.NEXT = 0;
                Item.MODIFY(TRUE);
            END;
        END;
    end;

    local procedure Parameter11(ItemNo: Code[20])
    begin
        Item.RESET;
        Item.SETRANGE("No.", ItemNo);
        IF Item.FINDFIRST THEN BEGIN
            IntegrationParameters.RESET;
            IF IntegrationParameters.FINDFIRST THEN BEGIN
                Item.VALIDATE("Base Unit of Measure", IntegrationParameters."Nissan Base Unit of Measure");
                Item.VALIDATE("Sales Unit of Measure", IntegrationParameters."Nissan Sales Unit of Measure");
                Item.VALIDATE("Purch. Unit of Measure", IntegrationParameters."Nissan Purch. Unit of Measure");
                Item."Gen. Prod. Posting Group" := IntegrationParameters."NissanGeneral Prod. Post Group";
                Item.VALIDATE("Gen. Prod. Posting Group");
                Item."VAT Prod. Posting Group" := IntegrationParameters."Nissan VAT Prod. Posting Group";
                Item.VALIDATE("VAT Prod. Posting Group");
                Item."Inventory Posting Group" := IntegrationParameters."Nissan Inventory Posting Group";
                Item.VALIDATE("Inventory Posting Group");
                Item."Item Type" := IntegrationParameters."Nissan Item Type";
                Item."Item Category Code" := IntegrationParameters."Nissan Item Category Code";
                Item."Price/Profit Calculation" := IntegrationParameters."NissanPrice/ ProfitCalculation";
                Item."Global Dimension 1 Code" := IntegrationParameters."Nissan Agency Code";
                Item."Reordering Policy" := IntegrationParameters."Nissan Reordering Policy";
                Item."Order Tracking Policy" := IntegrationParameters."Nissan Order Tracking Policy";
                Item."Reorder Point" := IntegrationParameters."Nissan Reordering Point";
                Item."Reorder Quantity" := IntegrationParameters."Nissan Reorder Quantity";
                Item."Inventory Factor" := IntegrationParameters."Nissan Inventory Factor";
                Item."Sales Price Factor" := IntegrationParameters."Nissan Sales Price Factor";
                Item."Costing Method" := IntegrationParameters."Nissan Costing Method";
                Item.VALIDATE("Costing Method");
                Item."Vendor No." := IntegrationParameters."Nissan Vendor No.";
                Item."Prevent Negative Inventory" := IntegrationParameters."Nissan Prevent Negative Int.";
                Item."Standard Cost" := Item."Dealers Net Price" * IntegrationParameters."Nissan Inventory Factor";
                Item.VALIDATE("Standard Cost");
                Item."Unit Price" := Item."Dealers Net Price" * IntegrationParameters."Nissan Sales Price Factor";
                Item.VALIDATE("Unit Price");
                PurchasePriceUpdate1;
                StockkeepingUnit.RESET;
                StockkeepingUnit.SETRANGE("Item No.", Item."No.");
                IF StockkeepingUnit.FINDSET THEN
                    REPEAT
                        StockkeepingUnit."Standard Cost" := Item."Standard Cost";
                        StockkeepingUnit.VALIDATE("Standard Cost");
                        StockkeepingUnit."Vendor No." := IntegrationParameters."Nissan Vendor No.";
                        // EP96-01 Updating Order Mutiple
                        IF StockkeepingUnit."Replenishment System" = StockkeepingUnit."Replenishment System"::Purchase THEN BEGIN
                            IF Item."Package Qty" <> 0 THEN
                                StockkeepingUnit."Order Multiple" := Item."Package Qty"
                            ELSE IF Item."Units per Parcel" <> 0 THEN
                                StockkeepingUnit."Order Multiple" := Item."Units per Parcel"
                        END;
                        // EP96-01 Updating Order Mutiple
                        StockkeepingUnit.MODIFY;
                    UNTIL StockkeepingUnit.NEXT = 0;
                Item.MODIFY(TRUE);
            END;
        END;
    end;

    local procedure Parameter12(ItemNo: Code[20])
    begin
        Item.RESET;
        Item.SETRANGE("No.", ItemNo);
        IF Item.FINDFIRST THEN BEGIN
            IntegrationParameters.RESET;
            IF IntegrationParameters.FINDFIRST THEN BEGIN
                Item."Item Type" := IntegrationParameters."Nissan Item Type";
                Item."Item Category Code" := IntegrationParameters."Nissan Item Category Code";
                Item."Price/Profit Calculation" := IntegrationParameters."NissanPrice/ ProfitCalculation";
                Item."Global Dimension 1 Code" := IntegrationParameters."Nissan Agency Code";
                Item."Reordering Policy" := IntegrationParameters."Nissan Reordering Policy";
                Item."Order Tracking Policy" := IntegrationParameters."Nissan Order Tracking Policy";
                Item."Reorder Point" := IntegrationParameters."Nissan Reordering Point";
                Item."Reorder Quantity" := IntegrationParameters."Nissan Reorder Quantity";
                Item."Inventory Factor" := IntegrationParameters."Nissan Inventory Factor";
                Item."Sales Price Factor" := IntegrationParameters."Nissan Sales Price Factor";
                Item."Costing Method" := IntegrationParameters."Nissan Costing Method";
                Item."Vendor No." := IntegrationParameters."Nissan Vendor No.";
                Item."Prevent Negative Inventory" := IntegrationParameters."Nissan Prevent Negative Int.";
                Item."Standard Cost" := Item."Dealers Net Price" * IntegrationParameters."Nissan Inventory Factor";
                Item.VALIDATE("Standard Cost");
                Item."Unit Price" := Item."Dealers Net Price" * IntegrationParameters."Nissan Sales Price Factor";
                Item.VALIDATE("Unit Price");
                PurchasePriceUpdate1;
                StockkeepingUnit.RESET;
                StockkeepingUnit.SETRANGE("Item No.", Item."No.");
                IF StockkeepingUnit.FINDSET THEN
                    REPEAT
                        StockkeepingUnit."Standard Cost" := Item."Standard Cost";
                        StockkeepingUnit.VALIDATE("Standard Cost");
                        StockkeepingUnit."Vendor No." := IntegrationParameters."Nissan Vendor No.";
                        // EP96-01 Updating Order Mutiple
                        IF StockkeepingUnit."Replenishment System" = StockkeepingUnit."Replenishment System"::Purchase THEN BEGIN
                            IF Item."Package Qty" <> 0 THEN
                                StockkeepingUnit."Order Multiple" := Item."Package Qty"
                            ELSE IF Item."Units per Parcel" <> 0 THEN
                                StockkeepingUnit."Order Multiple" := Item."Units per Parcel"
                        END;
                        // EP96-01 Updating Order Mutiple
                        StockkeepingUnit.MODIFY;
                    UNTIL StockkeepingUnit.NEXT = 0;
                Item.MODIFY(TRUE);
            END;
        END;
    end;

    local procedure PurchasePriceUpdate1()
    begin
        Vendor.RESET;
        Vendor.SETRANGE("No.", IntegrationParameters."Nissan Vendor No.");
        IF Vendor.FINDSET THEN BEGIN
            PurchasePrice.RESET;
            PurchasePrice.SETRANGE("Item No.", Item."No.");
            PurchasePrice.SETRANGE("Vendor No.", Vendor."No.");
            PurchasePrice.SETRANGE("Currency Code", CurrencyCode);
            PurchasePrice.SETRANGE("Starting Date", WORKDATE);
            IF PurchasePrice.FINDFIRST THEN BEGIN
                PurchasePrice."Vendor No." := Vendor."No.";
                PurchasePrice.VALIDATE("Vendor No.");
                PurchasePrice."Item No." := Item."No.";
                PurchasePrice.VALIDATE("Item No.");
                PurchasePrice."Currency Code" := CurrencyCode;
                PurchasePrice."Unit of Measure Code" := Item."Base Unit of Measure";
                PurchasePrice."Direct Unit Cost" := DealerNetprice1;
                PurchasePrice.VALIDATE("Direct Unit Cost");
                PurchasePrice.MODIFY;
            END ELSE BEGIN
                PurchasePrice.INIT;
                PurchasePrice."Vendor No." := Vendor."No.";
                PurchasePrice.VALIDATE("Vendor No.");
                PurchasePrice."Item No." := Item."No.";
                PurchasePrice.VALIDATE("Item No.");
                PurchasePrice."Starting Date" := WORKDATE;
                PurchasePrice."Currency Code" := CurrencyCode;
                PurchasePrice."Unit of Measure Code" := Item."Base Unit of Measure";
                PurchasePrice."Direct Unit Cost" := DealerNetprice1;
                PurchasePrice.VALIDATE("Direct Unit Cost");
                PurchasePrice.INSERT;
            END;
        END;
        //EP9615
        EndingPreviousPurchasePrice(Vendor."No.", Item."No.");
        //EP9615
    end;

    local procedure ReplacementUpdate()
    begin
        //EP9608-SuperSeded Part No
        RepBool := FALSE;
        SuperSededPN := DELCHR(COPYSTR(Buffer, 194, 12), '=', ' ');
        IF SuperSededPN <> '' THEN BEGIN
            SuperSededPN := 'N#' + SuperSededPN;
            Item1."Replacement Part Number" := SuperSededPN;
            Item1.RInd := TRUE;
            Item1."Replacement Part" := TRUE;
            ParentItemUpdate.SETRANGE("No.", SuperSededPN);
            IF ParentItemUpdate.FINDFIRST THEN BEGIN
                ParentItemUpdate.ParentReplacementItem := Item1."No.";
                ParentItemUpdate.MODIFY;
            END;
        END;
        //EP9608-SuperSeded Part No
    end;

    local procedure ReplacementInsert()
    begin
        //EP9608-SuperSeded Part No
        RepBool := FALSE;
        SuperSededPN := DELCHR(COPYSTR(Buffer, 194, 12), '=', ' ');
        IF SuperSededPN <> '' THEN BEGIN
            SuperSededPN := 'N#' + SuperSededPN;
            Item."Replacement Part Number" := SuperSededPN;
            Item.RInd := TRUE;
            Item."Replacement Part" := TRUE;
            ParentItemUpdate.SETRANGE("No.", SuperSededPN);
            IF ParentItemUpdate.FINDFIRST THEN BEGIN
                ParentItemUpdate.ParentReplacementItem := Item."No.";
                ParentItemUpdate.MODIFY;
            END;
        END;
        //EP9608-SuperSeded Part No
    end;

    local procedure EndingPreviousPurchasePrice(VendorNo: Code[20]; CurPartNo: Code[20])
    begin
        //EP9615
        LastRec := 0;
        Startdate := 0D;
        PurchasePriceEnding.RESET;
        PurchasePriceEnding.SETRANGE("Vendor No.", VendorNo);
        PurchasePriceEnding.SETRANGE("Item No.", CurPartNo);
        PurchasePriceEnding.SETRANGE("Ending Date", 0D);
        PurchasePriceEnding.SETCURRENTKEY("Starting Date");
        PurchasePriceEnding.SETASCENDING("Starting Date", FALSE);
        IF PurchasePriceEnding.FINDSET THEN
            REPEAT
                LastRec += 1;
                IF LastRec = 1 THEN
                    Startdate := PurchasePriceEnding."Starting Date" - 1;
                IF LastRec <> 1 THEN BEGIN
                    PurchasePriceEnding."Ending Date" := Startdate;
                    PurchasePriceEnding.MODIFY;
                END;
            UNTIL PurchasePriceEnding.NEXT = 0;
    end;
}

