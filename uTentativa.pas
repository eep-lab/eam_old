unit uTentativa;

interface

uses Windows, classes, controls, ExtCtrls, IdGlobal, Graphics, Forms, SysUtils,
     uCfgSes, uChave, uConseq, Messages;

type
  TEndTentEvent = procedure (Sender: TObject; Data: String; Result: Boolean) of object;

  TTentativa = class(TCustomControl)
  private
    FConseq: TConseq;
    FHeader: String;
    FIndChvCor: Integer;
    FLatencia: Integer;
    FOnEndTent: TEndTentEvent;
    FTent: PTent;
    FTimer2: TTimer;
    FTimerDurMax: TTimer;
    FIndChvResp: Integer;
    FVetChvMod: Array [0..8] of TChave;
    FVetChvCmp: Array [0..8] of TChave;
    procedure ChvModMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ChvCmpMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ConseqEndConseq(Sender: TObject);
    procedure MostraCompara;
    procedure MostraModelo;
    procedure RodaModelo;
    procedure Timer2Timer(Sender: TObject);
    procedure TimerDurMaxTimer(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EndTent;    
    procedure Paint; override;
    procedure PaintWindow(DC: HDC); override;
    procedure Play;
    procedure Reset;
    procedure SetCfgTent(CfgTent: PCfgTent);
    procedure SetTent(Tent: PTent);
    property IndChvCor: Integer read FIndChvCor write FIndChvCor;
    property OnEndTent: TEndTentEvent read FOnEndTent write FOnEndTent;
    property Header: String read FHeader;
  end;

const
    Labels: String =
    'Modelo(s)' +#9+ 'Comparações' +#9+ 'Correto' +#9+ 'Resposta' +#9+
    'Resultado' +#9+ 'Conseqüência' +#9+ 'Paralela' +#9+ 'Latência';

implementation

constructor TTentativa.Create(AOwner: TComponent);
var a1: Integer;
begin
  Inherited Create(AOwner);
  For a1:= 0 to 8 do begin
    FVetChvMod[a1]:= TChave.Create(Self);
    With FVetChvMod[a1] do begin
      OnMouseDown:= ChvModMouseDown;
      Parent:= Self;
    end;
  end;
  For a1:= 0 to 8 do begin
    FVetChvCmp[a1]:= TChave.Create(Self);
    With FVetChvCmp[a1] do begin
      Parent:= Self;
      Tag:= a1;
    end;
  end;
  FConseq:= TConseq.Create(Self);
  With FConseq do begin
    OnEndConseq:= ConseqEndConseq;
    Align:= alClient;
    Parent:= Self;
  end;
  FTimer2:= TTimer.Create(Self);
  With FTimer2 do begin
    Enabled:= False;
    OnTimer:= Timer2Timer;
    Interval:= 100;
  end;
  FTimerDurMax:= TTimer.Create(Self);
  With FTimerDurMax do begin
    Enabled:= False;
    OnTimer:= TimerDurMaxTimer;
  end;

  FHeader:= Labels;
  Reset;
end;

destructor TTentativa.Destroy;
begin
  Reset;
  Inherited Destroy;
end;

procedure TTentativa.Paint;
begin

end;

procedure TTentativa.PaintWindow(DC: HDC);
begin
  Canvas.Handle:= DC;
  Paint;
end;

procedure TTentativa.Play;
var a1: Integer; b1, b2: Boolean;
begin
  b1:= False; b2:= False;
  For a1:= 0 to 8 do If FVetChvMod[a1].Kind = stmSound then b1:= True;
  For a1:= 0 to 8 do If FVetChvMod[a1].Kind = stmImage then b2:= True;
  If b2 then MostraModelo
  else MostraCompara;
  If b1 then RodaModelo;
  FTimerDurMax.Enabled:= (FTimerDurMax.Interval > 0);
end;

procedure TTentativa.Reset;
var a1: Integer;
begin
  FTimer2.Enabled:= False;
  FTimerDurMax.Enabled:= False;
  Cursor:= crNone;
  FIndChvCor:= -1;
  FIndChvResp:= -1;
  FLatencia:= 0;
  For a1:= 0 to 8 do begin
    With FVetChvMod[a1] do begin
      Visible:= False;
      FileName:= '';
    end;
  end;
  For a1:= 0 to 8 do begin
    With FVetChvCmp[a1] do begin
      Visible:= False;
      FileName:= '';
    end;
  end;
  FConseq.Reset;
end;

procedure TTentativa.SetCfgTent(CfgTent: PCfgTent);
var a1: Integer;
begin
  For a1:= 0 to 8 do begin
    FVetChvMod[a1].SetBounds(CfgTent.ChvMod[a1].Left,
                             CfgTent.ChvMod[a1].Top,
                             CfgTent.ChvMod[a1].Right,
                             CfgTent.ChvMod[a1].Bottom);
  end;
  For a1:= 0 to 8 do begin
    FVetChvCmp[a1].SetBounds(CfgTent.ChvCmp[a1].Left,
                             CfgTent.ChvCmp[a1].Top,
                             CfgTent.ChvCmp[a1].Right,
                             CfgTent.ChvCmp[a1].Bottom);
  end;
  FConseq.SetCfgConseq(CfgTent);
end;

procedure TTentativa.SetTent(Tent: PTent);
var a1: Integer;
begin
  FTent:= Tent;
  Cursor:= FTent.CursorDeFundo;
  Color:= FTent.CorDeFundo;
  FTimerDurMax.Interval:= FTent.DuracaoMaxima;
  For a1:= 0 to 8 do begin
    FVetChvMod[a1].FileName:= FTent.Modelo[a1].PStm^;
    FVetChvMod[a1].Cursor:= FTent.CursorDasChaves;
  end;
  For a1:= 0 to 8 do begin
    FVetChvCmp[a1].FileName:= FTent.Compar[a1].PStm^;
    FVetChvCmp[a1].Cursor:= FTent.CursorDasChaves;
    FVetChvCmp[a1].OnMouseDown:= ChvCmpMouseDown;
  end;
  FConseq.SetConseq(Tent);
  IndChvCor:= FTent.IndChvCor;
end;

procedure TTentativa.ChvModMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var a1: Integer;
begin
  FTimerDurMax.Enabled:= False;
  For a1:= 0 to 8 do begin
    FVetChvMod[a1].Visible:= False;
    FVetChvMod[a1].Stop;
  end;
  MostraCompara;
end;

procedure TTentativa.ChvCmpMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var a1: Integer;
begin
  FTimerDurMax.Enabled:= False;
  TChave(Sender).OnClick:= nil;
  FTimer2.Enabled:= False;
  FIndChvResp:= TChave(Sender).Tag;
  Cursor:= crNone;

  For a1:= 0 to 8 do begin
    FVetChvMod[a1].Stop;
    FVetChvCmp[a1].Cursor:= crNone;
  end;

  If FIndChvResp = FIndChvCor then FConseq.DoConseq(0)
  else FConseq.DoConseq(1);
  
  For a1:= 0 to 8 do
    If FConseq.Visible then FVetChvCmp[a1].Visible:= False;
end;

procedure TTentativa.ConseqEndConseq(Sender: TObject);
begin
  EndTent;
end;

procedure TTentativa.EndTent;
var s1: String; a1: Integer; b1: Boolean;
begin
  FTimerDurMax.Enabled:= False;
  For a1:= 0 to 8 do
    If FVetChvMod[a1].Kind <> stmNone then
      s1:= s1+FTent.Modelo[a1].Conjunto+IntToStr(FTent.Modelo[a1].Classe)+#32;
  s1:= s1+#9;

  For a1:= 0 to 8 do
    If FVetChvCmp[a1].Kind <> stmNone then
      s1:= s1+FTent.Compar[a1].Conjunto+IntToStr(FTent.Compar[a1].Classe)+#32;
  s1:= s1+#9;

  If (FIndChvCor>-1) and (FIndChvCor<10) then
    If FVetChvCmp[FIndChvCor].Kind <> stmNone then
      s1:= s1+ FTent.Compar[FIndChvCor].Conjunto+IntToStr(FTent.Compar[FIndChvCor].Classe);
  s1:= s1+#9;

  If (FIndChvResp>-1) then s1:= s1+ FTent.Compar[FIndChvResp].Conjunto+IntToStr(FTent.Compar[FIndChvResp].Classe)+#9
  else s1:= s1+#9;

  If FIndChvCor = FIndChvResp then begin
    s1:= s1+'Correta'+#9;
    If FTent.CsqCor[0].PStm^>'' then s1:= s1+'CS'+IntToStr(FTent.CsqCor[0].IndCsq)+' ';
    If FTent.CsqCor[1].PStm^>'' then s1:= s1+'CS'+IntToStr(FTent.CsqCor[1].IndCsq);
    s1:= s1+#9;
    If FTent.CanParalel then
      s1:= s1+''+Copy(IntToBin(FTent.Paralela[0]), 25, 4)+'-'+Copy(IntToBin(FTent.Paralela[0]), 29, 4)+#9
    else s1:= s1+'Desativada'+#9;
  end else begin
    If (FIndChvResp>-1) then begin
      s1:= s1+'Errada'+#9;
      If FTent.CsqInc[0].PStm^>'' then s1:= s1+'CS'+IntToStr(FTent.CsqCor[0].IndCsq)+' ';
      If FTent.CsqInc[1].PStm^>'' then s1:= s1+'CS'+IntToStr(FTent.CsqCor[1].IndCsq);
      s1:= s1+#9;
      If FTent.CanParalel then
        s1:= s1+''+Copy(IntToBin(FTent.Paralela[1]), 25, 4)+'-'+Copy(IntToBin(FTent.Paralela[1]), 29, 4)+#9
      else s1:= s1+'Desativada'+#9;
    end else
      If FTent.DuracaoMaxima>0 then s1:= s1+'Tempo Esgotado'+#9+' '+#9+#9
      else s1:= s1+#9+#9+#9;
  end;

  s1:= s1+IntToStr(FLatencia)+#9;

  b1:= FIndChvCor = FIndChvResp;
  Reset;
  Application.ProcessMessages;
  If Assigned(OnEndTent) then FOnEndTent(Self, s1, b1);
end;

procedure TTentativa.MostraCompara;
var a1: Integer; b1: Boolean;
begin
  FTimer2.Enabled:= True;
  b1:= True;
  For a1:= 0 to 8 do
    If FVetChvCmp[a1].Kind = stmImage then begin
      FVetChvCmp[a1].Visible:= True;
      b1:= False;
    end;
  If b1 then EndTent;
end;

procedure TTentativa.MostraModelo;
var a1: Integer;
begin
  For a1:= 0 to 8 do
    If FVetChvMod[a1].Kind = stmImage then
      FVetChvMod[a1].Visible:= True;
end;

procedure TTentativa.RodaModelo;
var a1: Integer;
begin
  For a1:= 0 to 8 do
    If FVetChvMod[a1].Kind = stmSound then begin
      FVetChvMod[a1].Play;
      Break;
    end;
end;

procedure TTentativa.Timer2Timer(Sender: TObject);
begin
  FLatencia:= FLatencia + 100;
end;

procedure TTentativa.TimerDurMaxTimer(Sender: TObject);
begin
  EndTent;  
end;

end.
