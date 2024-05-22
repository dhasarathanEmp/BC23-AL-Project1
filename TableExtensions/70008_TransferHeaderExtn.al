tableextension 70008 TransferHeaderExtn extends "Transfer Header"
{
    fields
    {
        modify(Status)
        {
            OptionCaption = 'Open,Accepted,Not Accepted';
        }
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
        field(50002; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Order";
        }
        field(50003; "Sales Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Sales,Service,Purchase;
        }
        field(50004; "Delivery Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS010';
        }
        field(50005; "Fully Reserved Outbound"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Created-from-Requisition"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu102';
        }
        field(50007; "Sales Order Number"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EP9619';
            Editable = false;
        }
        field(50008; "Created By"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'EP9619';
        }
        field(50009; "Agency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".
    trigger OnAfterInsert()
    var
    begin
        "Created By" := UserId;
    end;
    //Unsupported feature: Variable Insertion (Variable: StockRequestArchiveLine) (VariableCollection) on "DeleteOneTransferOrder(PROCEDURE 4)".
    //Unsupported feature: Variable Insertion (Variable: StockRequestLine) (VariableCollection) on "DeleteOneTransferOrder(PROCEDURE 4)".
    //Unsupported feature: Code Modification on "DeleteOneTransferOrder(PROCEDURE 4)".
    //procedure DeleteOneTransferOrder();
    //Parameters and return type have not been exported.
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17
    //SR1
    StockRequestLine.RESET;
    StockRequestLine.SETRANGE("Transfer Order No.",TransHeader2."No.");
    StockRequestLine.SETRANGE("Stock Request No.",TransHeader2."Sales Order Number");
    StockRequestLine.SETRANGE(Status,StockRequestLine.Status::Released);
    IF StockRequestLine.FINDSET THEN REPEAT
      StockRequestArchiveLine.INIT;
      StockRequestArchiveLine.TRANSFERFIELDS(StockRequestLine);
      StockRequestArchiveLine.Status := StockRequestArchiveLine.Status::Completed;
      StockRequestArchiveLine.INSERT;
    UNTIL StockRequestLine.NEXT = 0;

    StockRequestLine.RESET;
    StockRequestLine.SETRANGE("Transfer Order No.",TransHeader2."No.");
    StockRequestLine.SETRANGE("Stock Request No.",TransHeader2."Sales Order Number");
    StockRequestLine.SETRANGE(Status,StockRequestLine.Status::Released);
    StockRequestLine.DELETEALL;
    //SR1
    #18..23
    */
    //end;
}

