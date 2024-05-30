tableextension 70017 GeneralJournalLineExtn extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CS01';
            OptionMembers = " ",Sales,Service,Purchase;
        }
        field(50001; "Applied Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS001';
        }
        field(50002; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CS01';
        }
        field(50003; "Contact Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS008';
        }
        field(50004; "Contact No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS008';
        }
        field(50005; "Cs.Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS008';
        }
        field(50006; "CS Vat"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
                UserSetupMgmt: Codeunit "User Setup Management";
            begin
                IF "Source Code" = 'CASHRECJNL' THEN BEGIN
                    CLEAR(UserSetupMgmt);
                    IF (UserSetupMgmt.GetSalesFilter <> '') AND (UserSetupMgmt.GetServiceFilter = '') THEN BEGIN
                        "Sales Type" := "Sales Type"::Sales;
                        "Responsibility Center" := UserSetupMgmt.GetSalesFilter;
                    END
                    ELSE BEGIN
                        IF (UserSetupMgmt.GetSalesFilter = '') AND (UserSetupMgmt.GetServiceFilter <> '') THEN BEGIN
                            "Sales Type" := "Sales Type"::Service;
                            "Responsibility Center" := UserSetupMgmt.GetServiceFilter;
                        END;
                    END;
                END;
            end;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}