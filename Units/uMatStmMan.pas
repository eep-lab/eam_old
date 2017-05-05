unit uMatStmMan;

interface

uses  Classes,
      uCfgSes;

type
  TMatStmMan = class(TComponent)
  private
    FCfgSes: TCfgSes;
    function GetFileName(IndCnj, IndCls: Integer): String;
    function GetFullFileName(IndCnj, IndCls: Integer): String;
    function GetStmLoaded(IndCnj, IndCls: Integer): Boolean;
    procedure SetFileName(IndCnj, IndCls: Integer; Name: String);
  public
    constructor Create(AOwner: TComponent; CfgSes: TCfgSes); reintroduce;
    destructor Destroy; override;
    property FileName[IndCnj, IndCls: Integer]: String read GetFileName write SetFileName;
    property FullFileName[IndCnj, IndCls: Integer]: String read GetFullFileName;
    property StmLoaded[IndCnj, IndCls: Integer]: Boolean read GetStmLoaded;
  end;

implementation

function TMatStmMan.GetFileName(IndCnj, IndCls: Integer): String;
begin
  Result:= FCfgSes.MatStm.GetFileName(IndCnj, IndCls);
end;

function TMatStmMan.GetFullFileName(IndCnj, IndCls: Integer): String;
begin
  Result:= FCfgSes.MatStm.GetFullFileName(IndCnj, IndCls);
end;

function TMatStmMan.GetStmLoaded(IndCnj, IndCls: Integer): Boolean;
begin
  Result:= not (FileName[IndCnj, IndCls] = '');
end;

procedure TMatStmMan.SetFileName(IndCnj, IndCls: Integer; Name: String);
begin
  FCfgSes.MatStm.SetFileName(IndCnj, IndCls, Name);
end;

constructor TMatStmMan.Create(AOwner: TComponent; CfgSes: TCfgSes);
begin
  Inherited Create(AOwner);
  FCfgSes:= CfgSes;  
end;

destructor TMatStmMan.Destroy;
begin
  Inherited Destroy;
end;

end.
