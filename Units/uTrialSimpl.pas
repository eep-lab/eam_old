unit uTrialSimpl;

interface

uses Classes, Types, SysUtils, Controls, Graphics, ExtCtrls, StrUtils, IdGlobal,
     uKey, uTrial;

type
  TSupportKey = Record
    Key: TKey;
    Csq: Byte;
    Msg: String;
    Nxt: String;
    Res: String;
  end;

  TSimpl = Class(TTrial)
  protected
    FLatCmp: Integer;
    FDataCMsg: String;
    FDataCsq: Byte;
    FTimerCsq: TTimer;
    FTimerClock: TTimer;
    FTimerLatCmp: TTimer;
    FFlagResp: Boolean;
    FKPlus: TSupportKey;
    FKMinus: TSupportKey;
    FNumKeyC: Integer;
    FVetSupportC: Array of TSupportKey;

    procedure TimerCsqTimer(Sender: TObject);
    procedure TimerClockTimer(Sender: TObject);
    procedure TimerLatCmpTimer(Sender: TObject);
    procedure EndTrial;
    procedure KeyCResponse(Sender: TObject);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;

  public
    constructor Create(AOwner: TComponent); override;
    procedure Play(TestMode: Boolean); override;
  end;

implementation

uses uCfgSes;

constructor TSimpl.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);

  FTimerCsq:= TTimer.Create(Self);
  With FTimerCsq do begin
    Enabled:= False;
    Interval:= 10;
    OnTimer:= TimerCsqTimer;
  end;

  FTimerClock:= TTimer.Create(Self);
  With FTimerClock do begin
    Enabled:= False;
    Interval:= 1000;
    OnTimer:= TimerClockTimer;
  end;

  FTimerLatCmp:= TTimer.Create(Self);
  With FTimerLatCmp do begin
    Enabled:= False;
    Interval:= 100;
    OnTimer:= TimerLatCmpTimer;
  end;

end;

procedure TSimpl.Play(TestMode: Boolean);
var s1: String; R: TRect; a1: Integer;
begin
  Randomize;
  FFlagResp:= True;
  FNextTrial:= '-1';
  Color:= StrToIntDef(FCfgTrial.SList.Values['BkGnd'], 0);

  If TestMode then Cursor:= 0
  else Cursor:= StrToIntDef(FCfgTrial.SList.Values['Cursor'], 0);

  FNumKeyC:= StrToIntDef(FCfgTrial.SList.Values['NumComp'], 0);

  SetLength(FVetSupportC, FNumKeyC);
  For a1:= 0 to FNumKeyC-1 do begin
    With FVetSupportC[a1] do begin
      Key:= TKey.Create(Self);
      Key.BorderColor:= clLime;
      Key.Tag:= a1;
      Key.Cursor:= Self.Cursor;
      Key.Parent:= Self;
      Key.OnResponse:= KeyCResponse;

      s1:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Bnd'];
      R.Left:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
      Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
      R.Top:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
      Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
      R.Right:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
      Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
      R.Bottom:= StrToIntDef(s1, 0);
      Key.SetBounds(R.Left, R.Top, R.Right, R.Bottom);

      Key.FileName:= FCfgTrial.SList.Values['HootMedia'] + FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Stm'];

      Key.SchMan.Kind:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Sch'];

      Csq:= StrToIntDef(FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Csq'], 255);

      Msg:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Msg'];
      Res:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Res'];
      Nxt:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Nxt'];
    end;
  end;

  With FKPlus do begin
    Csq:= StrToIntDef(FCfgTrial.SList.Values['K+Csq'], 255);
    Msg:= FCfgTrial.SList.Values['K+Msg'];
    Res:= FCfgTrial.SList.Values['K+Res'];
    Nxt:= FCfgTrial.SList.Values['K+Nxt'];
  end;

  With FKMinus do begin
    Csq:= StrToIntDef(FCfgTrial.SList.Values['K-Csq'], 0);
    Msg:= FCfgTrial.SList.Values['K-Msg'];
    Res:= FCfgTrial.SList.Values['K-Res'];
    Nxt:= FCfgTrial.SList.Values['K-Nxt'];
  end;

  FTimerClock.Enabled:= True;
  FTimerLatCmp.Enabled:= True;
end;

procedure TSimpl.TimerCsqTimer(Sender: TObject);
begin
  FTimerCsq.Enabled:= False;

  outportb($378, 0);
  outportb($278, 0);

  EndTrial;
end;

procedure TSimpl.TimerClockTimer(Sender: TObject);
var a1: Integer;
begin
  For a1:= 0 to FNumKeyC-1 do
    FVetSupportC[a1].Key.SchMan.Clock;
end;

procedure TSimpl.TimerLatCmpTimer(Sender: TObject);
begin
  Inc(FLatCmp);
end;

procedure TSimpl.EndTrial;
var Res_Cmp, Lat_Cmp, Disp: String[8];
    PosComps: String;
    a1: Integer;
    s1: String;
begin
  FTimerClock.Enabled:= False;

  FHeader:= 'Res.Cmp.' +#9+
            'Lat.Cmp.' +#9+
            'Disp.   ';

  For a1:= 0 to FNumKeyC-1 do begin
    If FVetSupportC[a1].Msg = '' then FVetSupportC[a1].Msg:= '-';
    PosComps:= PosComps + FVetSupportC[a1].Msg + #32;
    s1:= s1 + LeftStr(#32#32#32#32#32#32#32#32#32, Length(FVetSupportC[a1].Msg)+1);
  end;

  If FDataCMsg = '' then FDataCMsg:= '--------';
  Res_Cmp:= LeftStr(FDataCMsg+#32#32#32#32#32#32#32#32, 8);

  Lat_Cmp:= LeftStr(IntToStr(FLatCmp*100)+#32#32#32#32#32#32, 6)+'ms';

  Disp:= RightStr(IntToBin(FDataCsq)+#0, 8);

  Delete(s1, 1, 9);
  s1:= 'Pos.Comps'+s1;
  While Length(PosComps) < 9 do
    PosComps:= PosComps+#32;
  FHeader:= s1 + #9 + FHeader;

  FData:= PosComps+#9+Res_Cmp+#9+Lat_Cmp+#9+Disp;

  If Assigned(OnEndTrial) then FOnEndTrial(Self);
end;

procedure TSimpl.KeyDown(var Key: Word; Shift: TShiftState);
begin
  If ssCtrl in Shift then
    If Key = 13 then begin
      FDataCMsg:= 'Cancel';
      EndTrial;
    end;

  If Key = 27 then
    FFlagResp:= False;

  If Key = 107 {+} then begin
    FDataCMsg:= FKPlus.Msg;
    FDataCsq:= FKPlus.Csq;
    FResult:= FKPlus.Res;

    outportb($378, FKPlus.Csq);
    outportb($278, FKPlus.Csq);
    FTimerCsq.Enabled:= True;
  end;

  If Key = 109{-} then begin
    FDataCMsg:= FKMinus.Msg;
    FDataCsq:= FKMinus.Csq;
    FResult:= FKMinus.Res;

    outportb($378, FKMinus.Csq);
    outportb($278, FKMinus.Csq);
    FTimerCsq.Enabled:= True;
  end;
end;

procedure TSimpl.KeyUp(var Key: Word; Shift: TShiftState);
begin
  If Key = 27 then
    FFlagResp:= True;
end;

procedure TSimpl.KeyCResponse(Sender: TObject);
begin
  If FFlagResp then begin
    FTimerLatCmp.Enabled:= False;

    FDataCMsg:= FVetSupportC[TKey(Sender).Tag].Msg;

    FNextTrial:= FVetSupportC[TKey(Sender).Tag].Nxt;

    FDataCsq:= FVetSupportC[TKey(Sender).Tag].Csq;
    outportb($378, FVetSupportC[TKey(Sender).Tag].Csq);
    outportb($278, FVetSupportC[TKey(Sender).Tag].Csq);
    FTimerCsq.Enabled:= True;
  end;
end;

end.
