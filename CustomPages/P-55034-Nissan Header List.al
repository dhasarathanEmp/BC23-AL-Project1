page 55034 "Nissan Header List"
{
    CardPageID = "Nissan Card Page";
    Editable = false;
    PageType = List;
    SourceTable = "Semiannual Log Header";
    SourceTableView = SORTING("No.")
                      WHERE("Log Status" = FILTER(Nissan));

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
                field("Start Time"; Rec."Start Time")
                {
                }
                field("End Time"; Rec."End Time")
                {
                }
            }
        }
    }

    actions
    {
    }
}

