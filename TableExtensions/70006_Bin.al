tableextension 70006 BinExtn extends Bin
{
    fields
    {
        // Add changes to table fields here
        field(50000; Blocks; Boolean)//CS18
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Counter sale"; Boolean)//CS02
        {
            DataClassification = ToBeClassified;
        }
        field(50002; DeadStocks; Boolean)//CS18
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Temporary Delivery"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Discrepancy; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Counting Completed"; Boolean)//Cu109
        {
            DataClassification = ToBeClassified;
        }
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
}