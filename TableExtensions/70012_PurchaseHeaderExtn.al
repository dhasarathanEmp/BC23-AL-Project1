tableextension 70012 PurchaseHeaderExtn extends "Purchase Header"
{
    fields
    {

        //Unsupported feature: Property Insertion (Editable) on ""No."(Field 3)".


        //Unsupported feature: Property Modification (Data type) on ""Pay-to Address"(Field 7)".


        //Unsupported feature: Property Modification (Data type) on ""Pay-to Address 2"(Field 8)".


        //Unsupported feature: Property Modification (Data type) on ""Ship-to Address"(Field 15)".


        //Unsupported feature: Property Modification (Data type) on ""Ship-to Address 2"(Field 16)".


        //Unsupported feature: Property Modification (Data type) on ""Buy-from Address"(Field 81)".


        //Unsupported feature: Property Modification (Data type) on ""Buy-from Address 2"(Field 82)".


        //Unsupported feature: Code Modification on ""Buy-from Vendor No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." = '' THEN
          InitRecord;
        TESTFIELD(Status,Status::Open);
        IF ("Buy-from Vendor No." <> xRec."Buy-from Vendor No.") AND
           (xRec."Buy-from Vendor No." <> '')
        #6..28
        Vend.TESTFIELD("Gen. Bus. Posting Group");
        "Buy-from Vendor Name" := Vend.Name;
        "Buy-from Vendor Name 2" := Vend."Name 2";
        CopyBuyFromVendorAddressFieldsFromVendor(Vend,FALSE);
        IF NOT SkipBuyFromContact THEN
          "Buy-from Contact" := Vend.Contact;
        #35..39
        "VAT Registration No." := Vend."VAT Registration No.";
        VALIDATE("Lead Time Calculation",Vend."Lead Time Calculation");
        "Responsibility Center" := UserSetupMgt.GetRespCenter(1,Vend."Responsibility Center");
        ValidateEmptySellToCustomerAndLocation;

        IF "Buy-from Vendor No." = xRec."Pay-to Vendor No." THEN
        #46..83

        IF (xRec."Buy-from Vendor No." <> '') AND (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") THEN
          RecallModifyAddressNotification(GetModifyVendorAddressNotificationId);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "No." = '' THEN
          InitRecord;
        {
        //EP9620 Capture current reservation before changing vendor number, to reserve the same after vendor has changed and only for CD Agency vendors
        VendorMaster.RESET;
        VendorMaster.SETRANGE("No.",Rec."Buy-from Vendor No.");
        VendorMaster.SETRANGE("Agency Code",'CD');
        IF VendorMaster.FINDFIRST THEN
          CaptureCurrentReservation;
        //EP9620
        }
        #3..31
        "Customer Code" := Vend."Customer Code";
        #32..42
        "Agency Code" := Vend."Agency Code";
        #43..86
        */
        //end;


        //Unsupported feature: Code Modification on ""Currency Code"(Field 32).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT (CurrFieldNo IN [0,FIELDNO("Posting Date")]) OR ("Currency Code" <> xRec."Currency Code") THEN
          TESTFIELD(Status,Status::Open);
        IF (CurrFieldNo <> FIELDNO("Currency Code")) AND ("Currency Code" = xRec."Currency Code") THEN
        #4..17
              IF "Currency Factor" <> xRec."Currency Factor" THEN
                ConfirmUpdateCurrencyFactor;
            END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        {IF "Currency Code" = 'YER' THEN
          ExchangeRateRestriction;
          }
        #1..20
        */
        //end;
        field(50000; "Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
            OptionMembers = " ",Sales,Service,Purchase;
        }
        field(50001; "Applied Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
        }
        field(50003; "Service Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS002';
        }
        field(50004; Level; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Vendor Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50010; "Order Class Antares"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",E,S,W;
        }
        field(50011; "Customer Reference Number"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50012; "Agreement Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50013; "Letter of Credit Number"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50014; "Consolidated Ship Indicator"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50015; "Contract Number"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50016; "Consolidated Invoice Indicator"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50017; "Short Item Indicator"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",B,C;
        }
        field(50018; "Back Order Search Limit"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50019; "Antares Order Profile"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50020; "Mrkg Prg Auth Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50021; "Mrkg Prg Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50022; "Search Preference Customer Cod"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50023; "Marketing Program Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50026; "Acknowledgment Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50027; "Related Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50028; "Antares Order Entry Profile"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50029; "Batch Hold Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50030; "Dealer Order Entry Sys Version"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50031; "In Region Surface Indicator"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = " ",A,S,T;
        }
        field(50032; "Freight Plan Indicator"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50033; "Order Consolidation Indicator"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ","1","2";
        }
        field(50034; "Do Not Allow Ship Indicator"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N,B;
        }
        field(50035; "High Weight Indicator"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50036; "High Value Indicator"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50037; "Multiple Replaced Indicator"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50038; "High Demand Indicator"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50039; "Dealer Apply Service Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50040; "Future Date Order Source Day"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50041; "Release Control Indicator"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50042; "Sub Header Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = " ",S,H,M;
        }
        field(50043; "Consolidated Pack Indicator"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = " ",Y,N;
        }
        field(50044; "Import License Number"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50045; "Consolidation Group"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50046; "Purchase Order Number"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50047; "Out Reg.Surface OrderIndicator"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = " ",A,S;
        }
        field(50048; "IC Sales Order Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9615';
        }
        field(50049; "Agency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EP9615';
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitInsert;

    IF GETFILTER("Buy-from Vendor No.") <> '' THEN
      IF GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") THEN
        VALIDATE("Buy-from Vendor No.",GETRANGEMIN("Buy-from Vendor No."));

    IF "Purchaser Code" = '' THEN
      SetDefaultPurchaser;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8

    //  >> CUS002
      "Sales Type"  :=  "Sales Type"::Purchase;
      "Applied Doc. No."  :=  "No.";
    //  << CUS002

      "Assigned User ID" := USERID;
    */
    //end;


    //Unsupported feature: Code Modification on "RecreatePurchLines(PROCEDURE 4)".

    //procedure RecreatePurchLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT PurchLinesExist THEN
      EXIT;

    #4..76
                    TransferSavedFields(PurchLine,TempPurchLine);
                END;
            END;

            PurchLine.INSERT;
            ExtendedTextAdded := FALSE;

    #84..136
    END ELSE
      ERROR(
        Text018,ChangedFieldName);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..79
            //EP9621
            PurchLine."Planned Receipt Date" := TempPurchLine."Planned Receipt Date";
            PurchLine.LastPartNumber := TempPurchLine.LastPartNumber;
            PurchLine."Serial No" := TempPurchLine."Serial No";
            PurchLine."Part Type" := TempPurchLine."Part Type";
            PurchLine."Bin Code" := TempPurchLine."Bin Code";
            //EP9621
    #81..139
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateShipToAddress(PROCEDURE 21)".

    //procedure UpdateShipToAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF IsCreditDocType THEN
      EXIT;

    IF ("Location Code" <> '') AND Location.GET("Location Code") AND ("Sell-to Customer No." = '') THEN BEGIN
      SetShipToAddress(
        Location.Name,Location."Name 2",Location.Address,Location."Address 2",
        Location.City,Location."Post Code",Location.County,Location."Country/Region Code");
      "Ship-to Contact" := Location.Contact;
    END;
    #10..18
    END;

    OnAfterUpdateShipToAddress(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
        Location.Name,Location."T.R.No",Location.Address,Location."Address 2",
    #7..21
    */
    //end;


    //Unsupported feature: Code Modification on "SetShipToForSpecOrder(PROCEDURE 23)".

    //procedure SetShipToForSpecOrder();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Location.GET("Location Code") THEN BEGIN
      "Ship-to Code" := '';
      SetShipToAddress(
        Location.Name,Location."Name 2",Location.Address,Location."Address 2",
        Location.City,Location."Post Code",Location.County,Location."Country/Region Code");
      "Ship-to Contact" := Location.Contact;
      "Location Code" := Location.Code;
    #8..14
      "Ship-to Contact" := CompanyInfo."Ship-to Contact";
      "Location Code" := '';
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
        Location.Name,Location."T.R.No",Location.Address,Location."Address 2",
    #5..17
    */
    //end;


    //Unsupported feature: Code Modification on "SetSecurityFilterOnRespCenter(PROCEDURE 43)".

    //procedure SetSecurityFilterOnRespCenter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF UserSetupMgt.GetPurchasesFilter <> '' THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserSetupMgt.GetPurchasesFilter);
      FILTERGROUP(0);
    END;

    SETRANGE("Date Filter",0D,WORKDATE - 1);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    //SETRANGE("Date Filter",0D,WORKDATE - 1);
    */
    //end;


    //Unsupported feature: Code Modification on "AddSpecialOrderToAddress(PROCEDURE 80)".

    //procedure AddSpecialOrderToAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ShowError THEN BEGIN
      PurchLine3.RESET;
      PurchLine3.SETRANGE("Document Type","Document Type"::Order);
      PurchLine3.SETRANGE("Document No.","No.");
      IF NOT PurchLine3.ISEMPTY THEN BEGIN
        LocationCode.GET("Location Code");
        IF "Ship-to Name" <> LocationCode.Name THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Name"),"No.",SalesHeader."No.");
        IF "Ship-to Name 2" <> LocationCode."Name 2" THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Name 2"),"No.",SalesHeader."No.");
        IF "Ship-to Address" <> LocationCode.Address THEN
          ERROR(Text052,FIELDCAPTION("Ship-to Address"),"No.",SalesHeader."No.");
    #13..20
      END ELSE
        SetShipToForSpecOrder;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
        IF "Ship-to Name 2" <> LocationCode."T.R.No" THEN
    #10..23
    */
    //end;

    local procedure ExchangeRateRestriction()
    var
        E: Integer;
        ExcgRte: Record "Currency Exchange Rate";
    begin
        E := 0;
        ExcgRte.RESET;
        ExcgRte.SETRANGE("Currency Code", 'YER');
        IF ExcgRte.FINDSET THEN
            REPEAT BEGIN
                IF ExcgRte."Starting Date" = WORKDATE THEN
                    E := 1;
            END;
            UNTIL ExcgRte.NEXT = 0;
        IF E = 0 THEN
            ERROR('Update exchange rate in YER');
    end;

    local procedure CaptureCurrentReservation()
    var
        LineNo: Integer;
    begin
        LineNo := 0;
        POResvCancelandReReserve.DELETEALL;
        CurrReservePurchLine.RESET;
        CurrReservePurchLine.SETRANGE("Document No.", Rec."No.");
        CurrReservePurchLine.SETFILTER("Reserved Quantity", '>%1', 0);
        IF CurrReservePurchLine.FINDSET THEN
            REPEAT
                StoreReservationEntry.RESET;
                StoreReservationEntry.SETRANGE("Source ID", CurrReservePurchLine."Document No.");
                StoreReservationEntry.SETRANGE("Source Ref. No.", CurrReservePurchLine."Line No.");
                StoreReservationEntry.SETRANGE("Reservation Status", StoreReservationEntry."Reservation Status"::Reservation);
                IF StoreReservationEntry.FINDFIRST THEN
                    REPEAT
                        StoreReservationEntry1.RESET;
                        StoreReservationEntry1.SETRANGE("Entry No.", StoreReservationEntry."Entry No.");
                        StoreReservationEntry1.SETRANGE(Positive, FALSE);
                        IF StoreReservationEntry1.FINDFIRST THEN BEGIN
                            POResvCancelandReReserve."Line No" := LineNo + 1;
                            LineNo := POResvCancelandReReserve."Line No";
                            POResvCancelandReReserve."Source Type" := StoreReservationEntry1."Source Type";
                            POResvCancelandReReserve."Cancelled Qty" := StoreReservationEntry1."Quantity (Base)";
                            POResvCancelandReReserve."Source ID" := StoreReservationEntry1."Source ID";
                            POResvCancelandReReserve."Source Ref No" := StoreReservationEntry1."Source Ref. No.";
                            POResvCancelandReReserve."Source Sub Type" := StoreReservationEntry1."Source Subtype";
                            POResvCancelandReReserve."Location Code" := StoreReservationEntry1."Location Code";
                            POResvCancelandReReserve."Item No" := StoreReservationEntry1."Item No.";
                            POResvCancelandReReserve."PO Source Ref No" := CurrReservePurchLine."Line No.";
                            GetQuantityPer(StoreReservationEntry1."Source ID", StoreReservationEntry1."Source Ref. No.", StoreReservationEntry1."Source Type");
                            POResvCancelandReReserve."Quantity Per" := QuantityPer;
                            POResvCancelandReReserve."PO Number" := Rec."No.";
                            POResvCancelandReReserve.INSERT(TRUE);
                            ResEngManagement.CancelReservation(StoreReservationEntry1);
                        END;
                    UNTIL StoreReservationEntry.NEXT = 0;
            UNTIL CurrReservePurchLine.NEXT = 0;
    end;

    local procedure GetQuantityPer(SourceID: Code[30]; SourceRefNo: Integer; SourceType: Integer)
    var
        TransferLine: Record "Transfer Line";
        SalesLine: Record "Sales Line";
    begin
        QuantityPer := 0;
        IF SourceType = 5741 THEN BEGIN
            TransferLine.RESET;
            TransferLine.SETRANGE("Document No.", SourceID);
            TransferLine.SETRANGE("Line No.", SourceRefNo);
            IF TransferLine.FINDFIRST THEN
                QuantityPer := TransferLine."Qty. per Unit of Measure";
        END ELSE IF SourceType = 37 THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETRANGE("Document No.", SourceID);
            SalesLine.SETRANGE("Line No.", SourceRefNo);
            IF SalesLine.FINDFIRST THEN
                QuantityPer := SalesLine."Qty. per Unit of Measure";
        END
    end;

    var
        VendorMaster: Record Vendor;
        CurrReservePurchLine: Record "Purchase Line";
        POResvCancelandReReserve: Record "PO Resv Cancel and Re-Reserve";
        StoreReservationEntry: Record "Reservation Entry";
        StoreReservationEntry1: Record "Reservation Entry";
        QuantityPer: Decimal;
        ResEngManagement: Codeunit "Reservation Engine Mgt.";
}

