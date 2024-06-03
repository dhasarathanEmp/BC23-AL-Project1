page 55018 "NPR Lines"
{
    PageType = List;
    SourceTable = "NPR Log Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                }
                field(ItemNo; Rec.ItemNo)
                {
                    Editable = false;
                }
                field("User Id"; Rec."User Id")
                {
                    Editable = false;
                }
                field("User Name"; Rec."User Name")
                {
                    Editable = false;
                }
                field("Imported Date & Time"; Rec."Imported Date & Time")
                {
                    Editable = false;
                }
                field("Exception Message"; Rec."Exception Message")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(InsertedCount; Rec.InsertedCount)
                {
                    Editable = false;
                }
                field(ModifiedCount; Rec.ModifiedCount)
                {
                    Editable = false;
                }
                field(LineNo; Rec.LineNo)
                {
                    Editable = false;
                }
                field(FileName; Rec.FileName)
                {
                }
            }
        }
    }

    actions
    {
    }
}

