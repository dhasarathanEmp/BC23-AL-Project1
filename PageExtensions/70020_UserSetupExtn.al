pageextension 70020 UserSetupExtn extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Time Sheet Admin.")
        {
            field(Counter_Batch; Rec.Counter_Batch)
            {
                ApplicationArea = all;
            }
            field("Cash Receipt Batch"; Rec."Cash Receipt Batch")
            {
                ApplicationArea = all;
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