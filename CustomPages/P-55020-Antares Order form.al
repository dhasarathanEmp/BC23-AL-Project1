page 55020 "Antares Order form"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Antares Form";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Header';
                field("Record Type Header"; Rec."Record Type Header")
                {
                }
                field(Filler; Rec.Filler)
                {
                    Visible = false;
                }
                field(Filler1; Rec.Filler1)
                {
                    Visible = false;
                }
                field(Filler2; Rec.Filler2)
                {
                    Caption = 'End Filler';
                }
                field("Total Length Header"; Rec."Total Length Header")
                {
                }
            }
            group("Sub Header")
            {
                Caption = 'Sub Header';
                field("Record Type Sub Header"; Rec."Record Type Sub Header")
                {
                }
                field("Filler Sub Header"; Rec."Filler Sub Header")
                {
                }
                field("Total Length Sub Header"; Rec."Total Length Sub Header")
                {
                }
            }
            group("Order Item")
            {
                Caption = 'Order Item';
                field("Record Type Order Item"; Rec."Record Type Order Item")
                {
                }
                field("Filler Order Item"; Rec."Filler Order Item")
                {
                }
                field("Total Length Order Item"; Rec."Total Length Order Item")
                {
                }
            }
            group("End OF Record")
            {
                Caption = 'End OF Record';
                field("Record type Eof"; Rec."Record type Eof")
                {
                }
                field("Filler EOF"; Rec."Filler EOF")
                {
                }
                field("Total Length EOF"; Rec."Total Length EOF")
                {
                }
            }
            group("Data Path")
            {
                Caption = 'Data Path';
                field("Data Stored Path"; Rec."Data Stored Path")
                {
                }
            }
            group(Nissan)
            {
                field("Card No"; Rec."Card No")
                {
                    Caption = 'Header Card No';
                }
                field("Company Code"; Rec."Company Code")
                {
                }
                field("Supply source code"; Rec."Supply source code")
                {
                }
                field("Buyer Code"; Rec."Buyer Code")
                {
                }
                field("Card No Body"; Rec."Card No Body")
                {
                    Caption = 'Line Card No';
                }
                field("Order No"; Rec."Order No")
                {
                }
                field("Country Code"; Rec."Country Code")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        ServerFileName: Text;
        Sheetname: Text;
        FileManagement: Codeunit "File Management";
        ExcelBuffer: Record "Excel Buffer";
        ExcelBuffer1: Record "Excel Buffer";
        FileName: Text;
        Text001: Label 'NAV File Browser';
}

