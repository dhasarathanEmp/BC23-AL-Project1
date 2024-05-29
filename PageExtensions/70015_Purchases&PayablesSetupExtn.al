pageextension 70015 PurchasesPayablesSetupExtn extends "Purchases & Payables Setup"
{
    layout
    {

        //Unsupported feature: Property Modification (SourceExpr) on "Control 62".

        addafter("Ignore Updated Addresses")
        {
            field("Requisition Type"; Rec."Requisition Type")
            {
            }
            field("Enable Cal AFZ Free Stock Actn"; Rec."Enable Cal AFZ Free Stock Actn")
            {
            }
        }
        addafter("Posted Credit Memo Nos.")
        {
            field(DiscrepancyNo; Rec.DiscrepancyNo)
            {
            }
            field("Antares No Series"; Rec."Antares No Series")
            {
            }
            field("Antares Line"; Rec."Antares Line")
            {
            }
        }
    }
}

