table 60001 "Quote Template"
{
    // CS13 19/7/18 Report Template - New table

    LookupPageID = 55004;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; "Document Introduction"; BLOB)
        {
            SubType = Memo;
        }
        field(3; "Document Conclusion"; BLOB)
        {
        }
        field(4; Description; Text[50])
        {
        }
        field(5; "Quote Template No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DocumentIntroduction: Text;
        SalesHeader: Record "Sales Header";

    procedure SetWorkDescription(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Document Introduction");
        "Document Introduction".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify();
    end;

    procedure GetWorkDescription() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Document Introduction");
        "Document Introduction".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Document Introduction")));
    end;

    procedure SetWorkDescription1(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Document Conclusion");
        "Document Conclusion".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify();
    end;

    procedure GetWorkDescription1() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Document Conclusion");
        "Document Conclusion".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Document Conclusion")));
    end;
}
