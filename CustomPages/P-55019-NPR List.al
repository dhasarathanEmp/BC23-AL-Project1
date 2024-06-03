page 55019 "NPR List"
{
    CardPageID = NPR;
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "NPR Log Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("CreationDate&Time"; Rec."CreationDate&Time")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(RecordInserted; Rec.RecordInserted)
                {
                }
                field("User Id"; Rec."User Id")
                {
                }
                field("Total No of Errors"; Rec."Total No of Errors")
                {
                }
                field(UserName; Rec.UserName)
                {
                }
                field("Deleted Count"; Rec."Deleted Count")
                {
                }
            }
        }
    }

    actions
    {
    }
}

