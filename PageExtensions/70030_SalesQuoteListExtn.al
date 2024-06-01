pageextension 70030 SalesQuoteListExtn extends "Sales Quotes"
{
    layout
    {

    }

    actions
    {
        modify(Print)
        {
            Enabled = Printenabled;
        }


        modify(Reopen)
        {
            Enabled = ReleaseEnabled;

            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                IF Rec.Status = Rec.Status::Released THEN
                    PrintEnabled := TRUE
                ELSE
                    PrintEnabled := FALSE;

                IF Rec."Version No." = '' THEN
                    Rec."Version No." := 'REV0000001'
                ELSE BEGIN
                    Rec."Version No." := INCSTR(Rec."Version No.");
                    Rec."Latest Version Date" := WORKDATE;
                    Rec.Modify();
                END
            END
        }
    }

    trigger OnOpenPage()
    begin
        IF Rec.Status = Rec.Status::Released THEN
            Printenabled := TRUE
        ELSE
            Printenabled := FALSE;
    end;

    var
        myInt: Integer;
        Printenabled: Boolean;

    trigger OnAfterGetRecord()
    begin
        IF Rec.Status = Rec.Status::Released THEN
            Printenabled := TRUE
        ELSE
            Printenabled := FALSE;
    end;
}