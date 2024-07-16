codeunit 50003 "Amount In Words"
{

    trigger OnRun()
    begin
    end;

    var
        AmountInWordes: Text;
        OnesText: array [20] of Text[90];
        TensText: array [10] of Text[90];
        ThousText: array [5] of Text[30];
        WholePart: Integer;
        DecimalPart: Integer;
        WholeInWords: Text;
        DecimalInWords: Text;

    procedure NumberInWords(number: Decimal;CurrencyName: Text[30];DenomName: Text[30]): Text[300]
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
    begin
        WholePart := ROUND(ABS(number),1,'<');
        DecimalPart := ABS((ABS(number) - WholePart)*100);

        WholeInWords := NumberToWords(WholePart,CurrencyName);
        IF DecimalPart <> 0 THEN BEGIN
         DecimalInWords := NumberToWords(DecimalPart,DenomName);
          IF WholePart = 0 THEN
            WholeInWords := 'Zero' + ' and ' + DecimalInWords
          ELSE
            WholeInWords := WholeInWords + ' and ' + DecimalInWords;
        END;
        AmountInWordes := ' ' + WholeInWords + ' Only';
        EXIT (AmountInWordes);
    end;

    procedure NumberToWords(number: Decimal;appendScale: Text[30]): Text[300]
    var
        numString: Text[300];
        pow: Integer;
        powStr: Text[50];
        log: Integer;
    begin
        numString := '';
        IF number < 100 THEN
          IF number < 20 THEN BEGIN
            IF number <> 0 THEN numString := OnesText[number];
          END ELSE BEGIN
            numString := TensText[number DIV 10];
            IF (number MOD 10) > 0 THEN
              numString := numString + ' ' + OnesText[number MOD 10];
          END
        ELSE BEGIN
          pow := 0;
          powStr := '';
          IF number < 1000 THEN BEGIN // number is between 100 and 1000
           pow := 100;
            powStr := ThousText[1];
          END ELSE BEGIN // find the scale of the number
            log := ROUND(STRLEN(FORMAT(number DIV 1000))/3,1,'>');
            pow := POWER(1000, log);
            powStr := ThousText[log + 1];
         END;

          numString := NumberToWords(number DIV pow, powStr) + ' ' + NumberToWords(number MOD pow,'');
        END;

        EXIT(DELCHR(numString,'<>',' ') + ' ' + appendScale);
    end;

    procedure InitTextVariables()
    begin
        OnesText[1] := 'One';
        OnesText[2] := 'Two';
        OnesText[3] := 'Three';
        OnesText[4] := 'Four';
        OnesText[5] := 'Five';
        OnesText[6] := 'Six';
        OnesText[7] := 'Seven';
        OnesText[8] := 'Eight';
        OnesText[9] := 'Nine';
        OnesText[10] := 'Ten';
        OnesText[11] := 'Eleven';
        OnesText[12] := 'Twelve';
        OnesText[13] := 'Thirteen';
        OnesText[14] := 'Fourteen';
        OnesText[15] := 'Fifteen';
        OnesText[16] := 'Sixteen';
        OnesText[17] := 'Seventeen';
        OnesText[18] := 'Eighteen';
        OnesText[19] := 'Nineteen';

        TensText[1] := '';
        TensText[2] := 'Twenty';
        TensText[3] := 'Thirty';
        TensText[4] := 'Forty';
        TensText[5] := 'Fifty';
        TensText[6] := 'Sixty';
        TensText[7] := 'Seventy';
        TensText[8] := 'Eighty';
        TensText[9] := 'Ninety';

        ThousText[1] := 'Hundred';
        ThousText[2] := 'Thousand';
        ThousText[3] := 'Million';
        ThousText[4] := 'Billion';
        ThousText[5] := 'Trillion';
    end;
}

