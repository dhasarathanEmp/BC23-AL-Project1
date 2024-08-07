pageextension 70010 SalesOrderExtn extends "Sales Order"
{

    layout
    {
        addafter("Sell-to Customer No.")
        {
            field("Agency Code"; Rec."Agency Code")
            {

            }
        }
        addafter("Promised Delivery Date")
        {
            field("Customer PO date"; Rec."Customer PO date")
            {
                Caption = 'Customer Date';
            }
        }
        addafter("Your Reference")
        {
            field("Document Type."; Rec."Document Type.")
            {

            }
            field("CR Document No."; Rec."CR Document No.")
            {

            }
            field("CR External Reference No."; Rec."CR External Reference No.")
            {

            }
            field("SO Version No."; Rec."SO Version No.")
            {

            }
            field("SO Revision Date"; Rec."SO Revision Date")
            {

            }
            field("Latest Released Date"; Rec."Latest Released Date")
            {

            }
            field(AFZDiscount; Rec.AFZDiscount)
            {
                ApplicationArea = All;
                Editable = IsAFZ;
                trigger OnValidate()
                var
                    AFZSalesLine: Record "Sales Line";
                begin
                    IF Rec.Status <> Rec.Status::Open THEN
                        ERROR('The Order is not Open');
                    AFZSalesLine.RESET;
                    AFZSalesLine.SETRANGE("Document No.", Rec."No.");
                    AFZSalesLine.SETFILTER("No.", '<>%1', '');
                    IF AFZSalesLine.FINDSET THEN
                        REPEAT
                            AFZSalesLine."Unit Price" := ROUND((AFZSalesLine."Unit Price" - AFZSalesLine."Core Charges") * (100 - Rec.AFZDiscount) / (100 - xRec.AFZDiscount) + AFZSalesLine."Core Charges", 0.01);
                            AFZSalesLine.VALIDATE("Unit Price");
                            AFZSalesLine.MODIFY;
                        UNTIL AFZSalesLine.NEXT = 0;
                end;
            }
            field("Customer PO Total"; Rec."Customer PO Total")
            {

            }
            field("Special Price Factor"; Rec."Special Price Factor")
            {

            }
        }

        addafter("Ship-to Contact")
        {
            field("Price Validate"; Rec."Price Validate")
            {

            }
            field("Delivery Terms"; Rec."Delivery Terms")
            {

            }
        }

        modify("External Document No.")
        {
            Caption = 'Purchase Order No';
        }

    }

    actions
    {
        modify(Release)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                ItemCategory.RESET;
                ItemCategory.SETRANGE("Is mandatory Customer PO No", true);
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
            end;

            trigger OnAfterAction()
            var
                onetoone: Codeunit "One to One TO Against SO";
            begin
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

            group("Report")
            {
                action("Order Acknowledgement")
                {
                    Image = PrintAcknowledgement;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }

                action("New Order Checklist")
                {
                    Image = Report;

                    trigger OnAction()
                    begin
                        Saleshdr.RESET;
                        Saleshdr.SETRANGE("Document Type", Rec."Document Type");
                        Saleshdr.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(50037, TRUE, TRUE, Saleshdr);
                    end;
                }

                action("Stock Request")
                {
                    Image = Report;

                    trigger OnAction()
                    begin
                        Saleshdr.RESET;
                        Saleshdr.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(REPORT::"Sales Order Stock Request", TRUE, TRUE, Saleshdr);
                    end;
                }

                action("Picking Slip")
                {
                    Image = Report;

                    trigger OnAction()
                    begin
                        Saleshdr.RESET;
                        Saleshdr.SETRANGE("No.", Rec."No.");
                        REPORT.RUNMODAL(REPORT::"Picking Slip", TRUE, TRUE, Saleshdr);
                    end;
                }
            }

        }
    }
    trigger OnOpenPage()
    var

    begin
        IF (CompanyInfo.GET) AND CompanyInfo.AFZ then
            IsAFZ := true
        else
            IsAFZ := false;
    end;

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
        IsAFZ: Boolean;
        CompanyInfo: Record "Company Information";
        DocPrint: Codeunit "Document-Print";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction","Sales Order Stock1";
        Saleshdr: Record "Sales Header";

}