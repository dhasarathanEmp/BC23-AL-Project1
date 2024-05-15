table 60024 "Integration Parameters"
{

    fields
    {
        field(1; "Purch. Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(2; "Sales Unit of Measure"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code;
        }
        field(3; "General Product Posting Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(4; "VAT Product Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(5; "Inventory Posting Group"; Code[10])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(6; "Item Type"; Option)
        {
            OptionMembers = " ","E-PS Parts","Auto Parts","Prime Product";
        }
        field(7; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
        }
        field(8; "Price/ Profit Calculation"; Option)
        {
            OptionMembers = "Profit=Price-Cost","Price=Cost+Profit","No Relationship";
        }
        field(9; "Agency Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(10; "Reordering Policy"; Option)
        {
            OptionMembers = " ","Fixed Reorder Qty.","Maximum Qty.","Order","Lot-for-Lot";
        }
        field(11; "Order Tracking Policy"; Option)
        {
            OptionMembers = "None","Tracking Only","Tracking & Action Msg.";
        }
        field(12; "Reordering Point"; Decimal)
        {
        }
        field(13; "Reorder Quantity"; Decimal)
        {
        }
        field(14; "Inventory Factor"; Decimal)
        {
        }
        field(15; "Sales Price Factor"; Decimal)
        {
        }
        field(16; "Core Charges"; Decimal)
        {
        }
        field(17; "Prevent Negative Inventory"; Option)
        {
            OptionMembers = Default,No,Yes;
        }
        field(18; "Nissan Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UnitOfMeasure: Record "Unit of Measure";
            begin
            end;
        }
        field(19; "Nissan Purch. Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(20; "Nissan Sales Unit of Measure"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code;
        }
        field(21; "NissanGeneral Prod. Post Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(22; "Nissan VAT Prod. Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(23; "Nissan Inventory Posting Group"; Code[10])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(24; "Nissan Item Type"; Option)
        {
            OptionMembers = " ","E-PS Parts","Auto Parts","Prime Product";
        }
        field(25; "Nissan Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
        }
        field(26; "NissanPrice/ ProfitCalculation"; Option)
        {
            OptionMembers = "Profit=Price-Cost","Price=Cost+Profit","No Relationship";
        }
        field(27; "Nissan Agency Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(28; "Nissan Reordering Policy"; Option)
        {
            OptionMembers = " ","Fixed Reorder Qty.","Maximum Qty.","Order","Lot-for-Lot";
        }
        field(29; "Nissan Order Tracking Policy"; Option)
        {
            OptionMembers = "None","Tracking Only","Tracking & Action Msg.";
        }
        field(30; "Nissan Reordering Point"; Decimal)
        {
        }
        field(31; "Nissan Reorder Quantity"; Decimal)
        {
        }
        field(32; "Nissan Inventory Factor"; Decimal)
        {
        }
        field(33; "Nissan Sales Price Factor"; Decimal)
        {
        }
        field(34; "Nissan Core Charges"; Decimal)
        {
        }
        field(35; "Nissan Prevent Negative Int."; Option)
        {
            OptionMembers = Default,No,Yes;
        }
        field(36; "FGW  Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UnitOfMeasure: Record "Unit of Measure";
            begin
            end;
        }
        field(37; "FGW Purch. Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(38; "FGW Sales Unit of Measure"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code;
        }
        field(39; "FGW General Prod. Post Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(40; "FGW VAT Prod. Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(41; "FGW Inventory Posting Group"; Code[10])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(42; "FGW Item Type"; Option)
        {
            OptionMembers = " ","E-PS Parts","Auto Parts","Prime Product";
        }
        field(43; "FGW Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
        }
        field(44; "FGW Price/ ProfitCalculation"; Option)
        {
            OptionMembers = "Profit=Price-Cost","Price=Cost+Profit","No Relationship";
        }
        field(45; "FGW Agency Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(46; "FGW Reordering Policy"; Option)
        {
            OptionMembers = " ","Fixed Reorder Qty.","Maximum Qty.","Order","Lot-for-Lot";
        }
        field(47; "FGW Order Tracking Policy"; Option)
        {
            OptionMembers = "None","Tracking Only","Tracking & Action Msg.";
        }
        field(48; "FGW Reordering Point"; Decimal)
        {
        }
        field(49; "FGW Reorder Quantity"; Decimal)
        {
        }
        field(50; "FGW Inventory Factor"; Decimal)
        {
        }
        field(51; "FGW Sales Price Factor"; Decimal)
        {
        }
        field(52; "FGW Core Charges"; Decimal)
        {
        }
        field(53; "FGW Prevent Negative Int."; Option)
        {
            OptionMembers = Default,No,Yes;
        }
        field(54; "Pgt  Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UnitOfMeasure: Record "Unit of Measure";
            begin
            end;
        }
        field(55; "Pgt  Purch. Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(56; "Pgt Sales Unit of Measure"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code;
        }
        field(57; "Pgt General Prod. Post Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(58; "Pgt VAT Prod. Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(59; "Pgt Inventory Posting Group"; Code[10])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(60; "Pgt Item Type"; Option)
        {
            OptionMembers = " ","E-PS Parts","Auto Parts","Prime Product";
        }
        field(61; "Pgt Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
        }
        field(62; "Pgt Price/ ProfitCalculation"; Option)
        {
            OptionMembers = "Profit=Price-Cost","Price=Cost+Profit","No Relationship";
        }
        field(63; "Pgt Agency Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(64; "Pgt  Reordering Policy"; Option)
        {
            OptionMembers = " ","Fixed Reorder Qty.","Maximum Qty.","Order","Lot-for-Lot";
        }
        field(65; "Pgt Order Tracking Policy"; Option)
        {
            OptionMembers = "None","Tracking Only","Tracking & Action Msg.";
        }
        field(66; "Pgt  Reordering Point"; Decimal)
        {
        }
        field(67; "Pgt  Reorder Quantity"; Decimal)
        {
        }
        field(68; "Pgt  Inventory Factor"; Decimal)
        {
        }
        field(69; "Pgt Sales Price Factor"; Decimal)
        {
        }
        field(70; "Pgt Core Charges"; Decimal)
        {
        }
        field(71; "Pgt Prevent Negative Int."; Option)
        {
            OptionMembers = Default,No,Yes;
        }
        field(72; "MF Purch. Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(73; "MF Sales Unit of Measure"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code;
        }
        field(74; "MF General Prod Posting Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(75; "MF VAT Product Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(76; "MF Inventory Posting Group"; Code[10])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(77; "MF Item Type"; Option)
        {
            OptionMembers = " ","E-PS Partes","Auto Parts","Prime Product";
        }
        field(78; "MF Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
        }
        field(79; "MF Price/ Profit Calculation"; Option)
        {
            OptionMembers = "Profit=Price-Cost","Price=Cost+Profit","No Relationship";
        }
        field(80; "MF Agency Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(81; "MF Reordering Policy"; Option)
        {
            OptionMembers = " ","Fixed Reorder Qty.","Maximum Qty.","Order","Lot-for-Lot";
        }
        field(82; "MF Order Tracking Policy"; Option)
        {
            OptionMembers = "None","Tracking Only","Tracking & Action Msg.";
        }
        field(83; "MF Reordering Point"; Decimal)
        {
        }
        field(84; "MF Reorder Quantity"; Decimal)
        {
        }
        field(85; "MF Inventory Factor"; Decimal)
        {
        }
        field(86; "MF Sales Price Factor"; Decimal)
        {
        }
        field(87; "MF Core Charges"; Decimal)
        {
        }
        field(89; "MF Prevent Negative Inventory"; Option)
        {
            OptionMembers = Default,No,Yes;
        }
        field(90; "MCFE Base unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(91; "MCFE Purch. Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(92; "MCFE Sales Unit of Measure"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code;
        }
        field(93; "MCFE General Prod. Post Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(94; "MCFE VAT Prod. Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(95; "MCFE Inventory Posting Group"; Code[10])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(96; "MCFE Item Type"; Option)
        {
            OptionMembers = " ","E-PS Parts","Auto Parts","Prime Product";
        }
        field(97; "MCFE Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
        }
        field(98; "MCFE Price/ ProfitCalculation"; Option)
        {
            OptionMembers = "Profit=Price-Cost","Price=Cost+Profit","No Relationship";
        }
        field(99; "MCFE Agency Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(100; "MCFE  Reordering Policy"; Option)
        {
            OptionMembers = " ","Fixed Reorder Qty.","Maximum Qty.","Order","Lot-for-Lot";
        }
        field(101; "MCFE Order Tracking Policy"; Option)
        {
            OptionMembers = "None","Tracking Only","Tracking & Action Msg.";
        }
        field(102; "MCFE  Reordering Point"; Decimal)
        {
        }
        field(103; "MCFE  Reorder Quantity"; Decimal)
        {
        }
        field(104; "MCFE Inventory Factor"; Decimal)
        {
        }
        field(105; "MCFE Sales Price Factor"; Decimal)
        {
        }
        field(106; "MCFE Core Charges"; Decimal)
        {
        }
        field(107; "MCF Prevent Negative Inventory"; Option)
        {
            OptionMembers = Default,No,Yes;
        }
        field(108; "Base unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(109; NPR; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(110; "FG-Wilson"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(111; MCFE; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(112; Nissan; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(113; Peugeot; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(114; "Costing Method"; Option)
        {
            Caption = 'Costing Method';
            DataClassification = ToBeClassified;
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(115; "FGW Costing Method"; Option)
        {
            Caption = 'Costing Method';
            DataClassification = ToBeClassified;
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(116; "pgt Costing Method"; Option)
        {
            Caption = 'Costing Method';
            DataClassification = ToBeClassified;
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(117; "MCFE Costing Method"; Option)
        {
            Caption = 'Costing Method';
            DataClassification = ToBeClassified;
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(118; "Nissan Costing Method"; Option)
        {
            Caption = 'Costing Method';
            DataClassification = ToBeClassified;
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(119; "Vendor No.1"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(120; "FGW Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(121; "Pgt Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(122; "MCFE Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(123; "Nissan Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(124; "Nissan Purchase Price Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(125; "Weekly Price Update File Path"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(126; "Weekly Price Update Archives"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(127; "Weekly Price Update Day"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'None,Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday';
            OptionMembers = "None",Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;
        }
        field(128; "Vendor No.2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(129; "IC Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(130; MF; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(131; "MF Base unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(132; "MF Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(133; "MF Costing Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
    }

    keys
    {
        key(Key1; "Purch. Unit of Measure")
        {
        }
    }

    fieldgroups
    {
    }
}

