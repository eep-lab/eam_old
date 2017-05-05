unit uTrialMar;

interface

uses Controls, Classes, Windows, SysUtils, Graphics, ExtCtrls, Forms, Math, StrUtils, IdGlobal,
     uTrial, uCfgSes;

type
  TSupport = Record
    Csq: Byte;
    Msg: String;
    Nxt: String;
    Panel: TPanel;
    Res: String;
  end;

  TMar = class(TTrial)
  private
    FFlagResp: Boolean;
    FDataMsg: String;
    FDataCsq: Integer;
    FDataOtherResps: String;
    FLat: Integer;
    FTimerCsq: TTimer;
    FTimerLat: TTimer;
    FKPlus: TSupport;
    FKMinus: TSupport;
    FSupport: TSupport;
    procedure TimerCsqTimer(Sender: TObject);
    procedure TimerLatTimer(Sender: TObject);
    procedure PanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EndTrial;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure PaintWindow(DC: HDC); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Play(TestMode: Boolean); override;
  end;

const MTSSucess: String = 'Tentativa preparada para o procedimento da Marcia (Mar)';

implementation

constructor TMar.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  Color:= clBlack;
  FFlagResp:= True;

  FHeader:= 'Pos.    ' +#9+ 'Resp.   ' +#9+ 'Lat.    ' +#9+ 'Disp.   ' +#9+ 'Out.Res.';

  FTimerCsq:= TTimer.Create(Self);
  With FTimerCsq do begin
    Enabled:= False;
    Interval:= 10;
    OnTimer:= TimerCsqTimer;
  end;

  FTimerLat:= TTimer.Create(Self);
  With FTimerLat do begin
    Enabled:= False;
    Interval:= 10;
    OnTimer:= TimerLatTimer;
  end;

  FSupport.Panel:= TPanel.Create(Self);
  With FSupport.Panel do begin
    BevelInner:= bvNone;
    BevelOuter:= bvNone;
  end;
end;

destructor TMar.Destroy;
begin
  Inherited Destroy;
end;

procedure TMar.KeyDown(var Key: Word; Shift: TShiftState);
begin
  If ssCtrl in Shift then
    If Key = 13 then begin
      FDataMsg:= 'Cancel';
      EndTrial;
    end;

  If Key = 27 then
    FFlagResp:= False;

  If Key = 107 {+} then begin
    FDataCsq:= FKPlus.Csq;
    FDataMsg:= FKPlus.Msg;
    FResult:= FKPlus.Res;
    FNextTrial:= FKPlus.Nxt;

    outportb($378, FKPlus.Csq);
    outportb($278, FKPlus.Csq);
    FTimerCsq.Enabled:= True;
  end;

  If Key = 109{-} then begin
    FDataCsq:= FKMinus.Csq;
    FDataMsg:= FKMinus.Msg;
    FResult:= FKMinus.Res;
    FNextTrial:= FKMinus.Nxt;

    outportb($378, FKMinus.Csq);
    outportb($278, FKMinus.Csq);
    FTimerCsq.Enabled:= True;
  end;
end;

procedure TMar.KeyUp(var Key: Word; Shift: TShiftState);
begin
  If Key = 27 then
    FFlagResp:= True;
end;

procedure TMar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var catO, catA: Integer; Hip, sin, arsin, gr: Extended;
begin
  catO:= (FSupport.Panel.Height div 2)-(Y-FSupport.Panel.Height);
  catA:= (X-FSupport.Panel.Width)-(FSupport.Panel.Width div 2);
  Hip:= power(power(catO, 2) + power(catA, 2), 0.5);

  If Hip > 0 then sin:= CatO/Hip else sin:= 1;
  arsin:= arcsin(sin);
  gr:= arsin*180/Pi;

  If CatA > 0 then begin
    If CatO > 0 then gr:= 90-gr
    else gr:= 90-gr;
  end else begin
    If CatO > 0 then gr:= 270+gr
    else gr:= 270+gr;
  end;

  FDataOtherResps:= FDataOtherResps+ '('+
                    LeftStr(IntToStr(Round(Hip))+#32#32#32, 3) + ', ' +
                    LeftStr(IntToStr(Round(gr))+#32#32#32, 3) + ') ';
end;

procedure TMar.TimerCsqTimer(Sender: TObject);
begin
  FTimerCsq.Enabled:= False;

  outportb($378, 0);
  outportb($278, 0);

  EndTrial;
end;

procedure TMar.TimerLatTimer(Sender: TObject);
begin
  Inc(FLat);
end;

procedure TMar.PanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var catO, catA: Integer; Hip, sin, arsin, gr: Extended;
begin
  If FFlagResp then begin
    FTimerLat.Enabled:= False;
    Application.ProcessMessages;

    Try
      catO:= (FSupport.Panel.Height div 2)-Y;
      catA:= X-(FSupport.Panel.Width div 2);
      Hip:= power(power(catO, 2) + power(catA, 2), 0.5);

      If Hip > 0 then sin:= CatO/Hip else sin:= 1;
      arsin:= arcsin(sin);
      gr:= arsin*180/Pi;

      If CatA > 0 then begin
        If CatO > 0 then gr:= 90-gr
        else gr:= 90-gr;
      end else begin
        If CatO > 0 then gr:= 270+gr
        else gr:= 270+gr;
      end;
    Except
      gr:= 0;
      Hip:= 0;
    end;

    FDataMsg:= LeftStr(IntToStr(Round(Hip))+#32#32#32, 3) + ', ' + LeftStr(IntToStr(Round(gr))+#32#32#32, 3);

    FDataCsq:= FSupport.Csq;

    FResult:= FSupport.Res;

    FNextTrial:= FSupport.Nxt;

    outportb($378, FSupport.Csq);
    outportb($278, FSupport.Csq);
    FTimerCsq.Enabled:= True;
  end;
end;

procedure TMar.EndTrial;
var Pos, Resp, Lat, Disp: String[8];
begin
//  FHeader:= 'Pos.    ' +#9+ 'Resp.   ' +#9+ 'Lat.    ' +#9+ 'Disp.   ' +#9+ 'Out.Res.';

  If FSupport.Msg = '' then FSupport.Msg:= '--------';
  Pos:= LeftStr(FSupport.Msg+#32#32#32#32#32#32#32#32, 8);

  If FDataMsg = '' then FDataMsg:= '--------';
  Resp:= LeftStr(FDataMsg+#32#32#32#32#32#32#32#32, 8);

  Lat:= LeftStr(IntToStr(FLat*10)+#32#32#32#32#32#32, 6)+'ms';

  Disp:= RightStr(IntToBin(FDataCsq)+#0, 8);

  FData:= Pos+#9+Resp+#9+Lat+#9+Disp+#9+FDataOtherResps;

  If Assigned(OnEndTrial) then FOnEndTrial(Self);
end;

procedure TMar.Paint;
begin

end;

procedure TMar.PaintWindow(DC: HDC);
begin
  Canvas.Handle:= DC;
  Paint;
end;

procedure TMar.Play(TestMode: Boolean);
var s1: String; R: TRect;
begin
  FNextTrial:= '-1';
  Color:= StrToIntDef(FCfgTrial.SList.Values['BkGnd'], 0);

  If TestMode then Cursor:= 0
  else Cursor:= StrToIntDef(FCfgTrial.SList.Values['Cursor'], 0);

  With FSupport do begin
    Panel.Cursor:= Self.Cursor;
    Panel.Parent:= Self;
    Panel.OnMouseDown:= PanelMouseDown;

    s1:= FCfgTrial.SList.Values['Bnd'];
    R.Left:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    R.Top:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    R.Right:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    R.Bottom:= StrToIntDef(s1, 0);
    Panel.SetBounds(R.Left, R.Top, R.Right, R.Bottom);

    Panel.Color:= StrToIntDef(FCfgTrial.SList.Values['Clr'], 16777215);

    Csq:= StrToIntDef(FCfgTrial.SList.Values['Csq'], 255);

    Msg:= FCfgTrial.SList.Values['Msg'];
    Res:= FCfgTrial.SList.Values['Res'];
    Nxt:= FCfgTrial.SList.Values['Nxt'];
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

  FTimerLat.Enabled:= True;
end;

end.
