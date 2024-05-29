report 50085 "Discount Process Only"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; "Item Journal Line")
        {
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Discount Percentage"; "Discount Percentage")
                {
                    DecimalPlaces = 2 : 2;
                    MaxValue = 100;
                    MinValue = 0;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        "Discount Percentage": Decimal;

    procedure "Return Discount Percentage"(): Decimal
    begin
        EXIT("Discount Percentage");
    end;
}

