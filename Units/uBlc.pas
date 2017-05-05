unit uBlc;

interface

uses Windows, Classes,
     uCfgSes, uAbsTent, uSeq, fSuport;

type
  TThrPlay = class(TThread)
  private
    FAbsTent: TAbsTent;
    procedure AbsTentEndTent(Sender: TObject);
  public
    constructor Create(Suspended: Boolean);
    procedure Execute; override;
    property AbsTent: TAbsTent read FAbsTent write FAbsTent;
  end;

  TBlc = class(TComponent)
  private
    FAbsTent: TAbsTent;
    FCfgSes: TCfgSes;
    FIndBlc: Integer;
    FIndRefTent: Integer;
    FOnEndBlc: TNotifyEvent;
    FSeq: TSeq;
    FThrPlay: TThrPlay;
    function GetNextTent(Param: String): TAbsTent;
    procedure ThreadPlayTerminate(Sender: TObject);
  public
    constructor Create(AOwner: TComponent; CfgSes: TCfgSes; Seq: TSeq); reintroduce;
    destructor Destroy; override;
    procedure Play(IndBlc, IndTent: Integer);
    property OnEndBlc: TNotifyEvent read FOnEndBlc write FOnEndBlc;
  end;

implementation

procedure TThrPlay.AbsTentEndTent(Sender: TObject);
begin
  Resume;
end;

constructor TThrPlay.Create(Suspended: Boolean);
begin
  Inherited Create(Suspended);
  FreeOnTerminate:= True;
end;

procedure TThrPlay.Execute;
begin
  If Assigned(FAbsTent) then
    Try
      FAbsTent.OnEndTent:= AbsTentEndTent;
      FAbsTent.Play;
      Suspend;
    Except
      Terminate;
    end;
  FAbsTent:= nil;
end;

constructor TBlc.Create(AOwner: TComponent; CfgSes: TCfgSes; Seq: TSeq);
begin
  Inherited Create(AOwner);
  FCfgSes:= CfgSes;
  FSeq:= Seq;
end;

destructor TBlc.Destroy;
begin
  Inherited Destroy;
end;

procedure TBlc.Play(IndBlc, IndTent: Integer);
begin
  FIndBlc:= IndBlc;
  FIndRefTent:= IndTent;
  FAbsTent:= FSeq.LoadAbsTent(FCfgSes.CfgBlc[FIndBlc].RefTent[FIndRefTent].IndSeq,
                              FCfgSes.CfgBlc[FIndBlc].RefTent[FIndRefTent].IndTent);

  If Assigned(FAbsTent) then FAbsTent.Parent:= FmSup;

  FThrPlay:= TThrPlay.Create(True);
  FThrPlay.OnTerminate:= ThreadPlayTerminate;
  FThrPlay.Priority:= tpTimeCritical;
  FThrPlay.AbsTent:= FAbsTent;

  FThrPlay.Resume;
end;

function TBlc.GetNextTent(Param: String): TAbsTent;
var a1: Integer; b1: Boolean;
begin
  Result:= nil;
  b1:= False;
  For a1:= 0 to FCfgSes.CfgBlc[FIndBlc].RefTent[FIndRefTent].NumCrt-1 do
    If Param = FCfgSes.CfgBlc[FIndBlc].RefTent[FIndRefTent].Crt_Msg[a1] then begin
      b1:= True;
      FIndBlc:= FCfgSes.CfgBlc[FIndBlc].RefTent[FIndRefTent].Crt_IndBlc[a1];
      FIndRefTent:= FCfgSes.CfgBlc[FIndBlc].RefTent[FIndRefTent].Crt_IndTent[a1];
    end;
  If b1 then
    Result:= FSeq.LoadAbsTent(FCfgSes.CfgBlc[FIndBlc].RefTent[FIndRefTent].IndSeq,
                              FCfgSes.CfgBlc[FIndBlc].RefTent[FIndRefTent].IndTent);
end;

procedure TBlc.ThreadPlayTerminate(Sender: TObject);
var AuxTent: TAbsTent;
begin
  AuxTent:= GetNextTent(FAbsTent.Result);
  FAbsTent.Free;
  If Assigned(AuxTent) then begin
    FAbsTent:= AuxTent;
    FAbsTent.Parent:= FmSup;

    FThrPlay:= TThrPlay.Create(True);
    FThrPlay.OnTerminate:= ThreadPlayTerminate;
    FThrPlay.Priority:= tpTimeCritical;
    FThrPlay.AbsTent:= FAbsTent;

    FThrPlay.Resume;
  end else
    If Assigned(OnEndBlc) then FOnEndBlc(Self);
end;

end.
