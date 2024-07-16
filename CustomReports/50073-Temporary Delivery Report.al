report 50073 "Temporary Delivery Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Temporary Delivery Report.rdlc';
    Caption = 'Delivery Order';

    dataset
    {
        dataitem(DataItem1; "Item Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.");
            RequestFilterFields = "Document No.", "Item No.";
            column(JobOrderNo_ItemJournalLine; "Job Order No.")
            {
            }
            column(JobOrderDescription_ItemJournalLine; "Job Order Description")
            {
            }
            column(ServiceOrder_ItemJournalLine; "Service Order")
            {
            }
            column(DocumentNo_ItemJournalLine; "Document No.")
            {
            }
            column(BinCode_ItemJournalLine; "Bin Code")
            {
            }
            column(ItemNo_ItemJournalLine; "Item No.")
            {
            }
            column(Description_ItemJournalLine; Description)
            {
            }
            column(QuantityBase_ItemJournalLine; "Quantity (Base)")
            {
            }
            column(ItemCategoryCode_ItemJournalLine; "Item Category Code")
            {
            }
            column(UserName; UserName)
            {
            }
            column(PostingDate_ItemJournalLine; "Posting Date")
            {
            }
            dataitem(DataItem9; "Company Information")
            {
                column(Name_CompanyInformation; Name)
                {
                }
                column(Address_CompanyInformation; Address)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                User.RESET;
                User.SETRANGE("User Name", USERID);
                IF User.FINDFIRST THEN
                    UserName := User."Full Name";
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
        Amount: Decimal;
        Location: Record Location;
        LocName: Text[50];
        SerialNo: Integer;
        Curr: Code[20];
        PostedWhseShipmentLine: Record "Posted Whse. Shipment Line";
        DocNo: Code[20];
        Company: Record Company;
        Division: Text;
        User: Record User;
        LocAddress: Text;
        LocAddress2: Text;
        LocCity: Text;
        LOCPhone: Text;
        LocFaxNo: Text;
        LocCountry: Text;
        LocPostcode: Text;
        UserName: Text;
        CountryRegion: Record "Country/Region";
        CountryRegion1: Text;
}

