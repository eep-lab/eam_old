unit uConseq;

interface

uses Windows, SysUtils, Classes, Controls, ExtCtrls,
     uCfgSes, uChave;

type                                     
  TConseq = class(TCustomControl)
  private
    FOnEndConseq: TNotifyEvent;
    FCanParalel: Boolean;
    FFlagEndConseq1: Boolean;
    FFlagEndConseq2: Boolean;
    FTimer1: TTimer;
    FTimerAtraso: TTimer;
    FTimerParalel: TTimer;
    FVetChvCsqCor: Array [0..1] of TChave;
    FVetChvCsqInc: Array [0..1] of TChave;
    FParalelaR:  Byte;
    FParalelaP:  Byte;
    FIndConseq: Smallint;
    procedure EndConseq;
    procedure ChvCsqEndMedia(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TimerAtrasoTimer(Sender: TObject);
    procedure TimerParalelTimer(Sender: TObject);
    function  GetChave(Ind: Integer): TChave;
    procedure RunPunish;
    procedure RunReinf;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoConseq(Ind: Integer);
    procedure Reset;
    procedure SetCfgConseq(CfgConseq: PCfgTent);
    procedure SetConseq(Conseq: PTent);
    property Chv[Ind: Integer]: TChave read GetChave;
    property OnEndConseq: TNotifyEvent read FOnEndConseq write FOnEndConseq;
  end;

implementation

constructor TConseq.Create(AOwner: TComponent);
var a1: Integer;
begin
  inherited Create(AOwner);
  Visible:= False;
  For a1:= 0 to 1 do begin
    FVetChvCsqCor[a1]:= TChave.Create(Self);
    With FVetChvCsqCor[a1] do begin
      OnEndMedia:= ChvCsqEndMedia;
      Parent:= Self;
    end;
  end;
  For a1:= 0 to 1 do begin
    FVetChvCsqInc[a1]:= TChave.Create(Self);
    With FVetChvCsqInc[a1] do begin
      OnEndMedia:= ChvCsqEndMedia;
      Parent:= Self;
    end;
  end;
  FTimer1:= TTimer.Create(Self);
  With FTimer1 do begin
    Enabled:= False;
    OnTimer:= Timer1Timer;
  end;
  FTimerAtraso:= TTimer.Create(Self);
  With FTimerAtraso do begin
    Enabled:= False;
    OnTimer:= TimerAtrasoTimer;
  end;
  FTimerParalel:= TTimer.Create(Self);
  With FTimerParalel do begin
    Enabled:= False;
    OnTimer:= TimerParalelTimer;
    Interval:= 200;
  end;
  FFlagEndConseq1:= False;
  FFlagEndConseq2:= False;
end;

destructor TConseq.Destroy;
begin
  inherited Destroy;
end;

procedure TConseq.Reset;
var a1: Integer;
begin
  FFlagEndConseq1:= False;
  FFlagEndConseq2:= False;
  For a1:= 0 to 1 do begin
    With FVetChvCsqCor[a1] do begin
      Visible:= False;
      FileName:= '';
    end;
  end;
  For a1:= 0 to 1 do begin
    With FVetChvCsqInc[a1] do begin
      Visible:= False;
      FileName:= '';
    end;
  end;
end;

procedure TConseq.SetCfgConseq(CfgConseq: PCfgTent);
var a1: Integer;
begin
  For a1:= 0 to 1 do begin
    FVetChvCsqCor[a1].SetBounds(CfgConseq.ChvCsqCor[a1].Left,
                                CfgConseq.ChvCsqCor[a1].Top,
                                CfgConseq.ChvCsqCor[a1].Right,
                                CfgConseq.ChvCsqCor[a1].Bottom);
    FVetChvCsqInc[a1].SetBounds(CfgConseq.ChvCsqInc[a1].Left,
                                CfgConseq.ChvCsqInc[a1].Top,
                                CfgConseq.ChvCsqInc[a1].Right,
                                CfgConseq.ChvCsqInc[a1].Bottom);
  end;
end;

procedure TConseq.SetConseq(Conseq: PTent);
var a1: Integer;
begin
  FTimer1.Interval:= Conseq.TempoConseq;
  FTimerAtraso.Interval:= Conseq.Atraso;
  For a1:= 0 to 1 do begin
    FVetChvCsqCor[a1].FileName:= Conseq.CsqCor[a1].PStm^;
    FVetChvCsqInc[a1].FileName:= Conseq.CsqInc[a1].PStm^;
  end;
  FCanParalel:= Conseq.CanParalel;
  FParalelaR:= Conseq.Paralela[0];
  FParalelaP:= Conseq.Paralela[1];
end;

procedure TConseq.DoConseq(Ind: Integer);
begin
  FIndConseq:= Ind;
  If FTimerAtraso.Interval = 0 then begin
    If FIndConseq = 0 then RunReinf else RunPunish;
  end else FTimerAtraso.Enabled:= True;
end;

procedure TConseq.EndConseq;
begin
  If (FFlagEndConseq1 or not FCanParalel) and FFlagEndConseq2 then begin
    If FCanParalel then begin
      Try
        asm
          mov dx, $378
          mov al, 0
          out dx, al
          mov dx, $278
          mov al, 0
          out dx, al
        end;
      Except end;
    end;
    Visible:= False;
    FVetChvCsqCor[0].Visible:= False;
    FVetChvCsqCor[1].Visible:= False;
    FVetChvCsqInc[0].Visible:= False;
    FVetChvCsqInc[1].Visible:= False;
    If Assigned(FOnEndConseq) then FOnEndConseq(Self);
  end;
end;

procedure TConseq.ChvCsqEndMedia(Sender: TObject);
begin
  FFlagEndConseq2:= True;
  EndConseq;
end;

procedure TConseq.Timer1Timer(Sender: TObject);
begin
  FTimer1.Enabled:= False;
  FFlagEndConseq2:= True;
  EndConseq;
end;

procedure TConseq.TimerAtrasoTimer(Sender: TObject);
begin
  FTimerAtraso.Enabled:= False;
  If FIndConseq = 0 then RunReinf else RunPunish;
end;

procedure TConseq.TimerParalelTimer(Sender: TObject);
begin
  FTimerParalel.Enabled:= False;
  FFlagEndConseq1:= True;
  EndConseq;
end;

function TConseq.GetChave(Ind: Integer): TChave;
begin
  If (Ind > -1) and (Ind < 2) then Result:= FVetChvCsqCor[Ind]
  else Result:= nil;
end;

procedure TConseq.RunPunish;
begin
  If FCanParalel then begin
    Try
      asm
        mov dx, $378
        mov al, FParalelaP
        out dx, al
        mov dx, $278
        mov al, FParalelaP
        out dx, al
      end;
      FTimerParalel.Enabled:= True;
    Except
      FFlagEndConseq1:= True;
    end;
  end;
  If (FVetChvCsqInc[0].Kind = stmSound) or (FVetChvCsqInc[1].Kind = stmSound) then begin
    If (FVetChvCsqInc[0].Kind = stmSound) then begin
      FVetChvCsqInc[0].Play;
      If (FVetChvCsqInc[1].Kind = stmImage) then begin
        FVetChvCsqInc[1].Visible:= True;
        Visible:= True;
      end;
    end else begin
      FVetChvCsqInc[1].Play;
      If (FVetChvCsqInc[0].Kind = stmImage) then begin
        FVetChvCsqInc[0].Visible:= True;
        Visible:= True;
      end;
    end;
  end else begin
    If (FVetChvCsqInc[0].Kind = stmImage) or (FVetChvCsqInc[1].Kind = stmImage) then begin
      Visible:= True;
      If (FVetChvCsqInc[0].Kind = stmImage) then FVetChvCsqInc[0].Visible:= True;
      If (FVetChvCsqInc[1].Kind = stmImage) then FVetChvCsqInc[1].Visible:= True;
      If FTimer1.Interval = 0 then Timer1Timer(nil)
      else FTimer1.Enabled:= True;
    end else begin
      FFlagEndConseq2:= True;
      EndConseq;
    end
  end;
end;

procedure TConseq.RunReinf;
begin
  If FCanParalel then begin
    Try
      asm
        mov dx, $378
        mov al, FParalelaR
        out dx, al
        mov dx, $278
        mov al, FParalelaR
        out dx, al
      end;
      FTimerParalel.Enabled:= True;
    Except
      FFlagEndConseq1:= True;
    end;
  end;
  If (FVetChvCsqCor[0].Kind = stmSound) or (FVetChvCsqCor[1].Kind = stmSound) then begin
    If (FVetChvCsqCor[0].Kind = stmSound) then begin
      FVetChvCsqCor[0].Play;
      If (FVetChvCsqCor[1].Kind = stmImage) then begin
        FVetChvCsqCor[1].Visible:= True;
        Visible:= True;
      end;
    end else begin
      FVetChvCsqCor[1].Play;
      If (FVetChvCsqCor[0].Kind = stmImage) then begin
        FVetChvCsqCor[0].Visible:= True;
        Visible:= True;
      end;
    end;
  end else begin
    If (FVetChvCsqCor[0].Kind = stmImage) or (FVetChvCsqCor[1].Kind = stmImage) then begin
      Visible:= True;
      If (FVetChvCsqCor[0].Kind = stmImage) then FVetChvCsqCor[0].Visible:= True;
      If (FVetChvCsqCor[1].Kind = stmImage) then FVetChvCsqCor[1].Visible:= True;
      If FTimer1.Interval = 0 then Timer1Timer(nil)
      else FTimer1.Enabled:= True;
    end else begin
      FFlagEndConseq2:= True;
      EndConseq;
    end;
  end;
end;

end.
