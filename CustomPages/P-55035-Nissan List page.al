page 55035 "Nissan List page"
{
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Semiannual Error Log Line";
    SourceTableView = SORTING(No)
                      WHERE("Log Status" = filter(Nissan));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                }
                field("Header No"; Rec."Header No")
                {
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                }
                field("Import Date & Time"; Rec."Import Date & Time")
                {
                    Editable = false;
                }
                field("Exception Message"; Rec."Exception Message")
                {
                    Editable = false;
                }
                field("New Items Line Find"; Rec."New Items Line Find")
                {
                    Editable = false;
                }
                field(Modified; Rec.Modified)
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
                field("File Name"; Rec."File Name")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Log Status"; Rec."Log Status")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

