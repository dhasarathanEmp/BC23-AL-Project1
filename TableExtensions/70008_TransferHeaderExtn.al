tableextension 70008 TransferHeaderExtn extends "Transfer Header"
{
    fields
    {

        //Unsupported feature: Property Insertion (Editable) on ""No."(Field 1)".

        modify(Status)
        {
            OptionCaption = 'Open,Accepted,Not Accepted';

        }

        //Unsupported feature: Code Modification on ""Transfer-from Code"(Field 2).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        IF ("Transfer-from Code" = "Transfer-to Code") AND
        #4..24
          IF Confirmed THEN BEGIN
            IF Location.GET("Transfer-from Code") THEN BEGIN
              "Transfer-from Name" := Location.Name;
              "Transfer-from Name 2" := Location."Name 2";
              "Transfer-from Address" := Location.Address;
              "Transfer-from Address 2" := Location."Address 2";
              "Transfer-from Post Code" := Location."Post Code";
        #32..60
          END ELSE
            "Transfer-from Code" := xRec."Transfer-from Code";
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..27
              "Transfer-from Name 2" := Location."T.R.No";
        #29..63
        */
        //end;


        //Unsupported feature: Code Modification on ""Transfer-to Code"(Field 11).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        IF ("Transfer-from Code" = "Transfer-to Code") AND
        #4..18
          IF Confirmed THEN BEGIN
            IF Location.GET("Transfer-to Code") THEN BEGIN
              "Transfer-to Name" := Location.Name;
              "Transfer-to Name 2" := Location."Name 2";
              "Transfer-to Address" := Location.Address;
              "Transfer-to Address 2" := Location."Address 2";
              "Transfer-to Post Code" := Location."Post Code";
              "Transfer-to City" := Location.City;
              "Transfer-to County" := Location.County;
              "Trsf.-to Country/Region Code" := Location."Country/Region Code";
              "Transfer-to Contact" := Location.Contact;
        #30..56
            EXIT;
          END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..21
              "Transfer-to Name 2" := Location."T.R.No";
        #23..26
              // >> K03
                "Transfer-to Contact" := Location."Phone No.";
                "Transfer-to Fax No":=Location."Fax No.";
              //  << K03
        #27..59
        */
        //end;
        field(50000; "Transfer-to Fax No"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50001; "Transfer-From Fax No"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50002; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Order";
        }
        field(50003; "Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Sales,Service,Purchase;
        }
        field(50004; "Delivery Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS010';
        }
        field(50005; "Fully Reserved Outbound"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Created-from-Requisition"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu102';
        }
        field(50007; "Sales Order Number"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EP9619';
            Editable = false;
        }
        field(50008; "Created By"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EP9619';
        }
        field(50009; "Agency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetInventorySetup;
    IF "No." = '' THEN BEGIN
      TestNoSeries;
      NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Posting Date","No.","No. Series");
    END;
    InitRecord;
    VALIDATE("Shipment Date",WORKDATE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Created By" := USERID;
    #1..7
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: StockRequestArchiveLine) (VariableCollection) on "DeleteOneTransferOrder(PROCEDURE 4)".


    //Unsupported feature: Variable Insertion (Variable: StockRequestLine) (VariableCollection) on "DeleteOneTransferOrder(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "DeleteOneTransferOrder(PROCEDURE 4)".

    //procedure DeleteOneTransferOrder();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    No := TransHeader2."No.";

    WhseRequest.SETRANGE("Source Type",DATABASE::"Transfer Line");
    #4..14
    ItemChargeAssgntPurch.SETRANGE("Applies-to Doc. No.",TransLine2."Document No.");
    ItemChargeAssgntPurch.DELETEALL;

    IF TransLine2.FIND('-') THEN
      TransLine2.DELETEALL;

    TransHeader2.DELETE;
    IF NOT HideValidationDialog THEN
      MESSAGE(TransferOrderPostedMsg1,No);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17
    //SR1
    StockRequestLine.RESET;
    StockRequestLine.SETRANGE("Transfer Order No.",TransHeader2."No.");
    StockRequestLine.SETRANGE("Stock Request No.",TransHeader2."Sales Order Number");
    StockRequestLine.SETRANGE(Status,StockRequestLine.Status::Released);
    IF StockRequestLine.FINDSET THEN REPEAT
      StockRequestArchiveLine.INIT;
      StockRequestArchiveLine.TRANSFERFIELDS(StockRequestLine);
      StockRequestArchiveLine.Status := StockRequestArchiveLine.Status::Completed;
      StockRequestArchiveLine.INSERT;
    UNTIL StockRequestLine.NEXT = 0;

    StockRequestLine.RESET;
    StockRequestLine.SETRANGE("Transfer Order No.",TransHeader2."No.");
    StockRequestLine.SETRANGE("Stock Request No.",TransHeader2."Sales Order Number");
    StockRequestLine.SETRANGE(Status,StockRequestLine.Status::Released);
    StockRequestLine.DELETEALL;
    //SR1
    #18..23
    */
    //end;


    //Unsupported feature: Code Modification on "CreateInvtPutAwayPick(PROCEDURE 29)".

    //procedure CreateInvtPutAwayPick();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD(Status,Status::Released);

    WhseRequest.RESET;
    WhseRequest.SETCURRENTKEY("Source Document","Source No.");
    #5..7
      WhseRequest."Source Document"::"Outbound Transfer");
    WhseRequest.SETRANGE("Source No.","No.");
    REPORT.RUNMODAL(REPORT::"Create Invt Put-away/Pick/Mvmt",TRUE,FALSE,WhseRequest);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TESTFIELD(Status,Status::Accepted);
    #2..10
    */
    //end;


    //Unsupported feature: Code Modification on "CheckBeforePost(PROCEDURE 7)".

    //procedure CheckBeforePost();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Transfer-from Code");
    TESTFIELD("Transfer-to Code");
    IF "Transfer-from Code" = "Transfer-to Code" THEN
    #4..11
      VerifyNoOutboundWhseHandlingOnLocation("Transfer-from Code");
      VerifyNoInboundWhseHandlingOnLocation("Transfer-to Code");
    END;
    TESTFIELD(Status,Status::Released);
    TESTFIELD("Posting Date");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..14
    TESTFIELD(Status,Status::Accepted);
    TESTFIELD("Posting Date");
    */
    //end;
}

