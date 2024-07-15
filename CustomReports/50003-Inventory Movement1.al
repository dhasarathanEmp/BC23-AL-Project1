report 50003 "Inventory Movement1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Inventory Movement1.rdlc';

    dataset
    {
        dataitem(DataItem1; "Item Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Location Code", "Bin Code", "Item No.", "Variant Code", "Document No.";
            column(NewBinCode_ItemJournalLine; "New Bin Code")
            {
            }
            column(UnitofMeasureCode_ItemJournalLine; "Unit of Measure Code")
            {
            }
            column(BinCode_ItemJournalLine; "Bin Code")
            {
            }
            column(NewLocationCode_ItemJournalLine; "New Location Code")
            {
            }
            column(ItemCategoryCode_ItemJournalLine; "Item Category Code")
            {
            }
            column(Quantity_ItemJournalLine; Quantity)
            {
            }
            column(JournalTemplateName_ItemJournalLine; "Journal Template Name")
            {
            }
            column(LineNo_ItemJournalLine; "Line No.")
            {
            }
            column(ItemNo_ItemJournalLine; "Item No.")
            {
            }
            column(PostingDate_ItemJournalLine; "Posting Date")
            {
            }
            column(EntryType_ItemJournalLine; "Entry Type")
            {
            }
            column(DocumentNo_ItemJournalLine; "Document No.")
            {
            }
            column(Description_ItemJournalLine; Description)
            {
            }
            column(LocationCode_ItemJournalLine; "Location Code")
            {
            }
            column(JournalBatchName_ItemJournalLine; "Journal Batch Name")
            {
            }
            column(Batchname; Batchname)
            {
            }
            dataitem(DataItem15; "Company Information")
            {
                column(Name_CompanyInformation; Name)
                {
                }
                column(Name2_CompanyInformation; "Name 2")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                ItemJournalBatch.RESET;
                ItemJournalBatch.SETRANGE("Journal Template Name", "Item Journal Line"."Journal Template Name");
                ItemJournalBatch.SETRANGE(Name, "Item Journal Line"."Journal Batch Name");
                IF ItemJournalBatch.FINDFIRST THEN
                    Batchname := ItemJournalBatch.Description;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ItemJournalBatch: Record "Item Journal Batch";
        Batchname: Text[50];
        "Item Journal Line": Record "Item Journal Line";
}

