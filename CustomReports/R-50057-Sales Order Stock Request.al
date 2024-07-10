report 50057 "Sales Order Stock Request"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Sales Order Stock Request.rdlc';
    Caption = 'Sales Order Stock Request';

    dataset
    {
        dataitem(DataItem4; "Sales Header")
        {
            RequestFilterFields = "Document Type", "No.";
            dataitem(DataItem16; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE(Type = CONST(Item),
                                          Quantity = FILTER(> 0));
                RequestFilterFields = "Document No.";
                column(DocumentNo_SalesLine; "Document No.")
                {
                }
                column(LineNo_SalesLine; "Line No.")
                {
                }
                column(No_SalesLine; "No.")
                {
                }
                column(LocationCode_SalesLine; "Location Code")
                {
                }
                column(Description_SalesLine; Description)
                {
                }
                column(UnitofMeasureCode_SalesLine; "Unit of Measure Code")
                {
                }
                column(Quantity_SalesLine; Quantity)
                {
                }
                column(CustomerSerialNo_SalesLine; "Customer Serial No")
                {
                }
                column(QtyToRequest; QtyToRequest)
                {
                }
                column(UserFullName; UserFullName)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    QtyToRequest := 0;
                    "Sales Line".CALCFIELDS("Reserved Quantity");
                    Item.RESET;
                    Item.SETRANGE("No.", "Sales Line"."No.");
                    Item.SETRANGE("Hose Main item", TRUE);
                    IF Item.FINDFIRST THEN BEGIN
                        AssembletoOrderLink.RESET;
                        AssembletoOrderLink.SETRANGE("Document No.", "Sales Line"."Document No.");
                        AssembletoOrderLink.SETRANGE("Document Line No.", "Sales Line"."Line No.");
                        AssembletoOrderLink.SETRANGE("Document Type", "Sales Line"."Document Type"::Order);
                        IF AssembletoOrderLink.FINDFIRST THEN BEGIN
                            IF AssemblyOrderNumber <> '' THEN
                                AssemblyOrderNumber := AssemblyOrderNumber + '|' + AssembletoOrderLink."Assembly Document No."
                            ELSE
                                AssemblyOrderNumber := AssembletoOrderLink."Assembly Document No.";
                        END;
                        CurrReport.SKIP;
                    END ELSE IF "Sales Line"."Outstanding Quantity" > "Sales Line"."Reserved Quantity" THEN BEGIN
                        QtyToRequest := "Sales Line"."Outstanding Quantity" - "Sales Line"."Reserved Quantity"
                    END ELSE
                        CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    User.RESET;
                    User.SETRANGE("User Name", USERID);
                    IF User.FINDFIRST THEN
                        UserFullName := User."Full Name";
                    AssemblyOrderNumber := '';
                end;
            }
            dataitem(DataItem5; "Assembly Line")
            {
                column(DocumentNo_AssemblyLine; "Document No.")
                {
                }
                column(No_AssemblyLine; "No.")
                {
                }
                column(Description_AssemblyLine; Description)
                {
                }
                column(Quantity_AssemblyLine; Quantity)
                {
                }
                column(UnitofMeasureCode_AssemblyLine; "Unit of Measure Code")
                {
                }
                column(AssemblyQtytoRequest; AssemblyQtytoRequest)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF AssemblyOrderNumber <> '' THEN BEGIN
                        AssemblyQtytoRequest := 0;
                        AssemblyOutStanding := "Assembly Line".Quantity - "Assembly Line"."Consumed Quantity";
                        "Assembly Line".CALCFIELDS("Reserved Quantity");
                        IF AssemblyOutStanding > "Assembly Line"."Reserved Quantity" THEN
                            AssemblyQtytoRequest := AssemblyOutStanding - "Assembly Line"."Reserved Quantity"
                        ELSE
                            CurrReport.SKIP;
                    END ELSE
                        CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    "Assembly Line".SETFILTER("Document No.", AssemblyOrderNumber);
                    "Assembly Line".FINDSET;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        User: Record User;
        QtyToRequest: Decimal;
        UserFullName: Text;
        AssembletoOrderLink: Record "Assemble-to-Order Link";
        AssemblyLine: Record "Assembly Line";
        AssemblyOrderNumber: Code[30];
        Item: Record Item;
        AssemblyOutStanding: Decimal;
        AssemblyQtytoRequest: Decimal;
        "Sales Line": Record "Sales Line";
        "Assembly Line": Record "Assembly Line";
}

