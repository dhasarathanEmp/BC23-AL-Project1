page 55001 "Counter Sales -Item Reclass."
{
    // CS02 16-01-18 OnOpenPage, OnAfterGetRecord, OnNewRecord, OnInsertRecord, OnDeleteRecord, OnAfterGetCurrRecord, New Bin Code - OnValidate
    // Contact - OnValidate, Post - OnAction, Approve - OnAction, Cancel - OnAction -Counter Sales Customization.
    // 24/08/18   K08 VinNo vichle plate no, service Item no- Onvalidate & lookup ;
    // CUS016 09/06/18 addind Fields Vpn no(50006),Vehicle Plate No.(50007), Service item no(50008), Service item name(50009) using for report.
    // CS15 08/25/18 Reservation button added with its functionlaity.
    // CS16 07/08/2018 Added fields and coding for pricing in counter sales
    // Cu005 Default Price Factor Customisation
    // Cu021
    // EP9612 Restricting Mutiple agency items

    AutoSplitKey = true;
    Caption = 'Counter Sales -Item Reclass. Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Worksheet;
    RefreshOnActivate = false;
    SaveValues = true;
    SourceTable = "Item Journal Line";
    SourceTableView = WHERE("Journal Batch Name" = const('COUNTER'));

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                Caption = 'Batch Name';
                Enabled = true;
                Lookup = true;
                ToolTip = 'Specifies the name of the journal batch of the item journal.';

                trigger OnLookup(var Text: Text): Boolean
                var
                    UserSetupMgmt: Codeunit "User Setup Management";
                    ItemJnlMgt: Codeunit ItemJnlManagement;
                begin
                    CurrPage.SAVERECORD;
                    //  >>  CS02
                    IF UserSetupMgmt.GetSalesFilter <> '' THEN
                        LookupName3();
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                var
                    ItemJnlMgt: Codeunit ItemJnlManagement;
                begin
                    ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(Lines)
            {
                field(Cash; Rec.Cash)
                {
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date on the document that provides the basis for the entry on the item journal line.';
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies a document number for the journal line.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the number of the item on the journal line.';

                    trigger OnValidate()
                    var
                        ItemJournalLine: Record "Item Journal Line";
                        ItemJnlMgt: Codeunit ItemJnlManagement;
                        CurrLine: Integer;
                        ItemJournalBatch: Record "Item Journal Batch";
                        Item: Record Item;
                        DefaultPriceFactor: Record "Default Price Factor";
                    begin
                        //EP9612
                        "Restricting Mutiple Agency"();
                        //EP9612
                        //Cu018
                        GenJournalLineExist();
                        ItemJournalLine.RESET;
                        ItemJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                        ItemJournalLine.SETRANGE("Document No.", Rec."Document No.");
                        ItemJournalLine.SETRANGE(Cash, TRUE);
                        IF ItemJournalLine.FINDSET THEN
                            ERROR('Payment has been done for this Document No. use new Document No.');
                        //Cu018
                        //  >>  CS02
                        IF Rec."Document No." = '' THEN
                            ERROR('Document No. must be filled before selecting the item');
                        //  <<  CS02
                        ItemJnlMgt.GetItem(Rec."Item No.", ItemDescription);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        Rec.ShowNewShortcutDimCode(NewShortcutDimCode);

                        CurrLine := Rec."Line No.";
                        //  >>  CS02
                        ItemJournalBatch.RESET;
                        ItemJournalBatch.SETRANGE(Name, Rec."Journal Batch Name");
                        IF ItemJournalBatch.FINDFIRST THEN
                            Rec.VALIDATE("Location Code", 'HOD-HO');
                        IF Rec."Location Code" <> '' THEN BEGIN
                            MapCounterBin;
                        END;
                        //CS16
                        Item.RESET;
                        Item.SETRANGE("No.", Rec."Item No.");
                        IF Item.FINDFIRST THEN BEGIN
                            //Cu005
                            DefaultPriceFactor.RESET;
                            DefaultPriceFactor.SETRANGE("Agency Code", Item."Gen. Prod. Posting Group");
                            DefaultPriceFactor.FINDFIRST;
                            Rec."Unit Price" := (Item."Unit Price" - Item."Dealer Net - Core Deposit" * Item."Inventory Factor") * DefaultPriceFactor."Default Price Factor";
                            Rec."Unit Price" := ROUND(Rec."Unit Price", 0.01, '=');
                            Rec."Unit Price" := Item."Unit Price";
                            //Cu005
                            Rec."Line AmountUP" := Rec."Unit Price";
                        END;

                        MapContact();
                        //CS16
                        //  >>  K08
                        MapserviceItemNo();
                        //  <<  K08
                        Rec.VALIDATE("Unit Price");
                        BinStkCheck(Rec."Item No.", Rec."Location Code", Rec."Bin Code", Rec."Unit of Measure Code");
                        Rec."Bin Code" := '';
                        Rec."Required Quantity" := 0;
                        //  <<  CS02
                        Rec.VALIDATE(Rec."Currency Code");
                        Rec."VAT Bus" := 'VAT-DOM';
                        IF (Rec."Currency Code" = '') OR (Rec."Currency Code" = 'USD') THEN
                            Rec."Currency Code" := 'USD';
                    end;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Enabled = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies a variant code for the item.';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item on the journal line.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = LocationNonEditable;
                    Enabled = LocationNonEditable;
                    ToolTip = 'Specifies the code for the inventory location where the item on the journal line will be registered.';
                    Visible = true;

                    trigger OnValidate()
                    var
                        WMSManagement: Codeunit "WMS Management";
                    begin
                        //  >>  CS02
                        MapContact();
                        BinStkCheck(Rec."Item No.", Rec."Location Code", Rec."Bin Code", Rec."Unit of Measure Code");
                        //  <<  CS02
                        Rec."New Bin Code" := '';
                    end;
                }
                field("Available Quantity"; Rec.Quantity)
                {
                    Caption = 'Required Quantity';
                    Editable = true;
                    ToolTip = 'Specifies the number of units of the item to be included on the journal line.';

                    trigger OnValidate()
                    begin
                        //Cu018
                        GenJournalLineExist();
                        IF Rec.Cash = TRUE THEN
                            ERROR('Record cannot be changed after payment completion');
                        //Cu018                        
                        IF (Rec."Bin Code" <> '') AND (Rec."Location Code" <> '') THEN BEGIN
                            IF Rec.Quantity > Rec."Required Quantity" THEN
                                ERROR('Required quantity should be less than or equal to available quantity');
                        END;

                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies a bin code for the item.';
                    Visible = true;

                    trigger OnValidate()
                    begin
                        //Cu018
                        GenJournalLineExist();
                        IF Rec.Cash = TRUE THEN
                            ERROR('Record cannot be changed after payment completion');
                        //Cu018
                        //  >>  CS02
                        MapCounterBin();

                        BinStkCheck(Rec."Item No.", Rec."Location Code", Rec."Bin Code", Rec."Unit of Measure Code");
                        Rec.VALIDATE(Quantity);
                        IF Rec."Bin Code" = '' THEN BEGIN
                            Rec.Quantity := 0;
                            Rec."Line AmountUP" := 0;
                        END;
                        IF Rec."Bin Code" <> '' THEN BEGIN
                            IF Rec.Quantity > Rec."Required Quantity" THEN BEGIN
                                MESSAGE('Required Quantity should be less than or equal to available Quantity. Please select the available bins and enter the required quantity');
                                Rec.Quantity := 0;
                                Rec."Bin Code" := '';
                                Rec."Line AmountUP" := 0;
                            END;
                        END;
                        IF Rec."Bin Code" = '' THEN BEGIN
                            Rec."Required Quantity" := 0;
                            Rec.Quantity := 0;
                        END;
                    end;
                }
                field("New Bin Code"; Rec."New Bin Code")
                {
                    Editable = false;
                    Enabled = true;
                    TableRelation = Bin.Code;
                    ToolTip = 'Specifies the new bin code to link to the items on this journal line.';
                    Visible = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        IJB: Record "Item Journal Batch";
                        Bin2: Record Bin;
                    begin
                        // >> to filter counter bins
                        IJB.RESET;
                        IJB.SETRANGE(Counter_Batch, TRUE);
                        IJB.SETRANGE(Name, Rec."Journal Batch Name");
                        IJB.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                        IF IJB.FINDFIRST THEN BEGIN
                            Bin2.RESET;
                            Bin2.SETRANGE("Location Code", Rec."New Location Code");
                            Rec.FILTERGROUP(2);
                            Bin2.SETRANGE("Counter sale", TRUE);
                            Bin2.SETRANGE(Blocks, FALSE);
                            Bin2.SETRANGE("Temporary Delivery", FALSE);
                            Rec.FILTERGROUP(0);
                            IF PAGE.RUNMODAL(7303, Bin2) = ACTION::LookupOK THEN
                                Rec."New Bin Code" := Bin2.Code;
                        END
                        ELSE BEGIN
                            Bin2.RESET;
                            IF PAGE.RUNMODAL(7303, Bin2) = ACTION::LookupOK THEN
                                Rec."New Bin Code" := Bin2.Code;
                        END;
                    end;
                }
                field("Required Quantity"; Rec."Required Quantity")
                {
                    Caption = 'Available Quantity';
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the code if you have filled in the Sales Unit of Measure field on the item card.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        //Cu018
                        GenJournalLineExist;
                        IF Rec.Cash = TRUE THEN
                            ERROR('Record cannot be changed after payment completion');
                        //Cu018
                        //CS16
                        IF Rec.Quantity <> 0 THEN
                            Rec."Line AmountUP" := Rec.Quantity * Rec."Unit Price"
                        ELSE
                            Rec."Line AmountUP" := Rec."Unit Price";
                        //CurrPage.UPDATE;
                        //CS16
                    end;
                }
                field("VAT Bus"; Rec."VAT Bus")
                {

                    trigger OnValidate()
                    begin
                        /*
                        VATPostingSetup.RESET;
                        VATPostingSetup.SETRANGE("VAT Prod. Posting Group",Rec."VAT Prod");
                        IF VATPostingSetup.FINDFIRST THEN
                           Rec."VAT Bus" := Rec."VAT Bus"
                        ELSE
                           ERROR('Invalid VAT Combination');
                        */
                        /*ItemJnlLineCU.RESET;
                        ItemJnlLineCU.SETRANGE("Source Code",'RECLASSJNL');
                        ItemJnlLineCU.SETRANGE("Journal Batch Name","Journal Batch Name");
                        ItemJnlLineCU.SETRANGE("Document No.",Rec."Document No.");
                        ItemJnlLineCU.SETFILTER("Line No.",'<>%1',Rec."Line No.");
                        IF ItemJnlLineCU.FINDSET THEN REPEAT
                          ItemJnlLineCU."VAT Prod" := Rec."VAT Prod";
                          ItemJnlLineCU.MODIFY;
                        UNTIL ItemJnlLineCU.NEXT = 0;*/
                        //Cu018
                        GenJournalLineExist;
                        IF Rec.Cash = TRUE THEN
                            ERROR('Record cannot be changed after payment completion');
                        //Cu018

                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the dimension value code that the item journal line is linked to.';
                    Visible = false;
                }
                field("New Shortcut Dimension 1 Code"; Rec."New Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the new dimension value code that will link to the items on the journal line.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the dimension value code that the item journal line is linked to.';
                    Visible = false;
                }
                field("New Shortcut Dimension 2 Code"; Rec."New Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the new dimension value code that will link to the items on the journal line.';
                    Visible = false;
                }
                /* field(ShortcutDimCode[3];ShortcutDimCode[3])
                 {
                     CaptionClass = '1,2,3';
                     TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(3),
                                                                   Dimension Value Type=CONST(Standard),
                                                                   Blocked=CONST(No));
                     Visible = false;

                     trigger OnValidate()
                     begin
                         ValidateShortcutDimCode(3,ShortcutDimCode[3]);
                     end;
                 }
                field(NewShortcutDimCode[3];NewShortcutDimCode[3])
                {
                    CaptionClass = Text000;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupNewShortcutDimCode(3,NewShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        TESTFIELD("Entry Type","Entry Type"::Transfer);
                        ValidateNewShortcutDimCode(3,NewShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode[4];ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(4),
                                                                  Dimension Value Type=CONST(Standard),
                                                                  Blocked=CONST(No));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(4,ShortcutDimCode[4]);
                    end;
                }
                field(NewShortcutDimCode[4];NewShortcutDimCode[4])
                {
                    CaptionClass = Text001;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupNewShortcutDimCode(4,NewShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        TESTFIELD("Entry Type","Entry Type"::Transfer);
                        ValidateNewShortcutDimCode(4,NewShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode[5];ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(5),
                                                                  Dimension Value Type=CONST(Standard),
                                                                  Blocked=CONST(No));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(5,ShortcutDimCode[5]);
                    end;
                }
                field(NewShortcutDimCode[5];NewShortcutDimCode[5])
                {
                    CaptionClass = Text002;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupNewShortcutDimCode(5,NewShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        TESTFIELD("Entry Type","Entry Type"::Transfer);
                        ValidateNewShortcutDimCode(5,NewShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode[6];ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(6),
                                                                  Dimension Value Type=CONST(Standard),
                                                                  Blocked=CONST(No));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(6,ShortcutDimCode[6]);
                    end;
                }
                field(NewShortcutDimCode[6];NewShortcutDimCode[6])
                {
                    CaptionClass = Text003;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupNewShortcutDimCode(6,NewShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        TESTFIELD("Entry Type","Entry Type"::Transfer);
                        ValidateNewShortcutDimCode(6,NewShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode[7];ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(7),
                                                                  Dimension Value Type=CONST(Standard),
                                                                  Blocked=CONST(No));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(7,ShortcutDimCode[7]);
                    end;
                }
                field(NewShortcutDimCode[7];NewShortcutDimCode[7])
                {
                    CaptionClass = Text004;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupNewShortcutDimCode(7,NewShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        TESTFIELD("Entry Type","Entry Type"::Transfer);
                        ValidateNewShortcutDimCode(7,NewShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode[8];ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(8),
                                                                  Dimension Value Type=CONST(Standard),
                                                                  Blocked=CONST(No));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(8,ShortcutDimCode[8]);
                    end;
                }
                field(NewShortcutDimCode[8];NewShortcutDimCode[8])
                {
                    CaptionClass = Text005;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupNewShortcutDimCode(8,NewShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        TESTFIELD("Entry Type","Entry Type"::Transfer);
                        ValidateNewShortcutDimCode(8,NewShortcutDimCode[8]);
                    end;
                }*/
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ToolTip = 'Specifies the code for the salesperson or purchaser who is linked to the sale or purchase on the journal line.';
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the code of the general business posting group that will be used when you post the entry on the item journal line.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        //Cu018
                        GenJournalLineExist;
                        IF Rec.Cash = TRUE THEN
                            ERROR('Record cannot be changed after payment completion');
                        //Cu018
                    end;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the unit cost of the item on the line.';
                    Visible = false;
                }
                field("<Line Amount in YER>"; Rec."Line AmountUP")
                {
                    Caption = 'Line Amount';
                    Editable = false;
                    ToolTip = 'Line Amount in Yemeni Rials';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Caption = 'Currency code';

                    trigger OnValidate()
                    begin
                        //Cu018
                        GenJournalLineExist;
                        IF Rec.Cash = TRUE THEN
                            ERROR('Record cannot be changed after payment completion');
                        //Cu018
                        IF Rec."Currency Code" = 'YER' THEN
                            ExchangeRateRestriction;
                        //  >>  CS16
                        /*IF  Quantity <> 0 THEN
                        "Line AmountUP" :=  Quantity * "Unit Price" ELSE
                          "Line AmountUP" := "Unit Price";*/
                        //VALIDATE("Unit Price");
                        //CurrPage.UPDATE;
                        //  <<  CS16

                    end;
                }
                field("Discount%"; Rec."Discount%")
                {
                    DecimalPlaces = 0 : 2;

                    trigger OnValidate()
                    begin
                        //CS17
                        //CurrPage.UPDATE;
                    end;
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        //Cu018
                        GenJournalLineExist;
                        IF Rec.Cash = TRUE THEN
                            ERROR('Record cannot be changed after payment completion');
                        //Cu018
                    end;
                }
                field(Contact; Rec.Contact)
                {
                    ShowMandatory = true;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //Cu018
                        GenJournalLineExist;
                        IF Rec.Cash = TRUE THEN
                            ERROR('Record cannot be changed after payment completion');
                        //Cu018
                        ContactRec.RESET;
                        ContactRec.CLEARMARKS;
                        IF ContactRec.FINDSET THEN
                            REPEAT
                                ContBus.RESET;
                                ContBus.SETRANGE("Contact No.", ContactRec."Company No.");
                                IF ContBus.FINDFIRST THEN BEGIN
                                    IF ContBus."Link to Table" = ContBus."Link to Table"::Customer THEN
                                        ContactRec.MARK(TRUE);
                                END
                                ELSE
                                    ContactRec.MARK(TRUE);
                            UNTIL ContactRec.NEXT = 0;
                        ContactRec.MARKEDONLY(TRUE);
                        Usersetup.RESET;
                        Usersetup.SETRANGE("User ID", USERID);
                        IF Usersetup.FINDFIRST THEN
                            USerCode := Usersetup."Sales Resp. Ctr. Filter";
                        IF USerCode <> '' THEN
                            ContactRec.SETRANGE(Responsibility_Center, USerCode);
                        IF PAGE.RUNMODAL(5052, ContactRec) = ACTION::LookupOK THEN BEGIN
                            //IF CheckContact(ContactRec) THEN BEGIN
                            Rec.Contact := ContactRec."No.";
                            Rec."Contact Name" := ContactRec.Name;
                            FindCustomer(ContactRec);
                            ReplaceContact;
                            ReplaceCurrContact;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        //Cu018
                        GenJournalLineExist;
                        IF Rec.Cash = TRUE THEN
                            ERROR('Record cannot be changed after payment completion');
                        //Cu018
                        IF Rec."Item No." = '' THEN
                            ERROR('Item No. must be filled for the Counter Sale %1.', Rec."Document No.");


                        IF Rec.Contact = '' THEN BEGIN
                            Rec."Contact Name" := '';
                            Rec."CustomerNo." := '';
                            Rec."Customer Name1" := '';
                            Rec."Currency Code" := '';
                            ReplaceCurrContact;
                            ReplaceContact;

                        END
                        ELSE BEGIN
                            ContactRec.RESET;
                            ContactRec.SETRANGE("No.", Rec.Contact);
                            IF ContactRec.FINDFIRST THEN
                                Rec."Contact Name" := ContactRec.Name;
                            FindCustomer(ContactRec);
                            ReplaceCurrContact;
                            ReplaceContact;
                        END;
                    end;
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    Enabled = false;
                }
                field("Linked to Customer No."; Rec."CustomerNo.")
                {
                    Editable = false;
                }
                field("Customer Name1"; Rec."Customer Name1")
                {
                    Caption = 'Customer Name';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the code of the general product posting group that will be used for this item when you post the entry on the item journal line.';
                    Visible = false;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the reason code that will be inserted on the journal lines.';

                    trigger OnValidate()
                    begin
                        //Cu018
                        GenJournalLineExist;
                        IF Rec.Cash = TRUE THEN
                            ERROR('Record cannot be changed after payment completion');
                        //Cu018
                    end;
                }
                field("Service Item No."; Rec."Service Item No.")
                {
                    Visible = IsVisible;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //  >>  K08
                        /*Company.RESET;
                        IF Company.GET(COMPANYNAME) THEN BEGIN
                          IF Company.Division = Company.Division::Auto THEN BEGIN
                            ServiceItem.RESET;
                            ServiceItem.SETRANGE("Customer No.",Rec."CustomerNo.");
                            IF PAGE.RUNMODAL(0,ServiceItem) = ACTION::LookupOK THEN BEGIN
                              Rec."Service Item No." := ServiceItem."No.";
                              Rec."VIN No." := ServiceItem."Serial No.";
                              Rec."Vehicle Plate No." :=  ServiceItem."Vehicle Plate No.";
                              Rec."Service Item Name" := ServiceItem.Description;
                              ReplaceServiceItemNo;
                            END;
                            IF Rec."Service Item No." ='' THEN BEGIN
                              Rec."Service Item No." := 'N/A';
                              Rec."VIN No." := 'N/A';
                              Rec."Vehicle Plate No." :=  'N/A';
                               Rec."Service Item Name" := 'N/A';
                              ReplaceServiceItemNo;
                            END;
                          END;
                        END;*/
                        //  <<  K08

                    end;

                    trigger OnValidate()
                    begin
                        //  >>  K08
                        /*IF Rec."Service Item No." ='' THEN BEGIN
                          Rec."Service Item No." := '';
                          Rec."VIN No." := '';
                          Rec."Vehicle Model No." :=  '';
                           Rec."Service Item Name" := '';
                          ReplaceServiceItemNo;
                        END;*/
                        //  <<  K08

                    end;
                }
                field("VIN No."; Rec."VIN No.")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /*//  >>  K08
                        Company.RESET;
                        IF Company.GET(COMPANYNAME) THEN BEGIN
                          IF Company.Division = Company.Division::Auto THEN BEGIN
                            ServiceItem.RESET;
                            ServiceItem.SETRANGE("Customer No.",Rec."CustomerNo.");
                            IF PAGE.RUNMODAL(0,ServiceItem) = ACTION::LookupOK THEN BEGIN
                              Rec."VIN No." := ServiceItem."Serial No.";
                              Rec."Vehicle Plate No." :=  ServiceItem."Vehicle Plate No.";
                            END;
                            IF Rec."VIN No." ='' THEN BEGIN
                              Rec."VIN No." := 'N/A';
                              Rec."Vehicle Plate No." :=  'N/A';
                            END;
                          END;
                        END;
                        //  <<  K08*/

                    end;
                }
                field("Vehicle Model No."; Rec."Vehicle Model No.")
                {
                }
                field("CR External Reference No."; Rec."CR External Reference No.")
                {
                }
            }
            group(Item_Des)
            {
                fixed(FixedLayout)
                {
                    group("Item Description")
                    {
                        Caption = 'Item Description';
                        field(ItemDescription; ItemDescription)
                        {
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
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
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowReclasDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines(TRUE);
                    end;
                }
                action("Bin Contents")
                {
                    Caption = 'Bin Contents';
                    Image = BinContent;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page 7305;
                    RunPageLink = "Location Code" = field("Location Code"), "Item No." = field("Item No."), "Variant Code" = field("Variant Code");
                    RunPageView = SORTING(Default, "Location Code", "Item No.", "Variant Code");
                }
            }
            group("&Item")
            {
                Caption = '&Item';
                Image = Item;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 30;
                    RunPageLink = "No." = FIELD("Item No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Reserve)
                {
                    Caption = '&Reserve';
                    Ellipsis = true;
                    Image = Reserve;

                    trigger OnAction()
                    begin
                        //FIND;
                        //ShowReservation;
                    end;
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = ItemLedger;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page 38;
                    RunPageLink = "Item No." = FIELD("Item No.");
                    RunPageView = SORTING("Item No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData 14 = R;
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        Image = BOMLevel;

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
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    RunObject = Codeunit 246;
                    Visible = false;
                }
                separator(Separator)
                {
                }
                action("Get Bin Content")
                {
                    AccessByPermission = TableData 7302 = R;
                    Caption = 'Get Bin Content';
                    Ellipsis = true;
                    Image = GetBinContent;

                    trigger OnAction()
                    var
                        BinContent: Record "Bin Content";
                        GetBinContent: Report "Whse. Get Bin Content";
                    begin
                        BinContent.SETRANGE("Location Code", Rec."Location Code");
                        GetBinContent.SETTABLEVIEW(BinContent);
                        GetBinContent.InitializeItemJournalLine(Rec);
                        GetBinContent.RUNMODAL;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("CS-PickList")
                {
                    Caption = 'CS-Estimation';
                    Image = "Report";

                    trigger OnAction()
                    begin
                        ItemJournalLine.RESET;
                        ItemJournalLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                        ItemJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                        ItemJournalLine.SETRANGE("Document No.", Rec."Document No.");
                        //REPORT.RUNMODAL(REPORT::"Estimation for Cash Invoice", TRUE, TRUE, ItemJournalLine);
                    end;
                }
                action("Test Report")
                {
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
                    Caption = 'P&ost';
                    Enabled = IsPostVisible;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        //  >>  CS02
                        //IF "Journal Batch Name" = 'COUNTER' THEN BEGIN
                        IF CheckBatchName(Rec."Journal Batch Name") THEN BEGIN
                            Rec.RESET;
                            Rec.SETRANGE("Entry Type", ItemJournalLine."Entry Type"::Transfer);
                            Rec.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                            Rec.SETRANGE(Status, Rec.Status::Approved);
                            Rec.SETRANGE("Document No.", Rec."Document No.");
                            /*IF Rec.Contact  = '' THEN
                              ERROR('Enter Contact for the Counter Sales.');*/
                            MESSAGE('Only Approved Entries will be posted');
                            //
                            SingleCU.Setitemjournal1(Rec);
                            Rec.ModifyAll("Discount Amount", 0);
                            //
                            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);
                            CurrentJnlBatchName := Rec.GETRANGEMAX(Rec."Journal Batch Name");
                            CurrPage.UPDATE(FALSE);
                            ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
                        END
                        ELSE BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);
                            CurrentJnlBatchName := Rec.GETRANGEMAX(Rec."Journal Batch Name");
                            CurrPage.UPDATE(FALSE);
                        END;
                        //  <<  CS02

                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Enabled = IsPostVisible;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := Rec.GETRANGEMAX(Rec."Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ItemJnlLine: Record "Item Journal Line";
                begin
                    ItemJnlLine.COPY(Rec);
                    ItemJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    //REPORT.RUNMODAL(REPORT::"Inventory Movement1", TRUE, TRUE, ItemJnlLine);
                end;
            }
            group(Confirmation)
            {
                Caption = 'Confirmation';
                action(Approve)
                {
                    Ellipsis = false;
                    Enabled = IsCounterNew;
                    Image = Approve;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Update status to Approve for the customer confirmed lines';

                    trigger OnAction()
                    begin
                        //  >>  CS02
                        /*IF CheckBatchName("Journal Batch Name") THEN BEGIN
                        //IF Rec."Journal Batch Name" = 'COUNTER' THEN BEGIN
                        ItemJournalLine.RESET;
                        CurrPage.SETSELECTIONFILTER(ItemJournalLine);
                          IF ItemJournalLine.FINDSET THEN REPEAT
                              IF ItemJournalLine.Status = ItemJournalLine.Status::" " THEN BEGIN
                                IF ItemJournalLine.Contact  = '' THEN
                                  ERROR('Contact is empty in the Line %1. Enter contact before updating status.',ItemJournalLine."Line No.")
                                ELSE
                                ItemJournalLine.Status  :=  ItemJournalLine.Status::Approved;
                                ItemJournalLine.MODIFY;
                            END
                            ELSE
                            ERROR('Status of the line %1 is already filled with %2',ItemJournalLine."Line No.",ItemJournalLine.Status);
                          UNTIL ItemJournalLine.NEXT  = 0;
                        END;*/
                        IF CheckBatchName(Rec."Journal Batch Name") THEN BEGIN
                            //IF Rec."Journal Batch Name" = 'COUNTER' THEN BEGIN
                            ItemJournalLine.RESET;
                            CurrPage.SETSELECTIONFILTER(ItemJournalLine);
                            IF ItemJournalLine.FINDFIRST THEN BEGIN
                                ItemJnlLineCU.RESET;
                                ItemJnlLineCU.SETRANGE("Document No.", ItemJournalLine."Document No.");
                                IF ItemJnlLineCU.FINDSET THEN
                                    REPEAT
                                        IF ItemJnlLineCU.Status = ItemJnlLineCU.Status::" " THEN BEGIN
                                            IF ItemJnlLineCU.Contact = '' THEN
                                                ERROR('Contact is empty in the Line %1. Enter contact before updating status.', ItemJnlLineCU."Line No.")
                                            ELSE
                                                ItemJnlLineCU.Status := ItemJnlLineCU.Status::Approved;
                                            ItemJnlLineCU.MODIFY;
                                        END ELSE
                                            ERROR('Status of the line %1 is already filled with %2', ItemJnlLineCU."Line No.", ItemJnlLineCU.Status);
                                    UNTIL ItemJnlLineCU.NEXT = 0;
                            END;
                        END;
                        //  <<  CS02

                    end;
                }
                action(Cancel)
                {
                    Ellipsis = false;
                    Enabled = IsCounter;
                    Image = Cancel;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Update status to Cancel for the customer cancelled line';

                    trigger OnAction()
                    begin
                        //  >>  CS02
                        IF CheckBatchName(Rec."Journal Batch Name") THEN BEGIN
                            //IF Rec."Journal Batch Name" = 'COUNTER' THEN BEGIN
                            ItemJournalLine.RESET;
                            CurrPage.SETSELECTIONFILTER(ItemJournalLine);
                            IF ItemJournalLine.FINDSET THEN
                                REPEAT
                                    IF ItemJournalLine.Status = ItemJournalLine.Status::" " THEN BEGIN
                                        IF ItemJournalLine.Contact = '' THEN
                                            ERROR('Contact details must be filled in before cancellation for the document number %1', ItemJournalLine."Document No.")
                                        ELSE
                                            IF ItemJournalLine."Reason Code" = '' THEN
                                                ERROR('Reason code must be filled in before cancellation for the document number %1', ItemJournalLine."Document No.")
                                            ELSE
                                                ItemJournalLine.Status := ItemJournalLine.Status::Cancelled;
                                        ItemJournalLine.MODIFY;
                                        //Message
                                        /*IF CurrentJnlBatchName = 'COUNTER' THEN BEGIN
                                          IF ItemJournalLine1.FINDSET THEN  REPEAT
                                            IF ItemJournalLine1.Status = ItemJournalLine1.Status::Cancelled THEN
                                             MESSAGE('Please delete the cancelled line(s) to process the new lines');
                                          UNTIL ItemJournalLine1.NEXT = 0;
                                        END;*/
                                        IF AlertCancelledLines THEN
                                            MESSAGE('Please Delete the Cancelled Lines');

                                        //Message
                                    END
                                    ELSE
                                        ERROR('Status of the line %1 is already filled with %2', ItemJournalLine."Line No.", ItemJournalLine.Status);
                                UNTIL ItemJournalLine.NEXT = 0;
                        END;
                        //  <<  CS02

                    end;
                }
                action(DocNo)
                {
                    Caption = 'Generate New Document No.';
                    Image = NumberGroup;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Click to generate new Document No. for each Counter Sales.';

                    trigger OnAction()
                    begin
                        //  >>  CS02
                        CLEAR(IsInc1);
                        ItemJournalBatch.RESET;
                        ItemJournalBatch.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                        ItemJournalBatch.SETRANGE(Name, Rec."Journal Batch Name");
                        IF ItemJournalBatch.FINDFIRST THEN BEGIN
                            NoSeriesCode := ItemJournalBatch."No. Series";
                            NoSeriesLine.RESET;
                            NoSeriesLine.SETRANGE("Series Code", NoSeriesCode);
                            NoSeriesLine.SETFILTER("Starting Date", '<=%1', WORKDATE);
                            IF NoSeriesLine.FINDLAST THEN BEGIN
                                NewSeriesCode := NoSeriesLine."Last No. Used";
                                IF NewSeriesCode <> '' THEN BEGIN
                                    IF FindCSDocNo(NewSeriesCode) OR FindIJDocNo(NewSeriesCode) THEN BEGIN
                                        ItemJournalBatch.RESET;
                                        ItemJournalBatch.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                                        ItemJournalBatch.SETRANGE(Name, Rec."Journal Batch Name");
                                        IF ItemJournalBatch.FINDFIRST THEN BEGIN
                                            NoSeriesCode := ItemJournalBatch."No. Series";
                                            IF NoSeriesCode <> '' THEN BEGIN
                                                IF Rec."Line No." = 0 THEN
                                                    Rec."Document No." := NoSeriesMgt.GetNextNo(NoSeriesCode, WORKDATE, TRUE);
                                            END;
                                        END;
                                    END ELSE
                                        IF Rec."Line No." = 0 THEN
                                            Rec."Document No." := NoSeriesLine."Last No. Used";
                                END ELSE BEGIN
                                    IF FindIJDocNo(NoSeriesLine."Starting No.") THEN BEGIN
                                        NoSeriesLine."Last No. Used" := NoSeriesLine."Starting No.";
                                        NoSeriesLine.MODIFY;
                                        Rec."Document No." := NoSeriesMgt.GetNextNo(NoSeriesCode, WORKDATE, TRUE);
                                        Rec."Line No." := 0;
                                    END
                                    ELSE BEGIN
                                        Rec."Document No." := NoSeriesMgt.GetNextNo(NoSeriesCode, WORKDATE, TRUE);
                                        Rec."Line No." := 0;
                                    END;
                                END;
                            END;
                        END;
                        //  <<  CS02
                    end;
                }
                separator(Separate)
                {
                }
                action("Discount Percentage")
                {
                    Image = Discount;

                    trigger OnAction()
                    var
                        "Discount Percentage": Decimal;
                        DiscountProcessOnly: Report "Discount Process Only";
                        CounterLine: Record "Item Journal Line";
                    begin
                        //Cu021
                        "Discount Percentage" := 0;
                        /*                       
                        SalesReceivablesSetup.GET;
                        CLEAR(DiscountProcessOnly);
                        DiscountProcessOnly.RUNMODAL;
                        "Discount Percentage" := DiscountProcessOnly."Return Discount Percentage";
                        IF "Discount Percentage" >= SalesReceivablesSetup."Counter Sale Discount%" THEN
                            UserGroup.RESET;
                            UserGroup.SETRANGE(SalesDiscHigh, TRUE);
                            IF UserGroup.FINDFIRST THEN BEGIN
                                UserGroupMember.RESET;
                                UserGroupMember.SETRANGE("User Group Code", UserGroup.Code);
                                UserGroupMember.SETRANGE("User Name", USERID);
                                IF UserGroupMember.FINDFIRST THEN
                                    "Discount Percentage" := "Discount Percentage"
                                ELSE
                                    ERROR('Discount Percentage cannot exceed %1', SalesReceivablesSetup."Counter Sales Discount %");
                            END ELSE
                                ERROR('Discount Percentage cannot exceed %1', SalesReceivablesSetup."Counter Sales Discount %");
                        END;*/
                        SalesReceivablesSetup.GET;
                        CLEAR(DiscountProcessOnly);
                        DiscountProcessOnly.RUNMODAL;
                        "Discount Percentage" := DiscountProcessOnly."Return Discount Percentage";
                        IF "Discount Percentage" >= SalesReceivablesSetup."Counter Sale Discount%" THEN
                            ERROR('Discount Percentage cannot exceed %1', SalesReceivablesSetup."Counter Sale Discount%")
                        else begin
                            CounterLine.RESET;
                            CounterLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                            CounterLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                            CounterLine.SETRANGE("Document No.", Rec."Document No.");
                            IF CounterLine.FINDSET THEN
                                REPEAT
                                    CounterLine.VALIDATE("Discount%", "Discount Percentage");
                                    CounterLine.MODIFY;
                                UNTIL CounterLine.NEXT = 0;
                        end;
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ItemJnlMgt.GetItem(Rec."Item No.", ItemDescription);
        EnableButton;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        Rec.ShowNewShortcutDimCode(NewShortcutDimCode);

        //  >>  CS02
        EnableButton;
        //  <<  CS02

        Usersetup.RESET;
        Usersetup.SETRANGE("User ID", USERID);
        IF Usersetup.FINDFIRST THEN BEGIN
            IF Usersetup."Sales Resp. Ctr. Filter" <> '' THEN
                LocationNonEditable := FALSE
            ELSE
                LocationNonEditable := TRUE;
        END;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    begin
        COMMIT;
        IF NOT ReserveItemJnlLine.DeleteLineConfirm(Rec) THEN
            EXIT(FALSE);
        UncancelledBool := FALSE;
        CancelledBool := FALSE;
        //  >>  CS02
        IF NOT (Rec.Status = Rec.Status::Cancelled) THEN BEGIN
            IF NOT CONFIRM('Please select "YES" to delete the line . Select "NO" to cancel the line for tracking cancellation history') THEN BEGIN
                UncancelledBool := TRUE;
                IF CheckBatchName(Rec."Journal Batch Name") THEN BEGIN
                    //Cu018
                    GenJournalLineExist;
                    IF Rec.Cash = TRUE THEN
                        ERROR('Record cannot be changed after payment completion');
                    //Cu018
                    IF Rec.Status = Rec.Status::Approved THEN
                        ERROR('Approved line in document number %1 cannot be deleted.', Rec."Document No.")
                    ELSE BEGIN
                        IF (Rec.Status = Rec.Status::" ") AND CheckLines THEN BEGIN
                            //MESSAGE('Please cancel the line(s) to delete' );
                            EXIT(FALSE);
                        END
                        ELSE BEGIN
                            IF (Rec.Status = Rec.Status::Cancelled) AND (Rec.Contact = '') THEN
                                ERROR('Enter Contact for the Counter Sales')
                            ELSE BEGIN
                                IF (Rec.Status = Rec.Status::Cancelled) AND (Rec."Reason Code" = '') THEN
                                    ERROR('Enter reason code for the lines with status cancel.')
                                ELSE BEGIN
                                    IF (Rec.Status = Rec.Status::Cancelled) AND (Rec."Location Code" = '') THEN
                                        ERROR('Enter location code for %1', Rec."Document No.");
                                END;
                            END;
                        END;
                    END;
                END;
                //  <<  CS02
            END
            ELSE BEGIN
                IF CheckBatchName(Rec."Journal Batch Name") THEN BEGIN
                    //Cu018
                    GenJournalLineExist;
                    IF Rec.Cash = TRUE THEN
                        ERROR('Record cannot be changed after payment completion');
                    //Cu018
                    IF Rec.Status = Rec.Status::Approved THEN
                        ERROR('Approved line in document number %1 cannot be deleted.', Rec."Document No.")
                    ELSE BEGIN
                        IF (Rec.Status = Rec.Status::Cancelled) AND (Rec.Contact = '') THEN
                            ERROR('Enter Contact for the Counter Sales')
                        ELSE BEGIN
                            IF (Rec.Status = Rec.Status::Cancelled) AND (Rec."Reason Code" = '') THEN
                                ERROR('Enter reason code for the lines with status cancel.')
                            ELSE BEGIN
                                IF (Rec.Status = Rec.Status::Cancelled) AND (Rec."Location Code" = '') THEN
                                    ERROR('Enter location code for %1', Rec."Document No.");
                            END;
                        END;
                    END;
                END;
                ReserveItemJnlLine.DeleteLine(Rec);
            END;
        END;

        IF (Rec.Status = Rec.Status::Cancelled) AND CheckBatchName(Rec."Journal Batch Name") AND CheckLines THEN BEGIN
            CancelledBool := TRUE;
            IsIncrement := FindApprovedEntries;
            DeleteEntryforCounterSales;
            CLEAR(NoSeriesMgt);
        END
        ELSE
            ReserveItemJnlLine.DeleteLine(Rec);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //  >>  CS02
        EnableButton;
        //  >>  CS02
        Rec."VAT Bus" := 'VAT-DOM';
        Usersetup.RESET;
        Usersetup.SETRANGE("User ID", USERID);
        IF Usersetup.FINDFIRST THEN BEGIN
            IF Usersetup."Sales Resp. Ctr. Filter" <> '' THEN
                LocationNonEditable := FALSE
            ELSE
                LocationNonEditable := TRUE;
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //  >>  CS02
        IF CheckBatchName(Rec."Journal Batch Name") THEN BEGIN

            IF NOT Rec.ISEMPTY AND (xRec.Status = xRec.Status::" ") THEN BEGIN
                Rec."Document No." := xRec."Document No.";
                Rec."Posting Date" := WORKDATE;
            END
            ELSE BEGIN
                Rec."Document No." := '';
                Rec."Posting Date" := WORKDATE;
            END;
            //
        END;
        //  <<  CS02
        Rec.SetUpNewLine(xRec);
        CLEAR(ShortcutDimCode);
        CLEAR(NewShortcutDimCode);
        Rec."Entry Type" := Rec."Entry Type"::Transfer;

        //  >>  CS02
        EnableButton;
        //
        Usersetup.RESET;
        Usersetup.SETRANGE("User ID", USERID);
        IF Usersetup.FINDFIRST THEN BEGIN
            IF Usersetup."Sales Resp. Ctr. Filter" <> '' THEN
                LocationNonEditable := FALSE
            ELSE
                LocationNonEditable := TRUE;
        END;
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
        CompanyInformation: Record "Company Information";
    begin
        IF Rec.IsOpenedFromBatch THEN BEGIN
            CurrentJnlBatchName := Rec."Journal Batch Name";
            ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
            EXIT;
        END;

        ItemJnlMgt.TemplateSelection(PAGE::"Item Reclass. Journal", 1, FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');

        //  >>  CS02
        CLEAR(CurrentJnlBatchName);
        Usersetup.RESET;
        Usersetup.SETRANGE("User ID", USERID);
        IF Usersetup.FINDFIRST THEN
            CurrentJnlBatchName := Usersetup.Counter_Batch;
        IF CurrentJnlBatchName = '' THEN
            CurrentJnlBatchName := CheckUserRC;
        //  <<  CS02

        ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);

        //  >>  CS02
        IsCounter := FALSE;
        IsCounterNew := FALSE;
        //  >>  CS02

        //   >>  K08
        IsVisible := FALSE;
        CompanyInformation.RESET;
        CompanyInformation.SetRange(AFZ, false);
        IF CompanyInformation.FindFirst() THEN
            IsVisible := TRUE
        else
            IsVisible := FALSE;
        //   >>  K08
        Usersetup.RESET;
        Usersetup.SETRANGE("User ID", USERID);
        IF Usersetup.FINDFIRST THEN BEGIN
            Location := Usersetup."Sales Resp. Ctr. Filter";
            IF Location <> '' THEN
                LocationNonEditable := FALSE

            ELSE
                LocationNonEditable := TRUE;
        END;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF AlertCancelledLines THEN
            MESSAGE('Delete the Cancelled Lines before closing the Counter Sales Page');
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
        Text006CU: Label 'Approved line cannot be deleted. Update Status to Cancel.';
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
        Company: Record "Company Information";
        ServiceItem: Record "Service Item";
        Bincontents: Record "Bin Content";
        BinQty: Decimal;
        IJLQty: Decimal;
        AQ: Decimal;
        Text062: Label 'This BinCode:%1 is Blocked.';
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
        IJB1: Code[20];
        DefaultPriceFactor: Record "Default Price Factor";
        GenJournalLine: Record "Gen. Journal Line";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        //UserGroup: Record "9000";
        //UserGroupMember: Record "9001";
        ItemJournalLine_Agency_Restrict: Record "Item Journal Line";

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure DeleteEntryforCounterSales()
    begin
        //  >>  CS02
        //IF "Journal Batch Name" =  'COUNTER' THEN BEGIN
        DeleteBool := FALSE;
        IF CheckBatchName(Rec."Journal Batch Name") THEN BEGIN
            ItemJnlLineCU.RESET;
            ItemJnlLineCU.SETRANGE("Source Code", 'RECLASSJNL');
            //ItemJnlLineCU.SETRANGE("Journal Batch Name",'COUNTER');
            ItemJnlLineCU.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
            ItemJnlLineCU.SETFILTER(Status, '%1', ItemJnlLineCU.Status::Cancelled);
            ItemJnlLineCU.SETRANGE("Document No.", Rec."Document No.");
            IF ItemJnlLineCU.FINDSET THEN
                REPEAT
                    IF ItemJnlLineCU.Status = ItemJnlLineCU.Status::Cancelled THEN BEGIN
                        CounterSalesCU.INIT;
                        CounterSalesCU.TRANSFERFIELDS(ItemJnlLineCU);
                        //MESSAGE('Cancelled Entries are captured in Counter Sales History');
                        CounterSalesCU.INSERT(TRUE);
                        DeleteBool := TRUE
                    END;
                UNTIL ItemJnlLineCU.NEXT = 0;
            MESSAGE('Cancelled Entries are captured in Counter Sales History');
            ItemJnlLineCU.DELETEALL;

        END;
        //  <<  CS02
    end;

    local procedure FindApprovedEntries(): Boolean
    var
        WE: Record "Warehouse Entry";
        WECount: Integer;
    begin
        //  >>  CS02
        ItemJnlLineCU.RESET;
        ItemJnlLineCU.SETRANGE("Source Code", 'RECLASSJNL');
        //ItemJnlLineCU.SETRANGE("Journal Batch Name",'COUNTER');
        ItemJnlLineCU.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineCU.SETFILTER(Status, '%1', ItemJnlLineCU.Status::Approved);
        Number := ItemJnlLineCU.COUNT;
        WE.RESET;
        WE.SETRANGE("Source Document", WE."Source Document"::"Reclass. Jnl.");
        //WE.SETRANGE("Journal Batch Name",'COUNTER');
        WE.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        WE.SETRANGE("Source No.", Rec."Document No.");
        WE.SETRANGE("Bin Code", 'COUNTER');
        WECount := WE.COUNT;
        IF (Number = 0) AND (WECount = 0) THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
        //  <<  CS02
    end;

    local procedure FindCSDocNo(DocNo: Code[20]): Boolean
    var
        CounterSale: Record "Cancelled CounterSales History";
    begin
        CounterSale.RESET;
        CounterSale.SETRANGE("Document No.", DocNo);
        IF CounterSale.ISEMPTY THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;

    local procedure FindIJDocNo(Docno: Code[20]): Boolean
    var
        IJL: Record "Item Journal Line";
    begin
        IJL.RESET;
        IJL.SETRANGE("Source Code", 'RECLASSJNL');
        IJL.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        //IJL.SETRANGE("Journal Batch Name",'COUNTER');
        IJL.SETRANGE("Document No.", Docno);
        IF IJL.ISEMPTY THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;

    local procedure CheckLines(): Boolean
    begin
        IF (Rec."Item No." = '') AND (Rec.Description = '') AND (Rec."Location Code" = '') AND (Rec.Quantity = 0) AND (Rec.Contact = '') AND (Rec."Bin Code" = '') AND (Rec."Unit Price" = 0) AND (Rec."Line AmountUP" = 0)
         THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;

    procedure CheckBatchName("Code": Code[10]): Boolean
    var
        IJBatch: Record "Item Journal Batch";
    begin
        IJBatch.RESET;
        IJBatch.SETRANGE(Name, Code);
        IJBatch.SetRange(Counter_Batch, true);
        IF NOT IJBatch.ISEMPTY THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;

    procedure CheckUserRC(): Code[30]
    var
        IJBatch: Record "Item Journal Batch";
        UserSetupMgmt: Codeunit "User Setup Management";
    begin
        CLEAR(UserSetupMgmt);
        IF UserSetupMgmt.GetSalesFilter <> '' THEN BEGIN
            IJBatch.RESET;
            IJBatch.SetRange(Responsibility_Center, UserSetupMgmt.GetSalesFilter);
            IF IJBatch.FINDFIRST THEN
                EXIT(IJBatch.Name);
        END;
    end;

    local procedure CheckContact(Contact: Record Contact): Boolean
    var
        ItemJnlLineCU: Record "Item Journal Line";
    begin
        ItemJnlLineCU.RESET;
        ItemJnlLineCU.SETRANGE("Source Code", 'RECLASSJNL');
        ItemJnlLineCU.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineCU.SETRANGE("Document No.", Rec."Document No.");
        ItemJnlLineCU.SETFILTER("Line No.", '<>%1', Rec."Line No.");
        IF ItemJnlLineCU.FINDFIRST THEN BEGIN
            IF ItemJnlLineCU.Contact <> '' THEN BEGIN
                IF ItemJnlLineCU.Contact = Contact."No." THEN
                    EXIT(TRUE)
                ELSE
                    EXIT(FALSE);
            END
            ELSE
                EXIT(TRUE)
        END
        ELSE
            EXIT(TRUE);
    end;

    local procedure MapContact()
    var
        ItemJnlLineCU: Record "Item Journal Line";
        ContRec: Record Contact;
    begin
        ItemJnlLineCU.RESET;
        ItemJnlLineCU.SETRANGE("Source Code", 'RECLASSJNL');
        //ItemJnlLineCU.SETRANGE("Journal Batch Name",'COUNTER');
        ItemJnlLineCU.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineCU.SETRANGE("Document No.", Rec."Document No.");
        ItemJnlLineCU.SETFILTER("Line No.", '<>%1', Rec."Line No.");
        IF ItemJnlLineCU.FINDFIRST THEN BEGIN
            IF ItemJnlLineCU.Contact <> '' THEN BEGIN
                //IF ItemJnlLineCU.Contact  = Contact."No." THEN BEGIN
                Rec.Contact := ItemJnlLineCU.Contact;
                Rec."Contact Name" := ItemJnlLineCU."Contact Name";
                Rec."CustomerNo." := ItemJnlLineCU."CustomerNo.";
                Rec."VAT Bus" := ItemJnlLineCU."VAT Bus";
                Rec."Customer Name1" := ItemJnlLineCU."Customer Name1";
                //
                Rec."VIN No." := ItemJnlLineCU."VIN No.";
                Rec."Vehicle Model No." := ItemJnlLineCU."Vehicle Model No.";
                //
                CusRec1.RESET;
                CusRec1.SETRANGE("No.", Rec."CustomerNo.");
                IF CusRec1.FINDFIRST THEN
                    Rec."Currency Code" := CusRec1."Currency Code";
            END
            ELSE BEGIN
                Rec.Contact := '';
                Rec."Contact Name" := '';
                Rec."VAT Bus" := '';
                Rec."Currency Code" := 'USD';
            END;

        END;
    end;

    local procedure BinStkCheck(ItemNo: Code[20]; LocationCode: Code[10]; Bincode: Code[20]; UOM: Code[10])
    var
        BinContent: Record "Bin Content";
        Text01: Label 'Stock is less in the Bin %1 for the Part No. %2.';
        Text02: Label 'Stock is not available in the Bin %1 for the Part No. %2.';
        "IJLQty.": Integer;
        ActualQty: Integer;
        ItemRes: Record Item;
        FreeStk: Decimal;
    begin
        "IJLQty." := 0;
        ActualQty := 0;

        //Cu016
        ItemRes.RESET;
        ItemRes.SETRANGE("No.", ItemNo);
        ItemRes.SETRANGE("Location Filter", Rec."Location Code");
        IF ItemRes.FINDFIRST THEN;
        ItemRes.CALCFIELDS(Inventory);
        ItemRes.CALCFIELDS("Reserved Qty. on Inventory");
        FreeStk := ItemRes.Inventory - ItemRes."Reserved Qty. on Inventory";

        BinContent.RESET;
        BinContent.SETRANGE("Item No.", ItemNo);
        BinContent.SETRANGE("Location Code", LocationCode);
        BinContent.SETRANGE("Bin Code", Bincode);
        BinContent.SETRANGE("Unit of Measure Code", UOM);
        IF BinContent.FINDFIRST THEN BEGIN
            BinContent.CALCFIELDS(Quantity);
            "IJLQty." := CheckCSLineStk(ItemNo, LocationCode, Bincode, UOM);
            IF BinContent.Quantity <= FreeStk THEN BEGIN
                ActualQty := BinContent.Quantity - "IJLQty.";
                Rec."Required Quantity" := ActualQty
            END
            ELSE BEGIN
                ActualQty := FreeStk - "IJLQty.";
                Rec."Required Quantity" := ActualQty;
            END;
            /*  IF ActualQty  > 0 THEN BEGIN
              IF Rec.Quantity > ActualQty THEN
                ERROR(Text01,"Bin Code","Item No.");
              END
              ELSE
                ERROR(Text02,"Bin Code","Item No.");*/
        END;

    end;

    local procedure CheckCSLineStk(ItemNo: Code[20]; LocationCode: Code[10]; Bincode: Code[20]; UOM: Code[10]): Integer
    var
        IJL: Record "Item Journal Line";
        TotalQty: Integer;
    begin
        CLEAR(TotalQty);
        IJL.RESET;
        IJL.SETRANGE("Source Code", 'RECLASSJNL');
        IJL.SETRANGE("Item No.", Rec."Item No.");
        IJL.SETRANGE("Location Code", LocationCode);
        IJL.SETRANGE("Bin Code", Bincode);
        IJL.SETFILTER(Status, '<>%1', IJL.Status::Cancelled);
        IJL.SETFILTER("Line No.", '<>%1', Rec."Line No.");
        IF IJL.FINDSET THEN
            REPEAT
                TotalQty += IJL.Quantity;
            UNTIL IJL.NEXT = 0;
        EXIT(TotalQty);
    end;

    local procedure MapCounterBin()
    begin
        IF CheckBatchName(Rec."Journal Batch Name") THEN BEGIN
            //IF "Journal Batch Name" = 'COUNTER' THEN BEGIN
            LocationRec.RESET;
            LocationRec.SETRANGE(Code, Rec."Location Code");
            IF LocationRec.FINDFIRST THEN BEGIN
                IF LocationRec."Bin Mandatory" = TRUE THEN BEGIN
                    Bin1.RESET;
                    Bin1.SETRANGE("Location Code", Rec."Location Code");
                    Bin1.SETRANGE("Counter sale", TRUE);
                    Bin1.SETRANGE(Blocks, FALSE);
                    Bin1.SETRANGE("Temporary Delivery", FALSE);
                    IF Bin1.FINDFIRST THEN
                        Rec."New Bin Code" := Bin1.Code
                    ELSE
                        ERROR('Counter Bin does not exist in the location %1.', Rec."Location Code");
                END;
            END;
        END;
    end;

    local procedure AlertCancelledLines(): Boolean
    begin
        ItemJournalLine1.RESET;
        ItemJournalLine1.SETRANGE("Source Code", 'RECLASSJNL');
        ItemJournalLine1.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJournalLine1.SETRANGE(Status, ItemJournalLine1.Status::Cancelled);
        IF NOT ItemJournalLine1.ISEMPTY THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;

    local procedure EnableButton()
    begin
        IF CheckBatchName(Rec."Journal Batch Name") THEN BEGIN
            IsContactEnabled := TRUE;
            IsPostVisible := FALSE;
            IF Rec.Status = Rec.Status::" " THEN BEGIN
                IF Rec.Cash = TRUE THEN BEGIN
                    IsCounterNew := TRUE;
                    IsCounter := FALSE;
                END
                ELSE BEGIN
                    IsCounter := TRUE;
                    IsCounterNew := FALSE;
                END;
            END
            ELSE BEGIN
                IF Rec.Status = Rec.Status::Approved THEN BEGIN
                    IsPostVisible := TRUE;
                    IsCounterNew := FALSE;
                    IsCounter := FALSE;
                END
                ELSE
                    IF Rec.Status = Rec.Status::Cancelled THEN BEGIN
                        IsPostVisible := FALSE;
                        IsCounter := FALSE;
                        IsCounterNew := FALSE;
                    END;
            END;
        END
        ELSE BEGIN
            IsPostVisible := TRUE;
            IsContactEnabled := FALSE;
            IsCounter := FALSE;
            IsCounterNew := FALSE;
        END;
    end;

    local procedure FindCustomer(ContactRec: Record Contact)
    var
        CusRec: Record Customer;
        ContBus: Record "Contact Business Relation";
        ContRec: Record Contact;
    begin
        ContRec.RESET;
        ContRec.SETRANGE("No.", ContactRec."No.");
        IF ContRec.FINDFIRST THEN BEGIN
            IF ContRec.Type = ContRec.Type::Company THEN BEGIN
                ContBus.RESET;
                ContBus.SETRANGE("Link to Table", ContBus."Link to Table"::Customer);
                ContBus.SETRANGE("Contact No.", ContRec."No.");
                IF ContBus.FINDFIRST THEN BEGIN
                    Rec."CustomerNo." := ContBus."No.";
                    IF CusRec.GET(ContBus."No.") THEN BEGIN
                        Rec."Customer Name1" := CusRec.Name;
                        //
                        Rec."VIN No." := CusRec.Vin_No;
                        Rec."Vehicle Model No." := CusRec.Vehicle_Model_No;
                        //
                        Rec."Currency Code" := ContRec."Currency Code";
                        Rec."VAT Bus" := CusRec."VAT Bus. Posting Group";
                    END;
                END;
            END ELSE BEGIN
                ContBus.RESET;
                ContBus.SETRANGE("Link to Table", ContBus."Link to Table"::Customer);
                ContBus.SETRANGE("Contact No.", ContRec."Company No.");
                IF ContBus.FINDFIRST THEN BEGIN
                    Rec."CustomerNo." := ContBus."No.";
                    IF CusRec.GET(ContBus."No.") THEN BEGIN
                        Rec."Customer Name1" := CusRec.Name;
                        //
                        Rec."VIN No." := CusRec.Vin_No;
                        Rec."Vehicle Model No." := CusRec.Vehicle_Model_No;
                        //
                        Rec."Currency Code" := ContRec."Currency Code";
                        Rec."VAT Bus" := CusRec."VAT Bus. Posting Group";
                    END;
                END ELSE BEGIN
                    Rec."Customer Name1" := '';
                    Rec."CustomerNo." := '';
                    Rec."VIN No." := '';
                    Rec."Vehicle Model No." := '';
                END;
            END;
        END;
    end;

    local procedure ReplaceContact()
    var
        ItemJnlLineCU: Record "Item Journal Line";
    begin
        ItemJnlLineCU.RESET;
        ItemJnlLineCU.SETRANGE("Source Code", 'RECLASSJNL');
        //ItemJnlLineCU.SETRANGE("Journal Batch Name",'COUNTER');
        ItemJnlLineCU.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineCU.SETRANGE("Document No.", Rec."Document No.");
        ItemJnlLineCU.SETFILTER("Line No.", '<>%1', Rec."Line No.");
        IF ItemJnlLineCU.FINDSET THEN
            REPEAT
                IF Rec.Contact <> '' THEN BEGIN
                    Contact1.RESET;
                    Contact1.SETRANGE("No.", Rec.Contact);
                    IF Contact1.FINDFIRST THEN
                        ItemJnlLineCU."Currency Code" := Contact1."Currency Code";
                    IF ((Rec."Currency Code" <> '') OR (Rec."Currency Code" <> 'USD')) THEN BEGIN
                        VarUP := ItemJnlLineCU."Unit Price";
                        ItemJnlLineCU."Unit Price" := Rec.UnitPriceCalc(ItemJnlLineCU.PriceCheck);
                        ItemJnlLineCU."Line AmountUP" := ItemJnlLineCU.Quantity * ItemJnlLineCU."Unit Price";
                        ItemJnlLineCU."Discount Amount" := ROUND(ROUND(ItemJnlLineCU.Quantity * ItemJnlLineCU."Unit Price", Currency."Amount Rounding Precision") *
                                                 ItemJnlLineCU."Discount%" / 100, Currency."Amount Rounding Precision");
                        ItemJnlLineCU."Line AmountUP" := ItemJnlLineCU.Quantity * ItemJnlLineCU."Unit Price" - ItemJnlLineCU."Discount Amount";
                        //ItmJnLn.MODIFY;
                    END
                    ELSE BEGIN
                        ItemJnlLineCU."Currency Code" := 'USD';
                        ItemJnlLineCU."Unit Price" := Rec.UnitPriceCalc(ItemJnlLineCU.PriceCheck);
                        ItemJnlLineCU."Line AmountUP" := ItemJnlLineCU.Quantity * ItemJnlLineCU."Unit Price";
                        ItemJnlLineCU."Discount Amount" := ROUND(ROUND(ItemJnlLineCU.Quantity * ItemJnlLineCU."Unit Price", Currency."Amount Rounding Precision") *
                                                 ItemJnlLineCU."Discount%" / 100, Currency."Amount Rounding Precision");
                        ItemJnlLineCU."Line AmountUP" := ItemJnlLineCU.Quantity * ItemJnlLineCU."Unit Price" - ItemJnlLineCU."Discount Amount"
                        //ItmJnLn.MODIFY;
                    END;
                    ItemJnlLineCU.Contact := Rec.Contact;
                    ItemJnlLineCU."Contact Name" := Rec."Contact Name";
                    ItemJnlLineCU."CustomerNo." := Rec."CustomerNo.";
                    //
                    ItemJnlLineCU."VIN No." := Rec."VIN No.";
                    ItemJnlLineCU."Vehicle Model No." := Rec."Vehicle Model No.";
                    //
                    ItemJnlLineCU."VAT Bus" := Rec."VAT Bus";
                    ItemJnlLineCU."Customer Name1" := Rec."Customer Name1";
                    ItemJnlLineCU.MODIFY;
                END
                ELSE BEGIN
                    ItemJnlLineCU."Currency Code" := 'USD';
                    //ItemJnlLineCU."Currency Code" :=  'USD';
                    ItemJnlLineCU."Unit Price" := Rec.UnitPriceCalc(ItemJnlLineCU.PriceCheck);
                    ItemJnlLineCU."Line AmountUP" := ItemJnlLineCU.Quantity * ItemJnlLineCU."Unit Price";
                    ItemJnlLineCU."Discount Amount" := ROUND(ROUND(ItemJnlLineCU.Quantity * ItemJnlLineCU."Unit Price", Currency."Amount Rounding Precision") *
                                             ItemJnlLineCU."Discount%" / 100, Currency."Amount Rounding Precision");
                    ItemJnlLineCU."Line AmountUP" := ItemJnlLineCU.Quantity * ItemJnlLineCU."Unit Price" - ItemJnlLineCU."Discount Amount";
                    //MapCurrencyCodePage(ItemJnlLineCU);
                    ItemJnlLineCU.Contact := '';
                    ItemJnlLineCU."Contact Name" := '';
                    ItemJnlLineCU."CustomerNo." := '';
                    ItemJnlLineCU."VAT Bus" := '';
                    ItemJnlLineCU."Customer Name1" := '';
                    ItemJnlLineCU.MODIFY;
                END;
            UNTIL ItemJnlLineCU.NEXT = 0;
    end;

    local procedure MapCurrency()
    begin
        ItemJnlLineCU.RESET;
        ItemJnlLineCU.SETRANGE("Source Code", 'RECLASSJNL');
        //ItemJnlLineCU.SETRANGE("Journal Batch Name",'COUNTER');
        ItemJnlLineCU.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineCU.SETRANGE("Document No.", Rec."Document No.");
        ItemJnlLineCU.SETFILTER("Line No.", '<>%1', Rec."Line No.");
        IF ItemJnlLineCU.FINDFIRST THEN BEGIN
            IF (ItemJnlLineCU."Currency Code" <> '') AND (ItemJnlLineCU."Currency Code" <> 'YER') THEN
                Rec.VALIDATE("Currency Code", ItemJnlLineCU."Currency Code");
        END;
    end;

    local procedure ReplaceServiceItemNo()
    var
        ItemJnlLineCU: Record "Item Journal Line";
    begin
        //  >>  CUS016
        ItemJnlLineCU.RESET;
        ItemJnlLineCU.SETRANGE("Source Code", 'RECLASSJNL');
        //ItemJnlLineCU.SETRANGE("Journal Batch Name",'COUNTER');
        ItemJnlLineCU.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineCU.SETRANGE("Document No.", Rec."Document No.");
        ItemJnlLineCU.SETFILTER("Line No.", '<>%1', Rec."Line No.");
        IF ItemJnlLineCU.FINDSET THEN
            REPEAT
                IF Rec."Service Item No." <> '' THEN BEGIN
                    ItemJnlLineCU."Service Item No." := Rec."Service Item No.";
                    ItemJnlLineCU."VIN No." := Rec."VIN No.";
                    ItemJnlLineCU."Vehicle Model No." := Rec."Vehicle Model No.";
                    ItemJnlLineCU."Service Item Name" := Rec."Service Item Name";
                END
                ELSE BEGIN
                    ItemJnlLineCU."Service Item No." := '';
                    ItemJnlLineCU."VIN No." := '';
                    ItemJnlLineCU."Vehicle Model No." := '';
                    ItemJnlLineCU."Service Item Name" := '';
                    ItemJnlLineCU.MODIFY;
                END;
            UNTIL ItemJnlLineCU.NEXT = 0;
        //  <<  CUS016
    end;

    local procedure MapserviceItemNo()
    var
        ItemJnlLineCU: Record "Item Journal Line";
    begin
        //  >>  CUS016
        ItemJnlLineCU.RESET;
        ItemJnlLineCU.SETRANGE("Source Code", 'RECLASSJNL');
        ItemJnlLineCU.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineCU.SETRANGE("Document No.", Rec."Document No.");
        ItemJnlLineCU.SETFILTER("Line No.", '<>%1', Rec."Line No.");
        IF ItemJnlLineCU.FINDFIRST THEN BEGIN
            IF ItemJnlLineCU."Service Item No." <> '' THEN BEGIN
                Rec."Service Item No." := ItemJnlLineCU."Service Item No.";
                Rec."VIN No." := ItemJnlLineCU."VIN No.";
                Rec."Vehicle Model No." := ItemJnlLineCU."Vehicle Model No.";
                Rec."Service Item Name" := ItemJnlLineCU."Service Item Name";
            END
            ELSE BEGIN
                Rec."VIN No." := ItemJnlLineCU."VIN No.";
                ;
                Rec."Vehicle Model No." := ItemJnlLineCU."Vehicle Model No.";
                Rec."Service Item Name" := '';
            END;
        END;
        //  >>  CUS016
    end;

    local procedure MapCurrencyCodePage(var ItmJnLn: Record "Item Journal Line")
    var
        ItemJnlLineCU: Record "Item Journal Line";
    begin
        //ItmJnLn.RESET;
        ItmJnLn.SETRANGE("Source Code", 'RECLASSJNL');
        ItmJnLn.SETRANGE("Journal Batch Name", ItmJnLn."Journal Batch Name");
        ItmJnLn.SETRANGE("Document No.", ItmJnLn."Document No.");
        //ItmJnLn.SETRANGE("Line No.",ItmJnLn."Line No.");
        ItmJnLn.SETFILTER("Line No.", '<>%1', Rec."Line No.");
        IF ItmJnLn.FINDFIRST THEN BEGIN
            IF ((Rec."Currency Code" <> '') OR (Rec."Currency Code" <> 'USD')) THEN BEGIN
                ItmJnLn."Currency Code" := Rec."Currency Code";
                VarUP := ItmJnLn."Unit Price";
                ItmJnLn."Unit Price" := Rec.UnitPriceCalc(ItmJnLn.PriceCheck);
                ItmJnLn."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price";
                ItmJnLn."Discount Amount" := ROUND(ROUND(ItmJnLn.Quantity * ItmJnLn."Unit Price", Currency."Amount Rounding Precision") *
                                         ItmJnLn."Discount%" / 100, Currency."Amount Rounding Precision");
                ItmJnLn."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price" - ItmJnLn."Discount Amount";
                //ItmJnLn.MODIFY;
            END
            ELSE BEGIN
                ItmJnLn."Currency Code" := 'USD';
                ItmJnLn."Unit Price" := Rec.UnitPriceCalc(ItmJnLn.PriceCheck);
                ItmJnLn."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price";
                ItmJnLn."Discount Amount" := ROUND(ROUND(ItmJnLn.Quantity * ItmJnLn."Unit Price", Currency."Amount Rounding Precision") *
                                         ItmJnLn."Discount%" / 100, Currency."Amount Rounding Precision");
                ItmJnLn."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price" - ItmJnLn."Discount Amount"
                //ItmJnLn.MODIFY;
            END;
        END;
    end;

    local procedure CheckCSLineStkTotal(ItemNo: Code[20]; LocationCode: Code[10]; UOM: Code[10]): Integer
    var
        IJL: Record "Item Journal Line";
        TotalQty: Integer;
    begin
        CLEAR(TotalQty);
        IJL.RESET;
        IJL.SETRANGE("Source Code", 'RECLASSJNL');
        IJL.SETRANGE("Item No.", Rec."Item No.");
        IJL.SETRANGE("Location Code", LocationCode);
        IJL.SETFILTER(Status, '<>%1', IJL.Status::Cancelled);
        IJL.SETFILTER("Line No.", '<>%1', Rec."Line No.");
        IF IJL.FINDSET THEN
            REPEAT
                TotalQty += IJL.Quantity;
            UNTIL IJL.NEXT = 0;
        EXIT(TotalQty);
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
        BinContent.RESET;
        BinContent.SETRANGE("Item No.", ItemNo);
        BinContent.SETRANGE("Location Code", LocationCode);
        BinContent.SETRANGE("Unit of Measure Code", UOM);
        IF BinContent.FINDSET THEN
            REPEAT
                BinContent.CALCFIELDS(Quantity);
                "IJLQty." := CheckCSLineStkTotal(ItemNo, LocationCode, UOM);
                ActualQty := BinContent.Quantity - "IJLQty.";
                Rec."Required Quantity" := ActualQty;
            UNTIL BinContent.NEXT = 0;
    end;

    local procedure ReplaceCurrContact()
    var
        ItemJnlLineCU: Record "Item Journal Line";
    begin
        ItemJnlLineCU1.RESET;
        //ItemJnlLineCU1.GET("Journal Template Name","Journal Batch Name",Rec."Line No.");
        ItemJnlLineCU1.SETRANGE("Source Code", 'RECLASSJNL');
        //ItemJnlLineCU.SETRANGE("Journal Batch Name",'COUNTER');
        ItemJnlLineCU1.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLineCU1.SETRANGE("Document No.", Rec."Document No.");
        //ItemJnlLineCU1.SETFILTER("Line No.",'%1',CurrLine);
        IF ItemJnlLineCU1.FINDFIRST THEN BEGIN
            IF Rec.Contact <> '' THEN BEGIN
                Contact1.RESET;
                Contact1.SETRANGE("No.", Rec.Contact);
                IF Contact1.FINDFIRST THEN
                    Rec."Currency Code" := Contact1."Currency Code";
                IF Rec."Currency Code" = 'YER' THEN
                    ExchangeRateRestriction;
                Rec."Unit Price" := Rec.UnitPriceCalc(Rec."Unit Price");
                Rec."Line AmountUP" := Rec.Quantity * Rec."Unit Price";
                Rec."Discount Amount" := ROUND(ROUND(Rec."Unit Price" * Rec.Quantity, Currency."Amount Rounding Precision") *
                                         Rec."Discount%" / 100, Currency."Amount Rounding Precision");
                Rec."Line AmountUP" := Rec.Quantity * Rec."Unit Price" - Rec."Discount Amount";
                /*   Rec.Contact :=  Rec.Contact;
                   Rec."Contact Name"  :=  Rec."Contact Name";
                   Rec."CustomerNo." :=  Rec."CustomerNo.";
                   Rec."VAT Bus" := Rec."VAT Bus";
                   Rec."Customer Name1" :=  Rec."Customer Name1";*/
                // IJLCU2.MODIFY;
            END
            ELSE BEGIN
                Rec."Currency Code" := 'USD';
                // MapCurCurrencyCodePage(ItemJnlLineCU1);
                Rec."Unit Price" := Rec.UnitPriceCalc(Rec.PriceCheck);
                Rec."Line AmountUP" := Rec.Quantity * Rec."Unit Price";
                Rec."Discount Amount" := ROUND(ROUND(Rec."Unit Price" * Rec.Quantity, Currency."Amount Rounding Precision") *
                                         Rec."Discount%" / 100, Currency."Amount Rounding Precision");
                Rec."Line AmountUP" := Rec.Quantity * Rec."Unit Price" - Rec."Discount Amount";
                Rec.Contact := '';
                Rec."Contact Name" := '';
                Rec."CustomerNo." := '';
                Rec."VAT Bus" := '';
                Rec."Customer Name1" := '';
                // ItemJnlLineCU1.MODIFY;
            END;
        END;

    end;

    local procedure MapCurCurrencyCodePage(var ItmJnLn: Record "Item Journal Line")
    var
        ItemJnlLineCU: Record "Item Journal Line";
    begin
        //ItmJnLn.RESET;
        ItmJnLn.SETRANGE("Source Code", 'RECLASSJNL');
        ItmJnLn.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItmJnLn.SETRANGE("Document No.", Rec."Document No.");
        ItmJnLn.SETFILTER("Line No.", '=%1', Rec."Line No.");
        IF ItmJnLn.FINDFIRST THEN BEGIN
            IF ((Rec."Currency Code" <> '') OR (Rec."Currency Code" <> 'USD')) THEN BEGIN
                ItmJnLn."Currency Code" := Rec."Currency Code";
                VarUP := ItmJnLn."Unit Price";
                Rec."Unit Price" := Rec.UnitPriceCalc(ItmJnLn.PriceCheck);
                Rec."Line AmountUP" := ItmJnLn.Quantity * Rec."Unit Price";
                Rec."Discount Amount" := ROUND(ROUND(ItmJnLn."Unit Price" * ItmJnLn.Quantity, Currency."Amount Rounding Precision") *
                                         ItmJnLn."Discount%" / 100, Currency."Amount Rounding Precision");
                Rec."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price" - Rec."Discount Amount";
                //ItmJnLn.MODIFY;
            END
            ELSE BEGIN
                Rec."Currency Code" := 'USD';
                Rec."Unit Price" := Rec.UnitPriceCalc(ItmJnLn.PriceCheck);
                Rec."Line AmountUP" := ItmJnLn.Quantity * Rec."Unit Price";
                Rec."Discount Amount" := ROUND(ROUND(Rec."Unit Price" * Rec.Quantity, Currency."Amount Rounding Precision") *
                                         ItmJnLn."Discount%" / 100, Currency."Amount Rounding Precision");
                Rec."Line AmountUP" := ItmJnLn.Quantity * ItmJnLn."Unit Price" - ItmJnLn."Discount Amount";
                //ItmJnLn.MODIFY;
            END;
        END;
    end;

    local procedure ExchangeRateRestriction()
    var
        E: Integer;
        ExcgRte: Record "Currency Exchange Rate";
    begin
        E := 0;
        ExcgRte.RESET;
        ExcgRte.SETRANGE("Currency Code", 'YER');
        IF ExcgRte.FINDSET THEN
            REPEAT BEGIN
                IF ExcgRte."Starting Date" = WORKDATE THEN
                    E := 1;
            END;
            UNTIL ExcgRte.NEXT = 0;
        IF E = 0 THEN
            ERROR('Update exchange rate for YER currency');
    end;

    procedure GenJournalLineExist()
    begin
        GenJournalLine.SetRange("Cs.Document No.", Rec."Document No.");
        IF GenJournalLine.FINDFIRST THEN
            ERROR('Cash Receipt Journal Lines Exist,Please Delete');
    end;

    procedure "Restricting Mutiple Agency"()
    begin
        //EP9612
        ItemJournalLine_Agency_Restrict.RESET;
        ItemJournalLine_Agency_Restrict.SETRANGE("Document No.", Rec."Document No.");
        IF ItemJournalLine_Agency_Restrict.FINDLAST THEN BEGIN
            IF ItemJournalLine_Agency_Restrict."Item No." <> '' THEN BEGIN
                IF ItemJournalLine_Agency_Restrict."Gen. Prod. Posting Group" <> Rec."Gen. Prod. Posting Group" THEN
                    ERROR('Adding Mutiple Agency items in same Document No is Restricted , Previously choosen item agency is %1', ItemJournalLine_Agency_Restrict."Gen. Prod. Posting Group");
            END;
        END
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
            Responsibility_Center := usersetup."Sales Resp. Ctr. Filter"
        else
            Error('Sales Responsibility Should be empty in User Setup');

        ItemJnlBatch.Reset();
        ItemJnlBatch.FILTERGROUP(2);
        ItemJnlBatch.SETRANGE(Counter_Batch, TRUE);
        ItemJnlBatch.SETRANGE("Journal Template Name", 'RECLASS');
        ItemJnlBatch.SETRANGE(Responsibility_Center, Responsibility_Center);
        ItemJnlBatch.FILTERGROUP(0);
        IF PAGE.RUNMODAL(0, ItemJnlBatch) = ACTION::LookupOK THEN BEGIN
            CurrentJnlBatchName := ItemJnlBatch.Name;
        END;
    end;

}

