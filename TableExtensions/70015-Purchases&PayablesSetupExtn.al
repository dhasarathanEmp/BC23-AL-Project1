tableextension 70015 PurchasesPayablesSetupExtn extends "Purchases & Payables Setup"
{
    fields
    {

        field(50000; DiscrepancyNo; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50001; "Antares No Series"; Code[10])
        {
            Description = 'K19';
            TableRelation = "No. Series";
        }
        field(50002; "Antares Line"; Code[10])
        {
            Description = 'K19';
            TableRelation = "No. Series";
        }
        field(50003; "Requisition Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Calculate Plan","Get Orders";
        }
        field(50004; "Enable Cal AFZ Free Stock Actn"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "JobQueueActive(PROCEDURE 1)".

}

