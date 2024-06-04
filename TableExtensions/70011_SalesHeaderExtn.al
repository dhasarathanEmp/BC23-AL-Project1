tableextension 70011 SalesHeaderExtn extends "Sales Header"
{
    fields
    {

        //Unsupported feature: Property Insertion (Editable) on ""No."(Field 3)".


        //Unsupported feature: Property Modification (Editable) on "Status(Field 120)".


        //Unsupported feature: Code Modification on ""Sell-to Customer No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckCreditLimitIfLineNotInsertedYet;
        IF "No." = '' THEN
          InitRecord;
        #4..62
        "Sell-to Customer Template Code" := '';
        "Sell-to Customer Name" := Cust.Name;
        "Sell-to Customer Name 2" := Cust."Name 2";
        CopySellToCustomerAddressFieldsFromCustomer(Cust);
        IF NOT SkipSellToContact THEN
          "Sell-to Contact" := Cust.Contact;
        #69..108

        IF (xRec."Sell-to Customer No." <> '') AND (xRec."Sell-to Customer No." <> "Sell-to Customer No.") THEN
          RecallModifyAddressNotification(GetModifyCustomerAddressNotificationId);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..65
        //
        "VIN No." := Cust."Vin No.";
        "Vehicle Model No." := Cust."Vehicle Model  No.";
        //
        #66..111

        Rec."SO Version No." := '';
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
        #4..11
              IF "Currency Factor" <> xRec."Currency Factor" THEN
                ConfirmUpdateCurrencyFactor;
            END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Currency Code" = 'YER' THEN
          ExchangeRateRestriction;

        #1..14
        */
        //end;


        //Unsupported feature: Code Insertion on ""External Document No."(Field 100)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        IF "External Document No." <> '' THEN BEGIN
          SalesLineBuf1.RESET;
          SalesLineBuf1.SETRANGE("Document No.","No.");
          SalesLineBuf1.SETRANGE("Document Type",SalesLineBuf1."Document Type"::Order);
          IF SalesLineBuf1.FINDFIRST THEN BEGIN
            IF CONFIRM('Do you want to change PO No. in all sales line?',TRUE) THEN BEGIN
              SalesLineBuf.SETRANGE("Document No.","No.");
              SalesLineBuf.SETRANGE("Document Type",SalesLineBuf."Document Type"::Order);
              SalesLineBuf.MODIFYALL("PO Number","External Document No.");
            END ELSE
              "External Document No.":= xRec."External Document No.";
          END;
        END;
        */
        //end;


        //Unsupported feature: Code Modification on ""Sell-to Customer Template Code"(Field 5051).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Document Type","Document Type"::Quote);
        TESTFIELD(Status,Status::Open);

        #4..21
          SellToCustTemplate.TESTFIELD("Gen. Bus. Posting Group");
          "Gen. Bus. Posting Group" := SellToCustTemplate."Gen. Bus. Posting Group";
          "VAT Bus. Posting Group" := SellToCustTemplate."VAT Bus. Posting Group";
          IF "Bill-to Customer No." = '' THEN
            VALIDATE("Bill-to Customer Template Code","Sell-to Customer Template Code");
        END;
        #28..30
            (xRec."Currency Code" <> "Currency Code"))
        THEN
          RecreateSalesLines(FIELDCAPTION("Sell-to Customer Template Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..24
          //
          VALIDATE("Currency Code",SellToCustTemplate."Currency Code");
          //
        #25..33
        */
        //end;
        field(50000; "Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CS01,CUS001';
            OptionMembers = " ",Sales,Service,Purchase;
        }
        field(50001; "Applied Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
        }
        field(50002; Template; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CS13';
        }
        field(50003; "Customer PO date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
        }
        field(50005; "Branch Ref"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "VIN No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50007; "Vehicle Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50008; "Service Item No."; Code[20])
        {
            Description = 'CUS016';
        }
        field(50009; "Service Item Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50010; "Invoice Discount%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS023';
        }
        field(50011; "Price Validate"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS023';

            trigger OnValidate()
            var
                "Price Validatecheck": Integer;
            begin
                IF "Price Validate" <> '' THEN
                    IF NOT EVALUATE("Price Validatecheck", "Price Validate") THEN
                        ERROR('Your entry of %1 is not an acceptable value for Price Validate, %1 is not a valid Integer', "Price Validate");
            end;
        }
        field(50012; "Delivery Terms"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS023';

            trigger OnValidate()
            var
                "Delivery Terms Check": Integer;
            begin
            end;
        }
        field(50013; "CS Prepayment No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "No. Of Packages"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Customer Representative"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Vehicle Model No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Old Quote No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Document Type."; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Credit,Prepayment,Counter Sales,Temporary Delivery';
            OptionMembers = Credit,Prepayment,"Counter Sales","Temporary Delivery";
        }
        field(50019; "CR Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "CR External Reference No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Version No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Cu003';
        }
        field(50022; "Latest Version Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu003';
        }
        field(50023; "SO Version No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "SO Revision Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; Reserved; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; AFZDiscount; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu015';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50027; "Customer PO Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu015';
        }
        field(50028; "Agency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                IF "Posting Date" > 20220209D THEN BEGIN
                    SLExist.RESET;
                    SLExist.SETRANGE("Document No.", "No.");
                    IF SLExist.FINDFIRST THEN
                        ERROR('Lines exist, Unable to change Agency untill all the Lines are deleted');
                END
            end;
        }
        field(50029; "Not Shipped Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Outstanding Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                       "Document No." = FIELD("No.")));
            Description = 'MIS1';

        }
        field(50030; "Special Price Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu001';
        }
        field(50031; "Latest Released Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'EMP108.19';
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitInsert;
    InsertMode := TRUE;

    #4..7

    IF "Salesperson Code" = '' THEN
      SetDefaultSalesperson;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10

    //  >> CUS001 , CS01
    "Sales Type"  :=  "Sales Type"::Sales;
    //"Applied Doc. No."  :=  "No.";
    //  << CUS001 , CS01

    "Assigned User ID":= USERID;

    //EP9615
    "Shipment Date" := TODAY +90;
    //EP9615

    //For No. Series generation_Start
    IF ("Document Type" = SalesHeader."Document Type"::Quote) OR ("Document Type" = SalesHeader."Document Type"::Order) OR ("Document Type" = SalesHeader."Document Type"::Invoice) THEN BEGIN
      NoSeries.RESET;
      NoSeries.SETRANGE(ResponsibilityCenter,"Responsibility Center");
      NoSeries.SETRANGE("No Series Type",NoSeries."No Series Type"::Invoice);
      IF NoSeries.FINDFIRST THEN
        "Posting No. Series" := NoSeries.Code;
      END;

    IF ("Document Type" = SalesHeader."Document Type"::"Return Order") OR ("Document Type" = SalesHeader."Document Type"::"Credit Memo")THEN BEGIN
      NoSeries.RESET;
      NoSeries.SETRANGE(ResponsibilityCenter,"Responsibility Center");
      NoSeries.SETRANGE("No Series Type",NoSeries."No Series Type"::"Credit Memo");
      IF NoSeries.FINDFIRST THEN
        "Posting No. Series" := NoSeries.Code;
      END;
    //End
    */
    //end;


    //Unsupported feature: Code Modification on "InitRecord(PROCEDURE 10)".

    //procedure InitRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesSetup.GET;

    CASE "Document Type" OF
      "Document Type"::Quote,"Document Type"::Order:
        BEGIN
          NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Invoice Nos.");
          NoSeriesMgt.SetDefaultSeries("Shipping No. Series",SalesSetup."Posted Shipment Nos.");
          IF "Document Type" = "Document Type"::Order THEN BEGIN
            NoSeriesMgt.SetDefaultSeries("Prepayment No. Series",SalesSetup."Posted Prepmt. Inv. Nos.");
    #10..16
          THEN
            "Posting No. Series" := "No. Series"
          ELSE
            NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Invoice Nos.");
          IF SalesSetup."Shipment on Invoice" THEN
            NoSeriesMgt.SetDefaultSeries("Shipping No. Series",SalesSetup."Posted Shipment Nos.");
        END;
      "Document Type"::"Return Order":
        BEGIN
          NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Credit Memo Nos.");
          NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series",SalesSetup."Posted Return Receipt Nos.");
        END;
      "Document Type"::"Credit Memo":
    #30..32
          THEN
            "Posting No. Series" := "No. Series"
          ELSE
            NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Credit Memo Nos.");
          IF SalesSetup."Return Receipt on Credit Memo" THEN
            NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series",SalesSetup."Posted Return Receipt Nos.");
        END;
    #40..71
    "Doc. No. Occurrence" := ArchiveManagement.GetNextOccurrenceNo(DATABASE::"Sales Header","Document Type","No.");

    OnAfterInitRecord(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SalesSetup.GET;
    IF ("Document Type" = SalesHeader."Document Type"::Quote) OR ("Document Type" = SalesHeader."Document Type"::Order) OR ("Document Type" = SalesHeader."Document Type"::Invoice) THEN BEGIN
      NoSeries.RESET;
      NoSeries.SETRANGE(ResponsibilityCenter,Rec."Responsibility Center");
      NoSeries.SETRANGE("No Series Type",NoSeries."No Series Type"::Invoice);
      IF NoSeries.FINDFIRST THEN BEGIN
        InvoiceNo := NoSeries.Code;
      END ELSE
            InvoiceNo := SalesSetup."Posted Invoice Nos.";
    END ELSE
      IF ("Document Type" = SalesHeader."Document Type"::"Return Order") OR ("Document Type" = SalesHeader."Document Type"::"Credit Memo")THEN BEGIN
        NoSeries.RESET;
        NoSeries.SETRANGE(ResponsibilityCenter,Rec."Responsibility Center");
        NoSeries.SETRANGE("No Series Type",NoSeries."No Series Type"::"Credit Memo");
        IF NoSeries.FINDFIRST THEN BEGIN
          InvoiceNo := NoSeries.Code;
        END ELSE
          InvoiceNo := SalesSetup."Posted Invoice Nos.";
    END;

    #2..5
          NoSeriesMgt.SetDefaultSeries("Posting No. Series",InvoiceNo);
          //NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Invoice Nos.");
    #7..19
            NoSeriesMgt.SetDefaultSeries("Posting No. Series",InvoiceNo);
           // NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Invoice Nos.");
    #21..25
          NoSeriesMgt.SetDefaultSeries("Posting No. Series",InvoiceNo);
          //NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Credit Memo Nos.");
    #27..35
            NoSeriesMgt.SetDefaultSeries("Posting No. Series",InvoiceNo);
            //NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Credit Memo Nos.");
    #37..74
    */
    //end;


    //Unsupported feature: Code Modification on "ConfirmDeletion(PROCEDURE 11)".

    //procedure ConfirmDeletion();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SourceCodeSetup.GET;
    SourceCodeSetup.TESTFIELD("Deleted Document");
    SourceCode.GET(SourceCodeSetup."Deleted Document");

    PostSalesDelete.InitDeleteHeader(
      Rec,SalesShptHeader,SalesInvHeader,SalesCrMemoHeader,ReturnRcptHeader,
      SalesInvHeaderPrepmt,SalesCrMemoHeaderPrepmt,SourceCode.Code);

    IF SalesShptHeader."No." <> '' THEN
      IF NOT CONFIRM(Text009,TRUE,SalesShptHeader."No.") THEN
        EXIT;
    IF SalesInvHeader."No." <> '' THEN
      IF NOT CONFIRM(Text012,TRUE,SalesInvHeader."No.") THEN
        EXIT;
    IF SalesCrMemoHeader."No." <> '' THEN
      IF NOT CONFIRM(Text014,TRUE,SalesCrMemoHeader."No.") THEN
        EXIT;
    IF ReturnRcptHeader."No." <> '' THEN
      IF NOT CONFIRM(Text030,TRUE,ReturnRcptHeader."No.") THEN
        EXIT;
    IF "Prepayment No." <> '' THEN
      IF NOT CONFIRM(Text056,TRUE,SalesInvHeaderPrepmt."No.") THEN
        EXIT;
    IF "Prepmt. Cr. Memo No." <> '' THEN
      IF NOT CONFIRM(Text057,TRUE,SalesCrMemoHeaderPrepmt."No.") THEN
        EXIT;
    EXIT(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    //EP92-01 Error Message instead of warning
    IF SalesShptHeader."No." <> '' THEN
      ERROR(CusText001);
      {IF NOT CONFIRM(Text009,TRUE,SalesShptHeader."No.") THEN
        EXIT;}
    IF SalesInvHeader."No." <> '' THEN
      ERROR(CusText001);
      {IF NOT CONFIRM(Text012,TRUE,SalesInvHeader."No.") THEN
        EXIT;}
    IF SalesCrMemoHeader."No." <> '' THEN
      ERROR(CusText001);
      {IF NOT CONFIRM(Text014,TRUE,SalesCrMemoHeader."No.") THEN
        EXIT;}
    IF ReturnRcptHeader."No." <> '' THEN
      ERROR(CusText001);
      {IF NOT CONFIRM(Text030,TRUE,ReturnRcptHeader."No.") THEN
        EXIT;}
    IF "Prepayment No." <> '' THEN
      ERROR(CusText001);
      {IF NOT CONFIRM(Text056,TRUE,SalesInvHeaderPrepmt."No.") THEN
        EXIT;}
    IF "Prepmt. Cr. Memo No." <> '' THEN
      ERROR(CusText001);
      {IF NOT CONFIRM(Text057,TRUE,SalesCrMemoHeaderPrepmt."No.") THEN
        EXIT;}
    EXIT(TRUE);
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateShipToAddress(PROCEDURE 31)".

    //procedure UpdateShipToAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF IsCreditDocType THEN
      IF "Location Code" <> '' THEN BEGIN
        Location.GET("Location Code");
        SetShipToAddress(
          Location.Name,Location."Name 2",Location.Address,Location."Address 2",Location.City,
          Location."Post Code",Location.County,Location."Country/Region Code");
        "Ship-to Contact" := Location.Contact;
      END ELSE BEGIN
    #9..15
      END;

    OnAfterUpdateShipToAddress(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
          Location.Name,Location."T.R.No",Location.Address,Location."Address 2",Location.City,
    #6..18
    */
    //end;


    //Unsupported feature: Code Modification on "CreateSalesLine(PROCEDURE 78)".

    //procedure CreateSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLine.INIT;
    SalesLine."Line No." := SalesLine."Line No." + 10000;
    SalesLine.VALIDATE(Type,TempSalesLine.Type);
    #4..15
        SalesLine."Purchase Order No." := TempSalesLine."Purchase Order No.";
        SalesLine."Purch. Order Line No." := TempSalesLine."Purch. Order Line No.";
        SalesLine."Drop Shipment" := SalesLine."Purch. Order Line No." <> 0;
      END;
      SalesLine.VALIDATE("Shipment Date",TempSalesLine."Shipment Date");
    END;
    SalesLine.INSERT;
    OnAfterCreateSalesLine(SalesLine,TempSalesLine);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..18
        SalesLine."BOM Item No" := TempSalesLine."BOM Item No";
        SalesLine."BOM Item No." := TempSalesLine."BOM Item No.";
        SalesLine."BOM Main Line No." := TempSalesLine."BOM Main Line No.";
        SalesLine."BOM Quantity Per" := TempSalesLine."BOM Quantity Per";
        SalesLine."Core Charges" := TempSalesLine."Core Charges";
        SalesLine."Customer Serial No" := TempSalesLine."Customer Serial No";
        SalesLine."Sap No" := TempSalesLine."Sap No";
    #19..23
    */
    //end;


    //Unsupported feature: Code Modification on "ModifyBillToCustomerAddress(PROCEDURE 194)".

    //procedure ModifyBillToCustomerAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesSetup.GET;
    IF SalesSetup."Ignore Updated Addresses" THEN
      EXIT;
    IF IsCreditDocType THEN
      EXIT;
    IF ("Bill-to Customer No." <> "Sell-to Customer No.") AND Customer.GET("Bill-to Customer No.") THEN
      IF HasBillToAddress AND HasDifferentBillToAddress(Customer) THEN
        ShowModifyAddressNotification(GetModifyBillToCustomerAddressNotificationId,
          ModifyCustomerAddressNotificationLbl,ModifyCustomerAddressNotificationMsg,
          'CopyBillToCustomerAddressFieldsFromSalesDocument',"Bill-to Customer No.",
          "Bill-to Name",FIELDNAME("Bill-to Customer No."));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SalesSetup.GET;
    //IF SalesSetup."Ignore Updated Addresses" THEN
      //EXIT;
    #4..11
    */
    //end;


    //Unsupported feature: Code Modification on "ModifyCustomerAddress(PROCEDURE 150)".

    //procedure ModifyCustomerAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesSetup.GET;
    IF SalesSetup."Ignore Updated Addresses" THEN
      EXIT;
    IF IsCreditDocType THEN
      EXIT;
    IF Customer.GET("Sell-to Customer No.") AND HasSellToAddress AND HasDifferentSellToAddress(Customer) THEN
      ShowModifyAddressNotification(GetModifyCustomerAddressNotificationId,
        ModifyCustomerAddressNotificationLbl,ModifyCustomerAddressNotificationMsg,
        'CopySellToCustomerAddressFieldsFromSalesDocument',"Sell-to Customer No.",
        "Sell-to Customer Name",FIELDNAME("Sell-to Customer No."));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SalesSetup.GET;
    //IF SalesSetup."Ignore Updated Addresses" THEN
     // EXIT;
    #4..10
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
            ERROR('Update exchange rate for YER currency');
    end;


    //Unsupported feature: Property Modification (TextConstString) on "Text035(Variable 1076)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text035 : ENU=You cannot Release Quote or Make Order unless you specify a customer on the quote.\\Do you want to create customer(s) now?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text035 : ENU=You cannot Make Order unless you specify a customer on the quote.\\Do you want to create customer(s) now?;
    //Variable type has not been exported.

    var
        NoSeries: Record "No. Series";
        InvoiceNo: Code[20];
        CusText001: Label 'Deleting this document will cause a gap in the Posting number series please utilize it for a different order.';
        SalesLineBuf1: Record "Sales Line";
        SalesLineBuf: Record "Sales Line";
        SLExist: Record "Sales Line";
}

