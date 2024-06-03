table 60050 "Back Orders Tracking"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Order Number"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Cus/Ven Number"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Location Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Agency Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Part Number"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Part Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Reservation Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Back Orders Tracking"."Reservation Type";
        }
        field(9; "Order Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Shipped/Received Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Outstanding Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Reserved Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Res Branch Free Stock Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "SO/AO Res Against TO Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Res HO Free Stock Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Unreserved Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Order Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Comments; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; UOM; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Sub Order Number"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(21; "Assembly Outstn Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Transfer Outstn Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Purchase Outstn Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "SO Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Sales Outstn Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Transfer UnReserved Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "TO Res Against PO Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "TO Res Against SO Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EMP108.24';
        }
        field(29; "Transfer Qty in-transit Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "SO Res Against PO Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Assembly Res Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "PO Reserved Against TO"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EMP108.24';
        }
        field(33; "PO Reserved Against SO"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EMP108.24';
        }
        field(34; "PO Reserved Against AO"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EMP108.24';
        }
        field(35; "TO Res Against AO Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EMP108.24';
        }
        field(36; "Customer Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Vendor Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

