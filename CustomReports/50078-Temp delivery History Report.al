report 50078 "Temp delivery History Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Temp delivery History Report.rdlc';
    Caption = 'Temporary Delivery Confirmation Report';

    dataset
    {
        dataitem(DataItem1; "Temporary Job Orders")
        {
            DataItemTableView = SORTING("Job Order No", "Job Description", Location);
            RequestFilterFields = "Job Order No";
            column(JobOrderNo_TemporaryJobOrders; "Job Order No")
            {
            }
            column(JobDescription_TemporaryJobOrders; "Job Description")
            {
            }
            column(JobCreationDate_TemporaryJobOrders; "Job Creation Date")
            {
            }
            column(JobStatus_TemporaryJobOrders; "Job Status")
            {
            }
            column(Location_TemporaryJobOrders; Location)
            {
            }
            column(CustomerName_TemporaryJobOrders; "Customer Name")
            {
            }
            column(VehiclePlateNo_TemporaryJobOrders; "Vehicle Plate No")
            {
            }
            column(ModelNo_TemporaryJobOrders; "Model No")
            {
            }
            column(JobCradNo_TemporaryJobOrders; "Job Crad No")
            {
            }
            column(UserName; UserName)
            {
            }
            dataitem(DataItem11; "Temporary Delivery History")
            {
                DataItemLink = "Job Order No." = FIELD("Job Order No");
                DataItemTableView = SORTING("Document No.");
                column(ItemNo_TemporaryDeliveryHistory; "Item No.")
                {
                }
                column(DateofEnquiry_TemporaryDeliveryHistory; "Date of Enquiry")
                {
                }
                column(DocumentNo_TemporaryDeliveryHistory; "Document No.")
                {
                }
                column(Description_TemporaryDeliveryHistory; Description)
                {
                }
                column(LocationCode_TemporaryDeliveryHistory; "Location Code")
                {
                }
                column(Quantity_TemporaryDeliveryHistory; Quantity)
                {
                }
                column(DiscountAmount1_TemporaryDeliveryHistory; DiscountAmount1)
                {
                }
                column(LineAmount_TemporaryDeliveryHistory; "Line Amount")
                {
                }
                column(UnitPrice_TemporaryDeliveryHistory; "Unit Price")
                {
                }
                column(Discount_TemporaryDeliveryHistory; "Discount%")
                {
                }
                column(JobOrderNo_TemporaryDeliveryHistory; "Job Order No.")
                {
                }
                column(JobcardNo_TemporaryDeliveryHistory; "Job card No.")
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
        User: Record User;
        UserName: Text[50];
}

