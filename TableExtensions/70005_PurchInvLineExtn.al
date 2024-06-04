tableextension 70005 PurchInvLineExtn extends "Purch. Inv. Line"
{
    fields
    {
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
    }
}

