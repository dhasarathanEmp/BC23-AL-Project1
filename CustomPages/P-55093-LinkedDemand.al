page 55093 "Linked Demand"
{
    PageType = List;
    SourceTable = "Req Link Maintainance";
    //DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("S.No"; Rec."S.No")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Demand Required Qty"; Rec."Demand Required Qty")
                {
                    ApplicationArea = All;
                }
                field("Demand Source No."; Rec."Demand Source No.")
                {
                    ApplicationArea = All;
                }
                field("Demand Source Ref No."; Rec."Demand Source Ref No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

}