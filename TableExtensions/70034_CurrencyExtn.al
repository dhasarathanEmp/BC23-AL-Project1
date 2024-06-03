tableextension 70034 CurrencyExtn extends Currency
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
}

