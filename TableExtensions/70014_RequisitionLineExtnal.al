tableextension 70014 "RequisitionLineExtn" extends "Requisition Line"
{
    fields
    {
        field(50000; "Indent No."; Code[250])
        {
            Caption = 'Indent No.';
            DataClassification = ToBeClassified;
        }
        field(50001; "Line No. Ref"; Code[250])
        {
            Caption = 'Line No. Ref';
            DataClassification = ToBeClassified;
        }
        field(50002; "Sales Order No"; Code[250])
        {
            Caption = 'Sales Order No';
            DataClassification = ToBeClassified;
        }
        field(50003; "Branch Reference"; Code[250])
        {
            Caption = 'Branch Reference';
            DataClassification = ToBeClassified;
        }
        field(50004; "Sales Order"; Code[250])
        {
            Caption = 'Sales Order';
            DataClassification = ToBeClassified;
        }
    }
}
