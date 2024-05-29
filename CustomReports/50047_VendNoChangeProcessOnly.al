report 50047 "Vend No Change ProcessOnly"
{
    ApplicationArea = All;
    ProcessingOnly = true;

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Group)
                {
                    field("Old Vendor No"; "Old Vendor No")
                    {
                        ApplicationArea = All;
                        TableRelation = Vendor;
                    }
                    field("New Vendor No"; "New Vendor No")
                    {
                        ApplicationArea = All;
                        TableRelation = Vendor;
                        trigger OnValidate()
                        begin
                            IF "New Vendor No" = "Old Vendor No" then
                                Error('New Vendor No should be different from old vendor No');
                        end;
                    }
                }
            }
        }
    }
    procedure "Return Old Vend No"() Vend: Code[20]
    begin
        Vend := "Old Vendor No";
        EXIT(Vend);
    end;


    procedure "Return New Vend No"() Vend: Code[20]
    begin
        Vend := "New Vendor No";
        EXIT(Vend);
    end;

    var
        "Old Vendor No": Code[20];
        "New Vendor No": Code[20];
}