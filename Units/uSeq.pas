unit uSeq;

interface

uses Classes,
     uCfgSes, uAbsTent, uTentMaker;

type
  TSeq = class(TComponent)
  private
    FCfgSes: TCfgSes;
    FTentMaker: TTentMaker;
  public
    constructor Create(AOwner: TComponent; CfgSes: TCfgSes); reintroduce;
    destructor Destroy; override;
    function LoadAbsTent(IndSeq, IndTent: Integer): TAbsTent;
  end;

implementation

constructor TSeq.Create(AOwner: TComponent; CfgSes: TCfgSes);
begin
  Inherited Create(AOwner);
  FCfgSes:= CfgSes;
  FTentMaker:= TTentMaker.Create(Self, FCfgSes.MatStm);
end;

destructor TSeq.Destroy;
begin
  Inherited Destroy;
end;

function TSeq.LoadAbsTent(IndSeq, IndTent: Integer): TAbsTent;
var SLCfgSeq, SLCfgTent, SLMatStm: TStringList;
begin
  SLMatStm:= TStringList.Create;
  SLCfgSeq:= TStringList.Create;
  SLCfgTent:= TStringList.Create;

  FCfgSes.MatStm.ReadCfg(SLMatStm);
  FCfgSes.CfgSeq[IndSeq].ReadCfg(SLCfgSeq);
  FCfgSes.CfgSeq[IndSeq].CfgTent[IndTent].ReadCfg(SLCfgTent);

  Result:= FTentMaker.CreateAbsTent(SLMatStm, SLCfgSeq, SLCfgTent);

  SLMatStm.Free;
  SLCfgSeq.Free;
  SLCfgTent.Free;
end;

end.
