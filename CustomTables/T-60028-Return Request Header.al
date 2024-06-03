table 60028 "Return Request Header"
{

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF No <> xRec.No THEN BEGIN
                    SalesSetup.GET;
                    Rec.No := NoSeriesManagement.GetNextNo(SalesSetup."Return Request", WORKDATE, TRUE);
                    ReturnRequestParameter.RESET;
                    IF ReturnRequestParameter.FINDFIRST THEN BEGIN
                        Rec.ISA := ReturnRequestParameter.ISA;
                        Rec.GS := ReturnRequestParameter.GS;
                        Rec."GS01 479" := ReturnRequestParameter."GS01 479";
                        Rec.ST := ReturnRequestParameter.ST;
                        Rec.BGN := ReturnRequestParameter.BGN;
                        Rec.RDR := ReturnRequestParameter.RDR;
                        Rec.PRF := ReturnRequestParameter.PRF;
                        Rec.SE := ReturnRequestParameter.SE;
                        Rec.GE := ReturnRequestParameter.GE;
                        Rec.IEA := ReturnRequestParameter.IEA;
                        Rec.DTM := ReturnRequestParameter.DTM;
                        Rec.CTT := ReturnRequestParameter.CTT;
                        Rec.BSN := ReturnRequestParameter.BSN;
                    END;
                END;
            end;
        }
        field(2; ISA; Code[3])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*IF No <> xRec.No THEN BEGIN
                  SalesSetup.GET;
                  Rec.No := NoSeriesManagement.GetNextNo(SalesSetup."Return Request",WORKDATE,TRUE);
                  ReturnRequestParameter.RESET;
                  IF ReturnRequestParameter.FINDFIRST THEN BEGIN
                    Rec.ISA := ReturnRequestParameter.ISA;
                    Rec.GS := ReturnRequestParameter.GS;
                    Rec."GS01 479" := ReturnRequestParameter."GS01 479";
                    Rec.ST := ReturnRequestParameter.ST;
                    Rec.BGN := ReturnRequestParameter.BGN;
                    Rec.RDR := ReturnRequestParameter.RDR;
                    Rec.PRF := ReturnRequestParameter.PRF;
                    Rec.SE := ReturnRequestParameter.SE;
                    Rec.GE := ReturnRequestParameter.GE;
                    Rec.IEA := ReturnRequestParameter.IEA;
                  END;
                END;  */

            end;
        }
        field(3; "ISA01 I01"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "ISA02 I02"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "ISA03 I03"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "ISA04 I04"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "ISA05 I05"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "ISA06 I06"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "ISA08 I07"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "ISA09 I08"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "ISA10 I09"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "ISA11 165"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "ISA12 I11"; Text[5])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "ISA13 I12"; Text[9])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "ISA14 I13"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "ISA15 I14"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Test,Production';
            OptionMembers = ,T,P;
        }
        field(17; "ISA16 I15"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Segment Terminator"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(19; GS; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "GS01 479"; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "GS02 142"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "GS03 124"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,SPMT,SPM';
            OptionMembers = " ",SPMT,SPM;
        }
        field(23; "GS04 373"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "GS05 337"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "GS06 28"; Text[9])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "GS07 455"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "GS08 480"; Text[12])
        {
            DataClassification = ToBeClassified;
        }
        field(28; ST; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "ST01 143"; Text[3])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "ST02 329"; Text[9])
        {
            DataClassification = ToBeClassified;
        }
        field(31; BGN; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "BGN01 353"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "BGN02 127"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "BGN03 373"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "BGN04 337"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "BGN07 640"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(37; RDR; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "RDR01 1292"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "RDR02 1293"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "RDR03 1294"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "RDR04 352"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(42; PRF; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "PRF01 324"; Text[22])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "PRF02 328"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "PRF03 327"; Text[8])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "PRF04 373"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "PRF05 350"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,ZSUR,ZLVC,ZREF,ZBLV,ZBSU,ZBRF';
            OptionMembers = " ",ZSUR,ZLVC,ZREF,ZBLV,ZBSU,ZBRF;
        }
        field(48; "PRF06 367"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "PRF07 92"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(50; SE; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "SE01 96"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "SE02 329"; Text[9])
        {
            DataClassification = ToBeClassified;
        }
        field(53; GE; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "GE01 97"; Text[6])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "GE02 28"; Text[9])
        {
            DataClassification = ToBeClassified;
        }
        field(56; IEA; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "IEA01 I16"; Text[5])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "IEA02 I12"; Text[9])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "ISA07 I05"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Return Request"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,RR,ARR';
            OptionMembers = " ",RR,ARR;
        }
        field(61; "Return Request No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(62; BSN; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "BSN01 353"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "BSN02 396"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "BSN03 373"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "BSN04 337"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(67; DTM; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "DTM01 374"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "DTM02 373"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "DTM03 337"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(71; DTM04; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(72; "DTM05 624"; Code[102])
        {
            DataClassification = ToBeClassified;
        }
        field(73; CTT; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(74; "CTT01 354"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "CTT02 347"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF No = '' THEN BEGIN
            SalesSetup.GET;
            IF Rec."Return Request" = Rec."Return Request"::RR THEN
                Rec.No := NoSeriesManagement.GetNextNo(SalesSetup."Return Request", WORKDATE, TRUE)
            ELSE
                Rec.No := NoSeriesManagement.GetNextNo(SalesSetup."Authorized Return Request", WORKDATE, TRUE);
            ReturnRequestParameter.RESET;
            IF ReturnRequestParameter.FINDFIRST THEN BEGIN
                Rec.ISA := ReturnRequestParameter.ISA;
                Rec.GS := ReturnRequestParameter.GS;
                Rec."GS01 479" := ReturnRequestParameter."GS01 479";
                Rec.ST := ReturnRequestParameter.ST;
                Rec.BGN := ReturnRequestParameter.BGN;
                Rec.RDR := ReturnRequestParameter.RDR;
                Rec.PRF := ReturnRequestParameter.PRF;
                Rec.SE := ReturnRequestParameter.SE;
                Rec.GE := ReturnRequestParameter.GE;
                Rec.IEA := ReturnRequestParameter.IEA;
                Rec."Segment Terminator" := ReturnRequestParameter."Segment Terminator";
                CurrentDate := WORKDATE;
                Rec."ISA09 I08" := FORMAT(CurrentDate, 0, '<Year4><Month,2><Day,2>');
                Rec."ISA10 I09" := TIME;
                Rec."GS04 373" := FORMAT(CurrentDate, 0, '<Year4><Month,2><Day,2>');
                Rec."GS05 337" := TIME;
                Rec."BGN03 373" := FORMAT(CurrentDate, 0, '<Year4><Month,2><Day,2>');
                Rec."PRF04 373" := FORMAT(CurrentDate, 0, '<Year><Month><Day,2>');
                /*MESSAGE(FORMAT(TIME,0,'<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>'));
                MESSAGE(FORMAT(TIME,0,'<Hours24,2><Minutes,2>'));
                MESSAGE(FORMAT(TIME,0,'<Hours24,2>:<Minutes,2>:<Seconds,2>'));*/
            END;
        END;

    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        ReturnRequestParameter: Record "Return Request Parameter";
        CurrentDate: Date;
}

