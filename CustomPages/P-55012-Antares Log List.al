page 55012 "Antares Log List"
{
    CardPageID = "Antares Log Card Page";
    PageType = List;
    SourceTable = "Antares Log File";

    layout
    {
        area(content)
        {
            repeater(Group)
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
        }
    }

    actions
    {
    }
}

