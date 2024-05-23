page 55030 "FG wilson Line"
{
    PageType = List;
    SourceTable = "Daily Parts log Line";
    SourceTableView = SORTING(No)
                      WHERE("Log Status" = FILTER("Fg wilson"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Daily Header No"; Rec."Daily Header No")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Import Date & Time"; Rec."Import Date & Time")
                {
                }
                field("Exception Message"; Rec."Exception Message")
                {
                }
                field(Inserted; Rec.Inserted)
                {
                }
                field(Modified; Rec.Modified)
                {
                }
                field("User Id"; Rec."User Id")
                {
                }
                field("User Name"; Rec."User Name")
                {
                }
                field("File Name"; Rec."File Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Log Status"; Rec."Log Status")
                {
                }
            }
        }
    }

    actions
    {
    }
}

