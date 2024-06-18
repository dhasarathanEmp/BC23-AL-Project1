pageextension 70037 CompanyInfoExtn extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field(AFZ; Rec.AFZ)
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