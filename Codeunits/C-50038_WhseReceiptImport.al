codeunit 50038 "Whse Purch Receipt Import"
{
    // Cu012 Warehouse Receipt Import Customisation


    trigger OnRun()
    begin
    end;

    var
        ServerFileName: Text;
        Sheetname: Text;
        FileManagement: Codeunit "File Management";
        ExcelBuffer: Record "Excel Buffer";
        ExcelBuffer1: Record "Excel Buffer";
        I: Integer;
        X: Integer;
        Text001: Label 'NAV File Browser';
        FileName: Text;
        ClientFileName: Text;
        TotalRows: Integer;
        TotalColumns: Integer;
        BinContent: Record "Bin Content";
        Bincode: Code[20];
        UnitCost: Decimal;
        Item: Record Item;
        ItemNo: Text;
        "Count": Integer;
        SalesHeader1: Record "Sales Header";
        SalesHeader: Record "Sales Header";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        WarehouseReceiptLine1: Record "Warehouse Receipt Line";
        UnitPrice: Decimal;
        TempBlob: Codeunit "Temp Blob";
        FilePath: Text;
        StreamInTest: InStream;

    procedure WhsePurchReceiptImport(var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    begin
        FileManagement.BLOBImportWithFilter(TempBlob, Text001, '', FileManagement.GetToFilterText('', '.xlsx'), 'xlsx');
        TempBlob.CreateInStream(StreamInTest);
        Sheetname := ExcelBuffer.SelectSheetsNameStream(StreamInTest);
        ClientFileName := FileManagement.GetFileName(FilePath);
        ExcelBuffer.LOCKTABLE;
        //ExcelBuffer.OpenBook(ServerFileName,Sheetname);
        ExcelBuffer.OpenBookStream(StreamInTest, Sheetname);
        ExcelBuffer.ReadSheet;
        GetLastRowColumn;
        IF TotalColumns = 13 THEN
            TotalRows := TotalRows
        ELSE
            ERROR('InCorrect File Format ');
        FOR I := 2 TO TotalRows DO
            Insertdata(I, WarehouseReceiptHeader."No.", WarehouseReceiptHeader);
        //MESSAGE('Items are not available in the item master :'+ItemNo);
        IF Count <> 0 THEN
            MESSAGE('%1 lines imported', Count);
        ExcelBuffer.DELETEALL;
        CLEAR(ItemNo);
    end;

    procedure GetValueatCell(RowNo: Integer; ColNo: Integer): Text
    begin
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

    local procedure Insertdata(RowNo: Integer; DocNo: Code[10]; var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        SalesHeader: Record "Sales Header";
        SalesHeader1: Record "Sales Header";
        LineNo: Integer;
        VenQty: Decimal;
    begin
        WarehouseReceiptLine.RESET;
        WarehouseReceiptLine.SETRANGE("No.", DocNo);
        WarehouseReceiptLine.SETRANGE("Source No.", GetValueatCell(RowNo, 1));
        EVALUATE(LineNo, GetValueatCell(RowNo, 2));
        WarehouseReceiptLine.SETRANGE("Source Line No.", LineNo);
        WarehouseReceiptLine.SETRANGE("Serial No", GetValueatCell(RowNo, 9));
        WarehouseReceiptLine.SETRANGE("Item No.", GetValueatCell(RowNo, 3));
        IF WarehouseReceiptLine.FINDFIRST THEN BEGIN
            IF (GetValueatCell(RowNo, 10) = 'Y') OR (GetValueatCell(RowNo, 10) = 'y') THEN BEGIN
                EVALUATE(VenQty, GetValueatCell(RowNo, 5));
                IF VenQty = 0 THEN
                    ERROR('Line with PO Number %1 Serial No %2 does not contain Vendor Invoice Quantity', WarehouseReceiptLine."Source No.", WarehouseReceiptLine."Serial No")
                ELSE BEGIN
                    WarehouseReceiptLine.Received := TRUE;
                    WarehouseReceiptLine."Vendor Invoice Qty" := VenQty;
                    WarehouseReceiptLine.VALIDATE("Vendor Invoice Qty");

                    EVALUATE(WarehouseReceiptLine."Qty. to Receive", GetValueatCell(RowNo, 6));
                    WarehouseReceiptLine.VALIDATE("Qty. to Receive");
                    EVALUATE(WarehouseReceiptLine."Unit Price", GetValueatCell(RowNo, 7));
                    WarehouseReceiptLine.VALIDATE("Unit Price");
                    EVALUATE(WarehouseReceiptLine.Excess, GetValueatCell(RowNo, 8));
                    WarehouseReceiptLine.VALIDATE(Excess);
                    WarehouseReceiptLine.VALIDATE(Received, TRUE);
                    IF EVALUATE(WarehouseReceiptLine."Country/Region Code", GetValueatCell(RowNo, 11)) THEN
                        WarehouseReceiptLine.VALIDATE("Country/Region Code");
                    WarehouseReceiptLine."HS Code" := GetValueatCell(RowNo, 12);
                    WarehouseReceiptLine.VALIDATE("HS Code");
                    WarehouseReceiptLine."Bin Code" := GetValueatCell(RowNo, 13);
                    WarehouseReceiptLine.VALIDATE("Bin Code");
                    WarehouseReceiptLine.MODIFY;
                    Count += 1;
                END
            END
        END
        ELSE BEGIN
            IF (GetValueatCell(RowNo, 10) = 'Y') OR (GetValueatCell(RowNo, 10) = 'y') THEN
                ERROR('One or more lines to be modified by import does not match any existing lines');
        END;
    end;
}

