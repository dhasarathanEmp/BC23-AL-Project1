report 70001 CounterSalesHisToSalesInvoice
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemName; Customer)
        {

        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group("Customer&Counter_Details")
                {
                    field("Customer No."; "Customer No.")
                    {
                        ApplicationArea = All;
                        TableRelation = Customer."No.";
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Customer: Record Customer;
                        begin
                            UserSetup.Reset();
                            UserSetup.SetRange("User ID", UserId);
                            UserSetup.SetFilter("Sales Resp. Ctr. Filter", '<>%1', '');
                            if UserSetup.FindFirst() then begin
                                Customer.Reset();
                                Customer.SetRange("Responsibility Center", UserSetup."Sales Resp. Ctr. Filter");
                                "Customer No." := Customer."No.";
                            end else
                                "Customer No." := Customer."No.";
                        end;
                    }
                    field("Counter Document No."; "Counter Document No.")
                    {
                        ApplicationArea = All;
                        TableRelation = "Cancelled CounterSales History"."CashDocument No.";
                        trigger OnLookup(var Text: Text): Boolean
                        begin

                        end;
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

    rendering
    {
        layout(LayoutName)
        {
            Type = Excel;
            LayoutFile = 'mySpreadsheet.xlsx';
        }
    }

    var
        myInt: Integer;
        UserSetup: Record "User Setup";
        "Customer No.": Code[30];
        "Counter Document No.": Code[30];
        CSHistory: Record "Cancelled CounterSales History";
}