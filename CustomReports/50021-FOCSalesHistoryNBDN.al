report 50021 "FOC NBDN History"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FOC NBDN History.rdlc';

    dataset
    {
        dataitem("FOC Sales History"; "FOC Sales History")
        {
            RequestFilterFields = "Document No";
            column(PostingDate_FOCSalesHistory; "FOC Sales History"."Posting Date")
            {
            }
            column(DocumentNo_FOCSalesHistory; "FOC Sales History"."Document No")
            {
            }
            column(ItemNo_FOCSalesHistory; "FOC Sales History"."Item No")
            {
            }
            column(Description_FOCSalesHistory; "FOC Sales History".Description)
            {
            }
            column(Quantity_FOCSalesHistory; "FOC Sales History".Quantity)
            {
            }
            column(LocationCode_FOCSalesHistory; "FOC Sales History"."Location Code")
            {
            }
            column(UnitofMeasure_FOCSalesHistory; "FOC Sales History"."Unit of Measure")
            {
            }
            column(CustomerNo_FOCSalesHistory; "FOC Sales History"."Customer No")
            {
            }
            column(CustomerName_FOCSalesHistory; "FOC Sales History"."Customer Name")
            {
            }
            column(BinCode_FOCSalesHistory; "FOC Sales History"."Bin Code")
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
            column(YourReference_FOCSalesHistory; "FOC Sales History".Remark)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Document_Date := TODAY;
                if LoopControl = 0 then begin
                    LoopControl += 1;
                    Customer.SETRANGE("No.", "FOC Sales History"."Customer No");
                    if Customer.FINDFIRST then
                        CusAddress := Customer.Address + ',' + Customer."Post Code" + ',' + Customer.City;
                end
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
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
        if User.FINDFIRST then
            PrintedBy := User."Full Name";

        Location.SETRANGE(Code, 'HOD-HO');
        if Location.FINDLAST then
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
        Document_No: Code[20];
        Location: Record Location;
        FromTRNo: Text;
}

