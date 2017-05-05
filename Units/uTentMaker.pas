unit uTentMaker;

interface

uses Classes, SysUtils,
     uAbsTent, uTent, uCfgSes;

type
  TTentMaker = class(TComponent)
  private
    FMatStm: TMatStm;
  public
    constructor Create(AOwner: TComponent; MatStm: TMatStm); reintroduce;
    function CreateAbsTent(AType: String): TAbsTent;
    function CreateAbsCfgTent(AType: String; var AbsCfgTent: TAbsCfgTent): Boolean;
    procedure GetTypes(SList: TStrings);
  end;

implementation

constructor TTentMaker.Create(AOwner: TComponent; MatStm: TMatStm);
begin
  Inherited Create(AOwner);
  FMatStm:= MatStm;
end;

function TTentMaker.CreateAbsTent(AType: String): TAbsTent;
begin
  Result:= nil;
  If AType = 'M1C9' then Result:= TTent.Create(nil);
end;

function TTentMaker.CreateAbsCfgTent(AType: String; var AbsCfgTent: TAbsCfgTent): Boolean;
begin
  Result:= False;
  If AType = 'M1C9' then begin
    AbsCfgTent:= TCfgTent.Create(Self, FMatStm);
    Result:= True;
  end;
end;

procedure TTentMaker.GetTypes(SList: TStrings);
begin
  SList.Clear;
  SList.Add('M1C9');
  SList.Add('M1C2');
end;

end.
