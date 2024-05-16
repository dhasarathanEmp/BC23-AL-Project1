page 55074 "Default Price Factor List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Default Price Factor";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Agency Code"; Rec."Agency Code")
                {
                    Editable = false;
                }
                field("Default Price Factor"; Rec."Default Price Factor")
                {
                }
                field("Assembly Charges in Dollars"; Rec."Assembly Charges in Dollars")
                {
                }
            }
        }
    }

    actions
    {
    }
}

