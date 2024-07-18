report 50097 "GRN Report Whse Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './GRN Report Whse Receipt.rdlc';

    dataset
    {
        dataitem("Warehouse Receipt Header"; "Warehouse Receipt Header")
        {
            column(No_WarehouseReceiptHeader; "Warehouse Receipt Header"."No.")
            {
            }
            column(LocationCode_WarehouseReceiptHeader; "Warehouse Receipt Header"."Location Code")
            {
            }
            column(VendorInvoiceNumber_WarehouseReceiptHeader; "Warehouse Receipt Header"."Vendor Invoice Number")
            {
            }
            column(VendorInvoiceDate_WarehouseReceiptHeader; FORMAT("Warehouse Receipt Header"."Vendor Invoice Date"))
            {
            }
            column(PostingDate_WarehouseReceiptHeader; FORMAT("Warehouse Receipt Header"."Posting Date"))
            {
            }
            column(UserFullName; User."Full Name")
            {
            }
            dataitem("Warehouse Receipt Line"; "Warehouse Receipt Line")
            {
                DataItemLink = "No." = FIELD("No.");
                column(No_WarehouseReceiptLine; "Warehouse Receipt Line"."No.")
                {
                }
                column(LineNo_WarehouseReceiptLine; "Warehouse Receipt Line"."Line No.")
                {
                }
                column(SourceNo_WarehouseReceiptLine; "Warehouse Receipt Line"."Source No.")
                {
                }
                column(BinCode_WarehouseReceiptLine; "Warehouse Receipt Line"."Bin Code")
                {
                }
                column(ItemNo_WarehouseReceiptLine; "Warehouse Receipt Line"."Item No.")
                {
                }
                column(QtytoReceive_WarehouseReceiptLine; "Warehouse Receipt Line"."Qty. to Receive")
                {
                }
                column(QtyReceived_WarehouseReceiptLine; "Warehouse Receipt Line"."Qty. Received")
                {
                }
                column(Description_WarehouseReceiptLine; "Warehouse Receipt Line".Description)
                {
                }
                column(VendorInvoiceQty_WarehouseReceiptLine; "Warehouse Receipt Line"."Vendor Invoice Qty")
                {
                }
                column(UnitPrice_WarehouseReceiptLine; "Warehouse Receipt Line"."Unit Price")
                {
                }
                column(Amount_WarehouseReceiptLine; "Warehouse Receipt Line".Amount)
                {
                }
                column(Remarks_WarehouseReceiptLine; "Warehouse Receipt Line".Remarks)
                {
                }
                column(Excess_WarehouseReceiptLine; "Warehouse Receipt Line".Excess)
                {
                }
                column(InvLineAmt; InvLineAmt)
                {
                }
                column(RptLineAmt; RptLineAmt)
                {
                }
                column(InvTotAmt; InvTotAmt)
                {
                }
                column(RptTotAmt; RptTotAmt)
                {
                }
                column(ItemCategoryCode; ItemCategoryCode)
                {
                }
                column(VendorCode; "Vendor Code")
                {
                }
                column(VendorName; "Vendor Name")
                {
                }
                column(Excess1; Excess1)
                {
                }
                column(Shortage; Shortage)
                {
                }
                column(NetInvQty; NetInvQty)
                {
                }
                column(NetRptQty; NetRptQty)
                {
                }
                column(ShortageLineAmt; ShortageLineAmt)
                {
                }
                column(ExcessLineAmt; ExcessLineAmt)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(Item);
                    Item.GET("Warehouse Receipt Line"."Item No.");
                    ItemCategoryCode := Item."Item Category Code";
                    PurchHeader.RESET;
                    PurchHeader.SETRANGE("No.", "Warehouse Receipt Line"."Source No.");
                    if PurchHeader.FINDFIRST then begin
                        "Vendor Code" := PurchHeader."Buy-from Vendor No.";
                        "Vendor Name" := PurchHeader."Buy-from Vendor Name";
                    end;
                    NetInvQty += "Warehouse Receipt Line"."Vendor Invoice Qty";
                    NetRptQty += "Warehouse Receipt Line"."Qty. to Receive" + "Warehouse Receipt Line".Excess;
                    InvLineAmt := "Warehouse Receipt Line"."Vendor Invoice Qty" * "Warehouse Receipt Line"."Unit Price";
                    RptLineAmt := ("Warehouse Receipt Line"."Qty. to Receive" + "Warehouse Receipt Line".Excess) * "Warehouse Receipt Line"."Unit Price";
                    ShortageLineAmt := ("Warehouse Receipt Line"."Vendor Invoice Qty" - "Warehouse Receipt Line"."Qty. to Receive") * "Warehouse Receipt Line"."Unit Price";
                    ExcessLineAmt := "Warehouse Receipt Line".Excess * "Warehouse Receipt Line"."Unit Price";
                    InvTotAmt += InvLineAmt;
                    RptTotAmt += RptLineAmt;
                    Excess1 += "Warehouse Receipt Line".Excess;
                    Shortage += "Warehouse Receipt Line"."Vendor Invoice Qty" - "Warehouse Receipt Line"."Qty. to Receive";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                User.RESET;
                User.SETRANGE("User Name", USERID);
                User.FINDFIRST;
            end;
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

    trigger OnPreReport()
    begin
        CLEAR(InvTotAmt);
        CLEAR(RptTotAmt);
        CLEAR(Excess1);
        CLEAR(Shortage);
        CLEAR(NetInvQty);
        CLEAR(NetRptQty);
    end;

    var
        InvLineAmt: Decimal;
        RptLineAmt: Decimal;
        InvTotAmt: Decimal;
        RptTotAmt: Decimal;
        Item: Record Item;
        ItemCategoryCode: Code[10];
        PurchHeader: Record "Purchase Header";
        "Vendor Code": Code[10];
        "Vendor Name": Text;
        Excess1: Decimal;
        Shortage: Decimal;
        NetInvQty: Decimal;
        NetRptQty: Decimal;
        ShortageLineAmt: Decimal;
        ExcessLineAmt: Decimal;
        User: Record User;
}

