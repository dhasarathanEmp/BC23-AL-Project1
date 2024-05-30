pageextension 70010 SalesOrderExtn extends "Sales Order"
{
    layout
    {
        modify("External Document No.")
        {
            Caption = 'Purchase Order No';
        }

    }

    actions
    {
        // Add changes to page actions here
        modify(Release)
        {
            trigger OnAfterAction()
            var
                onetoone: Codeunit "One to One TO Against SO";
            begin
                ItemCategory.RESET;
                ItemCategory.SETRANGE("Is mandatory Customer PO No", TRUE);
                IF ItemCategory.FINDSET THEN
                    REPEAT
                        SalesLineBuf.RESET;
                        SalesLineBuf.SETRANGE("Document No.", Rec."No.");
                        SalesLineBuf.SETRANGE("Document Type", SalesLineBuf."Document Type"::Order);
                        SalesLineBuf.SETRANGE("Posting Group", ItemCategory.Code);
                        IF SalesLineBuf.FINDSET THEN
                            REPEAT
                                IF SalesLineBuf."PO Number" = '' THEN
                                    ERROR('Please Fill the Purchase Order No in all sales Line');
                                IF SalesLineBuf."Customer Serial No" = '' THEN
                                    ERROR('Please Fill the PO Serial No in all sales Line')
                            UNTIL SalesLineBuf.NEXT = 0;
                    UNTIL ItemCategory.NEXT = 0;
                //AFZ001

                onetoone."Create TO Against SO"(Rec."No.");
            end;
        }
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
                            Item.get(SalesLine."No.");
                            if Item.Type = Item.Type::Inventory then begin
                                SalesLine.CalcFields("Reserved Quantity", "Reserved Qty. (Base)");
                                if SalesLine."Outstanding Quantity" > SalesLine."Reserved Quantity" then begin
                                    Clear(ResMgt);
                                    RemQtytoRes := SalesLine."Outstanding Quantity" - SalesLine."Reserved Quantity";
                                    RemQtytoResBase := SalesLine."Outstanding Qty. (Base)" - SalesLine."Reserved Qty. (Base)";
                                    ResMgt.SetReservSource(SalesLine);
                                    ResMgt.AutoReserveOneLine(1, RemQtytoRes, RemQtytoResBase, '', SalesLine."Shipment Date");
                                end;
                            end;
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
        RemQtytoRes: Decimal;
        RemQtytoResBase: Decimal;
        Item: Record Item;
        ItemCategory: Record "Item Category";
        SalesLineBuf: Record "Sales Line";
}