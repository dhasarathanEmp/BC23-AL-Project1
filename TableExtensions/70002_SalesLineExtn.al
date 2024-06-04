tableextension 70002 SalesLineExtn extends "Sales Line"
{
    fields
    {

        //Unsupported feature: Property Modification (Editable) on ""Qty. Shipped Not Invoiced"(Field 58)".



        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "No." := FindRecordMgt.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");

        TestJobPlanningLine;
        #4..114
        PostingSetupMgt.CheckGenPostingSetupSalesAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
        PostingSetupMgt.CheckGenPostingSetupCOGSAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
        PostingSetupMgt.CheckVATPostingSetupSalesAccount("VAT Bus. Posting Group","VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        {SaleHdr1.RESET;
        SaleHdr1.GET("No.",Rec."Document No.");
        IF SaleHdr1.FINDFIRST THEN BEGIN
          IF SaleHdr1."Agency Code" = '' THEN
           ERROR('Please Choose the Agency Code Before Adding Item Lines');
        END;}

        SaleHdr1.RESET;
        SaleHdr1.SETRANGE("No.",Rec."Document No.");
        IF SaleHdr1.FINDFIRST THEN
          CurrCode := SaleHdr1."Currency Code";

        {
        IF CurrCode = 'YER' THEN
         ExchangeRateRestriction;

        Itm1.RESET;
        Itm1.SETRANGE("No.",Rec."No.");
        IF Itm1.FINDFIRST THEN
          Agency := Itm1."Global Dimension 1 Code";

        SalesLne2.RESET;
        SalesLne2.SETRANGE("Document No.",Rec."Document No.");
        IF SalesLne2.FINDFIRST THEN BEGIN
          SaleHdr2.RESET;
          SaleHdr2.SETRANGE("No.",SalesLne2."Document No.");
          IF SaleHdr2.FINDFIRST THEN
            SaleHdr2."Shortcut Dimension 1 Code" := Agency;
            SaleHdr2.MODIFY;
        END;
        }

        #1..117

        //  >> CUS038
        SalesLne2.RESET;
        SalesLne2.SETRANGE("Document No.",Rec."Document No.");
        IF SalesLne2.FINDSET THEN REPEAT
          IF SalesLne2."No." = Rec."No." THEN BEGIN
              SameItemCount := SameItemCount + 1;
          END;
        UNTIL SalesLne2.NEXT = 0;
        IF SameItemCount > 0 THEN
          MESSAGE('The item No.('+Rec."No."+') is already exist in '+FORMAT(SameItemCount)+' Line in the Same Sales order.Please check the item');
         // << CUS038

        // Intercompany sales order unit price value fetch from item dealer Net price.
        company.RESET;
        company.SETRANGE(Name,COMPANYNAME);
        company.SETRANGE(ADFZ,TRUE);
        IF company.FINDFIRST THEN BEGIN
          SalesHeaderBuf.RESET;
          SalesHeaderBuf.SETRANGE("No.",Rec."Document No.");
          SalesHeaderBuf.SETRANGE("Document Type",SalesHeaderBuf."Document Type"::Order);
          IF SalesHeaderBuf.FINDFIRST THEN BEGIN
            CustomerBuf.RESET;
            CustomerBuf.SETRANGE("No.",SalesHeaderBuf."Sell-to Customer No.");
            CustomerBuf.SETFILTER("IC Partner Code", '<>%1',' ');
            IF CustomerBuf.FINDFIRST THEN BEGIN
              ItemTable.RESET;
              ItemTable.SETRANGE("No.",Rec."No.");
              ItemTable.SETRANGE("Remanufactured Part Indicator",TRUE);
              IF ItemTable.FINDFIRST THEN BEGIN
                Rec."Unit Price" := ItemTable."Dealers Net Price"+ItemTable."Dealer Net - Core Deposit";
              END ELSE BEGIN
                Rec."Unit Price" := ItemTable."Dealers Net Price";
              END;
            END;
          END;
        END;

        //
        SalesHeaderBuf1.RESET;
        SalesHeaderBuf1.SETRANGE("No.",Rec."Document No.");
        SalesHeaderBuf1.SETRANGE("Document Type",SalesHeaderBuf."Document Type"::Order);
        IF SalesHeaderBuf1.FINDFIRST THEN
          Rec."PO Number" := SalesHeaderBuf1."External Document No.";
        //

        "Sales Type"  :=  "Sales Type"::Sales;
        "Applied Doc. No."  :=  "Document No.";
        IF "Document Type"="Document Type"::Order THEN
        "Sale Order No.":="Document No.";
        ItemBuf.RESET;
        ItemBuf.SETRANGE("No.",Rec."No.");
        IF ItemBuf.FINDFIRST THEN
          "Gross Weight kG" := ItemBuf."Gross Weight (kg)";
        //
        company.RESET;
        company.SETRANGE(Name,COMPANYNAME);
        company.SETRANGE(ADFZ,TRUE);
        IF NOT company.FINDFIRST THEN
          AgencyValidation;
        //Cu011

        IF (Rec.Type=Rec.Type::Item) AND ("No."<>xRec."No.") AND ((Rec."Document Type"=Rec."Document Type"::Quote) OR (Rec."Document Type"=Rec."Document Type"::Order)) THEN BEGIN
          ItemBuf.GET("No.");
          IF ItemBuf."Hose Main item"=TRUE THEN
            Rec."Unit Price" :=0.0;
        END;

        //EP9625 to excluding delivery charge lines from applying discount percentage by Allow Discount percentage field as false


        //EP9625
        */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Field 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;

        #4..89
        UpdatePlanned;
        IF "Document Type" = "Document Type"::"Return Order" THEN
          ValidateReturnReasonCode(FIELDNO(Quantity));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..92
        {//Cu009
        IF (Type=Type::Item) AND (Quantity<>0) THEN BEGIN
          ItemforBOMCheck.GET("No.");
          ItemforBOMCheck.CALCFIELDS("Assembly BOM");
          IF (ItemforBOMCheck."Assembly BOM"=TRUE) THEN
            IF CONFIRM(Text061,FALSE) THEN
              CODEUNIT.RUN(63,Rec);
          CLEAR(ItemforBOMCheck);
        //Cu009
        END;}
        */
        //end;


        //Unsupported feature: Code Modification on ""Line Discount %"(Field 27).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        "Line Discount Amount" :=
          ROUND(
            ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") *
            "Line Discount %" / 100,Currency."Amount Rounding Precision");
        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
        //"Inv. Discount Amount" := 0;
        //"Inv. Disc. Amount to Invoice" := 0;
        UpdateAmounts;
        */
        //end;


        //Unsupported feature: Code Modification on ""Qty. to Assemble to Order"(Field 900).OnValidate".

        //trigger  to Assemble to Order"(Field 900)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);

        "Qty. to Asm. to Order (Base)" := CalcBaseQty("Qty. to Assemble to Order");
        #4..27
        IF NOT (CurrFieldNo IN [FIELDNO(Quantity),FIELDNO("Qty. to Assemble to Order")]) THEN
          GetDefaultBin;
        AutoAsmToOrder;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //
        GetItem;
        IF (Item."Hose Main item"=FALSE) AND ("Qty. to Assemble to Order">0) THEN
          ERROR('Only Hose Items can be assembled to Order');
        //
        #1..30
        */
        //end;


        //Unsupported feature: Code Modification on ""Bin Code"(Field 5403).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT IsInbound AND ("Quantity (Base)" <> 0) THEN
          BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code",'',"Bin Code")
        ELSE
          BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code",'');

        IF BinCode <> '' THEN
          VALIDATE("Bin Code",BinCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        {IF NOT IsInbound AND ("Quantity (Base)" <> 0) THEN
          BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code",'',"Bin Code")
        ELSE
          BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code",'');}
        //  >>  CS18
        IF NOT IsInbound AND ("Quantity (Base)" <> 0) THEN
          IF Rec."Document Type" = "Document Type"::Order THEN
           BinCode := WMSManagement.BinContentLookUp1("Location Code","No.","Variant Code",'',"Bin Code",3)
          ELSE IF (Rec."Document Type" = "Document Type"::Invoice) OR (Rec."Document Type" = Rec."Document Type"::"Return Order") THEN
           BinCode := WMSManagement.BinContentLookUp1("Location Code","No.","Variant Code",'',"Bin Code",4)
          ELSE
           BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code",'',"Bin Code")
        ELSE
          IF Rec."Document Type" = "Document Type"::Order THEN
            BinCode := WMSManagement.BinLookUp1("Location Code","No.","Variant Code",'',3)
          ELSE IF (Rec."Document Type" = "Document Type"::Invoice) OR (Rec."Document Type" = Rec."Document Type"::"Return Order") THEN
            BinCode := WMSManagement.BinLookUp1("Location Code","No.","Variant Code",'',4)
          ELSE
            BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code",'');
        //  <<  CS18
        IF BinCode <> '' THEN
          VALIDATE("Bin Code",BinCode);
        */
        //end;


        //Unsupported feature: Code Modification on ""Bin Code"(Field 5403).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bin Code" <> '' THEN BEGIN
          IF NOT IsInbound AND ("Quantity (Base)" <> 0) AND ("Qty. to Asm. to Order (Base)" = 0) THEN
            WMSManagement.FindBinContent("Location Code","Bin Code","No.","Variant Code",'')
        #4..17
          CheckWarehouse;
        END;
        ATOLink.UpdateAsmBinCodeFromSalesLine(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..20
        //CS25
        {IF "Document Type" = "Document Type"::Order THEN BEGIN
        BinContents.RESET;
        BinContents.SETRANGE(BinContents."Item No.","No.");
        BinContents.SETRANGE(BinContents."Location Code","Location Code");
        BinContents.SETRANGE(BinContents."Bin Code","Bin Code");
        BinContents.SETRANGE(Dedicated,TRUE);
        IF BinContents.FINDFIRST THEN BEGIN
            //IF BinContents.Dedicated = TRUE THEN BEGIN
           "Unit Price" := 0;
           "Line Amount" := 0;
           MESSAGE('Manually enter the unit price');
          END;
        END;}
        //CS25
        */
        //end;
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                IF (Rec.Type = Rec.Type::Item) AND ("No." <> xRec."No.") AND ((Rec."Document Type" = Rec."Document Type"::Quote) OR (Rec."Document Type" = Rec."Document Type"::Order)) THEN BEGIN
                    ItemBuf.GET("No.");
                    IF ItemBuf."Hose Main item" = TRUE THEN
                        Rec."Unit Price" := 0.0;
                END;

            end;
        }

        modify(Quantity)
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
            begin
                OldQty := xRec.Quantity;
                if OldQty <> 0 then begin
                    InvDiscAmt := "Inv. Discount Amount";
                    InvDiscAmttoInv := "Inv. Disc. Amount to Invoice";
                end
                else begin
                    SalesLine.RESET;
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."Document No.");
                    SalesLine.SetFilter("Line No.", '<>%1', Rec."Line No.");
                    IF SalesLine.FindSet() then;
                    SalesLine.CalcSums("Line Amount", "Inv. Discount Amount");
                    TotalLineAmt := SalesLine."Line Amount";
                    TotalDiscAmt := SalesLine."Inv. Discount Amount";
                end;
            end;

            trigger OnAfterValidate()
            var
                SalesH: Record "Sales Header";
                Item: Record Item;
                SalesSetup: Record "Sales & Receivables Setup";
            begin
                if (Quantity <> OldQty) then begin
                    if (OldQty <> 0) then begin
                        "Inv. Discount Amount" := Quantity / OldQty * InvDiscAmt;
                        "Inv. Disc. Amount to Invoice" := Quantity / OldQty * InvDiscAmttoInv;
                        UpdateAmounts();
                    end
                    else begin
                        SalesSetup.GetRecordOnce();
                        if SalesSetup.Inc_CoreCharge = true then begin
                            SalesH.GET(Rec."Document Type", Rec."Document No.");
                            "Inv. Discount Amount" := ("Line Amount" - "Core Charges" * Quantity * Item."Inventory Factor") * SalesH."Invoice Discount%" / 100;
                            UpdateAmounts();
                        end else begin
                            SalesH.GET(Rec."Document Type", Rec."Document No.");
                            "Inv. Discount Amount" := "Line Amount" * SalesH."Invoice Discount%" / 100;
                            UpdateAmounts();
                        end;
                    end;
                end;
            end;
        }
        modify("Unit Price")
        {
            trigger OnBeforeValidate()
            var
                Item: Record Item;
            begin
                if Rec.Type = Rec.Type::Item then begin
                    Item.Get(Rec."No.");
                    OldUP := xRec."Unit Price" - xRec."Core Charges" * Item."Inventory Factor";
                end else
                    OldUP := xRec."Unit Price";
                if OldUP > 0 then begin
                    InvDiscAmt := "Inv. Discount Amount";
                    InvDiscAmttoInv := "Inv. Disc. Amount to Invoice";
                end
                else begin
                    SalesLine.RESET;
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."Document No.");
                    SalesLine.SetFilter("Line No.", '<>%1', Rec."Line No.");
                    IF SalesLine.FindSet() then;
                    SalesLine.CalcSums("Line Amount", "Inv. Discount Amount");
                    TotalLineAmt := SalesLine."Line Amount";
                    TotalDiscAmt := SalesLine."Inv. Discount Amount";
                end;
            end;

            trigger OnAfterValidate()
            var
                SalesH: Record "Sales Header";
                Item: Record Item;
                SalesSetup: Record "Sales & Receivables Setup";
                NewUP: Decimal;
                LineCore: Decimal;
            begin
                if Rec.Type = Rec.Type::Item then begin
                    Item.Get(Rec."No.");
                    NewUP := ("Unit Price" - "Core Charges" * Item."Inventory Factor");
                    LineCore := Quantity * "Core Charges" * Item."Inventory Factor";
                END Else
                    NewUP := "Unit Price";
                LineCore := 0;
                if (NewUP <> OldUP) then begin
                    if (OldUP <> 0) then begin
                        "Inv. Discount Amount" := NewUP / OldUP * InvDiscAmt;
                        "Inv. Disc. Amount to Invoice" := NewUP / OldUP * InvDiscAmttoInv;
                        UpdateAmounts();
                    end
                    else begin
                        SalesSetup.GetRecordOnce();
                        if SalesSetup.Inc_CoreCharge = true then begin
                            SalesH.GET(Rec."Document Type", Rec."Document No.");
                            "Inv. Discount Amount" := ("Line Amount" - LineCore) * SalesH."Invoice Discount%" / 100;
                            UpdateAmounts();
                        end else begin
                            SalesH.GET(Rec."Document Type", Rec."Document No.");
                            "Inv. Discount Amount" := "Line Amount" * SalesH."Invoice Discount%" / 100;
                            UpdateAmounts();
                        end;
                    end;
                end;
            end;
        }
        field(50000; "Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
            OptionMembers = " ",Sales,Service,Purchase;
        }
        field(50001; "Applied Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
        }
        field(50002; "Document No.1"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS009';
        }
        field(50003; InvoiceDiscountAmount1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; VATAmount1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Sales Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS013';
        }
        field(50006; SaleInvNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CS90';
        }
        field(50007; "VIN No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50008; "Vehicle Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50009; SaleInvLineNo; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CS90';
        }
        field(50010; "Service Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50011; "Service Item Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50013; "Sap No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS022';
        }
        field(50014; "Customer Serial No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS022';
        }
        field(50015; LastPartNumber; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50016; "Sale Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Core Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "PO Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Case Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Gross Weight kG"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Sale Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'AFZ001';
        }
        field(50032; "BOM Item No"; Code[20])
        {
            Caption = 'BOM Item No.';
            DataClassification = ToBeClassified;
            Description = 'Cu009';
            TableRelation = Item;
        }
        field(50033; "BOM Quantity Per"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu009';
        }
        field(50034; "BOM Main Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu009';
        }
        field(50037; "Qty to cancel"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                MainQty := Quantity - "Cancelled Quantity";
                Quantity := MainQty;
                */

            end;
        }
        field(50038; "Cancelled Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;
    IF Quantity <> 0 THEN BEGIN
      OnBeforeVerifyReservedQty(Rec,xRec,0);
    #4..9
        ERROR(Text056,SalesHeader."Shipping Advice");
    IF ("Deferral Code" <> '') AND (GetDeferralAmount <> 0) THEN
      UpdateDeferralAmounts;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12

    //  >> CUS001
    "Sales Type"  :=  "Sales Type"::Sales;
    "Applied Doc. No."  :=  "Document No.";
    //  << CUS001

    //
    IF "Document Type"="Document Type"::Order THEN
    "Sale Order No.":="Document No.";
    */
    //end;


    //Unsupported feature: Code Modification on "CopyFromItem(PROCEDURE 144)".

    //procedure CopyFromItem();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetItem;
    Item.TESTFIELD(Blocked,FALSE);
    Item.TESTFIELD("Gen. Prod. Posting Group");
    IF Item.Type = Item.Type::Inventory THEN BEGIN
      Item.TESTFIELD("Inventory Posting Group");
      "Posting Group" := Item."Inventory Posting Group";
    END;
    Description := Item.Description;
    "Description 2" := Item."Description 2";
    GetUnitCost;
    #11..33
    InitDeferralCode;
    SetDefaultItemQuantity;
    OnAfterAssignItemValues(Rec,Item);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    //Cu011
    {IF Item."Hose Main item" THEN BEGIN
      WeeklyNPRPriceUpdateStatus.RESET;
      WeeklyNPRPriceUpdateStatus.SETCURRENTKEY("Document Updated Date");
      WeeklyNPRPriceUpdateStatus.FINDLAST;
      IF Item."Hose Price Update Date"<=(WeeklyNPRPriceUpdateStatus."Document Updated Date"-1) THEN
        IF COMPANYNAME<>'AFZ' THEN
          ERROR('Update Hose Item Price');
    END;}
    #8..36
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SalesPrice) (VariableCollection) on "UpdateUnitPrice(PROCEDURE 2)".


    //Unsupported feature: Variable Insertion (Variable: ItemSpec) (VariableCollection) on "UpdateUnitPrice(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "UpdateUnitPrice(PROCEDURE 2)".

    //procedure UpdateUnitPrice();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeUpdateUnitPrice(Rec,xRec,CalledByFieldNo,CurrFieldNo,Handled);
    IF Handled THEN
      EXIT;
    #4..11
          PriceCalcMgt.FindSalesLinePrice(SalesHeader,Rec,CalledByFieldNo);
        END;
    END;
    VALIDATE("Unit Price");

    OnAfterUpdateUnitPrice(Rec,xRec,CalledByFieldNo,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..14
    //Cu001
          IF Type = Type::Item THEN BEGIN
            SalesPrice.RESET;
            SalesPrice.SETRANGE("Sales Code","Sell-to Customer No.");
            SalesPrice.SETRANGE("Item No.","No.");
            IF NOT SalesPrice.FINDFIRST THEN BEGIN
              IF SalesHeader."Special Price Factor"<>0 THEN BEGIN
                ItemSpec.GET("No.");
                "Unit Price" := ((ItemSpec."Unit Price"-ItemSpec."Dealer Net - Core Deposit"*ItemSpec."Inventory Factor")*SalesHeader."Special Price Factor"+ItemSpec."Dealer Net - Core Deposit"*ItemSpec."Inventory Factor")*"Qty. per Unit of Measure";
                "Unit Price" := ROUND("Unit Price",Currency."Unit-Amount Rounding Precision");
              END;
            END;
          END;
          //Cu001
    #15..17
    */
    //end;


    //Unsupported feature: Code Modification on "AutoReserve(PROCEDURE 11)".

    //procedure AutoReserve();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD(Type,Type::Item);
    TESTFIELD("No.");

    ReserveSalesLine.ReservQuantity(Rec,QtyToReserve,QtyToReserveBase);
    IF QtyToReserveBase <> 0 THEN BEGIN
      ReservMgt.SetSalesLine(Rec);
      TESTFIELD("Shipment Date");
      ReservMgt.AutoReserve(FullAutoReservation,'',"Shipment Date",QtyToReserve,QtyToReserveBase);
      FIND;
      IF NOT FullAutoReservation THEN BEGIN
        COMMIT;
    #12..14
        END;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
      ReservMgt.AutoReserve(FullAutoReservation,'',"Shipment Date",QtyToReserve,QtyToReserveBase,FALSE);
    #9..17
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: LineCoreCharge) (VariableCollection) on "UpdateVATOnLines(PROCEDURE 36)".



    //Unsupported feature: Code Modification on "UpdateVATOnLines(PROCEDURE 36)".

    //procedure UpdateVATOnLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LineWasModified := FALSE;
    IF QtyType = QtyType::Shipping THEN
      EXIT;
    #4..24
                TempVATAmountLineRemainder.INIT;
                TempVATAmountLineRemainder.INSERT;
              END;

              IF QtyType = QtyType::General THEN
                LineAmountToInvoice := "Line Amount"
              ELSE
                LineAmountToInvoice :=
                  ROUND("Line Amount" * "Qty. to Invoice" / Quantity,Currency."Amount Rounding Precision");

              IF "Allow Invoice Disc." THEN BEGIN
                IF (VATAmountLine."Inv. Disc. Base Amount" = 0) OR (LineAmountToInvoice = 0) THEN
                  InvDiscAmount := 0
                ELSE BEGIN
                  LineAmountToInvoiceDiscounted :=
                    VATAmountLine."Invoice Discount Amount" * LineAmountToInvoice /
                    VATAmountLine."Inv. Disc. Base Amount";
                  TempVATAmountLineRemainder."Invoice Discount Amount" :=
                    TempVATAmountLineRemainder."Invoice Discount Amount" + LineAmountToInvoiceDiscounted;
                  InvDiscAmount :=
    #45..135
    END;

    OnAfterUpdateVATOnLines(SalesHeader,SalesLine,VATAmountLine,QtyType);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..27
              //Cu017 & Cu107
              IF QtyType = QtyType::General THEN BEGIN
                LineAmountToInvoice := "Line Amount";
                IF Type = Type::Item THEN BEGIN
                  Item.GET("No.");
                  GetSalesSetup;
                  IF SalesSetup."Inc. Core charge in Inv Disc."=FALSE THEN
                    LineCoreCharge := ROUND(Quantity*Item."Dealer Net - Core Deposit"*Item."Inventory Factor",Currency."Amount Rounding Precision")
                  ELSE
                    LineCoreCharge := 0;
                  END;
              END ELSE BEGIN
                LineAmountToInvoice :=
                  ROUND("Line Amount" * "Qty. to Invoice" / Quantity,Currency."Amount Rounding Precision");
                IF Type = Type::Item THEN BEGIN
                  Item.GET("No.");
                  GetSalesSetup;
                  IF SalesSetup."Inc. Core charge in Inv Disc."=FALSE THEN
                    LineCoreCharge := ROUND("Qty. to Invoice"*Item."Dealer Net - Core Deposit"*Item."Inventory Factor",Currency."Amount Rounding Precision")
                  ELSE
                    LineCoreCharge := 0;
                END;
              END;
              //Cu017 & Cu107
    #35..39
                    VATAmountLine."Invoice Discount Amount" * (LineAmountToInvoice - LineCoreCharge) /
                    VATAmountLine."Inv. Disc. Base Amount";// In above line changed, subtracted core charge from line amount -- Cu017
    #42..138
    */
    //end;


    //Unsupported feature: Code Modification on "CalcVATAmountLines(PROCEDURE 35)".

    //procedure CalcVATAmountLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Currency.Initialize(SalesHeader."Currency Code");

    VATAmountLine.DELETEALL;
    #4..23
              QtyType::General:
                BEGIN
                  VATAmountLine.Quantity += "Quantity (Base)";
                  VATAmountLine.SumLine(
                    "Line Amount","Inv. Discount Amount","VAT Difference","Allow Invoice Disc.","Prepayment Line");
                END;
    #30..54
                    END;
                  END;
                  AmtToHandle := GetLineAmountToHandle(QtyToHandle);
                  IF SalesHeader."Invoice Discount Calculation" <> SalesHeader."Invoice Discount Calculation"::Amount THEN
                    VATAmountLine.SumLine(
                      AmtToHandle,ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision"),
    #61..74
                    VATAmountLine.Quantity += "Qty. to Ship (Base)";
                  END;
                  AmtToHandle := GetLineAmountToHandle(QtyToHandle);
                  VATAmountLine.SumLine(
                    AmtToHandle,ROUND("Inv. Discount Amount" * QtyToHandle / Quantity,Currency."Amount Rounding Precision"),
                    "VAT Difference","Allow Invoice Disc.","Prepayment Line");
    #81..97
      END;

    OnAfterCalcVATAmountLines(SalesHeader,SalesLine,VATAmountLine,QtyType);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..26
                  //Cu017 & Cu107
                  SalesSetup.GET;
                  IF Item.GET("No.") AND (SalesSetup."Inc. Core charge in Inv Disc."=FALSE) THEN
                    VATAmountLine."Inv. Disc. Base Amount"-=("Quantity (Base)"*"Core Charges"*Item."Inventory Factor");
                  //Cu017 & Cu107
    #27..57
                  //Cu017 & Cu107
                  SalesSetup.GET;
                  IF Item.GET("No.") AND (SalesSetup."Inc. Core charge in Inv Disc."=FALSE) THEN
                    VATAmountLine."Inv. Disc. Base Amount"-=(QtyToHandle*"Core Charges"*Item."Inventory Factor");
                  //Cu017 & Cu107
    #58..77
                  //Cu017 & Cu107
                  SalesSetup.GET;
                  IF Item.GET("No.") AND (SalesSetup."Inc. Core charge in Inv Disc."=FALSE) THEN
                    VATAmountLine."Inv. Disc. Base Amount"-=(QtyToHandle*"Core Charges"*Item."Inventory Factor");
                  //Cu017 & Cu107
    #78..100
    */
    //end;


    //Unsupported feature: Code Modification on "GetDefaultBin(PROCEDURE 50)".

    //procedure GetDefaultBin();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Type <> Type::Item THEN
      EXIT;

    #4..10
        IF ("Qty. to Assemble to Order" > 0) OR IsAsmToOrderRequired THEN
          IF GetATOBin(Location,"Bin Code") THEN
            EXIT;

        WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
        HandleDedicatedBin(FALSE);
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
        //  <<  CS18
        IF "Document Type" <> "Document Type"::Invoice THEN
         WMSManagement.GetDefaultBinUnlock("No.","Variant Code","Location Code","Bin Code")
        ELSE BEGIN
         WMSManagement.GetDefaultBinSalesInvoice("No.","Variant Code","Location Code","Bin Code");
        HandleDedicatedBin(FALSE);
        END;
       //  >>  CS18
    #16..18
    */
    //end;

    local procedure ExchangeRateRestriction()
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
            ERROR('Update exchange rate in YER');
    end;

    local procedure AgencyValidation()
    begin
        //EP9609 Adding validation for agency check up
        SalesHeader2.GET("Document Type", "Document No.");
        IF ((SalesHeader2."Document Type" = SalesHeader2."Document Type"::Order) OR (SalesHeader2."Document Type" = SalesHeader2."Document Type"::Quote)) AND (SalesHeader2."Order Date" > 20220209D) THEN BEGIN
            IF ((Rec.Type = Rec.Type::Item) AND (Rec."No." <> '')) THEN
                SalesHeader2.TESTFIELD("Agency Code")
        END;

        IF ((SalesHeader2."Document Type" = SalesHeader2."Document Type"::Order) OR (SalesHeader2."Document Type" = SalesHeader2."Document Type"::Quote)) AND (SalesHeader2."Order Date" > 20220209D) THEN BEGIN
            IF ((Rec.Type = Rec.Type::Item) AND (Rec."No." <> '')) THEN BEGIN
                ItemAG.RESET;
                ItemAG.GET(Rec."No.");
                IF ItemAG."Global Dimension 1 Code" <> SalesHeader2."Agency Code" THEN
                    ERROR('Please add the Same Agency Item, which Selected in Header');
            END;
        END
        //EP9609 Adding validation for agency check up
    end;

    var
        SalesHeaderBuf: Record "Sales Header";
        ItemTable: Record "Item";

    var
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Gpass: Code[20];
        ExcgRte: Record "Currency Exchange Rate";
        E: Integer;
        SalesHdr: Record "Sales Header";
        BinContents: Record "BIn Content";
        Bool: Boolean;
        ItemC: Record "Item";
        SaleHdr1: Record "Sales Header";
        SalesLne1: Record "Sales Line";
        QuoteNo: Code[20];
        SaleQte: Record "Sales Header Archive";
        CurrCode: Code[20];
        SaleHdr2: Record "Sales Header";
        SalesLne2: Record "Sales Line";
        Itm1: Record "Item";
        Agency: Code[20];
        SameItemCount: Integer;
        SalesHeaderBuf1: Record "Sales Header";
        CustomerBuf: Record "Customer";
        ItemforBOMCheck: Record "Item";
        Text061: Label 'Do you want to Explode BOM?';
        WeeklyNPRPriceUpdateStatus: Record "Weekly NPR Price Update Status";
        SalesHeader2: Record "Sales Header";
        ItemAG: Record "Item";
        MainQty: Decimal;
        ServiceItem: Record "Item";
        myInt: Integer;
        InvDiscAmt: Decimal;
        OldQty: Decimal;
        NewQty: Decimal;
        OldUP: Decimal;
        NewUP: Decimal;
        InvDiscAmttoInv: Decimal;
        SalesLine: Record "Sales Line";
        TotalLineAmt: Decimal;
        TotalDiscAmt: Decimal;
        TotalDiscAmttoInv: Decimal;
        ItemBuf: Record Item;
}

