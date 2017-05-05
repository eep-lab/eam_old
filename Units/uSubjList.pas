unit uSubjList;

interface

uses IniFiles, SysUtils, Classes;

type
  TSubj = record
    Name: String;
    NumProc: Integer;
    VetProc: Array of String;
  end;

  PSubj = ^TSubj;

  TSubjList = class (TIniFile)
  private
    FItemIndex: String;
    FSubj: TSubj;
    FNumSubj: Integer;
    function GetSubj(AName: String): PSubj;
  public
    constructor Create(FileName: String);
    procedure GetList(Strings: TStrings);
    property NumSubj: Integer read FNumSubj;
    property Subj[AName: String]: PSubj read GetSubj;
  end;

implementation

constructor TSubjList.Create(FileName: String);
begin
  Inherited Create(FileName);
  FNumSubj:= ReadInteger('Main', 'NumSubj', 0);
end;

function TSubjList.GetSubj(AName: String): PSubj;
var a1: Integer;
begin
  If FItemIndex <> AName then begin
    With FSubj do begin
      Name:= AName;
      NumProc:= ReadInteger(Name, 'NumProc', 0);
      SetLength(VetProc, NumProc);
      For a1:= 0 to NumProc-1 do VetProc[a1]:= ReadString(Name, 'I'+IntToStr(a1), '');
      FItemIndex:= Name;
    end;
  end;
  Result:= @FSubj;
end;

procedure TSubjList.GetList(Strings: TStrings);
var a1: Integer;
begin
  Strings.Clear;
  For a1:= 0 to FNumSubj-1 do
    Strings.Add(ReadString('Main', 'I'+IntToStr(a1), ''));
end;

end.
