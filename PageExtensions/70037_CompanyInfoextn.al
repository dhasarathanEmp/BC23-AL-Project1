pageextension 70037 CompanyInfoExtn extends "Company Information"
{
    layout
    {
        addafter(Name)
        {
            field(Auto; Rec.Auto)
            {

            }
            field(EPS; Rec.EPS)
            {

            }
            field(Division; Rec.Division)
            {

            }
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