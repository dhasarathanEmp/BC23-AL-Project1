pageextension 50114 SalesSetupExtnPage extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Canceled Issued Reminder Nos.")
        {
            field("Nisson header"; Rec."Nisson header")
            {
                ApplicationArea = All;
            }
            field("Nisson Line"; Rec."Nisson Line")
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