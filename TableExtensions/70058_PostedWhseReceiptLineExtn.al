tableextension 70058 PostedWhseReceiptLineExtn extends "Posted Whse. Receipt Line"
{
    fields
    {
        field(50000; "Vendor Invoice Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50001; SalesInvNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CS90';
        }
        field(50002; DiscrepancyNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS022';
        }
        field(50003; SaleInvLineNo; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CS90';
        }
        field(50004; ApplyFromItemEntry; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CS90';
        }
        field(50005; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; Remarks; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Empty,Damage,Missing';
            OptionMembers = " ",Damage,Missing;
        }
        field(50008; Excess; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Country/Region Code"; Code[50])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            begin
                //PostCode.CheckClearPostCodeCityCounty(City,"Post Code",County,"Country/Region Code",xRec."Country/Region Code");
            end;
        }
        field(50015; "Serial No"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Cu012';
        }
        field(50017; "HS Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Default Price/Unit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50019; "Agency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
    }
}

