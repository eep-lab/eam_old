unit uCfgSList;

interface

uses IniFiles, SysUtils, Classes;

type
  TCfgS = record
    Name: String;
  end;

  PCfgS = ^TCfgS;

  TCfgSList = class (TIniFile)
  private
    FItemIndex: String;
    FCfgS: TCfgS;
    FNumExpr: Integer;
    function GetCfgS(AName: String): PCfgS;
  public
    constructor Create(FileName: String);
    procedure GetList(Strings: TStrings);
    property NumCfgS: Integer read FNumExpr;
    property CfgS[AName: String]: PCfgS read GetCfgS;
  end;

implementation

constructor TCfgSList.Create(FileName: String);
begin
  Inherited Create(FileName);
  FNumExpr:= ReadInteger('Main', 'NumCfgS', 0);
end;

function TCfgSList.GetCfgS(AName: String): PCfgS;
begin
  If FItemIndex <> AName then begin
    With FCfgS do begin
      Name:= AName;
      FItemIndex:= Name;
    end;
  end;
  Result:= @FCfgS;
end;

procedure TCfgSList.GetList(Strings: TStrings);
var a1: Integer;
begin
  Strings.Clear;
  For a1:= 0 to FNumExpr-1 do
    Strings.Add(ReadString('Main', 'I'+IntToStr(a1), ''));
end;

end.
