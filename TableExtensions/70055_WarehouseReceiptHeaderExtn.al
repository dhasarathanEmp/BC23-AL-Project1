tableextension 70055 WarehouseReceiptHeaderExtn extends "Warehouse Receipt Header"
{
    fields
    {

        //Unsupported feature: Property Insertion (Editable) on ""No."(Field 1)".

        modify("Sorting Method")
        {
            OptionCaption = ' ,Item,Document,Shelf or Bin,Due Date,Ship-To,Received';

            //Unsupported feature: Property Modification (OptionString) on ""Sorting Method"(Field 6)".

        }
        modify("Bin Code")
        {
            TableRelation = IF ("Zone Code" = FILTER('')) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                                      "Counter sale" = FILTER(false))
            ELSE IF ("Zone Code" = FILTER(<> '')) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                       "Zone Code" = FIELD("Zone Code"),
                                                                                                                       "Counter sale" = FILTER(false));
        }
        field(50000; "Vendor Invoice Number"; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Vendor Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Discrepancy No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Vendor Invoice Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Vendor Invoice Total Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Validated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WhseSetup.GET;
    IF "No." = '' THEN BEGIN
      WhseSetup.TESTFIELD("Whse. Receipt Nos.");
    #4..9
    VALIDATE("Bin Code",Location."Receipt Bin Code");
    VALIDATE("Cross-Dock Bin Code",Location."Cross-Dock Bin Code");
    "Posting Date" := WORKDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
    "Assigned User ID" := USERID;
    */
    //end;


    //Unsupported feature: Code Modification on "SortWhseDoc(PROCEDURE 3)".

    //procedure SortWhseDoc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    WhseRcptLine.SETRANGE("No.","No.");
    GetLocation("Location Code");
    CASE "Sorting Method" OF
    #4..13
        END;
      "Sorting Method"::"Due Date":
        WhseRcptLine.SETCURRENTKEY("No.","Due Date");
    END;

    IF WhseRcptLine.FIND('-') THEN BEGIN
    #20..23
        SequenceNo := SequenceNo + 10000;
      UNTIL WhseRcptLine.NEXT = 0;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..16
      //Cu012
      "Sorting Method"::Received:
        WhseRcptLine.SETCURRENTKEY("No.",Received);
      //Cu012
    #17..26
    */
    //end;
    procedure SkipDelete(SKIP: Boolean)
    begin
        SKIP := SKIP;
    end;

    var
        Skip: Boolean;
}

