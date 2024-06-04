tableextension 70061 ServiceHeaderExtn extends "Service Header"
{
    fields
    {

        //Unsupported feature: Property Insertion (Editable) on ""No."(Field 3)".

        modify(Status)
        {
            OptionCaption = 'Pending,In Process,Finished,On Hold,Cancel,Conform';

            //Unsupported feature: Property Modification (OptionString) on "Status(Field 120)".

        }
        field(50000; "Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CS01';
            OptionMembers = " ",Sales,Service,Purchase;
        }
        field(50001; "Applied Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
        }
        field(50002; "Service Order"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS002';
            TableRelation = "Service Header"."No." where("Document Type" = const(Order));
        }
        field(50003; CancelStatus; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS014';
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ServSetup.GET ;
    IF "No." = '' THEN BEGIN
      TestNoSeries;
    #4..26
    IF GETFILTER("Contact No.") <> '' THEN
      IF GETRANGEMIN("Contact No.") = GETRANGEMAX("Contact No.") THEN
        VALIDATE("Contact No.",GETRANGEMIN("Contact No."));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..29
    //  >>  CUS001 , CS01
    "Sales Type"  :=  "Sales Type"::Service;
    "Applied Doc. No."  :=  "No.";
    //   << CUS001 , CS01
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateShipToAddress(PROCEDURE 29)".

    //procedure UpdateShipToAddress();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
      IF "Location Code" <> '' THEN BEGIN
        Location.GET("Location Code");
        SetShipToAddress(
          Location.Name,Location."Name 2",Location.Address,Location."Address 2",
          Location.City,Location."Post Code",Location.County,Location."Country/Region Code");
        "Ship-to Contact" := Location.Contact;
      END ELSE BEGIN
    #9..17
    END;

    OnAfterUpdateShipToAddress(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
          Location.Name,Location."T.R.No",Location.Address,Location."Address 2",
    #6..20
    */
    //end;
}

