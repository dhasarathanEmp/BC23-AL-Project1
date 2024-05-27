page 55015 "Antares Error Log List"
{
    PageType = ListPart;
    SourceTable = "Antares Error Log";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("User Id"; Rec."User Id")
                {
                }
                field("User Name"; Rec."User Name")
                {
                }
                field("Convertion Date & Time"; Rec."Convertion Date & Time")
                {
                }
                field("Exception Message"; Rec."Exception Message")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("No. of Po Lines Created"; Rec."No. of Po Lines Created")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Purchase Line No."; Rec."Purchase Line No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

