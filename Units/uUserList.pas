unit uUserList;

interface

uses IniFiles, SysUtils, Classes;

type
  TUser = record
    Name: String;
    Senha: String;
    Status: Integer;
    NumSubj: Integer;
    VetSubj: Array of String;
  end;

  PUser = ^TUser;

  TUserList = class (TIniFile)
  private
    FItemIndex: String;
    FUser: TUser;
    FNumUser: Integer;
    function GetUser(AName: String): PUser;
  public
    constructor Create(FileName: String);
    procedure GetList(Strings: TStrings);
    property NumUser: Integer read FNumUser;
    property User[AName: String]: PUser read GetUser;
    property ItemIndex: String read FItemIndex;
  end;

implementation

constructor TUserList.Create(FileName: String);
begin
  Inherited Create(FileName);
  FNumUser:= ReadInteger('Main', 'NumUser', 0);
end;

function TUserList.GetUser(AName: String): PUser;
var a1: Integer;
begin
  If FItemIndex <> AName then begin
    With FUser do begin
      If SectionExists(AName) then begin
        Name:= AName;
        Senha:= ReadString(Name, 'Senha', '');
        Status:= ReadInteger(Name, 'Status', 0);
        NumSubj:= ReadInteger(Name, 'NumSubj', 0);
        SetLength(VetSubj, NumSubj);
        For a1:= 0 to NumSubj-1 do VetSubj[a1]:= ReadString(Name, 'I'+IntToStr(a1), '');
        FItemIndex:= Name;
      end else begin
        Name:= '';
        Senha:= '';
        Status:= 0;
        NumSubj:= 0;
        SetLength(VetSubj, 0);
      end;
      FItemIndex:= Name;
    end;
  end;
  Result:= @FUser;
end;

procedure TUserList.GetList(Strings: TStrings);
var a1: Integer;
begin
  Strings.Clear;
  For a1:= 0 to FNumUser-1 do
    Strings.Add(ReadString('Main', 'I'+IntToStr(a1), ''));
end;

end.
