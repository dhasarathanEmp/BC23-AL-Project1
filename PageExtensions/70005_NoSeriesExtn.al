pageextension 70005 NoSeriesExtn extends "No. Series"
{
    layout
    {
        // Add changes to page layout here

        addafter(AllowGapsCtrl)
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;
            }
            field("Customer Check"; Rec."Customer Check")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }
    var
        myInt: Integer;
}