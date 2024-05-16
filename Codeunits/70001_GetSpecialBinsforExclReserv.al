codeunit 70001 GetSpecialBinsforExclReserv
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Management", 'OnBeforeCalcAvailAllocQuantities', '', true, true)]
    local procedure OnBeforeCalcAvailAllocQuantities(
        Item: Record Item; WhseActivLine: Record "Warehouse Activity Line";
        QtyOnOutboundBins: Decimal; QtyOnInvtMovement: Decimal; QtyOnSpecialBins: Decimal;
        var AvailQty: Decimal; var AllocQty: Decimal; var IsHandled: Boolean)
    begin
        IF WhseActivLine.FindFirst() then;
        bin.Reset();
        bin.SetRange("Location Code", 'SILVER');
        bin.SetRange(Blocks, true);
        IF bin.FindSet() then
            repeat
                bincontent.Reset();
                bincontent.SetRange("Bin Code", bin.Code);
                bincontent.SetRange("Location Code", bin."Location Code");
                bincontent.SetRange("Item No.", Item."No.");
                if bincontent.FindSet() then
                    repeat
                        bincontent.CalcFields("Quantity (Base)");
                        //AllocQty += bincontent."Quantity (Base)";
                        AvailQty -= bincontent."Quantity (Base)";
                    until bincontent.Next() = 0;
            until bin.Next() = 0;
    end;

    var
        bin: Record Bin;
        bincontent: Record "Bin Content";
}