unit uTrialMTSSuc;

interface

uses Controls, Classes, Windows, SysUtils, Graphics, ExtCtrls, Forms,
     uTrial, uCfgSes, uKey;

type
  TSupport = Record
    Key: TChave;
    Des: String;
    Csq: Byte;
    Msg: String;
  end;

  TMTSSuc = class(TTrial)
  private
    FFlagResp: Boolean;
    FDataRespCmp: String;
    FDataRespMod: String;
    FDataCsq: String;
    FLatMod: Integer;
    FLatCmp: Integer;
    FTimerCsq: TTimer;
    FTimerLatMod: TTimer;
    FTimerLatCmp: TTimer;
    FKPlus: TSupport;
    FKMinus: TSupport;
    FSupportSample: TSupport;
    FVetSupport: Array [0..8] of TSupport;
    procedure TimerCsqTimer(Sender: TObject);
    procedure TimerLatModTimer(Sender: TObject);
    procedure TimerLatCmpTimer(Sender: TObject);
    procedure KeyCompMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure KeySampleMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EndTrial;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure Paint; override;
    procedure PaintWindow(DC: HDC); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Play(TestMode: Boolean); override;
  end;

const MTSSucess: String = 'Tentativa de Matching Sucessivo (MTSSuc)';

implementation

constructor TMTSSuc.Create(AOwner: TComponent);
var a1: Integer;
begin
  Inherited Create(AOwner);
  Color:= clBlack;
  FFlagResp:= True;

  FHeader:= 'Mod.' +#9+ 'Comps.' +#9+
            'Resp. Mod.' +#9+ 'Lat. Mod.' +#9+
            'Resp. Comp.' +#9+ 'Lat. Comp.' +#9+
            'Disp.';

  FTimerCsq:= TTimer.Create(Self);
  With FTimerCsq do begin
    Enabled:= False;
    Interval:= 10;
    OnTimer:= TimerCsqTimer;
  end;

  FTimerLatMod:= TTimer.Create(Self);
  With FTimerLatMod do begin
    Enabled:= False;
    Interval:= 10;
    OnTimer:= TimerLatModTimer;
  end;

  FTimerLatCmp:= TTimer.Create(Self);
  With FTimerLatCmp do begin
    Enabled:= False;
    Interval:= 10;
    OnTimer:= TimerLatCmpTimer;
  end;

  FSupportSample.Key:= TChave.Create(Self);
  For a1:= 0 to 8 do FVetSupport[a1].Key:= TChave.Create(Self);
end;

destructor TMTSSuc.Destroy;
begin
  Inherited Destroy;
end;

procedure TMTSSuc.KeyDown(var Key: Word; Shift: TShiftState);
begin
  If ssCtrl in Shift then
    If Key = 13 then EndTrial;
  If Key = 107 {+} then begin
    FResult:= FKPlus.Des;
    EndTrial;
  end;
  If Key = 109{-} then begin
    FResult:= FKMinus.Des;
    EndTrial;
  end;
  If Key = 27 then
    FFlagResp:= False;
end;

procedure TMTSSuc.KeyUp(var Key: Word; Shift: TShiftState);
begin
  If Key = 27 then
    FFlagResp:= True;
end;

procedure TMTSSuc.TimerCsqTimer(Sender: TObject);
begin
  FTimerCsq.Enabled:= False;

  outportb($378, 0);
  outportb($278, 0);

  EndTrial;
end;

procedure TMTSSuc.TimerLatModTimer(Sender: TObject);
begin
  Inc(FLatMod);
end;

procedure TMTSSuc.TimerLatCmpTimer(Sender: TObject);
begin
  Inc(FLatCmp);
end;

procedure TMTSSuc.KeyCompMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If FFlagResp then begin
    FTimerLatCmp.Enabled:= False;
    Application.ProcessMessages;

    FResult:= FVetSupport[TChave(Sender).Tag].Des;
    FDataRespCmp:= FVetSupport[TChave(Sender).Tag].Msg+
                   ' ('+IntToStr(X-(FVetSupport[TChave(Sender).Tag].Key.Width div 2))+ ', '+
                   IntToStr(Y-(FVetSupport[TChave(Sender).Tag].Key.Height div 2))+')';

    FDataCsq:= IntToStr(FVetSupport[TChave(Sender).Tag].Csq);

    outportb($378, FVetSupport[TChave(Sender).Tag].Csq);
    outportb($278, FVetSupport[TChave(Sender).Tag].Csq);
    FTimerCsq.Enabled:= True;
  end;
end;

procedure TMTSSuc.KeySampleMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var a1: Integer;
begin
  If FFlagResp then begin
    FSupportSample.Key.Visible:= False;
    FTimerLatMod.Enabled:= False;
    Application.ProcessMessages;

    FDataRespMod:= FSupportSample.Msg+
                   ' ('+IntToStr(X-(FSupportSample.Key.Width div 2))+ ', '+
                   IntToStr(Y-(FSupportSample.Key.Height div 2))+')';

    For a1:= 0 to 8 do begin
      FVetSupport[a1].Key.Visible:= True;
    end;
    FTimerLatCmp.Enabled:= True;
  end;
end;

procedure TMTSSuc.EndTrial;
var a1: Integer; 
begin
{
  FHeader:= 'Mod.' +#9+ 'Comps.' +#9+
            'Resp. Mod.' +#9+ 'Lat. Mod.' +#9+
            'Resp. Comp.' +#9+ 'Lat. Comp.' +#9+
            'Disp.';
}
  FData:= FSupportSample.Msg+#9;

  For a1:= 0 to 8 do FData:= FData+FVetSupport[a1].Msg+' ';
  FData:= FData+#9;

  FData:= FData + FDataRespMod + #9;
  FData:= FData + IntToStr(FLatMod*10) + #9;

  FData:= FData + FDataRespCmp+#9;
  FData:= FData + IntToStr(FLatCmp*10) + #9;

  FData:= FData + FDataCsq;

  If Assigned(OnEndTrial) then FOnEndTrial(Self);
end;

procedure TMTSSuc.Paint;
begin

end;

procedure TMTSSuc.PaintWindow(DC: HDC);
begin
  Canvas.Handle:= DC;
  Paint;
end;

procedure TMTSSuc.Play(TestMode: Boolean);
var s1: String; R: TRect; a1: Integer;
begin
  Color:= StrToIntDef(FCfgTrial.SList.Values['BkGnd'], 0);
  Cursor:= StrToIntDef(FCfgTrial.SList.Values['Cursor'], 0);

  With FKPlus do begin
    Csq:= StrToInt(FCfgTrial.SList.Values['K+Csq']);
    Msg:= FCfgTrial.SList.Values['K+Msg'];
    Des:= FCfgTrial.SList.Values['K+Des'];
  end;

  With FKMinus do begin
    Csq:= StrToInt(FCfgTrial.SList.Values['K-Csq']);
    Msg:= FCfgTrial.SList.Values['K-Msg'];
    Des:= FCfgTrial.SList.Values['K-Des'];
  end;

  FSupportSample.Msg:= FCfgTrial.SList.Values['SMsg'];
  With FSupportSample.Key do begin
    Parent:= Self;
    OnMouseDown:= KeySampleMouseDown;

    s1:= FCfgTrial.SList.Values['SBnd'];
    R.Left:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    R.Top:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    R.Right:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    R.Bottom:= StrToIntDef(s1, 0);
    SetBounds(R.Left, R.Top, R.Right, R.Bottom);
    BorderColor:= 255;

    FileName:= FCfgTrial.SList.Values['Hoot'] + FCfgTrial.SList.Values['SStm'];
  end;

  For a1:= 0 to 8 do begin
    FVetSupport[a1].Des:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Res'];
    FVetSupport[a1].Csq:= StrToIntDef(FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Csq'], 0);
    FVetSupport[a1].Msg:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Msg'];

    With FVetSupport[a1].Key do begin
      Visible:= False;
      Parent:= Self;
      OnMouseDown:= KeyCompMouseDown;
      Tag:= a1;

      s1:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Bnd'];
      R.Left:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
      Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
      R.Top:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
      Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
      R.Right:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
      Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
      R.Bottom:= StrToIntDef(s1, 0);
      SetBounds(R.Left, R.Top, R.Right, R.Bottom);
      BorderColor:= clLime;

      FileName:= FCfgTrial.SList.Values['Hoot'] + FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Stm'];
    end;
  end;

  FTimerLatMod.Enabled:= True;
end;

end.
