unit uBloco;

interface

uses Classes, uCfgSes, ExtCtrls, uTentativa;

type
  TEndBlcEvent = procedure (Sender: TObject; Data: String; Result: Integer) of object;

  TBloco = class(TComponent)
  private
    FBlc: PBlc;
    FDatas: String;
    FTentativa: TTentativa;
    FTimer1: TTimer;
    FIndTent: Integer;
    FNumErros: Integer;
    FOnEndBlc: TEndBlcEvent;
    procedure TentativaEndTent(Sender: TObject; Data: String; Result: Boolean);
    procedure EndBlc;
    procedure Timer1Timer(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure NextTent(Ind: Integer);
    procedure Play;
    procedure Reset(Blc: PBlc; Tentativa: TTentativa);
    property OnEndBlc: TEndBlcEvent read FOnEndBlc write FOnEndBlc;
  end;

implementation

constructor TBloco.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FTimer1:= TTimer.Create(Self);
  With FTimer1 do begin
    Enabled:= False;
    OnTimer:= Timer1Timer;
  end;
end;

destructor TBloco.Destroy;
begin                                                
  Inherited Destroy;
end;

procedure TBloco.NextTent(Ind: Integer);
begin
  Case Ind of
    0: If FTentativa.Mode = mtStopped then Play;
    1: If FTentativa.Mode = mtPlaying then FTentativa.Response(True);
    2: If FTentativa.Mode = mtPlaying then FTentativa.Response(False);
  end;
end;

procedure TBloco.Play;
begin
  If FBlc.NumTent > 0 then begin
    FTentativa.Reset;
    FTentativa.SetTent(FBlc.VetTent[FIndTent]);
    FTentativa.OnEndTent:= TentativaEndTent;
    FTentativa.Play;
  end else EndBlc;
end;

procedure TBloco.Reset(Blc: PBlc; Tentativa: TTentativa);
begin
  FIndTent:= 0;
  FNumErros:= 0;
  FBlc:= Blc;
  FTimer1.Interval:= Trunc(FBlc.ITI);
  FTentativa:= Tentativa;
  FDatas:= FTentativa.Header+#10;
end;

procedure TBloco.TentativaEndTent(Sender: TObject; Data: String; Result: Boolean);
begin
  FDatas:= FDatas+Data+#10;
  If not Result then Inc(FNumErros);
  If FTimer1.Interval = 0 then Timer1Timer(nil)
  else FTimer1.Enabled:= True;
end;

procedure TBloco.EndBlc;
begin
  If Assigned(OnEndBlc) then FOnEndBlc(Self, FDatas, FNumErros);
end;

procedure TBloco.Timer1Timer(Sender: TObject);
begin
  FTimer1.Enabled:= False;
  If (FBlc.NumTent-1 > FIndTent) then begin
    Inc(FIndTent);
//    Play;
    NextTent(0);
  end else begin
    EndBlc;
  end;
end;

end.
