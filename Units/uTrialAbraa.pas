unit uTrialAbraa;

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

  TAbraao = Class(TTrial)
  protected
    FFlagModCmps: Boolean;
    FHeader1, FHeader2: String;
    FLatMod: Integer;
    FLatCmp: Integer;
    FDataSMsg: String;
    FDataCMsg: String;
    FDataCsq: Byte;
    FSucessive: Boolean;
    FTimerDelay: TTimer;
    FTimerCsq: TTimer;
    FTimerClock: TTimer;
    FTimerLatMod: TTimer;
    FTimerLatCmp: TTimer;
    FFlagResp: Boolean;
    FKPlus: TSupportKey;
    FKMinus: TSupportKey;
    FSupportS: TSupportKey;
    FNumKeyC: Integer;
    FVetSupportC: Array of TSupportKey;

    procedure ShowKeyC;
    procedure TimerCsqTimer(Sender: TObject);
    procedure TimerDelayTimer(Sender: TObject);
    procedure TimerClockTimer(Sender: TObject);
    procedure TimerLatModTimer(Sender: TObject);
    procedure TimerLatCmpTimer(Sender: TObject);
    procedure EndTrial;
    procedure KeySResponse(Sender: TObject);
    procedure KeyCResponse(Sender: TObject);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeySEndMedia(Sender: TObject);

  public
    constructor Create(AOwner: TComponent); override;
    procedure Play(TestMode: Boolean); override;
  end;

implementation

uses uCfgSes;

constructor TAbraao.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);

  FHeader1:= 'Pos.Mod.' +#9+
             'Res.Mod.' +#9+
             'Lat.Mod.' +#9;
  FHeader2:= 'Res.Cmp.' +#9+
             'Lat.Cmp.' +#9+
             'Disp.   ';


  FTimerCsq:= TTimer.Create(Self);
  With FTimerCsq do begin
    Enabled:= False;
    Interval:= 10;
    OnTimer:= TimerCsqTimer;
  end;

  FTimerDelay:= TTimer.Create(Self);
  With FTimerDelay do begin
    Enabled:= False;
    Interval:= 0;
    OnTimer:= TimerDelayTimer;
  end;

  FTimerClock:= TTimer.Create(Self);
  With FTimerClock do begin
    Enabled:= False;
    Interval:= 1000;
    OnTimer:= TimerClockTimer;
  end;

  FTimerLatMod:= TTimer.Create(Self);
  With FTimerLatMod do begin
    Enabled:= False;
    Interval:= 100;
    OnTimer:= TimerLatModTimer;
  end;

  FTimerLatCmp:= TTimer.Create(Self);
  With FTimerLatCmp do begin
    Enabled:= False;
    Interval:= 100;
    OnTimer:= TimerLatCmpTimer;
  end;

end;

procedure TAbraao.Play(TestMode: Boolean);
var s1: String; R: TRect; a1: Integer;
begin
  Randomize;
  FFlagResp:= True;
  FFlagModCmps:= True;
  FNextTrial:= '-1';
  Color:= StrToIntDef(FCfgTrial.SList.Values['BkGnd'], 0);

  FSucessive:= StrToBoolDef(FCfgTrial.SList.Values['Sucessivo'], False);
  FTimerDelay.Interval:= StrToIntDef(FCfgTrial.SList.Values['Atraso'], 0);

  If TestMode then Cursor:= 0
  else Cursor:= StrToIntDef(FCfgTrial.SList.Values['Cursor'], 0);

  With FSupportS do begin
    Key:= TKey.Create(Self);
    Key.Parent:= Self;
    Key.FileName:= FCfgTrial.SList.Values['HootMedia'] + FCfgTrial.SList.Values['SStm'];
    Key.OnEndMedia:= KeySEndMedia;

    Msg:= FCfgTrial.SList.Values['SMsg'];
  end;

  FNumKeyC:= StrToIntDef(FCfgTrial.SList.Values['NumComp'], 0);

  SetLength(FVetSupportC, FNumKeyC);
  For a1:= 0 to FNumKeyC-1 do begin
    With FVetSupportC[a1] do begin
      Key:= TKey.Create(Self);
      Key.BorderColor:= clLime;
      Key.Tag:= a1;
      Key.Visible:= False;
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
  FTimerLatMod.Enabled:= True;
  FSupportS.Key.Play;

end;

procedure TAbraao.TimerCsqTimer(Sender: TObject);
begin
  FTimerCsq.Enabled:= False;

  outportb($378, 0);
  outportb($278, 0);

  EndTrial;
end;

procedure TAbraao.TimerDelayTimer(Sender: TObject);
begin
  FTimerDelay.Enabled:= False;
  ShowKeyC;
end;

procedure TAbraao.TimerClockTimer(Sender: TObject);
var a1: Integer;
begin
  FSupportS.Key.SchMan.Clock;
  For a1:= 0 to FNumKeyC-1 do
    FVetSupportC[a1].Key.SchMan.Clock;
end;

procedure TAbraao.TimerLatModTimer(Sender: TObject);
begin
  Inc(FLatMod);
end;

procedure TAbraao.TimerLatCmpTimer(Sender: TObject);
begin
  Inc(FLatCmp);
end;

procedure TAbraao.EndTrial;
var Pos_Mod, Resp_Mod, Lat_Mod, Res_Mask, Lat_Mask, Disp: String[8];
    PosComps: String;
    a1: Integer;
    s1: String;
begin
  FTimerClock.Enabled:= False;

{
  FHeader1:= 'Pos.Mod.' +#9+
             'Res.Mod.' +#9+
             'Lat.Mod.' +#9;
  FHeader2:= 'Res.Cmp.' +#9+
             'Lat.Cmp.' +#9+
             'Disp.   ';
}

  If FSupportS.Msg = '' then FSupportS.Msg:= '--------';
  Pos_Mod:= LeftStr(FSupportS.Msg+#32#32#32#32#32#32#32#32, 8);

  If FDataSMsg = '' then FDataSMsg:= '--------';
  Resp_Mod:= LeftStr(FDataSMsg+#32#32#32#32#32#32#32#32, 8);

  Lat_Mod:= LeftStr(IntToStr(FLatMod*100)+#32#32#32#32#32#32, 6)+'ms';

  For a1:= 0 to FNumKeyC-1 do begin
    If FVetSupportC[a1].Msg = '' then FVetSupportC[a1].Msg:= '-';
    PosComps:= PosComps + FVetSupportC[a1].Msg + #32;
    s1:= s1 + LeftStr(#32#32#32#32#32#32#32#32#32, Length(FVetSupportC[a1].Msg)+1);
  end;

  If FDataCMsg = '' then FDataCMsg:= '--------';
  Res_Mask:= LeftStr(FDataCMsg+#32#32#32#32#32#32#32#32, 8);

  Lat_Mask:= LeftStr(IntToStr(FLatCmp*100)+#32#32#32#32#32#32, 6)+'ms';

  Disp:= RightStr(IntToBin(FDataCsq)+#0, 8);

  Delete(s1, 1, 9);
  s1:= 'Pos.Comps'+s1;
  While Length(PosComps) < 9 do
    PosComps:= PosComps+#32; 
  FHeader:= FHeader1 + s1 + #9 + FHeader2;

  FData:= Pos_Mod+#9+Resp_Mod+#9+Lat_Mod+#9+PosComps+#9+Res_Mask+#9+Lat_Mask+#9+Disp;

  If Assigned(OnEndTrial) then FOnEndTrial(Self);
end;

procedure TAbraao.KeyDown(var Key: Word; Shift: TShiftState);
begin
  If ssCtrl in Shift then
    If Key = 13 then begin
      If FFlagModCmps then FDataSMsg:= 'Cancel'
      else FDataCMsg:= 'Cancel';
      EndTrial;
    end;

  If Key = 27 then
    FFlagResp:= False;

  If Key = 107 {+} then begin
    If FFlagModCmps then begin
      FFlagModCmps:= False;
      FSupportS.Key.Visible:= False;
      FTimerLatMod.Enabled:= False;

      FDataSMsg:= FKPlus.Msg;

      ShowKeyC;
    end else begin
      FDataCMsg:= FKPlus.Msg;
      FDataCsq:= FKPlus.Csq;
      FResult:= FKPlus.Res;

      outportb($378, FKPlus.Csq);
      outportb($278, FKPlus.Csq);
      FTimerCsq.Enabled:= True;
    end;
  end;

  If Key = 109{-} then begin
    If FFlagModCmps then begin
      FFlagModCmps:= False;
      FSupportS.Key.Visible:= False;
      FTimerLatMod.Enabled:= False;

      FDataSMsg:= FKMinus.Msg;

      ShowKeyC;
    end else begin
      FDataCMsg:= FKMinus.Msg;
      FDataCsq:= FKMinus.Csq;
      FResult:= FKMinus.Res;

      outportb($378, FKMinus.Csq);
      outportb($278, FKMinus.Csq);
      FTimerCsq.Enabled:= True;
    end;
  end;
end;

procedure TAbraao.KeyUp(var Key: Word; Shift: TShiftState);
begin
  If Key = 27 then
    FFlagResp:= True;
end;

procedure TAbraao.KeySEndMedia(Sender: TObject);
begin
  ShowKeyC;
end;

procedure TAbraao.ShowKeyC;
var a1: Integer;
begin
  For a1:= 0 to FNumKeyC-1 do
    FVetSupportC[a1].Key.Visible:= True;

  FTimerLatCmp.Enabled:= True;
end;

procedure TAbraao.KeySResponse(Sender: TObject);
begin
  FTimerLatMod.Enabled:= False;

  FFlagModCmps:= False;

  FSupportS.Key.Enabled:= False;
  FSupportS.Key.Visible:= not FSucessive;
  FDataSMsg:= FSupportS.Msg;

  If FTimerDelay.Interval > 0 then FTimerDelay.Enabled:= True
  else ShowKeyC;
end;

procedure TAbraao.KeyCResponse(Sender: TObject);
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


