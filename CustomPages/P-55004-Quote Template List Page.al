page 55004 "Quote Template List Page"
{
    // CS13 19/7/18 Report Template - List Page for table Template

    CardPageID = "Quote Template Card";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Quote Template";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Quote Template No"; Rec."Quote Template No")
                {
                }
            }
        }
    }

    actions
    {
    }
}

