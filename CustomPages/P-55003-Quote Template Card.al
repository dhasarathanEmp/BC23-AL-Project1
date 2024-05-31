page 55003 "Quote Template Card"
{
    // CS13 19/7/18 Report Template - Card Page for table Template

    SourceTable = "Quote Template";
    UsageCategory = Tasks;

    layout
    {
        area(content)
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
            group("Template Data")
            {
            }
            field(DocumentIntroduction; DocumentIntroduction)
            {
                Caption = 'Document Introduction';
                Importance = Additional;
                MultiLine = true;

                trigger OnValidate()
                begin
                    Rec.SetWorkDescription(DocumentIntroduction);
                end;
            }
            field(DocumentConclusion; DocumentConclusion)
            {
                Caption = 'Document Conclusion';
                Importance = Additional;
                MultiLine = true;

                trigger OnValidate()
                begin
                    Rec.SetWorkDescription1(DocumentConclusion);
                end;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        DocumentIntroduction := Rec.GetWorkDescription();
        DocumentConclusion := Rec.GetWorkDescription1();
    end;

    var
        DocumentIntroduction: Text;
        DocumentConclusion: Text;
}

