tableextension 70000 CompanyInformationExtn extends "Company Information"
{
    fields
    {
        field(50000; Auto; Boolean)//CS03
        {

        }
        field(50001; EPS; Boolean)//CS03
        {

        }
        field(50003; Division; Option)//CS03
        {
            OptionMembers = " ","Auto","E-PS";
        }
        field(50004; AFZ; Boolean)
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

}