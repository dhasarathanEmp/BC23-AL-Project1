tableextension 70068PurchCreditMemoHeaderExtn extends "Purch. Cr. Memo Hdr." 
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Pay-to Address"(Field 7)".


        //Unsupported feature: Property Modification (Data type) on ""Pay-to Address 2"(Field 8)".


        //Unsupported feature: Property Modification (Data type) on ""Ship-to Address"(Field 15)".


        //Unsupported feature: Property Modification (Data type) on ""Ship-to Address 2"(Field 16)".


        //Unsupported feature: Property Modification (Data type) on ""Buy-from Address"(Field 81)".


        //Unsupported feature: Property Modification (Data type) on ""Buy-from Address 2"(Field 82)".

        field(50009;"Customer Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50010;"Order Class Antares";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",E,S,W;
        }
        field(50011;"Customer Reference Number";Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50012;"Agreement Type";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50013;"Letter of Credit Number";Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50014;"Consolidated Ship Indicator";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50015;"Contract Number";Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50016;"Consolidated Invoice Indicator";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50017;"Short Item Indicator";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",B,C;
        }
        field(50018;"Back Order Search Limit";Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50019;"Antares Order Profile";Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50020;"Mrkg Prg Auth Code";Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50021;"Mrkg Prg Number";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50022;"Search Preference Customer Cod";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50023;"Marketing Program Type";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50026;"Acknowledgment Type";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50027;"Related Customer Code";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50028;"Antares Order Entry Profile";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50029;"Batch Hold Order";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50030;"Dealer Order Entry Sys Version";Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50031;"In Region Surface Indicator";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = " ",A,S,T;
        }
        field(50032;"Freight Plan Indicator";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50033;"Order Consolidation Indicator";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ","1","2";
        }
        field(50034;"Do Not Allow Ship Indicator";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N,B;
        }
        field(50035;"High Weight Indicator";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50036;"High Value Indicator";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50037;"Multiple Replaced Indicator";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50038;"High Demand Indicator";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = "  ",Y,N;
        }
        field(50039;"Dealer Apply Service Charge";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50040;"Future Date Order Source Day";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50041;"Release Control Indicator";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50042;"Sub Header Type";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = " ",S,H,M;
        }
        field(50043;"Consolidated Pack Indicator";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = " ",Y,N;
        }
        field(50044;"Import License Number";Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50045;"Consolidation Group";Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50046;"Purchase Order Number";Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
        }
        field(50047;"Out Reg.Surface OrderIndicator";Option)
        {
            DataClassification = ToBeClassified;
            Description = 'CUS024';
            OptionMembers = " ",A,S;
        }
    }
}

