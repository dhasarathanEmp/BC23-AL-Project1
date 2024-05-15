page 50122 CP_50122_ItemReplacmentHis
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = CT_50121_ItemReplacementHis;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Rec; Rec.ItemNo)
                {
                    ApplicationArea = All;

                }
                field(Rec1; Rec.ParentItem)
                {
                    ApplicationArea = All;

                }
                field(Rec2; Rec.ChildItem)
                {
                    ApplicationArea = All;

                }
                field(Rec3; Rec.LocationCode)
                {
                    ApplicationArea = All;

                }
                field(Rec4; Rec.LatestReplacementItem)
                {
                    ApplicationArea = All;

                }
                field(Rec5; Rec.Inventory)
                {
                    ApplicationArea = All;

                }
                field(Rec6; Rec.CurrItem)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}