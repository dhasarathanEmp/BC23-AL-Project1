pageextension 70022 SalesOrderSubformExtn extends "Sales Order Subform"
{

    layout
    {
        addafter("No.")
        {
            field(Ordered_Part_No; Rec.Ordered_Part_No)
            {

            }
            field("Customer Serial No"; Rec."Customer Serial No")
            {
                Caption = 'Purchase Order Serial No';
            }
        }

        //Unit price is editable if type is service item
        modify("No.")
        {
            trigger OnBeforeValidate()
            begin
                Item.Reset();
                if Item.Get(Rec."No.") then begin
                    if Item.Type = Item.Type::Service then
                        PriceEditable := true
                    else
                        PriceEditable := false;
                end;

                //Message through if it's a hose item
                Item.Reset();
                Item.SetRange("No.", Rec."No.");
                Item.SetRange("Hose Main item", true);
                if Item.FindFirst() then begin
                    SalesLine.Reset();
                    SalesLine.SetRange("No.", Rec."No.");
                    SalesLine.SetRange(Type, SalesLine.Type::Item);
                    if SalesLine.FindFirst() then
                        Message('The chosen item is a Hose Main Item');
                end;
                //Message through if it's a hose item

            end;
            //Unit price is editable if type is service item

        }
        modify("Unit Price")
        {
            Editable = PriceEditable;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        Item: Record Item;
        PriceEditable: Boolean;
        SalesLine: Record "Sales Line";


    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Item.Reset();
        if Item.Get(Rec."No.") then begin
            if Item.Type = Item.Type::Service then
                PriceEditable := true
            else
                PriceEditable := false;
        end;
    end;
}