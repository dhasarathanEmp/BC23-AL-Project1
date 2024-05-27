pageextension 70014 ReqWorksheetExtn extends "Req. Worksheet"
{
    layout
    {
        // Add changes to page layout here
        addafter("Vendor No.")
        {
            field("Sales Order No"; Rec."Sales Order No")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter(CalculatePlan)
        {
            action(GetOrder)
            {
                ApplicationArea = All;
                Caption = 'Get Order';

                trigger OnAction()
                begin

                end;
            }
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}