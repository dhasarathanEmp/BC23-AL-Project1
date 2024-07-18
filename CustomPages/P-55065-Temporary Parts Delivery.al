page 55065 "Temporary Parts Delivery"
{
    // CS18 - 03/13/2018 Added code on Bin Code - OnValidate() to throw error when blocked bin code is choosen except for counter.
    // EP9612 Restricting Mutiple agency

    AutoSplitKey = true;
    Caption = 'Temporary Parts Delivery';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Item Journal Line";

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Batch Name';
                Lookup = true;
                ToolTip = 'Specifies the name of the journal batch, a personalized journal layout, that the journal is based on.';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SaveRecord;
                    IF UserSetupMgmt.GetSalesFilter <> '' THEN
                        LookupName3();

                    CurrPage.Update(false);
                end;

                trigger OnValidate()
                begin
                    ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a document number for the journal line.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the item on the journal line.';

                    trigger OnValidate()
                    begin
                        ItemJnlMgt.GetItem(Rec."Item No.", ItemDescription);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        Rec.ShowNewShortcutDimCode(NewShortcutDimCode);
                        //EP9612
                        "Restricting Mutiple Agency";
                        //EP9612
                        CurrLine := Rec."Line No.";
                        //  >>  CS02
                        ItemJournalBatch.Reset;
                        ItemJournalBatch.SetRange(Name, Rec."Journal Batch Name");
                        if ItemJournalBatch.FindFirst then
                            Rec.Validate("Location Code", ItemJournalBatch.Location);
                        if Rec."Location Code" <> '' then begin
                            MapCounterBin;
                        end;
                        //CS16
                        Item.Reset;
                        Item.SetRange("No.", Rec."Item No.");
                        if Item.FindFirst then begin
                            Rec."Unit Price" := Item."Unit Price";
                            Rec."Unit Price" := Round(Rec."Unit Price", 0.01);
                            Rec."Line AmountUP" := Rec."Unit Price";
                        end;

                        //  >>  K08
                        JobOrderNo;
                        //  <<  K08
                        Rec.Validate("Unit Price");
                        BinStkCheck(Rec."Item No.", Rec."Location Code", Rec."Bin Code", Rec."Unit of Measure Code");
                        Rec."Bin Code" := '';
                        Rec."Required Quantity" := 0;
                        //  <<  CS02
                        Rec.Validate(Rec."Currency Code");
                        Rec."VAT Bus" := 'VAT-DOM';
                        if (Rec."Currency Code" = '') or (Rec."Currency Code" = 'USD') then
                            Rec."Currency Code" := 'USD';
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a description of the item on the journal line.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the code for the inventory location where the item on the journal line will be registered.';

                    trigger OnValidate()
                    var
                        WMSManagement: Codeunit "WMS Management";
                    begin
                        //WMSManagement.CheckItemJnlLineLocation(Rec,xRec);
                        //  >>  CS02
                        //MapCounterBin;
                        BinStkCheck(Rec."Item No.", Rec."Location Code", Rec."Bin Code", Rec."Unit of Measure Code");
                        //  <<  CS02
                        Rec."New Bin Code" := '';
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of units of the item to be included on the journal line.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                    Visible = true;

                    trigger OnValidate()
                    begin
                        //  >>  CS02
                        MapCounterBin;

                        BinStkCheck(Rec."Item No.", Rec."Location Code", Rec."Bin Code", Rec."Unit of Measure Code");
                        Rec.Validate(Rec.Quantity);
                        if Rec."Bin Code" = '' then begin
                            Rec.Quantity := 0;
                            Rec."Line AmountUP" := 0;
                        end;

                        if Rec."Bin Code" = '' then begin
                            Rec."Required Quantity" := 0;
                            Rec.Quantity := 0;
                        end;

                        //  <<  CS02
                    end;
                }
                field("New Bin Code"; Rec."New Bin Code")
                {
                    ApplicationArea = Warehouse;
                    Editable = false;
                    Enabled = false;
                    ToolTip = 'Specifies the new bin code to link to the items on this journal line.';
                    Visible = true;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        // >> to filter counter bins
                        IJB.Reset;
                        IJB.SetRange(Counter_Batch, false);
                        IJB.SetRange(Name, Rec."Journal Batch Name");
                        IJB.SetRange("Journal Template Name", Rec."Journal Template Name");
                        if IJB.FindFirst then begin
                            Bin2.Reset;
                            Bin2.SetRange("Location Code", Rec."New Location Code");
                            Bin2.SetRange("Counter sale", false);
                            Bin2.SetRange(Blocks, false);
                            Bin2.SetRange("Temporary Delivery", true);
                            if PAGE.RunModal(7303, Bin2) = ACTION::LookupOK then
                                Rec."New Bin Code" := Bin2.Code;
                        end
                        else begin
                            Bin2.Reset;
                            if PAGE.RunModal(7303, Bin2) = ACTION::LookupOK then
                                Rec."New Bin Code" := Bin2.Code;
                        end;
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the price of one unit of the item on the journal line.';

                    trigger OnValidate()
                    begin
                        //CS16
                        if Rec.Quantity <> 0 then
                            Rec."Line AmountUP" := Rec.Quantity * Rec."Unit Price"
                        else
                            Rec."Line AmountUP" := Rec."Unit Price";

                        // CS16
                    end;
                }
                field("Line AmountUP"; Rec."Line AmountUP")
                {
                    Caption = 'Line Amount';
                }
                field("Discount%"; Rec."Discount%")
                {
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                }
                field("Job Order No."; Rec."Job Order No.")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        if Rec."Job Order No." = '' then begin
                            Rec."Job Order No." := '';
                            Rec."Job Card No." := '';
                            Rec."Job Order Description" := '';
                            Replacejobno;
                        end else begin
                            TemporaryJobOrders.Reset;
                            TemporaryJobOrders.SetRange("Job Order No", Rec."Job Order No.");
                            if TemporaryJobOrders.FindFirst then begin
                                Rec."Job Order Description" := TemporaryJobOrders."Job Description";
                                Rec."Job Card No." := TemporaryJobOrders."Job Crad No";
                                Replacejobno;
                            end;
                        end;
                    end;
                }
                field("Job Card No."; Rec."Job Card No.")
                {
                }
                field("Job Order Description"; Rec."Job Order Description")
                {
                }
            }
            group(Control28)
            {
                ShowCaption = false;
                Visible = false;
                fixed(Control26)
                {
                    ShowCaption = false;
                    Visible = false;
                    group("Item Description")
                    {
                        Caption = 'Item Description';
                        Visible = false;
                        field(ItemDescription; ItemDescription)
                        {
                            Editable = false;
                            ShowCaption = false;
                            Visible = false;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control21; Links)
            {
                Visible = false;
            }
            systempart(Control20; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowReclasDimensions;
                        CurrPage.SaveRecord;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines(true);
                    end;
                }
                action("Bin Contents")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Bin Contents';
                    Image = BinContent;
                    RunObject = Page "Bin Contents List";
                    RunPageLink = "Location Code" = FIELD("Location Code"),
                                  "Item No." = FIELD("Item No."),
                                  "Variant Code" = FIELD("Variant Code");
                    RunPageView = SORTING("Location Code", "Item No.", "Variant Code");
                    ToolTip = 'View items in the bin if the selected line contains a bin code.';
                    Visible = false;
                }
            }
            group("&Item")
            {
                Caption = '&Item';
                Image = Item;
                action(Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Item Card";
                    RunPageLink = "No." = FIELD("Item No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or change detailed information about the record on the document or journal line.';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger E&ntries';
                    Image = ItemLedger;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No." = FIELD("Item No.");
                    RunPageView = SORTING("Item No.");
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'View the projected quantity of the item over time according to time periods, such as day, week, or month.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData Location = R;
                        ApplicationArea = Location;
                        Caption = 'Location';
                        Image = Warehouse;
                        ToolTip = 'View the actual and projected quantity of the item per location.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        AccessByPermission = TableData "BOM Buffer" = R;
                        ApplicationArea = Assembly;
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ToolTip = 'View availability figures for items on bills of materials that show how many units of a parent item you can make based on the availability of child items.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("E&xplode BOM")
                {
                    AccessByPermission = TableData "BOM Component" = R;
                    ApplicationArea = Advanced;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    RunObject = Codeunit "Item Jnl.-Explode BOM";
                    ToolTip = 'Insert new lines for the components on the bill of materials, for example to sell the parent item as a kit. CAUTION: The line for the parent item will be deleted and represented by a description only. To undo, you must delete the component lines and add a line the parent item again.';
                }
                separator(Separator52)
                {
                }
                action("Get Bin Content")
                {
                    AccessByPermission = TableData "Bin Content" = R;
                    ApplicationArea = Warehouse;
                    Caption = 'Get Bin Content';
                    Ellipsis = true;
                    Image = GetBinContent;
                    ToolTip = 'Use a function to create transfer lines with items to put away or pick based on the actual content in the specified bin.';

                    trigger OnAction()
                    var
                        BinContent: Record "Bin Content";
                        GetBinContent: Report "Whse. Get Bin Content";
                    begin
                        BinContent.SetRange("Location Code", Rec."Location Code");
                        GetBinContent.SetTableView(BinContent);
                        GetBinContent.InitializeItemJournalLine(Rec);
                        GetBinContent.RunModal;
                        CurrPage.Update(false);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Temporary Delivery")
                {
                    Image = "Report";
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        ItemJournalLine.Reset;
                        ItemJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                        ItemJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        ItemJournalLine.SetRange("Document No.", Rec."Document No.");
                        REPORT.RunModal(REPORT::"Temporary Delivery Report", true, true, ItemJournalLine);
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintItemJnlLine(Rec);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", Rec);
                        CurrentJnlBatchName := Rec.GetRangeMax(Rec."Journal Batch Name");
                        CurrPage.Update(false);
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := Rec.GetRangeMax(Rec."Journal Batch Name");
                        CurrPage.Update(false);
                    end;
                }
            }
            action("&Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    ItemJnlLine: Record "Item Journal Line";
                begin
                    ItemJnlLine.Copy(Rec);
                    ItemJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    REPORT.RunModal(REPORT::"Inventory Movement", true, true, ItemJnlLine);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ItemJnlMgt.GetItem(Rec."Item No.", ItemDescription);
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        Rec.ShowNewShortcutDimCode(NewShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    begin
        Commit;
        if not ReserveItemJnlLine.DeleteLineConfirm(Rec) then
            exit(false);
        ReserveItemJnlLine.DeleteLine(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //  >>  CS02
        if CheckBatchName(Rec."Journal Batch Name") then begin

            if not Rec.IsEmpty and (xRec.Status = xRec.Status::" ") then begin
                Rec."Document No." := xRec."Document No.";
                Rec."Posting Date" := WorkDate;
            end
            else begin
                Rec."Document No." := '';
                Rec."Posting Date" := WorkDate;
            end;
            //
        end;
        //  <<  CS02

        Rec.SetUpNewLine(xRec);
        Clear(ShortcutDimCode);
        Clear(NewShortcutDimCode);
        Rec."Entry Type" := Rec."Entry Type"::Transfer;
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        if Rec.IsOpenedFromBatch then begin
            CurrentJnlBatchName := Rec."Journal Batch Name";
            ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
            exit;
        end;
        ItemJnlMgt.TemplateSelection(PAGE::"Item Reclass. Journal", 1, false, Rec, JnlSelected);
        if not JnlSelected then
            Error('');
        CurrentJnlBatchName := CheckUserRC;
        ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        Text000: Label '1,2,3,New ';
        Text001: Label '1,2,4,New ';
        Text002: Label '1,2,5,New ';
        Text003: Label '1,2,6,New ';
        Text004: Label '1,2,7,New ';
        Text005: Label '1,2,8,New ';
        ItemJnlMgt: Codeunit ItemJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[50];
        ShortcutDimCode: array[8] of Code[20];
        NewShortcutDimCode: array[8] of Code[20];
        CounterSalesCU: Record "Cancelled CounterSales History";
        IsPostVisible: Boolean;
        IsIncrement: Boolean;
        IsCounter: Boolean;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ItemJnlBatch: Record "Item Journal Batch";
        Number: Integer;
        IsExist: Boolean;
        ContactRec: Record Contact;
        ItemJournalLine: Record "Item Journal Line";
        LocationRec: Record Location;
        IsContactEnabled: Boolean;
        Bin1: Record Bin;
        ItemJournalBatch: Record "Item Journal Batch";
        NoSeriesCode: Code[30];
        ItemJournalLine1: Record "Item Journal Line";
        Item: Record Item;
        SingleCU: Codeunit TransferItemJournaltoService;
        CancelledCounterSalesHistory: Record "Cancelled CounterSales History";
        IsOk: Boolean;
        DocNo1: Code[10];
        IsInc: Boolean;
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
        NewSeriesCode: Code[30];
        IsInc1: Boolean;
        ContBus: Record "Contact Business Relation";
        YERUnitPrice: Decimal;
        UserSetupMgmt: Codeunit "User Setup Management";
        "Count": Integer;
        ContactNo: Code[20];
        ContactName: Text[50];
        DocNo: Code[20];
        IsCounterNew: Boolean;
        "CustomerNo.": Code[20];
        CustomerName: Code[50];
        IJL: Record "Item Journal Line";
        CurrExchRate: Record "Currency Exchange Rate";
        IsVisible: Boolean;
        Company: Record Company;
        ServiceItem: Record "Service Item";
        Bincontents: Record "Bin Content";
        BinQty: Decimal;
        IJLQty: Decimal;
        AQ: Decimal;
        Location1: Record Location;
        Bin2: Record Bin;
        IJB: Record "Item Journal Batch";
        TotLineAmt1: Decimal;
        TotLineAmt: Decimal;
        IJL4: Record "Item Journal Line";
        IJL1: Record "Item Journal Line";
        IJL5: Record "Item Journal Line";
        CurrLineAmt: Decimal;
        Currency: Record Currency;
        BinBool: Boolean;
        DeleteBool: Boolean;
        VATPostingSetup: Record "VAT Posting Setup";
        CancelledBool: Boolean;
        UncancelledBool: Boolean;
        VarUP: Decimal;
        ItemJnlLineCU: Record "Item Journal Line";
        ItemJnlLineCU1: Record "Item Journal Line";
        IJLC1: Record "Item Journal Line";
        CurrLine: Integer;
        CusRec1: Record Customer;
        Contact1: Record Contact;
        Usersetup: Record "User Setup";
        RespCenter: Record "Responsibility Center";
        USerCode: Code[10];
        LocationNonEditable: Boolean;
        Location: Text;
        Text062: Label 'This BinCode:%1 is Blocked.';
        TemporaryDeliveryHistory: Record "Temporary Delivery History";
        SONO: Code[20];
        Desccode: Text[50];
        TemporaryJobOrders: Record "Temporary Job Orders";
        TUSerCode: Code[10];
        ItemJournalLine_Agency_Restrict: Record "Item Journal Line";

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SaveRecord;
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.Update(false);
    end;

    local procedure Replacejobno()
    var
        ItemJnlLineCU: Record "Item Journal Line";
    begin
        ItemJnlLineCU.Reset;
        ItemJnlLineCU.SetRange("Source Code", 'RECLASSJNL');
        ItemJnlLineCU.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineCU.SetRange("Document No.", Rec."Document No.");
        ItemJnlLineCU.SetFilter("Line No.", '<>%1', Rec."Line No.");
        if ItemJnlLineCU.FindSet then
            repeat
                if Rec."Job Order No." <> '' then begin
                    TemporaryJobOrders.Reset;
                    TemporaryJobOrders.SetRange("Job Order No", Rec."Job Order No.");
                    if TemporaryJobOrders.FindFirst then begin
                        ItemJnlLineCU."Job Order No." := Rec."Job Order No.";
                        ItemJnlLineCU."Job Card No." := Rec."Job Card No.";
                        ItemJnlLineCU."Job Order Description" := Rec."Job Order Description";
                        ItemJnlLineCU."VAT Bus" := Rec."VAT Bus";
                        ItemJnlLineCU.Modify;
                    end;
                end else begin
                    ItemJnlLineCU."Job Order No." := '';
                    ItemJnlLineCU."Job Order Description" := '';
                    ItemJnlLineCU."Job Card No." := '';
                    ItemJnlLineCU.Modify;
                end;
            until ItemJnlLineCU.Next = 0;
    end;

    local procedure MapCurrency()
    begin
        ItemJnlLineCU.Reset;
        ItemJnlLineCU.SetRange("Source Code", 'RECLASSJNL');
        //ItemJnlLineCU.SETRANGE("Journal Batch Name",'COUNTER');
        ItemJnlLineCU.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineCU.SetRange("Document No.", Rec."Document No.");
        ItemJnlLineCU.SetFilter("Line No.", '<>%1', Rec."Line No.");
        if ItemJnlLineCU.FindFirst then begin
            if (ItemJnlLineCU."Currency Code" <> '') and (ItemJnlLineCU."Currency Code" <> 'YER') then
                Rec.Validate("Currency Code", ItemJnlLineCU."Currency Code");
        end;
    end;

    local procedure MapCurrencyCodePage(var ItmJnLn: Record "Item Journal Line")
    var
        ItemJnlLineCU: Record "Item Journal Line";
    begin
        //ItmJnLn.RESET;
        ItmJnLn.SetRange("Source Code", 'RECLASSJNL');
        ItmJnLn.SetRange("Journal Batch Name", ItmJnLn."Journal Batch Name");
        ItmJnLn.SetRange("Document No.", ItmJnLn."Document No.");
        //ItmJnLn.SETRANGE("Line No.",ItmJnLn."Line No.");
        ItmJnLn.SetFilter("Line No.", '<>%1', Rec."Line No.");
        if ItmJnLn.FindFirst then begin
            if ((Rec."Currency Code" <> '') or (Rec."Currency Code" <> 'USD')) then begin
                ItmJnLn."Currency Code" := Rec."Currency Code";
                VarUP := ItmJnLn."Unit Price";
                ItmJnLn."Unit Price" := Rec.UnitPriceCalc(ItmJnLn.PriceCheck);
                ItmJnLn."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price";
                ItmJnLn."Discount Amount" := Round(Round(ItmJnLn.Quantity * ItmJnLn."Unit Price", Currency."Amount Rounding Precision") *
                                         ItmJnLn."Discount%" / 100, Currency."Amount Rounding Precision");
                ItmJnLn."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price" - ItmJnLn."Discount Amount";
                //ItmJnLn.MODIFY;
            end
            else begin
                ItmJnLn."Currency Code" := 'USD';
                ItmJnLn."Unit Price" := Rec.UnitPriceCalc(ItmJnLn.PriceCheck);
                ItmJnLn."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price";
                ItmJnLn."Discount Amount" := Round(Round(ItmJnLn.Quantity * ItmJnLn."Unit Price", Currency."Amount Rounding Precision") *
                                         ItmJnLn."Discount%" / 100, Currency."Amount Rounding Precision");
                ItmJnLn."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price" - ItmJnLn."Discount Amount"
                //ItmJnLn.MODIFY;
            end;
        end;
    end;

    local procedure CheckCSLineStkTotal(ItemNo: Code[20]; LocationCode: Code[10]; UOM: Code[10]): Integer
    var
        IJL: Record "Item Journal Line";
        TotalQty: Integer;
    begin
        Clear(TotalQty);
        IJL.Reset;
        IJL.SetRange("Source Code", 'RECLASSJNL');
        IJL.SetRange("Item No.", Rec."Item No.");
        IJL.SetRange("Location Code", LocationCode);
        IJL.SetFilter(Status, '<>%1', IJL.Status::Cancelled);
        IJL.SetFilter("Line No.", '<>%1', Rec."Line No.");
        if IJL.FindSet then
            repeat
                TotalQty += IJL.Quantity;
            until IJL.Next = 0;
        exit(TotalQty);
    end;

    local procedure BinStkCheckTotal(ItemNo: Code[20]; LocationCode: Code[10]; Bincode: Code[20]; UOM: Code[10])
    var
        BinContent: Record "Bin Content";
        Text01: Label 'Stock is less in the Bin %1 for the Part No. %2.';
        Text02: Label 'Stock is not available in the Bin %1 for the Part No. %2.';
        "IJLQty.": Integer;
        ActualQty: Integer;
    begin
        "IJLQty." := 0;
        ActualQty := 0;
        BinContent.Reset;
        BinContent.SetRange("Item No.", ItemNo);
        BinContent.SetRange("Location Code", LocationCode);
        BinContent.SetRange("Unit of Measure Code", UOM);
        if BinContent.FindSet then
            repeat
                BinContent.CalcFields(Quantity);
                "IJLQty." := CheckCSLineStkTotal(ItemNo, LocationCode, UOM);
                ActualQty := BinContent.Quantity - "IJLQty.";
                Rec."Required Quantity" := ActualQty;
            until BinContent.Next = 0;
    end;

    local procedure MapCurCurrencyCodePage(var ItmJnLn: Record "Item Journal Line")
    var
        ItemJnlLineCU: Record "Item Journal Line";
    begin
        //ItmJnLn.RESET;
        ItmJnLn.SetRange("Source Code", 'RECLASSJNL');
        ItmJnLn.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        ItmJnLn.SetRange("Document No.", Rec."Document No.");
        ItmJnLn.SetFilter("Line No.", '=%1', Rec."Line No.");
        if ItmJnLn.FindFirst then begin
            if ((Rec."Currency Code" <> '') or (Rec."Currency Code" <> 'USD')) then begin
                ItmJnLn."Currency Code" := Rec."Currency Code";
                VarUP := ItmJnLn."Unit Price";
                Rec."Unit Price" := Rec.UnitPriceCalc(ItmJnLn.PriceCheck);
                Rec."Line AmountUP" := ItmJnLn.Quantity * Rec."Unit Price";
                Rec."Discount Amount" := Round(Round(ItmJnLn."Unit Price" * ItmJnLn.Quantity, Currency."Amount Rounding Precision") *
                                         ItmJnLn."Discount%" / 100, Currency."Amount Rounding Precision");
                Rec."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price" - Rec."Discount Amount";
                //ItmJnLn.MODIFY;
            end
            else begin
                Rec."Currency Code" := 'USD';
                Rec."Unit Price" := Rec.UnitPriceCalc(ItmJnLn.PriceCheck);
                Rec."Line AmountUP" := ItmJnLn.Quantity * Rec."Unit Price";
                Rec."Discount Amount" := Round(Round(Rec."Unit Price" * Rec.Quantity, Currency."Amount Rounding Precision") *
                                         ItmJnLn."Discount%" / 100, Currency."Amount Rounding Precision");
                Rec."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price" - ItmJnLn."Discount Amount";
                //ItmJnLn.MODIFY;
            end;
        end;
    end;

    local procedure ExchangeRateRestriction()
    var
        E: Integer;
        ExcgRte: Record "Currency Exchange Rate";
    begin
        E := 0;
        ExcgRte.Reset;
        ExcgRte.SetRange("Currency Code", 'YER');
        if ExcgRte.FindSet then
            repeat begin
                if ExcgRte."Starting Date" = WorkDate then
                    E := 1;
            end;
            until ExcgRte.Next = 0;
        if E = 0 then
            Error('Update exchange rate for YER currency');
    end;

    procedure CheckBatchName("Code": Code[10]): Boolean
    var
        IJBatch: Record "Item Journal Batch";
    begin
        IJBatch.Reset;
        IJBatch.SetRange(Name, Code);
        IJBatch.SetRange("Temporary Delivery", true);
        if not IJBatch.IsEmpty then
            exit(true)
        else
            exit(false);
    end;

    procedure CheckUserRC(): Code[30]
    var
        IJBatch: Record "Item Journal Batch";
        UserSetupMgmt: Codeunit "User Setup Management";
    begin
        Clear(UserSetupMgmt);
        if UserSetupMgmt.GetSalesFilter <> '' then begin
            IJBatch.Reset;
            IJBatch.SetRange(Responsibility_Center, UserSetupMgmt.GetSalesFilter);
            IJBatch.SetRange("Temporary Delivery", true);
            if IJBatch.FindFirst then
                exit(IJBatch.Name);
        end else begin
            IJBatch.Reset;
            IJBatch.SetRange("Temporary Delivery", true);
            if IJBatch.FindFirst then
                exit(IJBatch.Name);
        end;
    end;

    local procedure BinStkCheck(ItemNo: Code[20]; LocationCode: Code[10]; Bincode: Code[20]; UOM: Code[10])
    var
        BinContent: Record "Bin Content";
        Text01: Label 'Stock is less in the Bin %1 for the Part No. %2.';
        Text02: Label 'Stock is not available in the Bin %1 for the Part No. %2.';
        "IJLQty.": Integer;
        ActualQty: Integer;
    begin
        "IJLQty." := 0;
        ActualQty := 0;
        BinContent.Reset;
        BinContent.SetRange("Item No.", ItemNo);
        BinContent.SetRange("Location Code", LocationCode);
        BinContent.SetRange("Bin Code", Bincode);
        BinContent.SetRange("Unit of Measure Code", UOM);
        if BinContent.FindFirst then begin
            BinContent.CalcFields(Quantity);
            "IJLQty." := CheckCSLineStk(ItemNo, LocationCode, Bincode, UOM);
            ActualQty := BinContent.Quantity - "IJLQty.";
            Rec."Required Quantity" := ActualQty;
        end;
    end;

    local procedure CheckCSLineStk(ItemNo: Code[20]; LocationCode: Code[10]; Bincode: Code[20]; UOM: Code[10]): Integer
    var
        IJL: Record "Item Journal Line";
        TotalQty: Integer;
    begin
        Clear(TotalQty);
        IJL.Reset;
        IJL.SetRange("Source Code", 'RECLASSJNL');
        IJL.SetRange("Item No.", Rec."Item No.");
        IJL.SetRange("Location Code", LocationCode);
        IJL.SetRange("Bin Code", Bincode);
        IJL.SetFilter(Status, '<>%1', IJL.Status::Cancelled);
        IJL.SetFilter("Line No.", '<>%1', Rec."Line No.");
        if IJL.FindSet then
            repeat
                TotalQty += IJL.Quantity;
            until IJL.Next = 0;
        exit(TotalQty);
    end;

    local procedure MapCounterBin()
    begin
        if CheckBatchName(Rec."Journal Batch Name") then begin
            LocationRec.Reset;
            LocationRec.SetRange(Code, Rec."Location Code");
            if LocationRec.FindFirst then begin
                if LocationRec."Bin Mandatory" = true then begin
                    Bin1.Reset;
                    Bin1.SetRange("Location Code", Rec."Location Code");
                    Bin1.SetRange("Counter sale", false);
                    Bin1.SetRange(Blocks, false);
                    Bin1.SetRange("Temporary Delivery", true);
                    if Bin1.FindFirst then
                        Rec."New Bin Code" := Bin1.Code
                    else
                        Error('Temporary Bin does not exist in the location %1.', Rec."Location Code");
                end;
            end;
        end;
    end;

    local procedure JobOrderNo()
    begin
        ItemJnlLineCU.Reset;
        ItemJnlLineCU.SetRange("Source Code", 'RECLASSJNL');
        ItemJnlLineCU.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineCU.SetRange("Document No.", Rec."Document No.");
        ItemJnlLineCU.SetFilter("Line No.", '<>%1', Rec."Line No.");
        if ItemJnlLineCU.FindFirst then begin
            if ItemJnlLineCU."Job Order No." <> '' then begin
                Rec."Job Order No." := ItemJnlLineCU."Job Order No.";
                Rec."Job Card No." := ItemJnlLineCU."Job Card No.";
                Rec."Job Order Description" := ItemJnlLineCU."Job Order Description";
                //Rec."VAT Bus" :=  ItemJnlLineCU."VAT Bus";
            end else begin
                Rec."Job Order No." := '';
                Rec."Job Card No." := '';
                Rec."Job Order Description" := '';
            end;
        end;
    end;

    local procedure ModifyJobOrderNumber()
    begin
        ItemJnlLineCU.Reset;
        ItemJnlLineCU.SetRange("Source Code", 'RECLASSJNL');
        ItemJnlLineCU.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineCU.SetRange("Document No.", Rec."Document No.");
        ItemJnlLineCU.SetFilter("Line No.", '<>%1', Rec."Line No.");
        if ItemJnlLineCU.FindSet then
            repeat
                if Rec."Job Order No." <> '' then begin
                    TemporaryJobOrders.Reset;
                    TemporaryJobOrders.SetRange("Job Order No", Rec."Job Order No.");
                    if TemporaryJobOrders.FindFirst then begin
                        ItemJnlLineCU."Job Order No." := Rec."Job Order No.";
                        ItemJnlLineCU."Job Card No." := Rec."Job Card No.";
                        ItemJnlLineCU."Job Order Description" := Rec."Job Order Description";
                        //ItemJnlLineCU."VAT Bus" := Rec."VAT Bus";
                        ItemJnlLineCU.Modify;
                    end;
                end else begin
                    ItemJnlLineCU."Job Order No." := '';
                    ItemJnlLineCU."Job Card No." := '';
                    ItemJnlLineCU."Job Order Description" := '';
                    ItemJnlLineCU.Modify;
                end;
            until ItemJnlLineCU.Next = 0;
    end;

    local procedure "Restricting Mutiple Agency"()
    begin
        //EP9612
        ItemJournalLine_Agency_Restrict.Reset;
        ItemJournalLine_Agency_Restrict.SetRange("Document No.", Rec."Document No.");
        if ItemJournalLine_Agency_Restrict.FindLast then begin
            if ItemJournalLine_Agency_Restrict."Item No." <> '' then begin
                if ItemJournalLine_Agency_Restrict."Gen. Prod. Posting Group" <> Rec."Gen. Prod. Posting Group" then
                    Error('Adding Mutiple Agency items in same Document No is Restricted , Previously choosen item agency is %1', ItemJournalLine_Agency_Restrict."Gen. Prod. Posting Group");
            end;
        end
        //EP9612
    end;

    procedure LookupName3()
    var
        usersetup: Record "User Setup";
        Responsibility_Center: Code[30];
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlBatch: Record "Item Journal Batch";
    begin
        usersetup.Reset();
        usersetup.SetRange("User ID", UserId);
        usersetup.SetFilter("Sales Resp. Ctr. Filter", '<>%1', '');
        if usersetup.FindFirst() then
            Responsibility_Center := usersetup."Sales Resp. Ctr. Filter";

        ItemJnlBatch.Reset();
        ItemJnlBatch.FILTERGROUP(2);
        ItemJnlBatch.SETRANGE("Temporary Delivery", TRUE);
        ItemJnlBatch.SETRANGE("Journal Template Name", 'RECLASS');
        ItemJnlBatch.SETRANGE(Responsibility_Center, Responsibility_Center);
        ItemJnlBatch.FILTERGROUP(0);
        IF PAGE.RUNMODAL(0, ItemJnlBatch) = ACTION::LookupOK THEN BEGIN
            CurrentJnlBatchName := ItemJnlBatch.Name;
        END else begin
            ItemJnlBatch.Reset();
            ItemJnlBatch.FILTERGROUP(2);
            ItemJnlBatch.SETRANGE("Temporary Delivery", TRUE);
            ItemJnlBatch.SETRANGE("Journal Template Name", 'RECLASS');
            ItemJnlBatch.FILTERGROUP(0);
            IF PAGE.RUNMODAL(0, ItemJnlBatch) = ACTION::LookupOK THEN BEGIN
                CurrentJnlBatchName := ItemJnlBatch.Name;
            end;
        end;
    end;
}

