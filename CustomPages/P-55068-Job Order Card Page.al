page 55068 "Job Order Card Page"
{
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Temporary Job Orders";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Job Order No"; Rec."Job Order No")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        SalesReceivablesSetup.GET;
                        IF Rec."Job Order No" = '' THEN
                            Rec."Job Order No" := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Temporary Delivery", WORKDATE, TRUE);
                    end;
                }
                field("Job Description"; Rec."Job Description")
                {

                    trigger OnValidate()
                    begin
                        SalesReceivablesSetup.GET;
                        IF Rec."Job Order No" = '' THEN
                            Rec."Job Order No" := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Temporary Delivery", WORKDATE, TRUE);

                        IF Rec.Location = '' THEN BEGIN
                            Visible := TRUE;
                        END ELSE
                            Visible := FALSE;
                        Rec."Job Creation Date" := WORKDATE;
                    end;
                }
                field("Job Creation Date"; Rec."Job Creation Date")
                {
                }
                field("Job Crad No"; Rec."Job Crad No")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Vehicle Plate No"; Rec."Vehicle Plate No")
                {
                }
                field("Model No"; Rec."Model No")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field("Job Status"; Rec."Job Status")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Temporary Delivery Confirmation ")
            {
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TemporaryJobOrders.RESET;
                    TemporaryJobOrders.SETRANGE("Job Order No", Rec."Job Order No");
                    REPORT.RUNMODAL(REPORT::"Temp delivery History Report", TRUE, TRUE, TemporaryJobOrders);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SalesReceivablesSetup.GET;
        IF Rec."Job Order No" = '' THEN
            Rec."Job Order No" := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Temporary Delivery", WORKDATE, TRUE);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF (Rec."Job Status" = Rec."Job Status"::Completed) OR (Rec."Job Status" = Rec."Job Status"::"On Job") THEN
            ERROR('Deletion allowed only for the job status "Open"');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
            Rec.Location := UserMgt.GetSalesFilter;
        END;
    end;

    var
        UserMgt: Codeunit "User Setup Management";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Visible: Boolean;
        LocationMandatory: Boolean;
        TemporaryJobOrders: Record "Temporary Job Orders";
}

