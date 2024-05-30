page 55079 "Reservation Cancellation Hist."
{
    PageType = List;
    SourceTable = "Reservation Cancellation Hist.";
    ApplicationArea = ALL;
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Reserved In"; Rec."Reserved In")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Cancelled Qty."; Rec."Cancelled Qty.")
                {
                }
                field("Reservation Cancelled On."; Rec."Reservation Cancelled On.")
                {
                }
                field("Reason Code"; Rec."Reason Code")
                {
                }
                field("Reservation Cancelled For"; Rec."Reservation Cancelled For")
                {
                }
                field("Cancelled By"; Rec."Cancelled By")
                {
                }
                field("Reservation Cancelled From"; Rec."Reservation Cancelled From")
                {
                    Caption = 'Org. Reserved Against';
                }
            }
        }
    }

    actions
    {
    }
}

