page 55086 "FOC Sales"
{
    // CS05 3-2-18 OnAfterGetRecord, OnNewRecord,Service Order - OnValidate,Service Order - OnLookup,Post - OnAction  Transfer Item Journal Lines to Service Order Lines Customization
    // YER 03/13/2018 Added fields YER unit cost and YER unit amount and functions.
    // CUS001 03/2/18 Sales service,purchase Based on Service order.

    AutoSplitKey = true;
    Caption = 'Item Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Page';
    SaveValues = true;
    SourceTable = "Item Journal Line";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Batch Name';
                Editable = false;
                Lookup = true;
                ToolTip = 'Specifies the name of the journal batch, a personalized journal layout, that the journal is based on.';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;
                    ItemJnlMgt.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(false);
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
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the related document was created.';
                    Visible = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.';
                    ToolTip = 'Specifies the type of transaction that will be posted from the item journal line.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
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
                    Editable = false;
                    ToolTip = 'Specifies the code for the inventory location where the item on the journal line will be registered.';
                    Visible = true;

                    trigger OnValidate()
                    var
                        WMSManagement: Codeunit "WMS Management";
                    begin
                        WMSManagement.CheckItemJnlLineLocation(Rec, xRec);
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

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if Rec."Entry Type" = Rec."Entry Type"::"Negative Adjmt." then begin
                            Bin.RESET;
                            Bin.SETRANGE("Location Code", Rec."Location Code");
                            if PAGE.RUNMODAL(7303, Bin) = ACTION::LookupOK then
                                Rec."Bin Code" := Bin.Code;
                        end else begin
                            Bin.RESET;
                            Bin.SETRANGE("Location Code", Rec."Location Code");
                            Bin.SETRANGE("Counter sale", false);
                            Bin.SETRANGE(Blocks, false);
                            Bin.SETRANGE(Discrepancy, false);
                            Bin.SETRANGE("Temporary Delivery", false);
                            Bin.SETRANGE(DeadStocks, false);
                            if PAGE.RUNMODAL(7303, Bin) = ACTION::LookupOK then
                                Rec."Bin Code" := Bin.Code;
                        end;
                    end;
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the price of one unit of the item on the journal line.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field(Remark; Rec.Remark)
                {
                }
                field("CustomerNo."; Rec."CustomerNo.")
                {

                    trigger OnValidate()
                    begin
                        AutoUpdateChosenCusNotoAllLines;
                        Customer.RESET;
                        if Customer.GET(Rec."CustomerNo.") then begin
                            Rec."Customer Name1" := Customer.Name;
                        end else
                            Rec."Customer Name1" := '';
                    end;
                }
                field("Customer Name1"; Rec."Customer Name1")
                {
                }
            }
            group(Control22)
            {
                ShowCaption = false;
                fixed(Control1900669001)
                {
                    ShowCaption = false;
                    group("Item Description")
                    {
                        Caption = 'Item Description';
                        field(ItemDescription; ItemDescription)
                        {
                            ApplicationArea = Basic, Suite;
                            Editable = false;
                            ShowCaption = false;
                            ToolTip = 'Specifies a description of the item.';
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            part(Control1903326807; "Item Replenishment FactBox")
            {
                ApplicationArea = Advanced;
                SubPageLink = "No." = FIELD("Item No.");
                Visible = false;
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
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
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(ItemTrackingLines)
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines(false);
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
                }
                action("&Recalculate Unit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Recalculate Unit Amount';
                    Image = UpdateUnitCost;
                    ToolTip = 'Reset the unit amount to the amount specified on the item card.';

                    trigger OnAction()
                    begin
                        Rec.RecalculateUnitAmount;
                        CurrPage.SAVERECORD;
                    end;
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
                        ToolTip = 'Show the projected quantity of the item over time according to time periods, such as day, week, or month.';

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
                        ApplicationArea = Advanced;
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
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit "Item Jnl.-Explode BOM";
                    ToolTip = 'Insert new lines for the components on the bill of materials, for example to sell the parent item as a kit. CAUTION: The line for the parent item will be deleted and represented by a description only. To undo, you must delete the component lines and add a line the parent item again.';
                }
                action("&Calculate Whse. Adjustment")
                {
                    ApplicationArea = Warehouse;
                    Caption = '&Calculate Whse. Adjustment';
                    Ellipsis = true;
                    Image = CalculateWarehouseAdjustment;
                    ToolTip = 'Calculate adjustments in quantity based on the warehouse adjustment bin for each item in the journal. New lines are added for negative and positive quantities.';

                    trigger OnAction()
                    begin
                        CalcWhseAdjmt.SetItemJnlLine(Rec);
                        CalcWhseAdjmt.RUNMODAL;
                        CLEAR(CalcWhseAdjmt);
                    end;
                }
                action("&Get Standard Journals")
                {
                    ApplicationArea = Suite;
                    Caption = '&Get Standard Journals';
                    Ellipsis = true;
                    Image = GetStandardJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Import journal lines from a standard journal that already exists.';

                    trigger OnAction()
                    var
                        StdItemJnl: Record "Standard Item Journal";
                    begin
                        StdItemJnl.FILTERGROUP := 2;
                        StdItemJnl.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                        StdItemJnl.FILTERGROUP := 0;
                        if PAGE.RUNMODAL(PAGE::"Standard Item Journals", StdItemJnl) = ACTION::LookupOK then begin
                            StdItemJnl.CreateItemJnlFromStdJnl(StdItemJnl, CurrentJnlBatchName);
                            MESSAGE(Text001, StdItemJnl.Code);
                        end
                    end;
                }
                action("&Save as Standard Journal")
                {
                    ApplicationArea = Suite;
                    Caption = '&Save as Standard Journal';
                    Ellipsis = true;
                    Image = SaveasStandardJournal;
                    ToolTip = 'Save the journal lines as a standard journal that you can later reuse.';

                    trigger OnAction()
                    var
                        ItemJnlBatch: Record "Item Journal Batch";
                        ItemJnlLines: Record "Item Journal Line";
                        StdItemJnl: Record "Standard Item Journal";
                        SaveAsStdItemJnl: Report "Save as Standard Item Journal";
                    begin
                        ItemJnlLines.SETFILTER("Journal Template Name", Rec."Journal Template Name");
                        ItemJnlLines.SETFILTER("Journal Batch Name", CurrentJnlBatchName);
                        CurrPage.SETSELECTIONFILTER(ItemJnlLines);
                        ItemJnlLines.COPYFILTERS(Rec);

                        ItemJnlBatch.GET(Rec."Journal Template Name", CurrentJnlBatchName);
                        SaveAsStdItemJnl.Initialise(ItemJnlLines, ItemJnlBatch);
                        SaveAsStdItemJnl.RUNMODAL;
                        if not SaveAsStdItemJnl.GetStdItemJournal(StdItemJnl) then
                            exit;

                        MESSAGE(Text002, StdItemJnl.Code);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
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
                        Rec.TESTFIELD("CustomerNo.");
                        Rec.TESTFIELD("Item No.");
                        Rec.TESTFIELD(Quantity);
                        Rec.TESTFIELD("Bin Code");
                        ItemJournalLine_FOC.RESET;
                        ItemJournalLine_FOC.SETRANGE("Document No.", Rec."Document No.");
                        if ItemJournalLine_FOC.FINDSET then
                            repeat
                                if Line_No = 0 then begin
                                    Line_No := 1000;
                                end else
                                    Line_No += 1000;

                                FOCSalesHistory."Line No" := Line_No;
                                FOCSalesHistory."Posting Date" := ItemJournalLine_FOC."Posting Date";
                                FOCSalesHistory."Document No" := ItemJournalLine_FOC."Document No.";
                                FOCSalesHistory."Item No" := ItemJournalLine_FOC."Item No.";
                                FOCSalesHistory.Description := ItemJournalLine_FOC.Description;
                                FOCSalesHistory.Quantity := ItemJournalLine_FOC.Quantity;
                                FOCSalesHistory."Location Code" := ItemJournalLine_FOC."Location Code";
                                FOCSalesHistory."Default Price/Unit" := ItemJournalLine_FOC."Default Price/Unit";
                                FOCSalesHistory."Unit of Measure" := ItemJournalLine_FOC."Unit of Measure Code";
                                FOCSalesHistory."Created By" := USERID;
                                FOCSalesHistory."Customer No" := ItemJournalLine_FOC."CustomerNo.";
                                FOCSalesHistory."Customer Name" := ItemJournalLine_FOC."Customer Name1";
                                FOCSalesHistory."Bin Code" := ItemJournalLine_FOC."Bin Code";
                                FOCSalesHistory.Remark := ItemJournalLine_FOC.Remark;
                                FOCSalesHistory.INSERT;
                            until ItemJournalLine_FOC.NEXT = 0;

                        //  >>  CS05
                        if Rec."Journal Batch Name" = 'SERVICE' then begin
                            CheckServiceOrder;
                            CLEAR(SetItemJournalCU);
                            SetItemJournalCU.Setitemjournal;
                        end;
                        //  <<  CS05
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);
                        CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(false);
                    end;
                }
                action("FOC-NBDN")
                {
                    Caption = 'FOC-NBDN';
                    Image = "Report";

                    trigger OnAction()
                    begin
                        //EP9614 Opening Report for current document
                        ItemJournalLine.RESET;
                        ItemJournalLine.SETRANGE("Document No.", Rec."Document No.");
                        REPORT.RUNMODAL(50001, true, false, ItemJournalLine);
                        //EP96
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
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(false);
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
                    ItemJnlLine.COPY(Rec);
                    ItemJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    REPORT.RUNMODAL(REPORT::"Inventory Movement", true, true, ItemJnlLine);
                end;
            }
            group("Page")
            {
                Caption = 'Page';
                action(EditInExcel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Edit in Excel';
                    Image = Excel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Send the data in the journal to an Excel file for analysis or editing.';
                    Visible = IsSaasExcelAddinEnabled;

                    trigger OnAction()
                    var
                        ODataUtility: Codeunit ODataUtility;
                    begin
                        ODataUtility.EditJournalWorksheetInExcel(CurrPage.CAPTION, CurrPage.OBJECTID(false), Rec."Journal Batch Name", Rec."Journal Template Name");
                    end;
                }
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
        //  >>  CS05
        if Rec."Journal Batch Name" = 'SERVICE' then
            IsEnable := true
        else
            IsEnable := false;
        //  <<  CS05
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    begin
        COMMIT;
        if not ReserveItemJnlLine.DeleteLineConfirm(Rec) then
            exit(false);
        ReserveItemJnlLine.DeleteLine(Rec);
        Rec."CustomerNo." := '';
        Rec."Customer Name1" := '';
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec."Entry Type" > Rec."Entry Type"::"Negative Adjmt." then
            ERROR(Text000, Rec."Entry Type");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine(xRec);
        CLEAR(ShortcutDimCode);
        //  >>  CS05
        if Rec."Journal Batch Name" = 'SERVICE' then
            IsEnable := true
        else
            IsEnable := false;
        //  <<  CS05
        Rec."Entry Type" := Rec."Entry Type"::Sale;
        Rec."Location Code" := 'HOD-HO';
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Document No.", Rec."Document No.");
        if ItemJournalLine.FINDLAST then begin
            Rec."CustomerNo." := xRec."CustomerNo.";
            Rec."Customer Name1" := xRec."Customer Name1";
        end
    end;

    trigger OnOpenPage()
    var
        //ServerConfigSettingHandler: Codeunit "Server Config. Setting Handler";
        JnlSelected: Boolean;
    begin
        if Rec.IsOpenedFromBatch then begin
            CurrentJnlBatchName := Rec."Journal Batch Name";
            ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
            exit;
        end;

        ItemJnlMgt.TemplateSelection(PAGE::"Item Reclass. Journal", 1, false, Rec, JnlSelected);
        if not JnlSelected then
            ERROR('');
        CLEAR(CurrentJnlBatchName);
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        if UserSetup.FINDFIRST then
            CurrentJnlBatchName := UserSetup."FOC Sales Batch";

        ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
        Rec."Entry Type" := Rec."Entry Type"::Sale;
        Rec."Location Code" := 'HOD-HO';
    end;

    var
        Text000: Label 'You cannot use entry type %1 in this journal.';
        CalcWhseAdjmt: Report "Calculate Whse. Adjustment";
        ItemJnlMgt: Codeunit ItemJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        //ClientTypeManagement: Codeunit ClientTypeManagement;
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[50];
        ShortcutDimCode: array[8] of Code[20];
        Text001: Label 'Item Journal lines have been successfully inserted from Standard Item Journal %1.';
        Text002: Label 'Standard Item Journal %1 has been successfully created.';
        IsSaasExcelAddinEnabled: Boolean;
        IsEnable: Boolean;
        ItemJournal: Record "Item Journal Line" temporary;
        SetItemJournalCU: Codeunit TransferItemJournaltoService;
        SOrdType: Record "Service Order Type";
        ServiceHeader: Record "Service Header";
        UserSetupMgt: Codeunit "User Setup Management";
        //CopyRRLinetoItemJournal: Report "Copy RR Line to Item Journal";
        Bin: Record Bin;
        UserSetup: Record "User Setup";
        ItemJournalLine: Record "Item Journal Line";
        Customer: Record Customer;
        FOCSalesHistory: Record "FOC Sales History";
        ItemJournalLine_FOC: Record "Item Journal Line";
        Line_No: Integer;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(false);
    end;

    local procedure CheckServiceOrder()
    var
        Text001: Label 'Service Order No. is blank in the Line No. %1. Select a Service Order.';
        ItemJournal: Record "Item Journal Line";
    begin
        ItemJournal.RESET;
        ItemJournal.SETRANGE("Journal Template Name", 'ITEM');
        ItemJournal.SETRANGE("Journal Batch Name", 'SERVICE');
        if ItemJournal.FINDSET then
            repeat
                if ItemJournal."Service Order" = '' then
                    ERROR(Text001, ItemJournal."Line No.");
            until ItemJournal.NEXT = 0;
    end;

    local procedure Filteronsalesandserviceandpurchase()
    begin
        // >> CUS001
        if (UserSetupMgt.GetSalesFilter <> '') and (UserSetupMgt.GetServiceFilter = '') and (UserSetupMgt.GetPurchasesFilter = '') then begin
            Rec."Responsibility Center" := UserSetupMgt.GetSalesFilter;
            Rec."Sales Type" := Rec."Sales Type"::Sales;
        end else begin
            if (UserSetupMgt.GetServiceFilter <> '') and (UserSetupMgt.GetPurchasesFilter = '') and (UserSetupMgt.GetSalesFilter = '') then begin
                Rec."Responsibility Center" := UserSetupMgt.GetServiceFilter;
                Rec."Sales Type" := Rec."Sales Type"::Service;
            end else begin
                if (UserSetupMgt.GetPurchasesFilter <> '') and (UserSetupMgt.GetSalesFilter = '') and (UserSetupMgt.GetServiceFilter = '') then begin
                    Rec."Responsibility Center" := UserSetupMgt.GetPurchasesFilter;
                    Rec."Sales Type" := Rec."Sales Type"::Purchase;

                end;
            end;
        end;
        // << CUS001
    end;

    local procedure AutoUpdateChosenCusNotoAllLines()
    begin
        Customer.RESET;
        if Customer.GET(Rec."CustomerNo.") then begin
            ItemJournalLine.RESET;
            ItemJournalLine.SETRANGE("Document No.", Rec."Document No.");
            if ItemJournalLine.FINDSET then
                repeat
                    if ItemJournalLine."Line No." <> Rec."Line No." then begin
                        ItemJournalLine."CustomerNo." := Rec."CustomerNo.";
                        ItemJournalLine."Customer Name1" := Customer.Name;
                        ItemJournalLine.MODIFY;
                    end;
                until ItemJournalLine.NEXT = 0;
        end else begin
            ItemJournalLine.RESET;
            ItemJournalLine.SETRANGE("Document No.", Rec."Document No.");
            if ItemJournalLine.FINDSET then
                repeat
                    if ItemJournalLine."Line No." <> Rec."Line No." then begin
                        ItemJournalLine."CustomerNo." := '';
                        ItemJournalLine."Customer Name1" := '';
                        ItemJournalLine.MODIFY;
                    end;
                until ItemJournalLine.NEXT = 0;
        end
    end;
}

