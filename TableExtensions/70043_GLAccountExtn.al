tableextension 70043 GLAccountExtn extends "G/L Account"
{
    fields
    {
        modify("Account Category")
        {
            BlankZero = false;
        }
    }
}

