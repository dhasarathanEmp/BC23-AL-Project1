pageextension 70010 SalesOrderExtn extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(History)
        {
            action("Auto Reserve")
            {
                ApplicationArea = All;
                Image = AutoReserve;
                trigger OnAction()
                begin
                    SalesLine.Reset();
                    SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.SetRange(Type, SalesLine.Type::Item);
                    if SalesLine.FindSet() then
                        repeat
                        until SalesLine.Next() = 0;
                end;
            }

        }
    }

    var
        myInt: Integer;
        SalesRes: Codeunit "Sales Line-Reserve";
        ResMgt: Codeunit "Reservation Management";
        SalesLine: Record "Sales Line";
}