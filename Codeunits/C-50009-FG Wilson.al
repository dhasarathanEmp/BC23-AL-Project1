codeunit 50009 "FG Wilson"
{
    // EP96-01 Updating Order Mutiple
    // Cu014
    // IF01 Adding agency code as Postfix with Part No
    // EP9615 Updating Existing purchase price with end date

    //All files (*.*)|*.*"
    trigger OnRun()
    begin
        //ServerFileName := FileManagement.UploadFile(Text001, FileName);
        //UploadIntoStream(Text001, '', 'All Files (*.*)|*.*', FilePath, StreamInTest);
        FileManagement.BLOBImportWithFilter(TempBlob, Text001, '', FileManagement.GetToFilterText('', '.xlsx'), 'xlsx');
        TempBlob.CreateInStream(StreamInTest);
        Sheetname := ExcelBuffer.SelectSheetsNameStream(StreamInTest);
        ClientFileName := FileManagement.GetFileName(FilePath);
        SerialNum := 0;
        ErrorsCount := 0;
        Inserted := 0;
        Modified := 0;
        ErrorItems := 0;
        CLEAR(skip);
        User.SETRANGE("User Name", USERID);
        IF User.FINDFIRST THEN
            UserName := User."Full Name";

        FgwilsonLogHeader.INIT;
        SalesSetup.RESET;
        SalesSetup.GET;
        FgwilsonLogHeader."No." := NoSeriesManagement.GetNextNo(SalesSetup."Fg Wilson Header", WORKDATE, TRUE);
        FgwilsonLogHeader."Start Time" := TIME;
        FgwilsonLogHeader.Status := FgwilsonLogHeader.Status::Processing;
        FgwilsonLogHeader."Log Status" := FgwilsonLogHeader."Log Status"::"Fg wilson";
        FgwilsonLogHeader.INSERT;

        ExcelBuffer.LOCKTABLE;
        //ExcelBuffer.OpenBook(ServerFileName,Sheetname);
        ExcelBuffer.OpenBookStream(StreamInTest, Sheetname);
        ExcelBuffer.ReadSheet;
        GetLastRowColumn;
        IF TotalColumns = 10 THEN
            TotalRows := TotalRows
        ELSE BEGIN
            ErrorMessage := 'InCorrect File Format';
            insertAndModifyRec(UserName, ClientFileName, '', SerialNum, ErrorMessage, FgwilsonLogHeader."No.");
            ERROR('Invalid File Format');
        END;
        FOR I := 2 TO TotalRows DO
            Insertdata(I);
        ExcelBuffer.DELETEALL;
        IF ErrorsCount = 0 THEN BEGIN
            FgwilsonLogHeader1.RESET;
            FgwilsonLogHeader1.SETRANGE("No.", FgwilsonLogHeader."No.");
            IF FgwilsonLogHeader1.FINDFIRST THEN BEGIN
                FgwilsonLogHeader1."No." := FgwilsonLogHeader."No.";
                FgwilsonLogHeader1."User Id" := USERID;
                FgwilsonLogHeader1.UserName := UserName;
                FgwilsonLogHeader1.Description := 'Fg Wilson Part Price Update';
                FgwilsonLogHeader1."CreationDate&Time" := CURRENTDATETIME;
                FgwilsonLogHeader1."End Time" := TIME;
                FgwilsonLogHeader1."Total No. of Items Updated" := Modified;
                FgwilsonLogHeader1."Record Inserted" := Inserted;
                FgwilsonLogHeader1."Total No. Of Records" := SerialNum;
                FgwilsonLogHeader1."Total No of Errors" := ErrorsCount;
                FgwilsonLogHeader1.Status := FgwilsonLogHeader1.Status::Success;
                FgwilsonLogHeader1.MODIFY;

                FgWilsonPartslogLine.RESET;
                FgWilsonPartslogLine.SETRANGE("File Name", ClientFileName);
                FgWilsonPartslogLine.SETRANGE(Status, 'Error');
                FgWilsonPartslogLine."Log Status" := FgWilsonPartslogLine."Log Status"::"Fg wilson";
                IF FgWilsonPartslogLine.FINDSET THEN
                    REPEAT
                        FgWilsonPartslogLine.DELETE;
                    UNTIL FgWilsonPartslogLine.NEXT = 0;
                MESSAGE('Data Import successful\Total no. Of Records :%1\Total no. of items updated :%2\New items inserted :%3\Total no. of error items :%4\Skipped Recordes :%5\For more information check the error log', SerialNum, Modified, Inserted, ErrorItems,
              skip
              );
            END;
        END ELSE BEGIN
            FgwilsonLogHeader1.RESET;
            FgwilsonLogHeader1.SETRANGE("No.", FgwilsonLogHeader."No.");
            IF FgwilsonLogHeader1.FINDFIRST THEN BEGIN
                FgwilsonLogHeader1."No." := FgwilsonLogHeader."No.";
                FgwilsonLogHeader1."User Id" := USERID;
                FgwilsonLogHeader1.UserName := UserName;
                FgwilsonLogHeader1.Description := 'Fg Wilson Part Price Update';
                FgwilsonLogHeader1."CreationDate&Time" := CURRENTDATETIME;
                FgwilsonLogHeader1."End Time" := TIME;
                FgwilsonLogHeader1."Total No. of Items Updated" := Modified;
                FgwilsonLogHeader1."Record Inserted" := Inserted;
                FgwilsonLogHeader1."Total No. Of Records" := SerialNum;
                FgwilsonLogHeader1."Total No of Errors" := ErrorsCount;
                FgwilsonLogHeader1.Status := FgwilsonLogHeader1.Status::Error;
                FgwilsonLogHeader1.MODIFY;
            END;
            MESSAGE('Data Import Error\Total no. Of Records :%1\Total no. of items updated :%2\New items inserted :%3\Total no. of error items :%4\Skipped Recordes :%5\For more information check the error log', SerialNum, Modified, Inserted, ErrorItems, skip);
        END;
    end;

    var
        ServerFileName: Text;
        Sheetname: Text;
        FileManagement: Codeunit "File Management";
        TotalRows: Integer;
        Item: Record Item;
        ExcelBuffer: Record "Excel Buffer";
        ExcelBuffer1: Record "Excel Buffer";
        TotalColumns: Integer;
        FileName: Text;
        Text001: Label 'NAV File Browser';
        SalesSetup: Record "Sales & Receivables Setup";
        User: Record user;
        UserName: Text;
        SerialNum: Integer;
        FgwilsonLogHeader: Record "Daily Price Log Header";
        FgWilsonPartslogLine: Record "Daily Parts log Line";
        ErrorsCount: Integer;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        ErrorMessage: Text;
        ClientFileName: Text;
        Inserted: Integer;
        Modified: Integer;
        FgwilsonLogHeader1: Record "Daily Price Log Header";
        I: Integer;
        X: Integer;
        UOI: Integer;
        IntegrationParameters: Record "Integration Parameters";
        PowerExchangePartNumber: Code[20];
        Item1: Record Item;
        Item2: Record Item;
        skip: Integer;
        NewString: Text;
        Vendor: Record Vendor;
        PurchasePrice: Record "Purchase Price";
        Uoi1: Integer;
        XUoi1: Integer;
        NetStock: Decimal;
        XNetStock: Decimal;
        VorPrice: Decimal;
        XVorPrice: Decimal;
        XExchSurcharge: Decimal;
        FGW: Boolean;
        NetWeight: Decimal;
        XNetWeight: Decimal;
        ExchSurcharge1: Decimal;
        ExchSurcharge: Text;
        ErrorItems: Integer;
        StockkeepingUnit: Record "Stockkeeping Unit";
        ItemNo: Code[20];
        NetWeightKg: Decimal;
        PurchasePriceVendorNo: Code[20];
        LastRec: Integer;
        Startdate: Date;
        PurchasePriceEnding: Record "Purchase Price";
        FilePath: Text;
        StreamInTest: InStream;
        TempBlob: Codeunit "Temp Blob";

    procedure Insertdata(RowNo: Integer)
    begin
        FGW := FALSE;
        SerialNum += 1;
        ItemNo := GetValueatCell(RowNo, 1);
        ItemNo := 'F#' + ItemNo;//IF01
        Item.INIT;
        Item.SETRANGE("No.", ItemNo);
        IF Item.FINDSET THEN BEGIN
            //Cu014
            IF Item."Global Dimension 1 Code" <> 'FG' THEN BEGIN
                ErrorMessage := 'An Item of same Item No exists in different Agency';
                insertAndModifyRec(UserName, ClientFileName, Item."No.", SerialNum, ErrorMessage, FgwilsonLogHeader."No.");
            END;
            //EVALUATE(Item."No.",GetValueatCell(RowNo,1));
            EVALUATE(Item.Description, GetValueatCell(RowNo, 2));
            IF EVALUATE(Uoi1, GetValueatCell(RowNo, 3)) THEN BEGIN
                XUoi1 := Item.UOI;
                Item.UOI := Uoi1;
                IF XUoi1 <> Item.UOI THEN
                    FGW := TRUE;
            END ELSE BEGIN
                ErrorMessage := STRSUBSTNO('The value "%1" given for UOI is not an integer', GetValueatCell(RowNo, 3));
                insertAndModifyRec(UserName, ClientFileName, Item."No.", SerialNum, ErrorMessage, FgwilsonLogHeader."No.");
            END;

            IF EVALUATE(NetStock, GetValueatCell(RowNo, 4)) THEN BEGIN
                XNetStock := Item."Net Stock Price";
                Item."Net Stock Price" := NetStock / Uoi1;
                IF XNetStock <> Item."Net Stock Price" THEN
                    FGW := TRUE;
            END ELSE BEGIN
                ErrorMessage := STRSUBSTNO('The value "%1" given for Net Stock Price is not an integer', GetValueatCell(RowNo, 5));
                insertAndModifyRec(UserName, ClientFileName, Item."No.", SerialNum, ErrorMessage, FgwilsonLogHeader."No.");
            END;

            IF EVALUATE(VorPrice, GetValueatCell(RowNo, 5)) THEN BEGIN
                XVorPrice := Item."Dealers Net Price";
                Item."Dealers Net Price" := VorPrice / Uoi1;
                IF XVorPrice <> Item."Dealers Net Price" THEN
                    FGW := TRUE;
            END ELSE BEGIN
                ErrorMessage := STRSUBSTNO('The value "%1" given for Net VOR Price is not an integer', GetValueatCell(RowNo, 5));
                insertAndModifyRec(UserName, ClientFileName, Item."No.", SerialNum, ErrorMessage, FgwilsonLogHeader."No.");
            END;

            ExchSurcharge := GetValueatCell(RowNo, 6);
            NewString := DELCHR(ExchSurcharge, '<>', ' ');
            IF NewString = '' THEN BEGIN
                Item."Exchange Surcharge" := 0;
                Item."Dealer Net - Core Deposit" := 0;
            END
            ELSE BEGIN
                IF EVALUATE(ExchSurcharge1, ExchSurcharge) THEN BEGIN
                    XExchSurcharge := Item."Exchange Surcharge";
                    Item."Exchange Surcharge" := ExchSurcharge1;
                    Item."Dealer Net - Core Deposit" := ExchSurcharge1;
                    IF XExchSurcharge <> Item."Exchange Surcharge" THEN
                        FGW := TRUE;
                END ELSE BEGIN
                    ErrorMessage := STRSUBSTNO('The value "%1" given for Exchange Surcharge is not an integer', GetValueatCell(RowNo, 6));
                    insertAndModifyRec(UserName, ClientFileName, Item."No.", SerialNum, ErrorMessage, FgwilsonLogHeader."No.");
                END;
            END;

            /*IF EVALUATE(NetWeight,GetValueatCell(RowNo,7)) THEN BEGIN
              XNetWeight := Item."Net Weight (kg)";
              Item."Net Weight (kg)" := NetWeight/Uoi1;
              IF XNetWeight <> Item."Net Weight (kg)" THEN
                FGW := TRUE;
            END ELSE BEGIN
             ErrorMessage := STRSUBSTNO('The value "%1" given for Weight (kg) is not an integer', GetValueatCell(RowNo,7));
             insertAndModifyRec(UserName,ClientFileName,Item."No.",SerialNum,ErrorMessage,FgwilsonLogHeader."No.");
           END;*/
            EVALUATE(PowerExchangePartNumber, GetValueatCell(RowNo, 8));
            Item2.RESET;
            Item2.SETRANGE("No.", 'F#' + PowerExchangePartNumber);//IF01
            IF Item2.FINDFIRST THEN
                Item."Power Exchange Part Number" := 'F#' + PowerExchangePartNumber//IF01
            ELSE
                Item."Power Exchange Part Number" := '';

            FgWilsonPartslogLine.RESET;
            FgWilsonPartslogLine.SETRANGE("Item No.", Item."No.");
            FgWilsonPartslogLine.SETRANGE(Status, 'Error');
            FgWilsonPartslogLine.SETRANGE("Log Status", FgWilsonPartslogLine."Log Status"::"Fg wilson");
            FgWilsonPartslogLine.SETRANGE("Daily Header No", FgwilsonLogHeader."No.");
            IF FgWilsonPartslogLine.FINDFIRST THEN
                ErrorItems += 1
            ELSE BEGIN
                IF FGW = TRUE THEN BEGIN
                    Item.MODIFY;
                    Modified += 1;
                    Parameter1(Item."No.");
                END ELSE
                    skip += 1;
            END;
        END ELSE BEGIN
            Item1.INIT;
            EVALUATE(Item1."No.", ItemNo);
            EVALUATE(Item1.Description, GetValueatCell(RowNo, 2));
            IF EVALUATE(Uoi1, GetValueatCell(RowNo, 3)) THEN
                Item1.UOI := Uoi1
            ELSE BEGIN
                ErrorMessage := STRSUBSTNO('The value "%1" given for UOI is not an integer', GetValueatCell(RowNo, 3));
                insertAndModifyRec(UserName, ClientFileName, Item1."No.", SerialNum, ErrorMessage, FgwilsonLogHeader."No.");
            END;

            IF EVALUATE(NetStock, GetValueatCell(RowNo, 4)) THEN
                Item1."Net Stock Price" := NetStock / Uoi1
            ELSE BEGIN
                ErrorMessage := STRSUBSTNO('The value "%1" given for Net Stock Price is not an integer', GetValueatCell(RowNo, 5));
                insertAndModifyRec(UserName, ClientFileName, Item1."No.", SerialNum, ErrorMessage, FgwilsonLogHeader."No.");
            END;

            IF EVALUATE(VorPrice, GetValueatCell(RowNo, 5)) THEN
                Item1."Dealers Net Price" := VorPrice / Uoi1
            ELSE BEGIN
                ErrorMessage := STRSUBSTNO('The value "%1" given for Net VOR Price is not an integer', GetValueatCell(RowNo, 5));
                insertAndModifyRec(UserName, ClientFileName, Item1."No.", SerialNum, ErrorMessage, FgwilsonLogHeader."No.");
            END;
            EVALUATE(ExchSurcharge, GetValueatCell(RowNo, 6));
            NewString := DELCHR(ExchSurcharge, '<>', ' ');
            IF NewString = '' THEN BEGIN
                Item1."Exchange Surcharge" := 0;
                Item1."Dealer Net - Core Deposit" := 0;
            END
            ELSE BEGIN
                IF EVALUATE(Item1."Exchange Surcharge", ExchSurcharge) THEN BEGIN
                    Item1."Exchange Surcharge" := Item1."Exchange Surcharge";
                    Item1."Dealer Net - Core Deposit" := Item1."Exchange Surcharge";
                END
                ELSE BEGIN
                    ErrorMessage := STRSUBSTNO('The value "%1" given for Exchange Surcharge is not an integer', GetValueatCell(RowNo, 6));
                    insertAndModifyRec(UserName, ClientFileName, Item."No.", SerialNum, ErrorMessage, FgwilsonLogHeader."No.");
                END;
            END;
            /*IF EVALUATE(NetWeight,GetValueatCell(RowNo,7)) THEN BEGIN
              NetWeightKg := ROUND((NetWeight/Uoi1),0.001);//IF01
              Item1."Net Weight (kg)" := NetWeightKg;
            END ELSE BEGIN
              ErrorMessage := STRSUBSTNO('The value "%1" given for Weight is not an integer',GetValueatCell(RowNo,7));
              insertAndModifyRec(UserName,ClientFileName,Item1."No.",SerialNum,ErrorMessage,FgwilsonLogHeader."No.");
            END;*/
            EVALUATE(PowerExchangePartNumber, GetValueatCell(RowNo, 8));
            Item2.RESET;
            Item2.SETRANGE("No.", 'F#' + PowerExchangePartNumber);//IF01
            IF Item2.FINDFIRST THEN
                Item1."Power Exchange Part Number" := 'F#' + PowerExchangePartNumber //IF01
            ELSE
                Item1."Power Exchange Part Number" := '';
            //Item1."Power Exchange Part Number" := PowerExchangePartNumber;
            FgWilsonPartslogLine.RESET;
            FgWilsonPartslogLine.SETRANGE("Item No.", Item1."No.");
            FgWilsonPartslogLine.SETRANGE(Status, 'Error');
            FgWilsonPartslogLine.SETRANGE("Log Status", FgWilsonPartslogLine."Log Status"::"Fg wilson");
            FgWilsonPartslogLine.SETRANGE("Daily Header No", FgwilsonLogHeader."No.");
            IF FgWilsonPartslogLine.FINDFIRST THEN
                ErrorItems += 1
            ELSE BEGIN
                Item1.INSERT;
                Inserted += 1;
                Parameter(Item1."No.");
            END;
        END;

    end;

    procedure GetValueatCell(RowNo: Integer; ColNo: Integer): Text
    begin
        ExcelBuffer1.RESET;
        IF ExcelBuffer1.GET(RowNo, ColNo) THEN
            EXIT(ExcelBuffer1."Cell Value as Text")
        ELSE
            EXIT(' ');
    end;

    procedure GetLastRowColumn()
    begin
        ExcelBuffer.SETRANGE("Row No.", 1);
        TotalColumns := ExcelBuffer.COUNT;
        ExcelBuffer.RESET;
        IF ExcelBuffer.FINDLAST THEN
            TotalRows := ExcelBuffer."Row No.";
    end;

    local procedure insertAndModifyRec(UserName: Text; SelectedFile: Text; ItemNo: Code[30]; Serialno: Integer; ErrorMessage: Text; HeadeNo: Code[20])
    begin
        SalesSetup.RESET;
        SalesSetup.GET;
        FgWilsonPartslogLine.INIT;
        ErrorsCount += 1;
        FgWilsonPartslogLine.No := NoSeriesManagement.GetNextNo(SalesSetup."Fg Wilson Line", WORKDATE, TRUE);
        FgWilsonPartslogLine."User Id" := USERID;
        FgWilsonPartslogLine."User Name" := UserName;
        FgWilsonPartslogLine."File Name" := SelectedFile;
        FgWilsonPartslogLine."Item No." := ItemNo;
        FgWilsonPartslogLine."Line No." := Serialno;
        FgWilsonPartslogLine."Import Date & Time" := CURRENTDATETIME;
        FgWilsonPartslogLine."Exception Message" := ErrorMessage;
        FgWilsonPartslogLine.Status := 'Error';
        FgWilsonPartslogLine."Daily Header No" := HeadeNo;
        FgWilsonPartslogLine."Log Status" := FgWilsonPartslogLine."Log Status"::"Fg wilson";
        FgWilsonPartslogLine.INSERT;
    end;

    procedure Parameter(ItemNo: Code[20])
    begin
        Item1.RESET;
        Item1.SETRANGE("No.", ItemNo);
        IF Item1.FINDFIRST THEN BEGIN
            IntegrationParameters.RESET;
            IF IntegrationParameters.FINDFIRST THEN BEGIN
                Item1.VALIDATE("Base Unit of Measure", IntegrationParameters."FGW  Base Unit of Measure");
                Item1.VALIDATE("Sales Unit of Measure", IntegrationParameters."FGW Sales Unit of Measure");
                Item1.VALIDATE("Purch. Unit of Measure", IntegrationParameters."FGW Purch. Unit of Measure");
                Item1."Gen. Prod. Posting Group" := IntegrationParameters."FGW General Prod. Post Group";
                Item1."VAT Prod. Posting Group" := IntegrationParameters."FGW VAT Prod. Posting Group";
                Item1."Inventory Posting Group" := IntegrationParameters."FGW Inventory Posting Group";
                Item1."Item Type" := IntegrationParameters."FGW Item Type";
                Item1."Item Category Code" := IntegrationParameters."FGW Item Category Code";
                Item1."Price/Profit Calculation" := IntegrationParameters."FGW Price/ ProfitCalculation";
                Item1."Global Dimension 1 Code" := IntegrationParameters."FGW Agency Code";
                Item1."Reordering Policy" := IntegrationParameters."FGW Reordering Policy";
                Item1."Order Tracking Policy" := IntegrationParameters."FGW Order Tracking Policy";
                Item1."Reorder Point" := IntegrationParameters."FGW Reordering Point";
                Item1."Reorder Quantity" := IntegrationParameters."FGW Reorder Quantity";
                Item1."Inventory Factor" := IntegrationParameters."FGW Inventory Factor";
                Item1."Vendor No." := IntegrationParameters."FGW Vendor No.";
                Item1."Costing Method" := IntegrationParameters."FGW Costing Method";
                Item1."Sales Price Factor" := IntegrationParameters."FGW Sales Price Factor";
                Item1."Prevent Negative Inventory" := IntegrationParameters."FGW Prevent Negative Int.";
                Item1."Standard Cost" := (Item1."Dealers Net Price" + Item1."Dealer Net - Core Deposit") * IntegrationParameters."FGW Inventory Factor";
                Item1.VALIDATE("Standard Cost");
                Item1."Unit Price" := Item1."Dealers Net Price" * IntegrationParameters."FGW Sales Price Factor" + Item1."Dealer Net - Core Deposit" * IntegrationParameters."FGW Inventory Factor";
                Item1.VALIDATE("Unit Price");
                PurchasePriceUpdate;
                StockkeepingUnit.RESET;
                StockkeepingUnit.SETRANGE("Item No.", Item1."No.");
                IF StockkeepingUnit.FINDSET THEN
                    REPEAT
                        StockkeepingUnit."Standard Cost" := Item1."Dealers Net Price";
                        StockkeepingUnit.VALIDATE("Standard Cost");
                        StockkeepingUnit."Vendor No." := IntegrationParameters."FGW Vendor No.";
                        StockkeepingUnit.VALIDATE("Vendor No.");
                        // EP96-01 Updating Order Mutiple
                        IF StockkeepingUnit."Replenishment System" = StockkeepingUnit."Replenishment System"::Purchase THEN BEGIN
                            IF Item1."Package Qty" <> 0 THEN
                                StockkeepingUnit."Order Multiple" := Item1."Package Qty"
                            ELSE IF Item1."Units per Parcel" <> 0 THEN
                                StockkeepingUnit."Order Multiple" := Item1."Units per Parcel"
                        END;
                    // EP96-01 Updating Order Mutiple
                    UNTIL StockkeepingUnit.NEXT = 0;
                Item1.MODIFY;
            END;
        END;
    end;

    local procedure PurchasePriceUpdate()
    begin
        Vendor.RESET;
        Vendor.SETRANGE("No.", IntegrationParameters."FGW Vendor No.");
        IF Vendor.FINDSET THEN BEGIN
            PurchasePrice.RESET;
            PurchasePrice.SETRANGE("Item No.", Item1."No.");
            PurchasePrice.SETRANGE("Vendor No.", Vendor."No.");
            PurchasePrice.SETRANGE("Starting Date", WORKDATE);
            IF PurchasePrice.FINDFIRST THEN BEGIN
                PurchasePrice."Vendor No." := Vendor."No.";
                PurchasePrice."Item No." := Item1."No.";
                PurchasePrice."Unit of Measure Code" := Item1."Base Unit of Measure";
                PurchasePrice."Direct Unit Cost" := Item1."Dealers Net Price" + Item1."Dealer Net - Core Deposit";
                PurchasePrice."Currency Code" := 'USD';
                PurchasePrice."Starting Date" := WORKDATE;
                PurchasePrice.MODIFY;
            END ELSE BEGIN
                PurchasePrice.INIT;
                PurchasePrice."Vendor No." := Vendor."No.";
                PurchasePrice."Item No." := Item1."No.";
                PurchasePrice."Starting Date" := WORKDATE;
                PurchasePrice."Unit of Measure Code" := Item1."Base Unit of Measure";
                PurchasePrice."Direct Unit Cost" := Item1."Dealers Net Price" + Item1."Dealer Net - Core Deposit";
                PurchasePrice."Currency Code" := 'USD';
                PurchasePrice.INSERT;
            END;
        END;
        //EP9615
        EndingPreviousPurchasePrice(Vendor."No.", Item1."No.");
        //EP9615
    end;

    procedure Parameter1(ItemNo: Code[20])
    begin
        Item1.RESET;
        Item1.SETRANGE("No.", ItemNo);
        IF Item1.FINDFIRST THEN BEGIN
            IntegrationParameters.RESET;
            IF IntegrationParameters.FINDFIRST THEN BEGIN
                Item1."Costing Method" := IntegrationParameters."FGW Costing Method";
                Item1."Inventory Factor" := IntegrationParameters."FGW Inventory Factor";
                Item1."Vendor No." := IntegrationParameters."FGW Vendor No.";
                Item1."Sales Price Factor" := IntegrationParameters."FGW Sales Price Factor";
                Item1."Standard Cost" := (Item1."Dealers Net Price" + Item1."Dealer Net - Core Deposit") * IntegrationParameters."FGW Inventory Factor";
                Item1.VALIDATE("Standard Cost");
                Item1."Unit Price" := Item1."Dealers Net Price" * IntegrationParameters."FGW Sales Price Factor" + Item1."Dealer Net - Core Deposit" * IntegrationParameters."FGW Inventory Factor";
                Item1.VALIDATE("Unit Price");
                PurchasePriceUpdate;
                StockkeepingUnit.RESET;
                StockkeepingUnit.SETRANGE("Item No.", Item1."No.");
                IF StockkeepingUnit.FINDSET THEN
                    REPEAT
                        StockkeepingUnit."Standard Cost" := Item1."Standard Cost";
                        StockkeepingUnit.VALIDATE("Standard Cost");
                        StockkeepingUnit."Vendor No." := IntegrationParameters."FGW Vendor No.";
                        StockkeepingUnit.VALIDATE("Vendor No.");
                    UNTIL StockkeepingUnit.NEXT = 0;
                Item1.MODIFY;
            END;
        END;
    end;

    local procedure EndingPreviousPurchasePrice(VendorNo: Code[20]; CurPartNo: Code[20])
    begin
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

