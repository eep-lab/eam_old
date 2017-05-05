unit uProcList;

interface

uses IniFiles, SysUtils, Classes;

type
  TProc = record
    Name: String;
    NumCfgS: Integer;
    VetCfgS: Array of String;
  end;

  PProc = ^TProc;

  TProcList = class (TIniFile)
  private
    FItemIndex: String;
    FProc: TProc;
    FNumProc: Integer;
    function GetProc(AName: String): PProc;
  public
    constructor Create(FileName: String);
    procedure GetList(Strings: TStrings);
    property NumProc: Integer read FNumProc;
    property Proc[AName: String]: PProc read GetProc;
  end;

implementation

constructor TProcList.Create(FileName: String);
begin
  Inherited Create(FileName);
  FNumProc:= ReadInteger('Main', 'NumProc', 0);
end;

function TProcList.GetProc(AName: String): PProc;
var a1: Integer;
begin
  If FItemIndex <> AName then begin
    With FProc do begin
      Name:= AName;
      NumCfgS:= ReadInteger(Name, 'NumCfgS', 0);
      SetLength(VetCfgS, NumCfgS);
      For a1:= 0 to NumCfgS-1 do VetCfgS[a1]:= ReadString(Name, 'I'+IntToStr(a1), '');
      FItemIndex:= Name;
    end;
  end;
  Result:= @FProc;
end;

procedure TProcList.GetList(Strings: TStrings);
var a1: Integer;
begin
  Strings.Clear;
  For a1:= 0 to FNumProc-1 do
    Strings.Add(ReadString('Main', 'I'+IntToStr(a1), ''));
end;

end.
