codeunit 70001 GetSpecialBinsforExclReserv
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Management", 'OnBeforeCalcAvailAllocQuantities', '', true, true)]
    local procedure OnBeforeCalcAvailAllocQuantities(
        Item: Record Item; WhseActivLine: Record "Warehouse Activity Line";
        QtyOnOutboundBins: Decimal; QtyOnInvtMovement: Decimal; QtyOnSpecialBins: Decimal;
        var AvailQty: Decimal; var AllocQty: Decimal; var IsHandled: Boolean)
    begin
        bin.Reset();
        bin.SetRange("Location Code", WhseActivLine."Location Code");
        bin.SetRange(Blocks, true);
        IF bin.FindSet() then
            repeat
                bincontent.Reset();
                bincontent.SetRange("Bin Code", bin.Code);
                bincontent.SetRange("Location Code", bin."Location Code");
                bincontent.SetRange("Item No.", Item."No.");
                if bincontent.FindSet() then
                    QtyOnSpecialBins += bincontent."Quantity (Base)";
            until bin.Next() = 0;
    end;

    var
        bin: Record Bin;
        bincontent: Record "Bin Content";
}