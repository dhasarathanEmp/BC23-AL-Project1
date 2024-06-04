tableextension 70095 StockkeepingUnitExtn extends "Stockkeeping Unit"
{
    fields
    {
        field(50000; Bin1; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code;
        }
        field(50001; Bin2; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code;
        }
        field(50002; Bin3; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code;
        }
        field(50003; Bin4; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code;
        }
        field(50004; Bin5; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code;
        }
    }
}

