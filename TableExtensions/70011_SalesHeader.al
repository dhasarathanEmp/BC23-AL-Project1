tableextension 70011 SalesHeader extends "Sales Header"
{
    fields
    {
        field(50028; "Agency Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50030; Special_Price_Factor; Decimal)
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