page 55028 "FG wilson List Page"
{
    CardPageID = "FG wilson Card Page";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Daily Price Log Header";
    SourceTableView = SORTING("No.")
                      WHERE("Log Status" = FILTER("Fg wilson"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("User Id"; Rec."User Id")
                {
                }
                field(UserName; Rec.UserName)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("CreationDate&Time"; Rec."CreationDate&Time")
                {
                }
                field("Record Inserted"; Rec."Record Inserted")
                {
                }
                field("Total No. of Items Updated"; Rec."Total No. of Items Updated")
                {
                }
                field("Total No of Errors"; Rec."Total No of Errors")
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

