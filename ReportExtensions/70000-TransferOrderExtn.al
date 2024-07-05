reportextension 70000 TransferOrderExtn extends "Transfer Order"
{
    dataset
    {
        add("Transfer Header")
        {
            column(TransferfromCode_TransferHeader; "Transfer-from Code")
            {
            }
            column(TransfertoCode_TransferHeader; "Transfer-to Code")
            {
            }
        }

        add("Transfer Line")
        {
            column(TransferfromCode_TransferLine; "Transfer-from Code")
            {
            }
            column(TransfertoCode_TransferLine; "Transfer-to Code")
            {
            }
        }

    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }
}