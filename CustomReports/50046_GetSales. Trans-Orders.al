report 50046 "GetSales. Trans-Orders"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Group)
                {
                    field("Purchasing Location"; "Purchasing Location")
                    {
                        ApplicationArea = All;
                        TableRelation = Location where("Use As In-Transit" = const(false));
                    }
                    field("Agency Code"; "Agency Code")
                    {
                        ApplicationArea = All;
                        TableRelation = "Dimension Value" where("Global Dimension No." = const(1));
                    }
                    field("Demand Source Type"; "Demand Source Type")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    procedure ReturnPurchLoc() PurchLoc: Code[20]
    begin
        PurchLoc := "Purchasing Location";
        EXIT(PurchLoc);
    end;

    procedure ReturnAgencyCode() Agency: Code[20]
    begin
        Agency := "Agency Code";
        EXIT(Agency);
    end;

    procedure ReturnDemandType() DemandSourceType: Integer
    begin
        DemandSourceType := "Demand Source Type";
        EXIT(DemandSourceType);
    end;

    var
        "Purchasing Location": Code[20];
        "Agency Code": Code[20];
        "Demand Source Type": Option "Transfer Orders","Sales Orders";
}