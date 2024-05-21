pageextension 70011 SecurityGroupMemberExtn extends "Security Groups"
{
    layout
    {
        addafter(Name)
        {
            field("Sales Post"; Rec."Sales Post")
            {

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}