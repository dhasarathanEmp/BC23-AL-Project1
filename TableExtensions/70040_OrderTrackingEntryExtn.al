tableextension 70040 OrderTrackingEntryExtn extends "Order Tracking Entry" 
{
    fields
    {
        field(50000;Prepayment;Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS018';
        }
        field(50001;"Prepayment Line Amount";Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS018';
        }
    }
}

