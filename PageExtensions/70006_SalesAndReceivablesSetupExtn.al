pageextension 70006 SalesAndReceivablesExtnPage extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Canceled Issued Reminder Nos.")
        {
            field("Nisson header"; Rec."Nisson header")
            {
                ApplicationArea = All;
                TableRelation = "No. Series";
            }
            field("Nisson Line"; Rec."Nisson Line")
            {
                ApplicationArea = All;
                TableRelation = "No. Series";
            }
        }
        addafter("Document Default Line Type")
        {
            field(Inc_CoreCharge; Rec.Inc_CoreCharge)
            {

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