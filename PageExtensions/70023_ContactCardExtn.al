pageextension 70023 ContactCardExtn extends "Contact Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Registration Number")
        {
            field(Responsibility_Center; Rec.Responsibility_Center)
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