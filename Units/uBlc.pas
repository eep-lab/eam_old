unit uBlc;

interface

uses Classes, IdGlobal, Controls, Windows, ExtCtrls, SysUtils, StrUtils, Graphics, Forms,
     uCfgSes, uTrial, uRegData,
     uTrialMsg,
     uTrialMTS, uTrialSimpl,
     uTrialNat, uTrialNatC, uTrialMar,
     uTrialMTSPgl,
     uTrialAbraa;

type
  TThreadTrial = class(TThread)
  private
  public
    procedure Execute; override;
  end;

  TRecCrtMan = Record
    FlagSatisfied: Boolean;
    Count: Integer;
  end;

  TBlc = class(TComponent)
  private
    FBlcHeader: String;
    FCountTrial: Integer;
    FRegData: TRegData;
    FNextBlc: String;
    FOnEndBlc: TNotifyEvent;
    FBackGround: TWinControl;
    FCfgBlc: TCfgBlc;
    FLastHeader: String;
    FTheadTrial: TThreadTrial;
    FIndTrial: Integer;
    FTimerITI: TTimer;
    FTrial: TTrial;
    FVetCountOperand1: Array of TRecCrtMan;
    FTestMode: Boolean;
    procedure EndBlc;
    procedure TrialEndTrial(Sender: TObject);
    procedure ThreadTrialTerminate(Sender: TObject);
    procedure TimerITITimer(Sender: TObject);
    procedure PlayTrial;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Play(CfgBlc: TCfgBlc; IndTent: Integer; TestMode: Boolean);

    property RegData: TRegData write FRegData;
    property OnEndBlc: TNotifyEvent read FOnEndBlc write FOnEndBlc;
    property BackGround: TWinControl read FBackGround write FBackGround;
    property NextBlc: String read FNextBlc write FNextBlc;
  end;

implementation

procedure TThreadTrial.Execute;
begin
  Suspend;
end;

procedure TBlc.EndBlc;
var a1: Integer; b1: Boolean;
begin
  a1:= 0;
  b1:= False;
  While (a1 < FCfgBlc.NumCrt) and not b1 do begin
    Case FCfgBlc.VetCrtBlc[a1].Operator of
      '=': FVetCountOperand1[a1].FlagSatisfied:= FVetCountOperand1[a1].Count = FCfgBlc.VetCrtBlc[a1].Operand2;
      '>': FVetCountOperand1[a1].FlagSatisfied:= FVetCountOperand1[a1].Count > FCfgBlc.VetCrtBlc[a1].Operand2;
      '<': FVetCountOperand1[a1].FlagSatisfied:= FVetCountOperand1[a1].Count < FCfgBlc.VetCrtBlc[a1].Operand2;
    end;
    b1:= FVetCountOperand1[a1].FlagSatisfied;
    Inc(a1);
  end;
  Dec(a1);
  If b1 then FNextBlc:= FCfgBlc.VetCrtBlc[a1].NextBlc
  else FNextBlc:= FCfgBlc.DefNextBlc;

  FRegData.SaveData(#13#10);

  If Assigned(OnEndBlc) then FOnEndBlc(Self);
end;

procedure TBlc.TrialEndTrial(Sender: TObject);
begin
  FTheadTrial.Resume;
end;

procedure TBlc.ThreadTrialTerminate(Sender: TObject);
var a1: Integer; NumTr, NameTr: String[8];
begin
  If FTrial.Header <> FLastHeader then
    FRegData.SaveData(#13#10+FBlcHeader+FTrial.Header+#13#10);
  FLastHeader:= FTrial.Header;
  FBlcHeader:= #32#32#32#32#32#32#32#32#9#32#32#32#32#32#32#32#32#9;

  NumTr:= LeftStr(IntToStr(FCountTrial)+#32#32#32#32#32#32#32#32, 8);
  NameTr:= LeftStr(FCfgBlc.VetCfgTrial[FIndTrial].Name+#32#32#32#32#32#32#32#32, 8);
  If NameTr = #32#32#32#32#32#32#32#32 then NameTr:= '--------';
  FRegData.SaveData(NumTr+#9+NameTr+#9+FTrial.Data+#13#10);

  For a1:= 0 to FCfgBlc.NumCrt-1 do
    If FTrial.Result = FCfgBlc.VetCrtBlc[a1].Operand1 then
      Inc(FVetCountOperand1[a1].Count);

  If FTrial.NextTrial = 'end' then
    FIndTrial:= FCfgBlc.NumTrials;
  If StrToIntDef(FTrial.NextTrial, -1) > -1 then FIndTrial:= StrToInt(FTrial.NextTrial)-1
  else Inc(FIndTrial);

  FTrial.Free;

  If FTimerITI.Interval > 0 then FTimerITI.Enabled:= True
  else PlayTrial;
end;

procedure TBlc.TimerITITimer(Sender: TObject);
begin
  FTimerITI.Enabled:= False;
  PlayTrial;
end;

constructor TBlc.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);

  FTimerITI:= TTimer.Create(Self);
  With FTimerITI do begin
    Enabled:= False;
    OnTimer:= TimerITITimer;
  end;
end;

destructor TBlc.Destroy;
begin
  Inherited Destroy;
end;

procedure TBlc.Play(CfgBlc: TCfgBlc; IndTent: Integer; TestMode: Boolean);
var a1: Integer;
begin
  FCfgBlc:= CfgBlc;
  FTestMode:= TestMode;
  If FBackGround is TForm then TForm(FBackGround).Color:= FCfgBlc.BkGnd;

  If FTestMode then FTimerITI.Interval:= 0
  else FTimerITI.Interval:= FCfgBlc.ITI;

  FLastHeader:= '';

  SetLength(FVetCountOperand1, FCfgBlc.NumCrt);
  For a1:= 0 to FCfgBlc.NumCrt-1 do
    FVetCountOperand1[a1].Count:= 0;

  FCountTrial:= 0;
  FIndTrial:= IndTent;

  FBlcHeader:= 'Núm.Tent'+#9+'Nom.Tent'+#9;
  FRegData.SaveData(FCfgBlc.Name);

  If FTestMode then FTimerITI.Interval:= 0
  else FTimerITI.Interval:= FCfgBlc.ITI;

  PlayTrial;
end;

procedure TBlc.PlayTrial;
begin
  If FIndTrial < FCfgBlc.NumTrials then begin
    FTrial:= nil;

    If FCfgBlc.VetCfgTrial[FIndTrial].Kind = 'Msg' then FTrial:= TMsg.Create(Self);

    If FCfgBlc.VetCfgTrial[FIndTrial].Kind = 'Nat' then FTrial:= TNat.Create(Self);
    If FCfgBlc.VetCfgTrial[FIndTrial].Kind = 'NatC' then FTrial:= TNatC.Create(Self);
    If FCfgBlc.VetCfgTrial[FIndTrial].Kind = 'Mar' then FTrial:= TMar.Create(Self);

    If FCfgBlc.VetCfgTrial[FIndTrial].Kind = 'MTS' then FTrial:= TMTS.Create(Self);
    If FCfgBlc.VetCfgTrial[FIndTrial].Kind = 'Simpl' then FTrial:= TSimpl.Create(Self);
    If FCfgBlc.VetCfgTrial[FIndTrial].Kind = 'MTSPgl' then FTrial:= TMTSPgl.Create(Self);
    If FCfgBlc.VetCfgTrial[FIndTrial].Kind = 'Abraão' then FTrial:= TAbraao.Create(Self);


    If Assigned(FTrial) then begin
      Inc(FCountTrial);
      FTrial.Parent:= FBackGround;
      FTrial.Align:= alClient;
      FTrial.OnEndTrial:= TrialEndTrial;
      FTrial.CfgTrial:= FCfgBlc.VetCfgTrial[FIndTrial];
      FTrial.SetFocus;

      FTheadTrial:= TThreadTrial.Create(True);
      FTheadTrial.Priority:= tpHighest;
      FTheadTrial.OnTerminate:= ThreadTrialTerminate;
      FTheadTrial.Resume;

      FTrial.Play(FTestMode);

    end else EndBlc;
  end else EndBlc;
end;

end.
