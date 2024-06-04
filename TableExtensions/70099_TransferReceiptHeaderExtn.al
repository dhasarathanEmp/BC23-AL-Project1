tableextension 70099 TransferReceiptHeaderExtn extends "Transfer Receipt Header"
{
    fields
    {
        field(50000; "Transfer-to Fax No"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50001; "Transfer-From Fax No"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS011';
        }
        field(50004; "Delivery Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS010';
        }
        field(50005; "Discrepancy No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS017';
        }
        field(50006; "ADF Internal Invoice No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS017';
        }
    }
}

