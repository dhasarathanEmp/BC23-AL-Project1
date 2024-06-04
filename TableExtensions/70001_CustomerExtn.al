tableextension 70001 CustomerExtn extends Customer
{
    fields
    {

        //Unsupported feature: Property Insertion (Editable) on ""No."(Field 1)".

        field(50001; "Vehicle Model  No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Vin No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "One Time Customer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EP96-01';
        }
        field(50005; "Modified By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EP96-01';
        }
        field(50006; "Sales Tools"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50007; "Service Dept"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50008; "Service Tools"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50009; "Operating Genset"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50010; Policy; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50011; Warranty; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50012; "For Internal Customers"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      SalesSetup.GET;
      SalesSetup.TESTFIELD("Customer Nos.");
      NoSeriesMgt.InitSeries(SalesSetup."Customer Nos.",xRec."No. Series",0D,"No.","No. Series");
    END;

    IF "Invoice Disc. Code" = '' THEN
      "Invoice Disc. Code" := "No.";

    #10..17
      "Global Dimension 1 Code","Global Dimension 2 Code");

    SetLastModifiedDateTime;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    {UserSetup1.RESET;
    UserSetup1.SETRANGE("User ID",USERID);
    IF UserSetup1.FINDFIRST THEN
      ResponsiblityCenter1 := UserSetup1."Sales Resp. Ctr. Filter";
    }
    IF "Responsibility Center" <> '' THEN BEGIN
      NoSer.RESET;
      NoSer.SETCURRENTKEY(ResponsibilityCenter);
      NoSer.SETRANGE(CustomerCheck,TRUE);
      NoSer.SETRANGE(ResponsibilityCenter,"Responsibility Center");
      IF NoSer.FINDFIRST THEN
        Othercode := NoSer.Code;
    END;

    {
    IF ResponsiblityCenter1 <> '' THEN BEGIN
      NoSer.RESET;
      NoSer.SETCURRENTKEY(ResponsibilityCenter);
      NoSer.SETRANGE(CustomerCheck,TRUE);
      NoSer.SETRANGE(ResponsibilityCenter,ResponsiblityCenter1);
      IF NoSer.FINDFIRST THEN
        Othercode := NoSer.Code;
    END;
    }
    NoSer1.RESET;
    NoSer1.SETRANGE(CustomerCheck,TRUE);
    IF NoSer1.FINDFIRST THEN BEGIN
      HOD := TRUE;
      HODCode := NoSer1.Code;
    END;

    CustLoc.RESET;
    CustLoc.SETCURRENTKEY("Customer Creation");
    CustLoc.SETRANGE("Customer Creation",TRUE);
    IF CustLoc.FINDFIRST THEN BEGIN
      IF "No." = '' THEN BEGIN
        SalesSetup.GET;
        SalesSetup.TESTFIELD("Customer Nos.");
        IF ("Responsibility Center" <> '')  THEN BEGIN
           NoSeriesMgt.InitSeries(Othercode,xRec."No. Series",0D,"No.","No. Series")
        END
        ELSE
           AssistEditLoc(xRec);
           //NoSeriesMgt.InitSeries(HODCode,xRec."No. Series",0D,"No.","No. Series")
      END;
    END
    ELSE
    BEGIN
       IF "No." = '' THEN BEGIN
        SalesSetup.GET;
        SalesSetup.TESTFIELD("Customer Nos.");
        NoSeriesMgt.InitSeries(SalesSetup."Customer Nos.",xRec."No. Series",0D,"No.","No. Series")
      END;

    END;
    //
    IF Rec."No." = ''  THEN
      ERROR('Please select customer no');

    IF ResponsiblityCenter1 <> ''  THEN
      VALIDATE("Responsibility Center",ResponsiblityCenter1);
    //
    //
    IF ResponsibilityCenter3.GET(Rec."Responsibility Center") THEN
      VALIDATE("Location Code",ResponsibilityCenter3."Location Code");
    //
    #7..20
    */
    //end;
}

