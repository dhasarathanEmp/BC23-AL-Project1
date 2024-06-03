page 55017 NPR
{
    SourceTable = "NPR Log Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                    Enabled = true;
                }
                field("CreationDate&Time"; Rec."CreationDate&Time")
                {
                    Editable = false;
                    Enabled = true;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field(RecordInserted; Rec.RecordInserted)
                {
                    Caption = 'Inserted';
                    Editable = false;
                }
                field(RecordModified; Rec.RecordModified)
                {
                    Caption = '<Modified>';
                }
                field("User Id"; Rec."User Id")
                {
                    Editable = false;
                }
                field("Total No of Errors"; Rec."Total No of Errors")
                {
                    Editable = false;
                }
                field(Skipped; Rec.Skipped)
                {
                }
                field("Deleted Count"; Rec."Deleted Count")
                {
                    Caption = 'Deleted';
                    Editable = false;
                }
                field(UserName; Rec.UserName)
                {
                    Editable = false;
                }
            }
            part(NPRLines; "NPR Lines")
            {
                SubPageLink = "No." = FIELD(No);
            }
        }
    }

    actions
    {
    }
}

