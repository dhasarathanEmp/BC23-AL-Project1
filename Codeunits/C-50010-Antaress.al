codeunit 50010 Antaress
{
    // //Cu012

    TableNo = 38;

    trigger OnRun()
    begin
        FileWrit(Rec);
    end;

    var
        PurchaseHeader1: Record "Purchase Header";
        "Purchase Header": Record "Purchase Header";
        RecordType: Code[10];
        RecordType1: Code[10];
        CustomerCode: Text;
        OrderClass: Text;
        CustrefNumber: Text;
        AgreementType: Text;
        DueDate: Text;
        DueDate1: Text;
        LetterofCredit: Text;
        ConsolidatedShipIndicator: Text;
        ImportLicenseNumber: Text;
        ContractNumber: Text;
        ConsolidatedInvoiceIndicator: Text;
        ShortItemIndicator: Text;
        BackOrderSearchLimit: Text;
        ANTARESOrderProfile: Text;
        MarketingProgramAuthorityCode: Text;
        MarketingProgramNumber: Text;
        SearchPreferenceCustomerCode: Text;
        MarketingProgramType: Text;
        OutofRegionSurfaceOrderIndicator: Text;
        AcknowledgmentType: Text;
        RelatedCustomerCode: Text;
        ANTARESOrderEntryProfile: Text;
        BatchHoldOrder: Text;
        DealerOrderEntrySystemVersion: Text;
        InRegioSurfaceOrderIndicator: Text;
        FreightPlanIndicator: Text;
        OrderConsolidationIndicator: Text;
        DoNotallowShipmentIndicator: Text;
        HighWeightIndicator: Text;
        HighValueIndicator: Text;
        MultipleReplacedIndicator: Text;
        HighDemandIndicator: Text;
        DealerApplyServiceCharge: Text;
        ConsolidatedPackIndicator: Text;
        FutureDateOrderSourceDays: Text;
        ReleaseControlIndicator: Text;
        SubHeaderType: Text;
        SerialNo: Integer;
        PartNumber: Text;
        OrderQuantity: Text;
        PartType: Text;
        PartName: Text;
        DealerBinLocation: Text;
        CustomerItemNumber: Text;
        Position: Integer;
        TExtInformation: Text;
        Mon: Integer;
        Yr: Integer;
        Dt: Integer;
        RecordType3: Code[10];
        RecordType2: Code[10];
        ItemCount: Text;
        RecordCount: Text;
        Position1: Integer;
        SerialNo1: Text;
        Position2: Integer;
        RecordCount1: Text;
        Position3: Integer;
        ItemCount1: Text;
        SerNum: Integer;
        PurchaseLine: Record "Purchase Line";
        Number: Integer;
        Filler: Text;
        Filler1: Text;
        PurchaseOrderNumber: Text;
        Value: Text;
        Fillertextline: Text;
        Fillertext: Text;
        FillerSubheading: Text;
        FillerSubheading1: Text;
        Fillertextline1: Text;
        FillerEnd: Text;
        FillerEnd1: Text;
        Space: Text;
        Space1: Text;
        Text002: Text;
        Text004: Text[300];
        FileMyHTML: File;
        OutStreamObj: OutStream;
        InTransitType: Text;
        PrimaryPSO: Text;
        RequestorID: Text;
        CopyQuoteOrder: Text;
        empty: Text;
        ConsolidationGroup: Text;
        FILLER11: Text;
        FILLER12: Text;
        MiscellaneousFloorIndicator: Text;
        BackwardReplacedIndicator: Text;
        FutureDatePenaltyIndicator: Text;
        CustomerApplyServiceCharge: Text;
        Text011: Text[400];
        Text001: Text[400];
        Text012: Text[400];
        Text013: Text[400];
        Text014: Text[300];
        Quantity: Text;
        Text033: Text[300];
        Text003: Text[300];
        Text034: Text[300];
        SerialNumber: Text;
        Text016: Text[300];
        Text015: Text[300];
        Text017: Text[300];
        AntaresForm: Record "Antares Form";
        Positionlen: Integer;
        Positionlen1: Integer;
        Instr: InStream;
        Outstr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: text;
        Content_M: Text;
        Rec_CompanyInformation: Record "Company Information";

    local procedure FileWrit(PurchaseHeader: Record "Purchase Header")
    begin

        /*AntaresForm.RESET;
        IF AntaresForm.FINDFIRST THEN
            //FileMyHTML.CREATE(AntaresForm."Data Stored Path"+FORMAT(PurchaseHeader."No.")+'.txt');
            //FileMyHTML.Create(AntaresForm."Data Stored Path" + '\' + FORMAT(PurchaseHeader."No.") + '.txt');
            //FileMyHTML.CREATEOUTSTREAM(OutStreamObj);

            FileName := 'Antares Form';
        TempBlob.CreateOutStream(Outstr, TextEncoding::Windows);
        Outstr.WriteText(Text001);
        Outstr.WriteText();

        TempBlob.CreateInStream(Instr, TextEncoding::Windows);
        DownloadFromStream(Instr, '', '', '', FileName);
    */

        CreatePurchaseHeader1(PurchaseHeader);
        CreatePurchaseHeader(PurchaseHeader);
        CreatePurchaseLine(PurchaseHeader);
        CreatePurchaseTrilar(PurchaseHeader);
        OutStreamObj.WRITETEXT();

        AntaresForm.RESET;
        IF AntaresForm.FINDFIRST THEN
            //FileMyHTML.CREATE(AntaresForm."Data Stored Path"+FORMAT(PurchaseHeader."No.")+'.txt');
            //FileMyHTML.Create(AntaresForm."Data Stored Path" + '\' + FORMAT(PurchaseHeader."No.") + '.txt');
            //FileMyHTML.CREATEOUTSTREAM(OutStreamObj);

            FileName := 'Antares Form';
        TempBlob.CreateOutStream(Outstr, TextEncoding::Windows);
        Outstr.WriteText(Text001);
        Outstr.WriteText();

    end;

    local procedure CreatePurchaseHeader(PurchaseHeader: Record "Purchase Header")
    begin
        empty := ' ';
        PurchaseHeader1.RESET;
        PurchaseHeader1.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseHeader1.SETRANGE("No.", PurchaseHeader."No.");
        IF PurchaseHeader1.FINDFIRST THEN BEGIN
            AntaresForm.RESET;
            IF AntaresForm.FINDFIRST THEN BEGIN
                RecordType1 := PADSTR(AntaresForm."Record Type Sub Header", 2, ' ');
                ;
                SubHeaderType := PADSTR(FORMAT(PurchaseHeader1."Sub Header Type"), 1, ' ');
                // FillerSubheading:='                                                                                                                                                    ';
                //FillerSubheading1:='                                                                                                                                                   ';
                FillerSubheading := PADSTR(empty, AntaresForm."Filler Sub Header" - 1, ' ');
            END;
            OutStreamObj.WRITETEXT();
            Text002 := RecordType1 + SubHeaderType + FillerSubheading + FillerSubheading1;
            //OutStreamObj.WRITE( Text002);
            Positionlen := STRLEN(Text002);
            Positionlen1 := Positionlen + 1;
            AntaresForm.RESET;
            IF AntaresForm.FINDFIRST THEN
                IF Positionlen1 = AntaresForm."Total Length Sub Header" THEN
                    OutStreamObj.WRITE(Text002)
                ELSE
                    ERROR('Line Length is Mismatch');
        END;
    end;

    local procedure CreatePurchaseLine(PurchaseHeader: Record "Purchase Header")
    begin
        empty := ' ';
        SerialNo := 0;
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        IF PurchaseLine.FINDSET THEN
            REPEAT
                IF PurchaseLine."No." = '' THEN
                    PurchaseLine."No." := PurchaseLine."No."
                ELSE BEGIN
                    SerialNo += 1;
                    AntaresForm.RESET;
                    IF AntaresForm.FINDFIRST THEN
                        RecordType2 := PADSTR(AntaresForm."Record Type Order Item", 2, ' ');
                    IF STRLEN(PurchaseLine."No.") > 6 THEN BEGIN
                        PartNumber := PADSTR(PurchaseLine."No.", 20, ' ');
                    END ELSE
                        PartNumber := PADSTR(PurchaseLine."No.", 19, ' ');
                    PartName := PADSTR(PurchaseLine.Description, 20, ' ');
                    PartType := PADSTR(PurchaseLine."Part Type", 2, ' ');
                    DealerBinLocation := PADSTR(PurchaseLine."Bin Code", 10, ' ');
                    //Fillertextline  :='                                                                                                                      ';
                    //Fillertextline1  :='                                                                                                                     ';
                    AntaresForm.RESET;
                    IF AntaresForm.FINDFIRST THEN
                        Fillertextline := PADSTR(empty, AntaresForm."Filler Order Item" - 1, ' ');
                    Quantity := FORMAT(PurchaseLine.Quantity);
                    Quantity := DELCHR(Quantity, '=', ',');
                    Position := STRLEN(Quantity);
                    CASE Position OF
                        0:
                            OrderQuantity := '00000';
                        1:
                            OrderQuantity := '0000';
                        2:
                            OrderQuantity := '000';
                        3:
                            OrderQuantity := '00';
                        4:
                            OrderQuantity := '0';
                    END;
                    Position1 := STRLEN(FORMAT(SerialNo));
                    CASE Position1 OF
                        0:
                            SerialNo1 := '0000';
                        1:
                            SerialNo1 := '000';
                        2:
                            SerialNo1 := '00';
                        3:
                            SerialNo1 := '0';
                    END;
                    //Cu012
                    PurchaseLine."Serial No" := SerialNo1 + FORMAT(SerialNo);
                    PurchaseLine.MODIFY(TRUE);
                    //Cu012
                    OutStreamObj.WRITETEXT();
                    IF STRLEN(PurchaseLine."No.") > 6 THEN BEGIN
                        Text033 := RecordType2 + PartNumber + OrderQuantity + Quantity + PartType + PartName + DealerBinLocation + SerialNo1;
                    END ELSE
                        Text033 := RecordType2 + ' ' + PartNumber + OrderQuantity + Quantity + PartType + PartName + DealerBinLocation + SerialNo1;

                    Text034 := FORMAT(SerialNo) + Fillertextline;
                    Text003 := Text033 + Text034;
                    // OutStreamObj.WRITE( Text003);
                    Positionlen := STRLEN(Text003);
                    Positionlen1 := Positionlen + 1;
                    AntaresForm.RESET;
                    IF AntaresForm.FINDFIRST THEN
                        IF Positionlen1 = AntaresForm."Total Length Order Item" THEN
                            OutStreamObj.WRITE(Text003)
                        ELSE
                            ERROR('Line Length is Mismatch');
                END;
            UNTIL PurchaseLine.NEXT = 0;
    end;

    local procedure CreatePurchaseTrilar(PurchaseHeader: Record "Purchase Header")
    begin
        empty := ' ';
        CLEAR(Number);
        AntaresForm.RESET;
        IF AntaresForm.FINDFIRST THEN
            RecordType3 := PADSTR(AntaresForm."Record type Eof", 2, ' ');
        ;
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        IF PurchaseLine.FINDSET THEN
            REPEAT
                Number += 1;
            UNTIL PurchaseLine.NEXT = 0;
        ItemCount := FORMAT(Number);
        RecordCount := FORMAT(Number + 3);
        Position2 := STRLEN(RecordCount);
        CASE Position2 OF
            0:
                RecordCount1 := '00000';
            1:
                RecordCount1 := '0000';
            2:
                RecordCount1 := '000';
            3:
                RecordCount1 := '00';
            4:
                RecordCount1 := '0';
        END;
        Position3 := STRLEN(ItemCount);
        CASE Position3 OF
            0:
                ItemCount1 := '00000';
            1:
                ItemCount1 := '0000';
            2:
                ItemCount1 := '000';
            3:
                ItemCount1 := '00';
            4:
                ItemCount1 := '0';
        END;
        //FillerEnd :='                                                                                                                                                ';
        //FillerEnd1 :='                                                                                                                                              ';
        AntaresForm.RESET;
        IF AntaresForm.FINDFIRST THEN
            FillerEnd := PADSTR(empty, AntaresForm."Filler EOF" - 1, ' ');
        OutStreamObj.WRITETEXT();
        Text004 := RecordType3 + ItemCount1 + ItemCount + RecordCount1 + RecordCount + FillerEnd;
        //OutStreamObj.WRITE( Text004);
        Positionlen := STRLEN(Text004);
        Positionlen1 := Positionlen + 1;
        AntaresForm.RESET;
        IF AntaresForm.FINDFIRST THEN
            IF Positionlen1 = AntaresForm."Total Length EOF" THEN
                OutStreamObj.WRITE(Text004)
            ELSE
                ERROR('Line Length is Mismatch');
    end;

    local procedure CreatePurchaseHeader1(PurchaseHeader: Record "Purchase Header")
    begin
        "Purchase Header" := PurchaseHeader;
        empty := '';
        AntaresForm.RESET;
        IF AntaresForm.FINDFIRST THEN
            RecordType := PADSTR(AntaresForm."Record Type Header", 2, ' ');
        CustomerCode := PADSTR(PurchaseHeader."Customer Code", 6, ' ');
        OrderClass := PADSTR(FORMAT(PurchaseHeader."Order Class Antares"), 1, ' ');
        CustrefNumber := PADSTR(PurchaseHeader."Customer Reference Number", 25, ' ');
        AgreementType := PADSTR(PurchaseHeader."Agreement Type", 5, ' ');
        IF PurchaseHeader."Due Date" = 0D THEN
            DueDate := PADSTR(FORMAT(PurchaseHeader."Due Date"), 10, ' ')
        ELSE BEGIN
            DueDate1 := FORMAT(PurchaseHeader."Due Date");
            Yr := DATE2DMY(PurchaseHeader."Due Date", 3);
            DueDate := FORMAT(Yr) + '-' + COPYSTR(DueDate1, 1, 2) + '-' + COPYSTR(DueDate1, 4, 2);
        END;
        LetterofCredit := PADSTR(PurchaseHeader."Letter of Credit Number", 40, ' ');
        ConsolidatedShipIndicator := PADSTR(FORMAT(PurchaseHeader."Consolidated Ship Indicator"), 1, ' ');
        ImportLicenseNumber := PADSTR(PurchaseHeader."Import License Number", 40, ' ');
        ContractNumber := PADSTR(PurchaseHeader."Contract Number", 40, ' ');
        ConsolidatedInvoiceIndicator := PADSTR(FORMAT(PurchaseHeader."Consolidated Invoice Indicator"), 1, ' ');
        ShortItemIndicator := PADSTR(FORMAT(PurchaseHeader."Short Item Indicator"), 1, ' ');
        BackOrderSearchLimit := PADSTR(FORMAT(PurchaseHeader."Back Order Search Limit"), 2, ' ');
        ANTARESOrderProfile := PADSTR(PurchaseHeader."Antares Order Profile", 5, ' ');
        MarketingProgramAuthorityCode := PADSTR(FORMAT(PurchaseHeader."Mrkg Prg Auth Code"), 2, ' ');
        MarketingProgramNumber := PADSTR(PurchaseHeader."Mrkg Prg Number", 6, ' ');
        SearchPreferenceCustomerCode := PADSTR(PurchaseHeader."Search Preference Customer Cod", 6, ' ');
        MarketingProgramType := PADSTR(PurchaseHeader."Marketing Program Type", 4, ' ');
        OutofRegionSurfaceOrderIndicator := PADSTR(FORMAT(PurchaseHeader."Out Reg.Surface OrderIndicator"), 1, ' ');
        AcknowledgmentType := PADSTR(PurchaseHeader."Acknowledgment Type", 1, ' ');
        RelatedCustomerCode := PADSTR(PurchaseHeader."Related Customer Code", 6, ' ');
        InTransitType := PADSTR(empty, 2, ' ');
        ANTARESOrderEntryProfile := PADSTR(PurchaseHeader."Antares Order Entry Profile", 8, ' ');
        PurchaseOrderNumber := PADSTR(PurchaseHeader."Purchase Order Number", 9, ' ');
        BatchHoldOrder := PADSTR(FORMAT(PurchaseHeader."Batch Hold Order"), 1, ' ');
        PrimaryPSO := PADSTR(empty, 9, ' ');
        RequestorID := PADSTR(empty, 3, ' ');
        CopyQuoteOrder := PADSTR(empty, 1, ' ');
        DealerOrderEntrySystemVersion := PADSTR(PurchaseHeader."Dealer Order Entry Sys Version", 3, ' ');
        InRegioSurfaceOrderIndicator := PADSTR(FORMAT(PurchaseHeader."In Region Surface Indicator"), 1, ' ');
        FreightPlanIndicator := PADSTR(FORMAT(PurchaseHeader."Freight Plan Indicator"), 1, ' ');
        OrderConsolidationIndicator := PADSTR(FORMAT(PurchaseHeader."Order Consolidation Indicator"), 1, ' ');
        ConsolidationGroup := PADSTR(PurchaseHeader."Consolidation Group", 2, ' ');
        AntaresForm.RESET;
        IF AntaresForm.FINDFIRST THEN
            FILLER11 := PADSTR(empty, AntaresForm.Filler, ' ');
        MiscellaneousFloorIndicator := PADSTR(empty, 1, ' ');
        DoNotallowShipmentIndicator := PADSTR(FORMAT(PurchaseHeader."Do Not Allow Ship Indicator"), 1, ' ');
        AntaresForm.RESET;
        IF AntaresForm.FINDFIRST THEN
            FILLER12 := PADSTR(empty, AntaresForm.Filler1, ' ');
        HighWeightIndicator := PADSTR(FORMAT(PurchaseHeader."High Weight Indicator"), 1, ' ');
        BackwardReplacedIndicator := PADSTR(empty, 1, ' ');
        HighValueIndicator := PADSTR(FORMAT(PurchaseHeader."High Value Indicator"), 1, ' ');
        MultipleReplacedIndicator := PADSTR(FORMAT(PurchaseHeader."Multiple Replaced Indicator"), 1, ' ');
        HighDemandIndicator := PADSTR(FORMAT(PurchaseHeader."High Demand Indicator"), 1, ' ');
        FutureDatePenaltyIndicator := PADSTR(empty, 1, ' ');
        CustomerApplyServiceCharge := PADSTR(empty, 1, ' ');
        DealerApplyServiceCharge := PADSTR(PurchaseHeader."Dealer Apply Service Charge", 1, ' ');
        ConsolidatedPackIndicator := PADSTR(FORMAT(PurchaseHeader."Consolidated Pack Indicator"), 1, ' ');
        FutureDateOrderSourceDays := PADSTR(PurchaseHeader."Future Date Order Source Day", 3, ' ');
        ReleaseControlIndicator := PADSTR(PurchaseHeader."Release Control Indicator", 1, ' ');
        AntaresForm.RESET;
        IF AntaresForm.FINDFIRST THEN
            Fillertext := PADSTR(empty, AntaresForm.Filler2 - 1, ' ');
        //OutStreamObj.WRITETEXT();
        Text011 := RecordType + CustomerCode + OrderClass + CustrefNumber + AgreementType + DueDate + LetterofCredit + ConsolidatedShipIndicator + ImportLicenseNumber + ContractNumber + ConsolidatedInvoiceIndicator + ShortItemIndicator;
        Text012 := BackOrderSearchLimit + ANTARESOrderProfile + MarketingProgramAuthorityCode + MarketingProgramNumber + SearchPreferenceCustomerCode + MarketingProgramType + OutofRegionSurfaceOrderIndicator + AcknowledgmentType + RelatedCustomerCode;
        Text013 := InTransitType + ANTARESOrderEntryProfile + PurchaseOrderNumber + BatchHoldOrder + PrimaryPSO + RequestorID + CopyQuoteOrder + DealerOrderEntrySystemVersion + InRegioSurfaceOrderIndicator + FreightPlanIndicator;
        Text014 := OrderConsolidationIndicator + ConsolidationGroup + FILLER11 + MiscellaneousFloorIndicator + DoNotallowShipmentIndicator + FILLER12 + HighWeightIndicator + BackwardReplacedIndicator + HighValueIndicator + MultipleReplacedIndicator;
        Text015 := (HighDemandIndicator + FutureDatePenaltyIndicator + CustomerApplyServiceCharge + DealerApplyServiceCharge + ConsolidatedPackIndicator + FutureDateOrderSourceDays + ReleaseControlIndicator + Fillertext);
        Text001 := (Text011 + Text012 + Text013 + Text014 + Text015);
        //OutStreamObj.WRITE(Text001);
        Positionlen := STRLEN(Text001);
        Positionlen1 := Positionlen + 1;
        AntaresForm.RESET;
        IF AntaresForm.FINDFIRST THEN
            IF Positionlen1 = AntaresForm."Total Length Header" THEN
                OutStreamObj.WRITE(Text001)
            ELSE
                ERROR('Line Length is Mismatch');
    end;
}

