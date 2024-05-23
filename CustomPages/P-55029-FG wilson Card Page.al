page 55029 "FG wilson Card Page"
{
    PageType = Card;
    SourceTable = "Daily Price Log Header";

    layout
    {
        area(content)
        {
            group(General)
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
                field("Total No. Of Records"; Rec."Total No. Of Records")
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
            part(FGWilsonLine; "FG wilson Line")
            {
                SubPageLink = "Daily Header No"=FIELD("No."),
                              "Log Status"=FIELD("Log Status"),
                              "User Id"=FIELD("User Id");
            }
        }
    }

    actions
    {
    }
}

