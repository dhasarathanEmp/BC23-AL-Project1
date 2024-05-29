pageextension 70017 TransferOrderExtn extends "Transfer Order"
{
    layout
    {
        addafter(Status)
        {
            field("Sales Order Number"; Rec."Sales Order Number")
            {

            }
            field("Agency Code"; Rec."Agency Code")
            {

            }
        }
        addafter("Transfer-from City")
        {
            field("Transfer-From Fax No"; Rec."Transfer-From Fax No")
            {

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    
}