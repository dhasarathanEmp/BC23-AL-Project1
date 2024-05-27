pageextension 70013 PurchaseOrderExtn extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Whse. Put-away Lines")
        {
            group("Data Export")
            {
                Caption = 'Data Export';
                Image = Export;

                action("Antares Parts Ordering")
                {
                    ApplicationArea = All;
                    Caption = 'Antares Parts Ordering';
                    Image = Import;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        AntaresLogFile: Record "Antares Log File";
                        PurchaseSetup: Record "Purchases & Payables Setup";
                        NoSeriesManagement: Codeunit NoSeriesManagement;
                        AntNo: Code[10];
                        User: Record User;
                        Count11: Integer;
                        Error11: Integer;
                        PurchaseLine: Record "Purchase Line";
                        AntaresErrorLog: Record "Antares Error Log";
                        AntaresErrorLog1: Record "Antares Error Log";
                        AntaresLogFile1: Record "Antares Log File";
                        PurchaseHdr: Record "Purchase Header";
                        Save12: Code[10];
                        AntaresForm: Record "Antares Form";

                    begin
                        AntaresLogFile.INIT;
                        PurchaseSetup.RESET;
                        PurchaseSetup.GET;
                        AntaresLogFile."Purchase Order No." := Rec."No.";
                        AntaresLogFile."Antares No." := NoSeriesManagement.GetNextNo(PurchaseSetup."Antares No Series", WORKDATE, TRUE);
                        AntNo := AntaresLogFile."Antares No.";
                        AntaresLogFile."Po Date" := Rec."Order Date";
                        AntaresLogFile."User Id" := USERID;
                        User.RESET;
                        User.SETRANGE("User Name", USERID);
                        IF User.FINDFIRST THEN
                            AntaresLogFile."Operator (User Name)" := User."Full Name";
                        AntaresLogFile.Description := 'Antares data is Export sucessfully';
                        AntaresLogFile."Conversion Date &Time" := CURRENTDATETIME;
                        AntaresLogFile.Status := 'Error';
                        AntaresLogFile.INSERT;
                        //
                        Count11 := 0;
                        Error11 := 0;
                        PurchaseLine.RESET;
                        PurchaseLine.SETRANGE("Document No.", Rec."No.");
                        IF PurchaseLine.FINDFIRST THEN
                            REPEAT
                                Count11 += 1;
                                IF PurchaseLine."No." = '' THEN BEGIN
                                    AntaresErrorLog.INIT;
                                    PurchaseSetup.RESET;
                                    PurchaseSetup.GET;
                                    AntaresErrorLog."Line No." := NoSeriesManagement.GetNextNo(PurchaseSetup."Antares Line", WORKDATE, TRUE);
                                    AntaresErrorLog."Document No." := Rec."No.";
                                    AntaresErrorLog."Document Date" := Rec."Order Date";
                                    AntaresErrorLog."User Id" := USERID;
                                    User.RESET;
                                    User.SETRANGE("User Name", USERID);
                                    IF User.FINDFIRST THEN
                                        AntaresErrorLog."User Name" := User."Full Name";
                                    AntaresErrorLog."Convertion Date & Time" := CURRENTDATETIME;
                                    AntaresErrorLog."Purchase Line No." := PurchaseLine."Line No.";
                                    AntaresErrorLog."Item No." := PurchaseLine."No.";
                                    AntaresErrorLog."Exception Message" := ('Purchase order Empty line Is created');
                                    AntaresErrorLog.Status := AntaresErrorLog.Status::Error;
                                    AntaresErrorLog."No." := AntaresLogFile."Antares No.";
                                    Error11 += 1;
                                    AntaresErrorLog.INSERT;
                                    COMMIT;
                                END;
                                IF PurchaseLine."Bin Code" = '' THEN BEGIN
                                    AntaresErrorLog.INIT;
                                    PurchaseSetup.RESET;
                                    PurchaseSetup.GET;
                                    AntaresErrorLog."Line No." := NoSeriesManagement.GetNextNo(PurchaseSetup."Antares Line", WORKDATE, TRUE);
                                    AntaresErrorLog."Document No." := Rec."No.";
                                    AntaresErrorLog."Document Date" := Rec."Order Date";
                                    AntaresErrorLog."User Id" := USERID;
                                    User.RESET;
                                    User.SETRANGE("User Name", USERID);
                                    IF User.FINDFIRST THEN
                                        AntaresErrorLog."User Name" := User."Full Name";
                                    AntaresErrorLog."Convertion Date & Time" := CURRENTDATETIME;
                                    AntaresErrorLog."Purchase Line No." := PurchaseLine."Line No.";
                                    AntaresErrorLog."Item No." := PurchaseLine."No.";
                                    AntaresErrorLog."Exception Message" := ('Purchase line Bin code Missing');
                                    AntaresErrorLog.Status := AntaresErrorLog.Status::Error;
                                    AntaresErrorLog."No." := AntaresLogFile."Antares No.";
                                    Error11 += 1;
                                    AntaresErrorLog.INSERT;
                                    COMMIT;
                                END;
                                IF PurchaseLine.Quantity = 0 THEN BEGIN
                                    AntaresErrorLog.INIT;
                                    PurchaseSetup.RESET;
                                    PurchaseSetup.GET;
                                    AntaresErrorLog."Line No." := NoSeriesManagement.GetNextNo(PurchaseSetup."Antares Line", WORKDATE, TRUE);
                                    AntaresErrorLog."Document No." := Rec."No.";
                                    AntaresErrorLog."Document Date" := Rec."Order Date";
                                    AntaresErrorLog."User Id" := USERID;
                                    User.RESET;
                                    User.SETRANGE("User Name", USERID);
                                    IF User.FINDFIRST THEN
                                        AntaresErrorLog."User Name" := User."Full Name";
                                    AntaresErrorLog."Convertion Date & Time" := CURRENTDATETIME;
                                    AntaresErrorLog."Purchase Line No." := PurchaseLine."Line No.";
                                    AntaresErrorLog."Item No." := PurchaseLine."No.";
                                    AntaresErrorLog."Exception Message" := ('Purchase line Quantity is Missing');
                                    AntaresErrorLog.Status := AntaresErrorLog.Status::Error;
                                    AntaresErrorLog."No." := AntaresLogFile."Antares No.";
                                    Error11 += 1;
                                    AntaresErrorLog.INSERT;
                                    COMMIT;
                                END;
                            UNTIL PurchaseLine.NEXT = 0;

                        IF Error11 = 0 THEN
                            PurchaseLine."No." := Rec."No."
                        ELSE
                            ERROR('Please check The purchase Line Details');
                        IF Rec."Customer Code" = '' THEN BEGIN
                            AntaresErrorLog.INIT;
                            PurchaseSetup.RESET;
                            PurchaseSetup.GET;
                            AntaresErrorLog."Line No." := NoSeriesManagement.GetNextNo(PurchaseSetup."Antares Line", WORKDATE, TRUE);
                            AntaresErrorLog."Document No." := Rec."No.";
                            AntaresErrorLog."Document Date" := Rec."Order Date";
                            AntaresErrorLog."User Id" := USERID;
                            User.RESET;
                            User.SETRANGE("User Name", USERID);
                            IF User.FINDFIRST THEN
                                AntaresErrorLog."User Name" := User."Full Name";
                            AntaresErrorLog."Convertion Date & Time" := CURRENTDATETIME;
                            AntaresErrorLog."Exception Message" := ('Please fill the Customer Code');
                            AntaresErrorLog.Status := AntaresErrorLog.Status::Error;
                            AntaresErrorLog."No." := AntaresLogFile."Antares No.";
                            AntaresErrorLog.INSERT;
                            COMMIT;
                            ERROR('Please fill the %1', 'Customer Code');
                        END ELSE
                            IF Rec."Order Class Antares" = Rec."Order Class Antares"::"  " THEN BEGIN
                                AntaresErrorLog.INIT;
                                PurchaseSetup.RESET;
                                PurchaseSetup.GET;
                                AntaresErrorLog."Line No." := NoSeriesManagement.GetNextNo(PurchaseSetup."Antares Line", WORKDATE, TRUE);
                                AntaresErrorLog."Document No." := Rec."No.";
                                AntaresErrorLog."Document Date" := Rec."Order Date";
                                AntaresErrorLog."User Id" := USERID;
                                User.RESET;
                                User.SETRANGE("User Name", USERID);
                                IF User.FINDFIRST THEN
                                    AntaresErrorLog."User Name" := User."Full Name";
                                AntaresErrorLog."Convertion Date & Time" := CURRENTDATETIME;
                                AntaresErrorLog."Exception Message" := ('Please fill the Order Class Antares');
                                AntaresErrorLog.Status := AntaresErrorLog.Status::Error;
                                AntaresErrorLog."No." := AntaresLogFile."Antares No.";
                                AntaresErrorLog.INSERT;
                                COMMIT;
                                ERROR('Please fill the %1', 'Order Class Antares');
                            END ELSE
                                IF Rec."Antares Order Profile" = '' THEN BEGIN
                                    AntaresErrorLog.INIT;
                                    PurchaseSetup.RESET;
                                    PurchaseSetup.GET;
                                    AntaresErrorLog."Line No." := NoSeriesManagement.GetNextNo(PurchaseSetup."Antares Line", WORKDATE, TRUE);
                                    AntaresErrorLog."Document No." := Rec."No.";
                                    AntaresErrorLog."Document Date" := Rec."Order Date";
                                    AntaresErrorLog."User Id" := USERID;
                                    User.RESET;
                                    User.SETRANGE("User Name", USERID);
                                    IF User.FINDFIRST THEN
                                        AntaresErrorLog."User Name" := User."Full Name";
                                    AntaresErrorLog."Convertion Date & Time" := CURRENTDATETIME;
                                    AntaresErrorLog."Exception Message" := ('Please fill the Antares Order Profile');
                                    AntaresErrorLog.Status := AntaresErrorLog.Status::Error;
                                    AntaresErrorLog."No." := AntaresLogFile."Antares No.";
                                    AntaresErrorLog.INSERT;
                                    COMMIT;
                                    ERROR('Please fill the %1', 'Antares Order Profile');
                                END ELSE
                                    IF Rec."Customer Reference Number" = '' THEN BEGIN
                                        AntaresErrorLog.INIT;
                                        PurchaseSetup.RESET;
                                        PurchaseSetup.GET;
                                        AntaresErrorLog."Line No." := NoSeriesManagement.GetNextNo(PurchaseSetup."Antares Line", WORKDATE, TRUE);
                                        AntaresErrorLog."Document No." := Rec."No.";
                                        AntaresErrorLog."Document Date" := Rec."Order Date";
                                        AntaresErrorLog."User Id" := USERID;
                                        User.RESET;
                                        User.SETRANGE("User Name", USERID);
                                        IF User.FINDFIRST THEN
                                            AntaresErrorLog."User Name" := User."Full Name";
                                        AntaresErrorLog."Convertion Date & Time" := CURRENTDATETIME;
                                        AntaresErrorLog."Exception Message" := ('Please fill the Customer Reference Number');
                                        AntaresErrorLog.Status := AntaresErrorLog.Status::Error;
                                        AntaresErrorLog."No." := AntaresLogFile."Antares No.";
                                        AntaresErrorLog.INSERT;
                                        COMMIT;
                                        ERROR('Please fill the %1', 'Customer Reference Number');
                                    END ELSE
                                        IF Rec."Acknowledgment Type" = '' THEN BEGIN
                                            AntaresErrorLog.INIT;
                                            PurchaseSetup.RESET;
                                            PurchaseSetup.GET;
                                            AntaresErrorLog."Line No." := NoSeriesManagement.GetNextNo(PurchaseSetup."Antares Line", WORKDATE, TRUE);
                                            AntaresErrorLog."Document No." := Rec."No.";
                                            AntaresErrorLog."Document Date" := Rec."Order Date";
                                            AntaresErrorLog."User Id" := USERID;
                                            User.RESET;
                                            User.SETRANGE("User Name", USERID);
                                            IF User.FINDFIRST THEN
                                                AntaresErrorLog."User Name" := User."Full Name";
                                            AntaresErrorLog."Convertion Date & Time" := CURRENTDATETIME;
                                            AntaresErrorLog."Exception Message" := ('Please fill the Acknowledgment Type');
                                            AntaresErrorLog.Status := AntaresErrorLog.Status::Error;
                                            AntaresErrorLog."No." := AntaresLogFile."Antares No.";
                                            AntaresErrorLog.INSERT;
                                            COMMIT;
                                            ERROR('Please fill the %1', 'Acknowledgment Type');
                                        END ELSE
                                            IF Rec."Antares Order Entry Profile" = '' THEN BEGIN
                                                AntaresErrorLog.INIT;
                                                PurchaseSetup.RESET;
                                                PurchaseSetup.GET;
                                                AntaresErrorLog."Line No." := NoSeriesManagement.GetNextNo(PurchaseSetup."Antares Line", WORKDATE, TRUE);
                                                AntaresErrorLog."Document No." := Rec."No.";
                                                AntaresErrorLog."Document Date" := Rec."Order Date";
                                                AntaresErrorLog."User Id" := USERID;
                                                User.RESET;
                                                User.SETRANGE("User Name", USERID);
                                                IF User.FINDFIRST THEN
                                                    AntaresErrorLog."User Name" := User."Full Name";
                                                AntaresErrorLog."Convertion Date & Time" := CURRENTDATETIME;
                                                AntaresErrorLog."Exception Message" := ('Please fill the Antares Order Entry Profile');
                                                AntaresErrorLog.Status := AntaresErrorLog.Status::Error;
                                                AntaresErrorLog."No." := AntaresLogFile."Antares No.";
                                                AntaresErrorLog.INSERT;
                                                COMMIT;
                                                ERROR('Please fill the %1', 'Antares Order Entry Profile');
                                            END ELSE BEGIN
                                                AntaresErrorLog.INIT;
                                                PurchaseSetup.RESET;
                                                PurchaseSetup.GET;
                                                AntaresErrorLog."Line No." := NoSeriesManagement.GetNextNo(PurchaseSetup."Antares Line", WORKDATE, TRUE);
                                                AntaresErrorLog."Document No." := Rec."No.";
                                                AntaresErrorLog."Document Date" := Rec."Order Date";
                                                AntaresErrorLog."User Id" := USERID;
                                                User.RESET;
                                                User.SETRANGE("User Name", USERID);
                                                IF User.FINDFIRST THEN
                                                    AntaresErrorLog."User Name" := User."Full Name";
                                                AntaresErrorLog."No. of Po Lines Created" := Count11;
                                                AntaresErrorLog."Convertion Date & Time" := CURRENTDATETIME;
                                                AntaresErrorLog."Exception Message" := '';
                                                AntaresErrorLog.Status := AntaresErrorLog.Status::Success;
                                                AntaresErrorLog."No." := AntaresLogFile."Antares No.";
                                                AntaresErrorLog.INSERT;
                                                //
                                                PurchaseHdr.RESET;
                                                PurchaseHdr.SETRANGE("No.", Rec."No.");
                                                Save12 := Rec."No.";
                                                CODEUNIT.RUN(50010, Rec);
                                                //REPORT.SAVEASEXCEL(REPORT::Antaracks,('C:\TEMP\TEMP1\'+FORMAT(Save12)+'.CSV'),PurchaseHdr);
                                                //
                                                AntaresLogFile1.RESET;
                                                AntaresLogFile1.SETRANGE("Purchase Order No.", Rec."No.");
                                                AntaresLogFile1.SETRANGE("Antares No.", AntNo);
                                                IF AntaresLogFile1.FINDFIRST THEN BEGIN
                                                    AntaresLogFile1.Status := 'Success';
                                                    AntaresLogFile1."Order Class" := FORMAT(Rec."Order Class Antares");
                                                    AntaresLogFile1."Customer Code" := Rec."Customer Code";
                                                    AntaresLogFile1."Customer Reference Number" := Rec."Customer Reference Number";
                                                    AntaresLogFile1."Antares Order Profile" := Rec."Antares Order Profile";
                                                    AntaresLogFile1."Acknowledgment Type" := Rec."Acknowledgment Type";
                                                    AntaresLogFile1."Antares Order Entry" := Rec."Antares Order Entry Profile";
                                                    AntaresLogFile1.MODIFY;
                                                    AntaresForm.RESET;
                                                    IF AntaresForm.FINDFIRST THEN
                                                        MESSAGE('Antares Parts Ordering File Generated for Purchase order No : %1 \ File Path : %2', FORMAT(Rec."No."), AntaresForm."Data Stored Path");
                                                    AntaresErrorLog.RESET;
                                                    AntaresErrorLog.SETRANGE("Document No.", Rec."No.");
                                                    AntaresErrorLog.SETRANGE(Status, AntaresErrorLog.Status::Error);
                                                    IF AntaresErrorLog.FINDSET THEN
                                                        AntaresErrorLog.DELETEALL;
                                                END;
                                            END;


                    end;
                }

            }
        }
    }
}
