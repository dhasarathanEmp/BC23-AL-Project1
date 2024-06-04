tableextension 70081 JobQueryEntryExtn extends "Job Queue Entry"
{
    fields
    {
        field(50000; "Quote Delete Time Period"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Cu003';
        }
    }


    //Unsupported feature: Code Modification on "FinalizeLogEntry(PROCEDURE 51)".

    //procedure FinalizeLogEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Status = Status::Error THEN BEGIN
      JobQueueLogEntry.Status := JobQueueLogEntry.Status::Error;
      JobQueueLogEntry.SetErrorMessage(GetErrorMessage);
    END ELSE
      JobQueueLogEntry.Status := JobQueueLogEntry.Status::Success;
    JobQueueLogEntry."End Date/Time" := CURRENTDATETIME;
    JobQueueLogEntry.MODIFY(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      //EP9609
      {ResErrorMessage := JobQueueLogEntry."Error Message";
      LocationCode := Rec."Parameter String";
      SendEmailEMP."Transfer Receipt-Job Error-Mail Automation"(ResErrorMessage,LocationCode);}
      //EP9609
    #4..7
    */
    //end;

    var
        //SendEmailEMP: Codeunit "50044";
        ResErrorMessage: Text;
        ObjectName: Text;
        LocationCode: Text;
        EntryNo: Integer;
}

