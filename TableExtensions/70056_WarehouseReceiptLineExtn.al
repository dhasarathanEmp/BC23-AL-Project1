tableextension 70056 WarehouseReceiptLineExtn extends "Warehouse Receipt Line"
{
    fields
    {
        modify("Bin Code")
        {
            TableRelation = IF ("Zone Code" = FILTER('')) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                                      "Temporary Delivery" = FILTER(false),
                                                                      "Counter sale" = FILTER(false),
                                                                      DeadStocks = FILTER(false))
            ELSE IF ("Zone Code" = FILTER(<> '')) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                       "Zone Code" = FIELD("Zone Code"),
                                                                                                                       "Temporary Delivery" = FILTER(false),
                                                                                                                       "Counter sale" = FILTER(false),
                                                                                                                       DeadStocks = FILTER(false));
        }

        //Unsupported feature: Code Modification on ""Qty. to Receive"(Field 21).OnValidate".

        //trigger  to Receive"(Field 21)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Qty. to Receive" > "Qty. Outstanding" THEN
          ERROR(
            Text002,
        #4..16
        "Qty. to Receive (Base)" := CalcBaseQty("Qty. to Receive");

        Item.CheckSerialNoQty("Item No.",FIELDCAPTION("Qty. to Receive (Base)"),"Qty. to Receive (Base)");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..19

        //Amount Calculation
        Amount := "Qty. to Receive" * "Unit Price";
        */
        //end;
        field(50000; "Vendor Invoice Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50001; SalesInvNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; SaleInvLineNo; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CS90';
        }
        field(50004; ApplyFromItemEntry; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'CS90';
        }
        field(50005; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Amount Calculation
                Amount := "Qty. to Receive" * "Unit Price";
            end;
        }
        field(50006; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; Remarks; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'None,Damage,Missing';
            OptionMembers = "None ",Damage,Missing;
        }
        field(50008; Excess; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Country/Region Code"; Code[50])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            begin
                //PostCode.CheckClearPostCodeCityCounty(City,"Post Code",County,"Country/Region Code",xRec."Country/Region Code");
            end;
        }
        field(50014; Received; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu012';
        }
        field(50015; "Serial No"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Cu012';
        }
        field(50016; VendorNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Cu012';
        }
        field(50017; "HS Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Default Price/Unit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
        field(50019; "Agency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'EP9613';
        }
    }
}

