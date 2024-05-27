page 55007 "Log Function in Antares"
{
    PageType = List;
    SourceTable = "Antares Log File";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Purchase Order No.";Rec."Purchase Order No.")
                {
                }
                field(Description;Rec.Description)
                {
                }
                field("Conversion Date &Time";Rec."Conversion Date &Time")
                {
                    Caption = 'Date';
                }
                field("User Id";Rec."User Id")
                {
                }
                field(Status;Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}

