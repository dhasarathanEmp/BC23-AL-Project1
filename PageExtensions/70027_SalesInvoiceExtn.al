pageextension 70027 SalesInvoiceExtn extends "Sales Invoice"
{
    layout
    {
        addafter("Ship-to Contact")
        {
            field("Price Validate"; Rec."Price Validate")
            {

            }
            field("Delivery Terms"; Rec."Delivery Terms")
            {

            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(CopyDocument)
        {
            action("Copy Counter Document")
            {
                Image = CopyDocument;
                trigger OnAction()
                var
                    Options: Text[30];
                    OptionText: Label 'Counter_Invoice,Sales_Invoice';
                    SelectedOption: Integer;
                    CSHtoINV: Report CounterSalesHisToSalesInvoice;
                    SalesHeader: Record "Sales Header";
                begin
                    Options := OptionText;
                    SelectedOption := Dialog.StrMenu(Options, 2, '');
                    if SelectedOption = 1 then begin
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                        SalesHeader.SetRange("No.", Rec."No.");
                        Report.RunModal(70001, true, false, SalesHeader);
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
        CopyCounterDoc: Boolean;
}