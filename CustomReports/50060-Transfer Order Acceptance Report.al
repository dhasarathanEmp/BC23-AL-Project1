report 50060 "Transfer order1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Transfer order1.rdlc';
    Caption = 'Transfer order';

    dataset
    {
        dataitem(DataItem1; "Transfer Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(No_TransferHeader; "No.")
            {
            }
            column(TransferfromCode_TransferHeader; "Transfer-from Code")
            {
            }
            column(TransferfromName_TransferHeader; "Transfer-from Name")
            {
            }
            column(TransferfromName2_TransferHeader; "Transfer-from Name 2")
            {
            }
            column(TransferfromAddress_TransferHeader; "Transfer-from Address")
            {
            }
            column(TransferfromAddress2_TransferHeader; "Transfer-from Address 2")
            {
            }
            column(TransferfromPostCode_TransferHeader; "Transfer-from Post Code")
            {
            }
            column(TransferfromCity_TransferHeader; "Transfer-from City")
            {
            }
            column(TransferfromCounty_TransferHeader; "Transfer-from County")
            {
            }
            column(TrsffromCountryRegionCode_TransferHeader; "Trsf.-from Country/Region Code")
            {
            }
            column(TransfertoCode_TransferHeader; "Transfer-to Code")
            {
            }
            column(TransfertoName_TransferHeader; "Transfer-to Name")
            {
            }
            column(TransfertoName2_TransferHeader; "Transfer-to Name 2")
            {
            }
            column(TransfertoAddress_TransferHeader; "Transfer-to Address")
            {
            }
            column(TransfertoAddress2_TransferHeader; "Transfer-to Address 2")
            {
            }
            column(TransfertoPostCode_TransferHeader; "Transfer-to Post Code")
            {
            }
            column(TransfertoCity_TransferHeader; "Transfer-to City")
            {
            }
            column(TransfertoCounty_TransferHeader; "Transfer-to County")
            {
            }
            column(TrsftoCountryRegionCode_TransferHeader; "Trsf.-to Country/Region Code")
            {
            }
            column(PostingDate_TransferHeader; "Posting Date")
            {
            }
            column(ShipmentDate_TransferHeader; "Shipment Date")
            {
            }
            column(ReceiptDate_TransferHeader; "Receipt Date")
            {
            }
            column(Status_TransferHeader; Status)
            {
            }
            column(Comment_TransferHeader; Comment)
            {
            }
            column(ShortcutDimension1Code_TransferHeader; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_TransferHeader; "Shortcut Dimension 2 Code")
            {
            }
            column(InTransitCode_TransferHeader; "In-Transit Code")
            {
            }
            column(NoSeries_TransferHeader; "No. Series")
            {
            }
            column(LastShipmentNo_TransferHeader; "Last Shipment No.")
            {
            }
            column(LastReceiptNo_TransferHeader; "Last Receipt No.")
            {
            }
            column(TransferfromContact_TransferHeader; "Transfer-from Contact")
            {
            }
            column(ExternalDocumentNo_TransferHeader; "External Document No.")
            {
            }
            column(LocName; LocName)
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; Address2)
            {
            }
            column(City; City)
            {
            }
            column(PhoneNo; PhoneNo)
            {
            }
            column(TRNo; TRNo)
            {
            }
            column(County; County)
            {
            }
            column(UserName; UserName)
            {
            }
            column(ItemCategoryDesc; ItemCategoryDesc)
            {
            }
            column(CompanyInformationPicture; CompanyInformation.Picture)
            {
            }
            column(CompanyInformationName; CompanyInformation.Name)
            {
            }
            column(Serialno; Serialno)
            {
            }
            dataitem(DataItem34; "Transfer Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(ShippedQty_TransferLine; "ShippedQty.")
                {
                }
                column(DocumentNo_TransferLine; "Document No.")
                {
                }
                column(LineNo_TransferLine; "Line No.")
                {
                }
                column(ItemNo_TransferLine; "Item No.")
                {
                }
                column(DerivedFromLineNo_TransferLine; "Derived From Line No.")
                {
                }
                column(Quantity_TransferLine; Quantity)
                {
                }
                column(QtytoShip_TransferLine; "Qty. to Ship")
                {
                }
                column(QtytoReceive_TransferLine; "Qty. to Receive")
                {
                }
                column(QuantityBase_TransferLine; "Quantity (Base)")
                {
                }
                column(OutstandingQtyBase_TransferLine; "Outstanding Qty. (Base)")
                {
                }
                column(Description_TransferLine; Description)
                {
                }
                column(Itemno1; Itemno1)
                {
                }
                column(ItemDes; ItemDes)
                {
                }
                column(Qty2; Qty2)
                {
                }
                column(Qty1; Qty1)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    Location.RESET;
                    Location.SETRANGE(Code, "Transfer Header"."Transfer-from Code");
                    IF Location.FINDFIRST THEN BEGIN
                        LocName := Location.Name;
                        Address := DELCHR(Location.Address, '<>', ' ');
                        Address2 := Location."Address 2";
                        City := Location.City;
                        County := Location.County;
                        PhoneNo := Location."Phone No.";
                        TRNo := Location."Name 2";
                    END;
                    CLEAR(Itemno1);
                    CLEAR(ItemDes);
                    CLEAR(Qty1);
                    CLEAR(Qty2);
                    IF "Transfer Line"."Derived From Line No." = 0 THEN BEGIN
                        Serialno += 1;
                        Itemno1 := "Transfer Line"."Item No.";
                        ItemDes := "Transfer Line".Description;
                        Qty1 := "Transfer Line"."ShippedQty.";
                        Qty2 := "Transfer Line".Quantity;
                    END;
                    itemCategory.RESET;
                    IF itemCategory.GET("Transfer Line"."Item Category Code") THEN
                        ItemCategoryDesc := itemCategory.Description;
                end;

                trigger OnPreDataItem()
                begin
                    Serialno := 0;
                end;
            }
            dataitem(DataItem53; "Company Information")
            {
                column(Name_CompanyInformation; Name)
                {
                }
                column(VATRegistrationNo_CompanyInformation; "VAT Registration No.")
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

    trigger OnInitReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        Location: Record Location;
        LocName: Text[50];
        Address: Text;
        Address2: Text;
        City: Text;
        PhoneNo: Text;
        itemCategory: Record "Item Category";
        ItemCategoryDesc: Text[50];
        County: Text;
        User: Record User;
        UserName: Text;
        TRNo: Text;
        CountryRegion: Record "Country/Region";
        CountryRegion1: Text;
        CompanyInformation: Record "Company Information";
        Serialno: Integer;
        Itemno1: Code[20];
        ItemDes: Text;
        Qty1: Integer;
        Qty2: Integer;
        "Transfer Header": Record "Transfer Header";
        "Transfer Line": Record "Transfer Line";
}

