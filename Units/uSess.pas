unit uSess;

interface

uses Classes, 
     uCfgSes, uBlc, uSeq, uCsq;

type
  TSess = class(TComponent)
  private
    FCfgSes: TCfgSes;
    FBlc: TBlc;
    FSeq: TSeq;
    FOnEndSess: TNotifyEvent;
    procedure BlcEndBlc(Sender: TObject);
  public
    constructor Create(AOwner: TComponent; CfgSes: TCfgSes); reintroduce;
    destructor Destroy; override;
    procedure Play;
    property OnEndSess: TNotifyEvent read FOnEndSess write FOnEndSess;
  end;

implementation

constructor TSess.Create(AOwner: TComponent; CfgSes: TCfgSes);
begin
  Inherited Create(AOwner);
  FCfgSes:= CfgSes;
  FSeq:= TSeq.Create(Self, CfgSes);
  FBlc:= TBlc.Create(Self, CfgSes, FSeq);
  FBlc.OnEndBlc:= BlcEndBlc;
end;

destructor TSess.Destroy;
begin
  Inherited Destroy;
end;

procedure TSess.Play;
begin
  FBlc.Play(0, 0);
end;

procedure TSess.BlcEndBlc(Sender: TObject);
begin

end;

end.
