unit uCfgSes;

interface

uses
  Classes, IniFiles, SysUtils, Types;

type
  TCfgTrial = Record
    Name: String;
    Kind: String;
    SList: TStringList;
  end;

  TCrtBlc = Record
    Operand1: String;
    Operator: Char;
    Operand2: Integer;
    NextBlc: String;
  end;

  TCfgBlc = Record
    BkGnd: Integer;
    IDBlc: Integer;
    ITI: Integer;
    Name: String;
    NumTrials: Integer;
    VetCfgTrial: Array of TCfgTrial;
    NumCrt: Integer;
    VetCrtBlc: Array of TCrtBlc;
    DefNextBlc: String;
  end;

  TCfgSes = class(TComponent)
  private
    FHootMedia: String;
    FHootData: String;
    FIniFile: TIniFile;
    FName: String;
    FNumBlc: Integer;
    FVetCfgBlc: Array of TCfgBlc;
    function GetCfgBlc(Ind: Integer): TCfgBlc;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function LoadFromFile(FileName: String): Boolean;

    property CfgBlc[Ind: Integer]: TCfgBlc read GetCfgBlc;
    property Name: String read FName;
    property NumBlc: Integer read FNumBlc;
    property HootData: String read FHootData;
  end;

implementation

function TCfgSes.GetCfgBlc(Ind: Integer): TCfgBlc;
begin
  Result:= FVetCfgBlc[Ind];
end;

constructor TCfgSes.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
end;

destructor TCfgSes.Destroy;
begin
  Inherited Destroy;
end;

function TCfgSes.LoadFromFile(FileName: String): Boolean;
var a1, a2: Integer; s1: String;
begin
  If FileExists(FileName) then begin
    FIniFile:= TIniFile.Create(FileName);
    With FIniFile do begin
      If SectionExists('Main') and ValueExists('Main', 'Name') and ValueExists('Main', 'NumBlc') then begin
        FName:= ReadString('Main', 'Name', '');
        FNumBlc:= ReadInteger('Main', 'NumBlc', 0);

        FHootMedia:= ExtractFilePath(FileName) + ReadString('Main', 'HootMedia', '');
        If not (FHootMedia[Length(FHootMedia)] = '\') then FHootMedia:= FHootMedia + '\';

        FHootData:= ExtractFilePath(FileName) + ReadString('Main', 'HootData', '');
        If not (FHootData[Length(FHootData)] = '\') then FHootData:= FHootData + '\';

        SetLength(FVetCfgBlc, FNumBlc);
        For a1:= 0 to FNumBlc-1 do begin
          FVetCfgBlc[a1].Name:= ReadString('Blc '+IntToStr(a1+1), 'Name', '');
          FVetCfgBlc[a1].BkGnd:= ReadInteger('Blc '+IntToStr(a1+1), 'BkGnd', 0);
          FVetCfgBlc[a1].ITI:= ReadInteger('Blc '+IntToStr(a1+1), 'ITI', 0);
          FVetCfgBlc[a1].NumTrials:= ReadInteger('Blc '+IntToStr(a1+1), 'NumTrials', 0);
          FVetCfgBlc[a1].IDBlc:= a1;
          FVetCfgBlc[a1].DefNextBlc:= ReadString('Blc '+IntToStr(a1+1), 'DefNextBlc', '');
          FVetCfgBlc[a1].NumCrt:= ReadInteger('Blc '+IntToStr(a1+1), 'NumCrt', 0);

          SetLength(FVetCfgBlc[a1].VetCrtBlc, FVetCfgBlc[a1].NumCrt);
          For a2:= 0 to FVetCfgBlc[a1].NumCrt-1 do begin
            s1:= ReadString('Blc '+IntToStr(a1+1), 'Crt'+IntToStr(a2+1), '');

            FVetCfgBlc[a1].VetCrtBlc[a2].Operand1:= Copy(s1, 0, Pos(#32, s1)-1);
            Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
            FVetCfgBlc[a1].VetCrtBlc[a2].Operator:= Copy(s1, 0, Pos(#32, s1)-1)[1];
            Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
            FVetCfgBlc[a1].VetCrtBlc[a2].Operand2:= StrToIntDef(Copy(s1, 0, Pos(#32, s1)-1), 0);
            Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
            FVetCfgBlc[a1].VetCrtBlc[a2].NextBlc:= s1;
          end;

          SetLength(FVetCfgBlc[a1].VetCfgTrial, FVetCfgBlc[a1].NumTrials);
          For a2:= 0 to FVetCfgBlc[a1].NumTrials-1 do begin
            FVetCfgBlc[a1].VetCfgTrial[a2].Name:= ReadString('Blc '+IntToStr(a1+1) + ' - T'+IntToStr(a2+1), 'Name', '');
            FVetCfgBlc[a1].VetCfgTrial[a2].Kind:= ReadString('Blc '+IntToStr(a1+1) + ' - T'+IntToStr(a2+1), 'Kind', '');

            FVetCfgBlc[a1].VetCfgTrial[a2].SList:= TStringList.Create; // Dar um jeito de destruir na hora adequada. Quando rodar outra vez esta procedure.
            ReadSectionValues('Blc '+IntToStr(a1+1) + ' - T'+IntToStr(a2+1), FVetCfgBlc[a1].VetCfgTrial[a2].SList);
            FVetCfgBlc[a1].VetCfgTrial[a2].SList.Add('HootMedia='+FHootMedia);
          end;
        end;
        Result:= True;
      end else Result:= False;
    end;
  end else Result:= False;
end;

end.



