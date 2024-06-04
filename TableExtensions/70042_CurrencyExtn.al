tableextension 70042 CurrencyExtn extends Currency
{
    fields
    {
        field(50000; "Currency Code"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS009';
            TableRelation = "Sub Unites"."Sub Units";
        }
    }


    //Unsupported feature: Code Modification on "InitRoundingPrecision(PROCEDURE 2)".

    //procedure InitRoundingPrecision();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLSetup.GET;
    IF GLSetup."Amount Rounding Precision" <> 0 THEN
      "Amount Rounding Precision" := GLSetup."Amount Rounding Precision"
    ELSE
      "Amount Rounding Precision" := 0.01;
    IF GLSetup."Unit-Amount Rounding Precision" <> 0 THEN
      "Unit-Amount Rounding Precision" := GLSetup."Unit-Amount Rounding Precision"
    ELSE
      "Unit-Amount Rounding Precision" := 0.00001;
    "Max. VAT Difference Allowed" := GLSetup."Max. VAT Difference Allowed";
    "VAT Rounding Type" := GLSetup."VAT Rounding Type";
    "Invoice Rounding Precision" := GLSetup."Inv. Rounding Precision (LCY)";
    "Invoice Rounding Type" := GLSetup."Inv. Rounding Type (LCY)";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5

    #6..9
      "Max. VAT Difference Allowed" := GLSetup."Max. VAT Difference Allowed";
      "VAT Rounding Type" := GLSetup."VAT Rounding Type";
      "Invoice Rounding Precision" := GLSetup."Inv. Rounding Precision (LCY)";
      "Invoice Rounding Type" := GLSetup."Inv. Rounding Type (LCY)";
    */
    //end;
}

