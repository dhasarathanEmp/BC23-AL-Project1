table 60031 "Temporary Delivery History"
{
    // CS02 16-01-18 OnInsert -No. Series generation for Counter Sales Customization
    // CUS008 2/6/18 Creating For 2 Fieldes Cash And CashDocument No.
    // CUS009 2/6/18 5021 Added Field Currency Code
    // CUS016 09/06/18 addind Fields Vpn no(50006),Vehicle Plate No.(50007), Service item no(50008), Service item name(50009) using for report.

    Caption = 'Temporary Delivery History';

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template";
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;

            trigger OnValidate()
            var
                ProdOrderLine: Record "Prod. Order Line";
                ProdOrderComp: Record "Prod. Order Component";
            begin
                //Rec."VAT Bus" := 'VAT-DOM';
                //Rec.VALIDATE("VAT Bus");
            end;
        }
        field(4; "Date of Enquiry"; Date)
        {
        }
        field(5; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(9; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(13; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                CallWhseCheck: Boolean;
            begin
            end;
        }
        field(22; DiscountAmount1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Source Code";
        }
        field(41; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(42; "Reason for Cancel"; Code[10])
        {
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';

            trigger OnValidate()
            var
                ProdOrderComp: Record "Prod. Order Component";
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
            end;
        }
        field(5406; "New Bin Code"; Code[20])
        {
            Caption = 'New Bin Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
            end;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5704; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(50007; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CS02';
        }
        field(50013; "Line Amount"; Decimal)
        {
        }
        field(50014; "Unit Price"; Decimal)
        {
        }
        field(50024; "Service Item No."; Code[20])
        {
            Description = 'CUS016';
        }
        field(50025; "Service Item Name"; Text[50])
        {
            Description = 'CUS016';
        }
        field(50027; "Available Quantity"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                VALIDATE(Quantity);
            end;
        }
        field(50028; "Discount%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "VAT Bus"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS008';
            TableRelation = "VAT Business Posting Group".Code;
        }
        field(50032; "VAT Prod"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(50036; "Job Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Temporary Job Orders"."Job Order No";
        }
        field(50037; "Job Order Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Job Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,On Job,Completed';
            OptionMembers = Open,"On Job",Completed;
        }
        field(50039; "Job card No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //  >>  CS02
        InitSeries;
        //  <<  CS02
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Record "No. Series";
        Item: Record Item;
        amount1: Integer;
        TemporaryDeliveryHistory: Record "Temporary Delivery History";

    local procedure InitSeries()
    begin
        //  >>  CS02
        TemporaryDeliveryHistory.RESET;
        IF TemporaryDeliveryHistory.FINDLAST THEN
            Rec."Entry No." := TemporaryDeliveryHistory."Entry No." + 1
        ELSE
            Rec."Entry No." := 1;
        //  <<  CS02
    end;
}

