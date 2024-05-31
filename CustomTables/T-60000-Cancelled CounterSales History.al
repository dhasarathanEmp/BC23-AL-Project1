table 60000 "Cancelled CounterSales History"
{
    // CS02 16-01-18 OnInsert -No. Series generation for Counter Sales Customization
    // CUS008 2/6/18 Creating For 2 Fieldes Cash And CashDocument No.
    // CUS009 2/6/18 5021 Added Field Currency Code
    // CUS016 09/06/18 addind Fields Vpn no(50006),Vehicle Plate No.(50007), Service item no(50008), Service item name(50009) using for report.

    Caption = 'Cancelled Counter Sales History';

    fields
    {
        field(2; "Line No."; Integer)
        {

        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;

            trigger OnValidate()
            begin
                Rec."VAT Bus" := 'VAT-DOM';
                Rec.Validate("VAT Bus");
            end;
        }
        field(4; "Date of Enquiry"; Date)
        {
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
        field(42; "Reason for Cancel"; Code[10])
        {
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';

            trigger OnValidate()
            var
            begin
            end;
        }
        field(5406; "New Bin Code"; Code[20])
        {
            Caption = 'New Bin Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
            begin
            end;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = field("Item No."));
        }
        field(5704; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(50004; Status; Option)
        {
            Description = 'CS02';
            OptionMembers = " ",Approved,Cancelled;
        }
        field(50005; Contact; Code[10])
        {
            Description = 'CS02';
            TableRelation = Contact."No.";
        }
        field(50006; "Contact Name"; Text[100])
        {
            Description = 'CS02';
        }
        field(50007; "Entry No."; Integer)
        {
            Description = 'CS02';
        }
        field(50011; "Currency Code1"; Code[10])
        {
            Description = 'YER';
        }
        field(50012; "Currency Factor"; Decimal)
        {
            Description = 'YER';
        }
        field(50013; "Line Amount"; Decimal)
        {
        }
        field(50014; "Unit Price"; Decimal)
        {
        }
        field(50015; Cash; Boolean)
        {
            Description = 'CUS008';
        }
        field(50016; "CashDocument No."; Code[20])
        {
            Description = 'CUS008';
        }
        field(50017; "CustomerNo."; Code[20])
        {
        }
        field(50019; "Customer Name1"; Text[50])
        {
        }
        field(50021; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            Description = 'CUS009';
            TableRelation = Currency;
        }
        field(50022; "VIN No."; Code[20])
        {
            Description = 'CUS016';
            TableRelation = "Service Item"."Serial No.";
        }
        field(50023; "Vehicle Plate No."; Code[50])
        {
            Description = 'CUS016';
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
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                //IF Rec."Discount%" = 0 THEN BEGIN
                /*IJL4.RESET;
                IJL4.SETRANGE("Journal Batch Name",Rec."Journal Batch Name");
                IJL4.SETRANGE("Document No.",Rec."Document No.");
                IF IJL4.FINDSET THEN REPEAT
                  IF IJL4."Discount%" <> 0 THEN
                    ERROR('Discount amount should entered only once');
                UNTIL IJL4.NEXT = 0;*/
                //END;
                /*
                IJL1.RESET;
                IJL1.SETRANGE("Journal Batch Name",Rec."Journal Batch Name");
                IJL1.SETRANGE("Document No.",Rec."Document No.");
                IF IJL1.FINDSET THEN REPEAT
                  BEGIN
                   TotLineAmt += IJL1."Line AmountUP";
                   MESSAGE('%1',TotLineAmt);
                  END;
                UNTIL IJL1.NEXT = 0;
                "Discount Amount" :=
                  ROUND(
                    ROUND(TotLineAmt,Currency."Amount Rounding Precision") *
                   "Discount%" / 100,Currency."Amount Rounding Precision");
                   */

            end;
        }
        field(50029; DiscountAmount; Decimal)
        {
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
        field(50034; "Vehicle Model No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "CR External Reference No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "CashDocument No.")
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
        CounterSales: Record "Cancelled CounterSales History";
        Item: Record Item;
        amount1: Integer;

    local procedure InitSeries()
    begin
        CounterSales.RESET;
        IF CounterSales.FINDLAST THEN
            Rec."Entry No." := CounterSales."Entry No." + 1
        ELSE
            Rec."Entry No." := 1;
    end;
}

