tableextension 70088 ReservationEntryExtn extends "Reservation Entry"
{
    fields
    {
        // Add changes to table fields here
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    procedure SetSourceFilter2(SourceBatchName: Code[10]; SourceProdOrderLine: Integer)
    begin
        SETRANGE("Source Batch Name", SourceBatchName);
        SETRANGE("Source Prod. Order Line", SourceProdOrderLine);
    end;

}