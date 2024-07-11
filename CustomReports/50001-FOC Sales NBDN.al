report 50001 "FOC Sales NBDN"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FOC Sales NBDN.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem1; "Item Journal Line")
        {
            column(PostingDate_ItemJournalLine; "Posting Date")
            {
            }
            column(DocumentNo_ItemJournalLine; "Document No.")
            {
            }
            column(LocationCode_ItemJournalLine; "Location Code")
            {
            }
            column(DefaultPriceUnit_ItemJournalLine; "Default Price/Unit")
            {
            }
            column(Quantity_ItemJournalLine; Quantity)
            {
            }
            column(CustomerNo_ItemJournalLine; "CustomerNo.")
            {
            }
            column(CustomerName1_ItemJournalLine; "Customer Name1")
            {
            }
            column(ItemNo_ItemJournalLine; "Item No.")
            {
            }
            column(Description_ItemJournalLine; Description)
            {
            }
            column(Document_Date; Document_Date)
            {
            }
            column(Company_Name; CompanyInformation.Name)
            {
            }
            column(Company_PhoneNumber; CompanyInformation."Phone No.")
            {
            }
            column(Company_Address; CompanyInformation.Address)
            {
            }
            column(Company_City; CompanyInformation.City)
            {
            }
            column(Company_VAT; CompanyInformation."VAT Registration No.")
            {
            }
            column(PrintedBy; PrintedBy)
            {
            }
            column(CusAddress; CusAddress)
            {
            }
            column(Company_Logo; CompanyInformation.Picture)
            {
            }
            column(FromTRNo; FromTRNo)
            {
            }
            column(YourReference_ItemJournalLine; Remark)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Document_Date := TODAY;
                IF LoopControl = 0 THEN BEGIN
                    LoopControl += 1;
                    Customer.SETRANGE("No.", "Item Journal Line"."CustomerNo.");
                    IF Customer.FINDFIRST THEN
                        CusAddress := Customer.Address + ',' + Customer."Post Code" + ',' + Customer.City;
                END
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

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
        User.RESET;
        User.SETRANGE("User Name", USERID);
        IF User.FINDFIRST THEN
            PrintedBy := User."Full Name";

        Location.SETRANGE(Code, 'HOD-HO');
        IF Location.FINDLAST THEN
            FromTRNo := Location."Name 2";
    end;

    var
        Document_Date: Date;
        CompanyInformation: Record "Company Information";
        User: Record User;
        PrintedBy: Text;
        Customer: Record Customer;
        LoopControl: Integer;
        CusAddress: Text;
        Location: Record Location;
        FromTRNo: Text;
        "Item Journal Line": Record "Item Journal Line";
}

