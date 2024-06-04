tableextension 70018 ContactExtn extends Contact
{
    fields
    {
        // Add changes to table fields here
        field(50000; Responsibility_Center; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RMSetup.GET;

    IF "No." = '' THEN BEGIN
      RMSetup.TESTFIELD("Contact Nos.");
      NoSeriesMgt.InitSeries(RMSetup."Contact Nos.",xRec."No. Series",0D,"No.","No. Series");
    END;

    IF NOT SkipDefaults THEN BEGIN
      IF "Salesperson Code" = '' THEN BEGIN
    #10..26

    TypeChange;
    SetLastDateTimeModified;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RMSetup.GET;

    UserSetup1.RESET;
    UserSetup1.SETRANGE("User ID",USERID);
    IF UserSetup1.FINDFIRST THEN
      ResponsiblityCenter1 := UserSetup1."Sales Resp. Ctr. Filter";

    IF ResponsiblityCenter1 <> '' THEN BEGIN
      NoSer.RESET;
      NoSer.SETCURRENTKEY(ResponsibilityCenter,CustomerCheck,"No Series Type");
      NoSer.SETRANGE(CustomerCheck,FALSE);
      NoSer.SETRANGE(ResponsibilityCenter,ResponsiblityCenter1);
      NoSer.SETRANGE("No Series Type",NoSeries."No Series Type"::"None ");

      IF NoSer.FINDFIRST THEN
        Othercode := NoSer.Code;
    END;

    CustLoc.RESET;
    CustLoc.SETCURRENTKEY("Customer Creation");
    CustLoc.SETRANGE("Customer Creation",TRUE);
    IF CustLoc.FINDFIRST THEN BEGIN
      IF "No." = '' THEN BEGIN
        RMSetup.GET;
        RMSetup.TESTFIELD("Contact Nos.");
        IF (ResponsiblityCenter1 <> '')  THEN BEGIN
           NoSeriesMgt.InitSeries(Othercode,xRec."No. Series",0D,"No.","No. Series")
        END
        ELSE
           AssistEditLoc(xRec);
           //NoSeriesMgt.InitSeries(HODCode,xRec."No. Series",0D,"No.","No. Series")
      END;
    END
    ELSE
    BEGIN
    #3..6
    END;
    //
    IF Rec."No." = ''  THEN
      ERROR('Please select Contact no');

    IF ResponsiblityCenter1 <> ''  THEN
      VALIDATE("Responsibility Center",ResponsiblityCenter1);

    //
    #7..29
    */
    //end;


    //Unsupported feature: Code Modification on "CreateCustomer(PROCEDURE 3)".

    //procedure CreateCustomer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckForExistingRelationships(ContBusRel."Link to Table"::Customer);
    CheckIfPrivacyBlockedGeneric;
    RMSetup.GET;
    #4..7

    CLEAR(Cust);
    Cust.SetInsertFromContact(TRUE);
    Cust."Contact Type" := Type;
    OnBeforeCustomerInsert(Cust,CustomerTemplate);
    Cust.INSERT(TRUE);
    #14..50
      Cust."Payment Method Code" := CustTemplate."Payment Method Code";
      Cust."Prices Including VAT" := CustTemplate."Prices Including VAT";
      Cust."Shipment Method Code" := CustTemplate."Shipment Method Code";
      Cust.MODIFY;

      DefaultDim.SETRANGE("Table ID",DATABASE::"Customer Template");
    #57..73
      PAGE.RUN(PAGE::"Customer Card",Cust)
    ELSE
      IF NOT HideValidationDialog THEN
        MESSAGE(RelatedRecordIsCreatedMsg,Cust.TABLECAPTION);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
    //
    Cust."Responsibility Center" := "Responsibility Center";
    //
    #11..53
        //  >>  CS03
      Cust."Responsibility Center"  :=  CustTemplate."Responsibility Center";
      Cust."Location Code"  :=  CustTemplate."Location Code";
      Cust."Prepayment %" := CustTemplate."Pre-Payment %";
      //  <<  CS03
      //EP96-01
      Cust."Created By":=USERID;
      //EP96-01
    #54..76
        MESSAGE(RelatedRecordIsCreatedMsg,Cust.TABLECAPTION,Cust."No.",Cust.Name);
    //  >>  CS03
    //CODEUNIT.RUN(50001,Cust);
    //  <<  CS03
    */
    //end;


    //Unsupported feature: Code Modification on "ChooseCustomerTemplate(PROCEDURE 27)".

    //procedure ChooseCustomerTemplate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckForExistingRelationships(ContBusRel."Link to Table"::Customer);
    ContBusRel.RESET;
    ContBusRel.SETRANGE("Contact No.","No.");
    #4..6
        Text019,
        TABLECAPTION,"No.",ContBusRel.TABLECAPTION,ContBusRel."Link to Table",ContBusRel."No.");

    IF CONFIRM(CreateCustomerFromContactQst,TRUE) THEN BEGIN
      CustTemplate.SETRANGE("Contact Type",Type);
      IF PAGE.RUNMODAL(0,CustTemplate) = ACTION::LookupOK THEN
        EXIT(CustTemplate.Code);

      ERROR(Text022);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
    //IF CONFIRM(CreateCustomerFromContactQst,TRUE) THEN BEGIN
     IF "Responsibility Center" <> '' THEN BEGIN
      CLEAR(CustTemplate);
      CustTemplate.FILTERGROUP(2);
      CustTemplate.SETRANGE("Responsibility Center","Responsibility Center");
      CustTemplate.FILTERGROUP(0);
     END;
      //IF "Responsibility Center" = '' THEN
        //ERROR('Please choose reponsibility center');
    #12..15
    //END;
    */
    //end;


    //Unsupported feature: Code Modification on "LookupCustomerTemplate(PROCEDURE 53)".

    //procedure LookupCustomerTemplate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CustomerTemplate.FILTERGROUP(2);
    CustomerTemplate.SETRANGE("Contact Type",Type);
    CustomerTemplate.FILTERGROUP(0);
    CustomerTemplateList.LOOKUPMODE := TRUE;
    CustomerTemplateList.SETTABLEVIEW(CustomerTemplate);
    IF CustomerTemplateList.RUNMODAL = ACTION::LookupOK THEN BEGIN
      CustomerTemplateList.GETRECORD(CustomerTemplate);
      EXIT(CustomerTemplate.Code);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CustomerTemplate.FILTERGROUP(2);
    CustomerTemplate.SETRANGE("Contact Type",Type);
    //
    CustomerTemplate.SETRANGE("Responsibility Center",Rec."Responsibility Center");
    //
    #3..9
    */
    //end;

    /*    procedure AssistEditLoc(OldCont: Record "5050"): Boolean
        var
            Cont: Record "5050";
        begin
            WITH Cont DO BEGIN
                Cont := Rec;
                RMSetup.GET;
                RMSetup.TESTFIELD("Contact Nos.");
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                IF UserSetup.FINDFIRST THEN
                    ResponsiblityCenter := UserSetup."Sales Resp. Ctr. Filter";
                IF NoSeriesMgt.SelectSeriesCont(RMSetup."Contact Nos.", OldCont."No. Series", "No. Series", ResponsiblityCenter) THEN BEGIN
                    RMSetup.GET;
                    RMSetup.TESTFIELD("Contact Nos.");
                    "Responsibility Center" := NoSeriesMgt.SetSeriesCC("No.");
                    Rec := Cont;
                    EXIT(TRUE);
                END;
            END;
        end;
    */
    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".



    //Unsupported feature: Property Modification (TextConstString) on "RelatedRecordIsCreatedMsg(Variable 1009)".

    //var
    //>>>> ORIGINAL VALUE:
    //RelatedRecordIsCreatedMsg : @@@=The Customer record has been created.;ENU=The %1 record has been created.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RelatedRecordIsCreatedMsg : @@@=The Customer record has been created.;ENU=The %1 record has been created. The Customer No is %2 and Name is %3;
    //Variable type has not been exported.


    var
        ResponsiblityCenter: Code[20];
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        ResponsiblityCenter1: Code[20];
        Othercode: Code[20];
        NoSer: Record "No. Series";
        CustLoc: Record "Customer parameter";
        HOD: Boolean;
        NoSer1: Record "No. Series";
        NoSeries: Record "No. Series";
}