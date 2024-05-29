report 50093 "Split Qty"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; "Transfer Line")
        {
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Item_Number; Item_Number)
                {
                    Caption = 'Item Number';
                    Editable = false;
                }
                field(Current_Quantity; Current_Quantity)
                {
                    Caption = 'Current Quantity';
                    Editable = false;
                }
                field("Quantity to Split"; Quantity_to_Split)
                {
                    Caption = 'Quantity to Split';

                    trigger OnValidate()
                    begin
                        Quantity_to_Split := Quantity_to_Split;
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Quantity_to_Split: Decimal;
        Item_Number: Code[30];
        Current_Quantity: Decimal;

    procedure "Return SplitQty"() Split: Decimal
    begin
        EXIT(Quantity_to_Split);
    end;

    procedure "Store Details"("Item No": Code[30]; "Current Qty": Decimal)
    begin
        Item_Number := "Item No";
        Current_Quantity := "Current Qty";
    end;
}

