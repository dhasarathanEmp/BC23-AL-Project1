page 55087 "FOC Sales History"
{
    PageType = List;
    SourceTable = "FOC Sales History";
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                }
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field("Item No"; Rec."Item No")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                }
                field("Default Price/Unit"; Rec."Default Price/Unit")
                {
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                }
                field("Customer No"; Rec."Customer No")
                {
                    Editable = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    Editable = false;
                }
                field(Remark; Rec.Remark)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("FOC NBDN")
            {
                Caption = 'FOC NBDN';
                Image = "Report";
                RunObject = Report "FOC NBDN History";
            }
        }
    }
}

