tableextension 70013 PurchaseLineExtn extends "Purchase Line"
{
    fields
    {


        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "No." := FindRecordMgt.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");

        TestStatusOpen;
        #4..123

        PostingSetupMgt.CheckGenPostingSetupPurchAccount("Gen. Bus. Posting Group","Gen. Prod. Posting Group");
        PostingSetupMgt.CheckVATPostingSetupPurchAccount("VAT Bus. Posting Group","VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PurchHdr1.RESET;
        PurchHdr1.SETRANGE("No.",Rec."Document No.");
        IF PurchHdr1.FINDFIRST THEN
          CurrCode := PurchHdr1."Currency Code";
        {
        IF CurrCode = 'YER' THEN
         ExchangeRateRestriction;
        }
        {
        Itm1.RESET;
        Itm1.SETRANGE("No.",Rec."No.");
        IF Itm1.FINDFIRST THEN
          Agency := Itm1."Global Dimension 1 Code";

        PurchLne2.RESET;
        PurchLne2.SETRANGE("Document No.",Rec."Document No.");
        IF PurchLne2.FINDFIRST THEN BEGIN
          PurchHdr2.RESET;
          PurchHdr2.SETRANGE("No.",PurchLne2."Document No.");
          IF PurchHdr2.FINDFIRST THEN
            PurchHdr2."Shortcut Dimension 1 Code" := Agency;
            PurchHdr2.MODIFY;
        END;
        }

        #1..126
        "Planning Flexibility":= "Planning Flexibility"::None; //Cu006
        */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Field 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        IF "Drop Shipment" AND ("Document Type" <> "Document Type"::Invoice) THEN
        #4..50
          InitItemAppl;

        IF Type = Type::Item THEN
          UpdateDirectUnitCost(FIELDNO(Quantity))
        ELSE
          VALIDATE("Line Discount %");

        #58..84
        END;

        CheckWMS;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..53
          //Cu002
          //UpdateDirectUnitCost(FIELDNO(Quantity))
          UpdateDirectUnitCostNew(FIELDNO(Quantity))
          //Cu002
        #55..87

        //CS21

        {Item1.RESET;
        Item1.SETRANGE("No.","No.");
        IF Item1.FINDFIRST THEN
          MnRordQty := Item1."Minimum Order Quantity";
        IF Quantity < MnRordQty THEN BEGIN
          IF DIALOG.CONFIRM(Text055,TRUE,MnRordQty) THEN
            Quantity := MnRordQty;
         END;}

         //CS21
         //CS24
         IF Quantity <> 0 THEN
          "Vendor Invoice Quantity" := Quantity;
         //CS24
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
        IF NOT IsInbound AND ("Quantity (Base)" <> 0) THEN
        //  >>  CS18
          IF Rec."Document Type" = "Document Type"::Order THEN
           BinCode := WMSManagement.BinContentLookUp1("Location Code","No.","Variant Code",'',"Bin Code",1)
          ELSE IF (Rec."Document Type" = "Document Type"::Invoice) OR (Rec."Document Type" = Rec."Document Type"::"Return Order") THEN
           BinCode := WMSManagement.BinContentLookUp1("Location Code","No.","Variant Code",'',"Bin Code",1)
          ELSE
           BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code",'',"Bin Code")
        ELSE
          IF (Rec."Document Type" = "Document Type"::Order) OR (Rec."Document Type" = Rec."Document Type"::"Return Order") THEN
            BinCode := WMSManagement.BinLookUp1("Location Code","No.","Variant Code",'',1)
          ELSE IF Rec."Document Type" = "Document Type"::Invoice THEN
            BinCode := WMSManagement.BinLookUp1("Location Code","No.","Variant Code",'',1)
          ELSE
            BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code",'');
        //  <<  CS18

        #5..7
        */
        //end;

        //Unsupported feature: Property Deletion (Editable) on ""Qty. to Assign"(Field 5801)".

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
        field(50002; "Is Inserted"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS003';
        }
        field(50003; "Service Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS002';

            trigger OnValidate()
            begin
                //"Service Order No."  :=  PurchHeader."Service Order No.";
            end;
        }
        field(50004; "Vendor Invoice Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50006; "Sales Order No"; Code[250])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS015';
        }
        field(50009; "Part Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50010; Status; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu002';
            OptionMembers = " ",Cancelled,Modified;
        }
        field(50011; "Cancelled Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu002';

            trigger OnValidate()
            begin
                //Cu002
                "Purch Header".RESET;
                "Purch Header".SETRANGE("No.", Rec."Document No.");
                "Purch Header".FINDFIRST;
                IF "Purch Header".Status <> "Purch Header".Status::Released THEN
                    ERROR('Document Not Released');
                //"Purch Header".Status:= "Purch Header".Status::Open;
                //"Purch Header".MODIFY(TRUE);
                ReleasePurchaseDocument.PerformManualReopen("Purch Header");
                IF Rec."Original Quantity" = 0 THEN
                    Rec."Original Quantity" := Quantity;
                IF "Cancelled Quantity" > (Rec."Original Quantity" - "Quantity Received") THEN
                    ERROR(Text1)
                ELSE BEGIN
                    Quantity := Rec."Original Quantity" - "Cancelled Quantity";
                    Rec.VALIDATE(Quantity);
                    IF (Quantity = 0) THEN
                        Status := Status::Cancelled
                    ELSE IF Quantity = "Original Quantity" THEN
                        Status := Status::" "
                    ELSE
                        Status := Status::Modified;
                    //Rec."Original Quantity":= Quantity+"Cancelled Quantity";
                END;
                //"Purch Header".Status:= "Purch Header".Status::Released;
                //"Purch Header".MODIFY(TRUE);
                IF Status = Status::Cancelled THEN
                    "Vendor Invoice Quantity" := 0;
                ReleasePurchaseDocument.PerformManualRelease("Purch Header");
                //Cu002
            end;
        }
        field(50012; "Original Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu002';
        }
        field(50015; "Serial No"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Cu012';
        }
        field(50017; LastPartNumber; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Cu104';
        }
        field(50018; "Req Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Old PO Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Transfered to"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    trigger OnInsert()
    begin
        //  >> CUS002
        "Sales Type" := "Sales Type"::Purchase;
        "Applied Doc. No." := "Document No.";
        //  << CUS002
        //Cu006
        "Planning Flexibility" := "Planning Flexibility"::None;
        //Cu006
    end;


    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Document Type" = "Document Type"::"Blanket Order") AND
       ((Type <> xRec.Type) OR ("No." <> xRec."No."))
    THEN BEGIN
    #4..13

    IF ((Quantity <> 0) OR (xRec.Quantity <> 0)) AND ItemExists(xRec."No.") THEN
      ReservePurchLine.VerifyChange(Rec,xRec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..16
    //  >>  CUS001
    PurchHeader.RESET;
    PurchHeader.SETRANGE("No.",PurchLine2."Document No.");
    IF PurchHeader."Service Order No."  <>  '' THEN
      PurchLine2."Service Order No."  :=  PurchHeader."Service Order No.";
    //  <<  CUS001
    */
    //end;


    //Unsupported feature: Code Modification on "CheckWarehouse(PROCEDURE 47)".

    //procedure CheckWarehouse();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Prod. Order No." <> '' THEN
      EXIT;
    GetLocation("Location Code");
    #4..79
    END;

    CASE ShowDialog OF
      ShowDialog::Message:
        MESSAGE(Text016 + Text017,DialogText,FIELDCAPTION("Line No."),"Line No.");
      ShowDialog::Error:
        ERROR(Text016,DialogText,FIELDCAPTION("Line No."),"Line No.")
    END;

    HandleDedicatedBin(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..82
      //ShowDialog::Message:
       // MESSAGE(Text016 + Text017,DialogText,FIELDCAPTION("Line No."),"Line No.");
    #85..89
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

    #4..7
    IF ("Location Code" <> '') AND ("No." <> '') THEN BEGIN
      GetLocation("Location Code");
      IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN BEGIN
        WMSManagement.GetDefaultBin("No.","Variant Code","Location Code","Bin Code");
        HandleDedicatedBin(FALSE);
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
        //CS
        WMSManagement.GetDefaultBinUnlock("No.","Variant Code","Location Code","Bin Code");
    #12..14
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

    var
        Item1: Record "Item";
        MnRordQty: Integer;
        Qts: Text;
        Ans: Boolean;
        Qty: Integer;
        Vendor: Record "Vendor";
        ExcgRte: Record "Currency Exchange Rate";
        E: Integer;
        PurchHdr: Record "Purchase Header";
        Reservation: Page "Reservation";
        Text055: Label 'Update minimum reorder Quantity %1 ?';
        PurchHdr1: Record "Purchase Header";
        CurrCode: Code[20];
        PurchHdr2: Record "Purchase Header";
        PurchLne2: Record "Purchase Line";
        Itm1: Record "Item";
        Agency: Code[20];
        "Purch Header": Record "Purchase Header";
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";
        Text1: Label 'Cannot cancel more than the outstanding quantity';
}

