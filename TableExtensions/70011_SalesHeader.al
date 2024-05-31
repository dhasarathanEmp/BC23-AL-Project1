tableextension 70011 SalesHeader extends "Sales Header"
{
    fields
    {
        field(50010; "Invoice Discount%"; Decimal)
        {

        }
        field(50011; "Price Validate"; Text[30])//CUS023
        {

        }
        field(50012; "Delivery Terms"; Text[30])//CUS023
        {

        }
        field(50021; "Version No."; Text[30])//Cu003
        {

        }
        field(50022; "Latest Version Date"; Date)
        {

        }
        field(50023; "SO Version No."; Text[30])
        {

        }
        field(50024; "SO Revision Date"; Date)
        {

        }
        field(50026; AFZDiscount; Decimal)
        {

        }
        field(50028; "Agency Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50030; Special_Price_Factor; Decimal)
        {

        }
        field(50031; "Latest Released Date"; Date)
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