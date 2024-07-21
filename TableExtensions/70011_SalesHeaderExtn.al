tableextension 70011 SalesHeaderExtn extends "Sales Header"
{
    fields
    {
        field(50000; "Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CS01,CUS001';
            OptionMembers = " ",Sales,Service,Purchase;
        }
        field(50001; "Applied Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
        }
        field(50002; Template; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CS13';
        }
        field(50003; "Customer PO date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
        }
        field(50005; "Branch Ref"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "VIN No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50007; "Vehicle Plate No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50008; "Service Item No."; Code[20])
        {
            Description = 'CUS016';
        }
        field(50009; "Service Item Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS016';
        }
        field(50010; "Invoice Discount%"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS023';
        }
        field(50011; "Price Validate"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS023';

            trigger OnValidate()
            var
                "Price Validatecheck": Integer;
            begin
                IF "Price Validate" <> '' THEN
                    IF NOT EVALUATE("Price Validatecheck", "Price Validate") THEN
                        ERROR('Your entry of %1 is not an acceptable value for Price Validate, %1 is not a valid Integer', "Price Validate");
            end;
        }
        field(50012; "Delivery Terms"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS023';
        }
        field(50013; "CS Prepayment No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "No. Of Packages"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Customer Representative"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Vehicle Model No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Old Quote No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Document Type."; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Credit,Prepayment,Counter Sales,Temporary Delivery';
            OptionMembers = Credit,Prepayment,"Counter Sales","Temporary Delivery";
        }
        field(50019; "CR Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "CR External Reference No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Version No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Cu003';
        }
        field(50022; "Latest Version Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu003';
        }
        field(50023; "SO Version No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "SO Revision Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; Reserved; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; AFZDiscount; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu015';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50027; "Customer PO Total"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu015';
        }
        field(50028; "Agency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                IF "Posting Date" > 20220209D THEN BEGIN
                    SLExist.RESET;
                    SLExist.SETRANGE("Document No.", "No.");
                    IF SLExist.FINDFIRST THEN
                        ERROR('Lines exist, Unable to change Agency untill all the Lines are deleted');
                END
            end;
        }
        field(50029; "Not Shipped Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Outstanding Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                       "Document No." = FIELD("No.")));
            Description = 'MIS1';

        }
        field(50030; "Special Price Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu001';
        }
        field(50031; "Latest Released Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'EMP108.19';
        }
    }
    var
        NoSeries: Record "No. Series";
        InvoiceNo: Code[20];
        CusText001: Label 'Deleting this document will cause a gap in the Posting number series please utilize it for a different order.';
        SalesLineBuf1: Record "Sales Line";
        SalesLineBuf: Record "Sales Line";
        SLExist: Record "Sales Line";


}

