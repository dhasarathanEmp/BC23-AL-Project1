tableextension 70002 SalesLineExtn extends "Sales Line"
{
    fields
    {
        field(50015; Ordered_Part_No; Code[30])
        {

        }
        field(50026; CoreCharge; Decimal)
        {

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