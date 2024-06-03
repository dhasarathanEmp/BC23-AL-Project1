tableextension 70035 LocationExtn extends Location
{
    fields
    {
        modify("Name 2")
        {
            Caption = 'T.R.No';
        }
        field(50000; "Indent No."; Code[10])
        {
            Description = 'Indent No./CS14';
            TableRelation = "No. Series".Code;
        }
        field(50001; IsVisible; Boolean)
        {
            Description = 'CUS021';
        }
        field(50002; "Responsibility Center"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'AFZ002';
        }
    }
}

