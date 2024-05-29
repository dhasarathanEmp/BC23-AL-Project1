tableextension 70022 BinContentExtn extends "Bin Content"
{
    fields
    {
        field(50000; "Bin Blocks"; Boolean)
        {
            CalcFormula = Lookup(Bin.Blocks WHERE("Location Code" = FIELD("Location Code"),
                                                   Code = FIELD("Bin Code")));
            Description = 'CS18';
            FieldClass = FlowField;
        }
        field(50001; "Counter sale"; Boolean)
        {
            CalcFormula = Lookup(Bin."Counter sale" WHERE("Location Code" = FIELD("Location Code"),
                                                           Code = FIELD("Bin Code")));
            Caption = 'Counter sale';
            FieldClass = FlowField;
        }
        field(50002; "Dedicated Blocks"; Boolean)
        {
            CalcFormula = Lookup(Bin.Dedicated WHERE("Location Code" = FIELD("Location Code"),
                                                      Code = FIELD("Bin Code")));
            Description = 'CS18';
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50003; DeadBlocks; Boolean)
        {
            CalcFormula = Lookup(Bin.DeadStocks WHERE("Location Code" = FIELD("Location Code"),
                                                       Code = FIELD("Bin Code")));
            Description = 'CS18';
            FieldClass = FlowField;
        }
        field(50004; Discrepancy; Boolean)
        {
            CalcFormula = Lookup(Bin.Discrepancy WHERE("Location Code" = FIELD("Location Code"),
                                                        Code = FIELD("Bin Code")));
            FieldClass = FlowField;
        }
        field(50005; "Temporary Delivery"; Boolean)
        {
            CalcFormula = Lookup(Bin."Temporary Delivery" WHERE("Location Code" = FIELD("Location Code"),
                                                                 Code = FIELD("Bin Code")));
            FieldClass = FlowField;
        }
    }

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: DropDown)".

}

