//Functionality to restrict reserving stock from special bins such as Counter Sales,TD,Discrepancy etc..
//For all special customized bins keep the custom field blocks as true.
codeunit 70001 GetSpecialBinsforExclReserv
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Warehouse Availability Mgt.", 'OnAfterGetSpecialBins', '', true, true)]
    procedure OnAfterGetSpecialBins(Location: Record Location; var SpecialBins: List of [Code[20]])
    begin
        bin.Reset();
        bin.SetRange("Location Code", Location.Code);
        bin.SetRange("Counter sale", true);
        IF bin.FindSet() then
            repeat
                if (bin.Code <> '') and not SpecialBins.Contains(bin.Code) then
                    SpecialBins.Add(bin.Code);
            until bin.Next() = 0;
        bin.Reset();
        bin.SetRange("Location Code", Location.Code);
        bin.SetRange("Temporary Delivery", true);
        IF bin.FindSet() then
            repeat
                if (bin.Code <> '') and not SpecialBins.Contains(bin.Code) then
                    SpecialBins.Add(bin.Code);
            until bin.Next() = 0;
        bin.Reset();
        bin.SetRange("Location Code", Location.Code);
        bin.SetRange(Discrepancy, true);
        IF bin.FindSet() then
            repeat
                if (bin.Code <> '') and not SpecialBins.Contains(bin.Code) then
                    SpecialBins.Add(bin.Code);
            until bin.Next() = 0;
        bin.Reset();
        bin.SetRange("Location Code", Location.Code);
        bin.SetRange(Blocks, true);
        IF bin.FindSet() then
            repeat
                if (bin.Code <> '') and not SpecialBins.Contains(bin.Code) then
                    SpecialBins.Add(bin.Code);
            until bin.Next() = 0;
        bin.Reset();
        bin.SetRange("Location Code", Location.Code);
        bin.SetRange(DeadStocks, true);
        IF bin.FindSet() then
            repeat
                if (bin.Code <> '') and not SpecialBins.Contains(bin.Code) then
                    SpecialBins.Add(bin.Code);
            until bin.Next() = 0;
    end;

    var
        bin: Record Bin;
        bincontent: Record "Bin Content";
}