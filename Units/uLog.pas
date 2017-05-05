unit uLog;

interface

uses Classes, uUserList;
                                                               
type
  TLog = class(TComponent)
  private
    FLogged: Boolean;
    FUserList: TUserList;
  public
    constructor Create(AOwner: TComponent; FileName: String); reintroduce;
    destructor Destroy; override;
    function TryLog(AUserName, APassword: String): Boolean;
    procedure Logout;
    property UserList: TUserList read FUserList;
    property Logged: Boolean read FLogged;
  end;

implementation

constructor TLog.Create(AOwner: TComponent; FileName: String);
begin
  Inherited Create(AOwner);
  FUserList:= TUserList.Create(FileName);
end;

destructor TLog.Destroy;
begin
  FUserList.Free;
  Inherited Destroy;
end;

function TLog.TryLog(AUserName, APassword: String): Boolean;
begin
  FLogged:= (FUserList.User[AUserName].Senha = APassword) and (FUserList.ItemIndex > '');
  Result:= FLogged;
end;

procedure TLog.Logout;
begin
  FLogged:= False;
end;

end.
