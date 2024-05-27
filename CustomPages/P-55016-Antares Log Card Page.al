page 55016 "Antares Log Card Page"
{
    PageType = Document;
    SourceTable = "Antares Log File";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Conversion Date &Time"; Rec."Conversion Date &Time")
                {
                }
                field("User Id"; Rec."User Id")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Operator (User Name)"; Rec."Operator (User Name)")
                {
                }
                field("Po Date"; Rec."Po Date")
                {
                }
                field("Order Class"; Rec."Order Class")
                {
                }
                field("Customer Code"; Rec."Customer Code")
                {
                }
                field("Customer Reference Number"; Rec."Customer Reference Number")
                {
                }
                field("Antares Order Profile"; Rec."Antares Order Profile")
                {
                }
                field("Acknowledgment Type"; Rec."Acknowledgment Type")
                {
                }
                field("Antares Order Entry"; Rec."Antares Order Entry")
                {
                }
                field("Antares No."; Rec."Antares No.")
                {
                }
            }
            part(AntaresErrorLogList; "Antares Error Log List")
            {
                SubPageLink = "Document No." = FIELD("Purchase Order No."),
                              "No." = FIELD("Antares No.");
            }
        }
    }

    actions
    {
    }
}

