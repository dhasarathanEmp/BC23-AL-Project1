tableextension 70103 "ItemChargeAss(Purch)Extn" extends "Item Charge Assignment (Purch)"
{
    fields
    {
        field(50000; "ILE Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CS04';
        }
        field(50001; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CS04';
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                //  >>  CS04
                /*IF xRec.Percentage <> 0 THEN
                  MESSAGE('Percentage %1 of Item Charge Line %2 is updated to %3.\Amount to Assign of all the lines will be updated according to the percentage given in the each line.',xRec.Percentage,Rec."Line No.",Rec.Percentage);*/


                /**/


                /*"Charge Amount" :=("ILE Amount")*((Percentage)/100);
                PurchLine.GET("Document Type","Document No.","Document Line No.");
                IF PurchLine."Currency Code"<>'' THEN BEGIN
                  CurrencyFactor := CurrExch.ExchangeRate(WORKDATE,PurchLine."Currency Code");
                  AmttoAssign:=CurrExch.ExchangeAmtLCYToFCYOnlyFactor("Charge Amount",CurrencyFactor);
                  "Amount to Assign":= ROUND(AmttoAssign,0.01);
                END
                ELSE
                  "Amount to Assign":=ROUND("Charge Amount",0.01);
                IF Rec."Qty. to Assign" <>  0 THEN
                  CLEAR("Qty. to Assign");
                Rec.MODIFY;*/

                //  <<  CS04

            end;
        }
        field(50002; "Charge Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CS04';
        }
    }
}

