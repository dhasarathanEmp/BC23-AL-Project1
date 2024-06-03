page 55067 "Job Order List"
{
    CardPageID = "Job Order Card Page";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Temporary Job Orders";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job Order No"; Rec."Job Order No")
                {
                }
                field("Job Description"; Rec."Job Description")
                {
                }
                field("Job Creation Date"; Rec."Job Creation Date")
                {
                }
                field("Job Crad No"; Rec."Job Crad No")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Job Status"; Rec."Job Status")
                {
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Temporary Delivery Confirmation")
            {
                Image = "Report";
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;

                trigger OnAction()
                begin
                    TemporaryJobOrders.RESET;
                    TemporaryJobOrders.SETRANGE("Job Order No", Rec."Job Order No");
                    REPORT.RUNMODAL(REPORT::"Temp delivery History Report", TRUE, TRUE, TemporaryJobOrders);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        IF (Rec."Job Status" = Rec."Job Status"::Completed) OR (Rec."Job Status" = Rec."Job Status"::"On Job") THEN
            ERROR('Deletion allowed only for the job status "Open"');
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE(Location, UserMgt.GetSalesFilter);
            Rec.FILTERGROUP(0);
        END;
    end;

    var
        UserMgt: Codeunit "User Setup Management";
        TemporaryJobOrders: Record "Temporary Job Orders";
}

