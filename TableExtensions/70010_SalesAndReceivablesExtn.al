tableextension 70010 SalesAndReceivables extends "Sales & Receivables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Gate Pass ADE"; Code[20])//CUS020
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Gate Pass ADF"; Code[20])//CUS020
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Gate Pass HOD-SHA"; Code[20])//CUS020
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Gate Pass MUK"; Code[20])//CUS020
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Gate Pass SAN"; Code[20])//CUS020
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Gate Pass TAI"; Code[20])//CUS020
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Daily Part Price Update"; Code[20])//CUS025
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Semi Annual Price Update"; Code[20])//CUS026
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Semi Annual Header"; Code[20])//CUS026
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Daily Part Price Header"; Code[20])//CUS025
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "NPRHeader"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "NPRLine"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Hose Header"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Hose Line"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "MFHeader"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "MFLine"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Puegoet Header"; Code[20])//CUS027
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Puegoet Line"; Code[20])//CUS027
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Fg Wilson Header"; Code[20])//CUS028
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Fg Wilson Line"; Code[20])//CUS028
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Nisson header"; Code[20])//CUS029
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Nisson Line"; Code[20])//CUS029
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "MCFE Price Header"; Code[20])//CUS030
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "MCFE Price Line"; Code[20])//CUS030
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "NPRDup"; Code[20])//NPRDup
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Gate Pass HOD-HO"; Code[20])//CUS020
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Return Request"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Authorized Return Request"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Temporary Delivery"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Quote Deletion Time Limit"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Allow Sales Quote Autodelete"; Boolean)//Cu003
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "MF Price Header"; Code[20])//CUST06
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "MF Price Line"; Code[20])//CUST06
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Sales Discount%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Counter Sale Discount%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Internal Customer Discount%"; Decimal)//ep9615
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Order Deletion Time Limit"; Integer)//EMP108.14
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Allow Sales Order Autodelete"; Boolean)//EMP108.14
        {
            DataClassification = ToBeClassified;
        }
        field(50038; Inc_CoreCharge; Boolean)//Cu107
        {

        }
        field(50039; "Stock Request ADE"; Code[30])//EP9625
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Stock Request HOD-SHA"; Code[30])//EP9625
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Stock Request MUK"; Code[30])//EP9625
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Stock Request SAN"; Code[30])//EP9625
        {
            DataClassification = ToBeClassified;
        }
        field(50044; "Stock Request TAI"; Code[30])//EP9625
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Stock Request AFZ"; Code[30])//EP9625
        {
            DataClassification = ToBeClassified;
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