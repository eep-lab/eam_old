unit uTrialNat;

interface

uses Controls, Classes, Windows, SysUtils, Graphics, ExtCtrls, Forms, StrUtils, Math, IdGlobal,
     uTrial, uCfgSes;

type
  TSupport = Record
    Csq: Byte;
    Msg: String;
    Nxt: Integer;
    Panel: TPanel;
    Res: String;
  end;

  TNat = class(TTrial)
  protected
    FFlagResp: Boolean;
    FDataCMsg: String;
    FDataSMsg: String;
    FDataCsq: Integer;
    FDataOtherResps: String;
    FLatMod: Integer;
    FLatCmp: Integer;
    FTimerCsq: TTimer;
    FTimerLatMod: TTimer;
    FTimerLatCmp: TTimer;
    FKPlus: TSupport;
    FKMinus: TSupport;
    FSupportS: TSupport;
    FSupportC: TSupport;
    procedure TimerCsqTimer(Sender: TObject);
    procedure TimerLatModTimer(Sender: TObject);
    procedure TimerLatCmpTimer(Sender: TObject);
    procedure PanelCompMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PanelSampleMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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

const MTSSucess: String = 'Tentativa preparada para o procedimento da Natali (Nat)';

implementation

constructor TNat.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  Color:= clBlack;
  FFlagResp:= True;

  FHeader:= 'Pos.Mod.' +#9+
            'Res.Mod.' +#9+
            'Lat.Mod.' +#9+
            'Pos.Msk.' +#9+
            'Res.Msk.' +#9+
            'Lat.Msk.' +#9+
            'Disp.   ' +#9+
            'Out.Res.';

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

  FSupportS.Panel:= TPanel.Create(Self);
  With FSupportS.Panel do begin
    BevelInner:= bvNone;
    BevelOuter:= bvNone;
  end;

  FSupportC.Panel:= TPanel.Create(Self);
  With FSupportC.Panel do begin
    BevelInner:= bvNone;
    BevelOuter:= bvNone;
  end;
end;

destructor TNat.Destroy;
begin
  Inherited Destroy;
end;

procedure TNat.KeyDown(var Key: Word; Shift: TShiftState);
begin
  If ssCtrl in Shift then
    If Key = 13 then begin
      If FSupportS.Panel.Visible then FDataSMsg:= 'Cancel'
      else FDataCMsg:= 'Cancel';
      EndTrial;
    end;

  If Key = 27 then
    FFlagResp:= False;

  If Key = 107 {+} then begin
    If FSupportS.Panel.Visible then begin
      FSupportS.Panel.Visible:= False;
      FTimerLatMod.Enabled:= False;
      Application.ProcessMessages;

      FDataSMsg:= FKPlus.Msg;

      FSupportC.Panel.Visible:= True;
      FTimerLatCmp.Enabled:= True;
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
    If FSupportS.Panel.Visible then begin
      FSupportS.Panel.Visible:= False;
      FTimerLatMod.Enabled:= False;
      Application.ProcessMessages;

      FDataSMsg:= FKMinus.Msg;

      FSupportC.Panel.Visible:= True;
      FTimerLatCmp.Enabled:= True;
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

procedure TNat.KeyUp(var Key: Word; Shift: TShiftState);
begin
  If Key = 27 then
    FFlagResp:= True;
end;

procedure TNat.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var catO, catA: Integer; Hip, sin, arsin, gr: Extended; c: Char;
begin
  If FSupportS.Panel.Visible then c:= 'M' else c:= 'C';

  catO:= (FSupportS.Panel.Height div 2)-(Y-FSupportS.Panel.Height);
  catA:= (X-FSupportS.Panel.Width)-(FSupportS.Panel.Width div 2);
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

  FDataOtherResps:= FDataOtherResps+ c + '('+
                    LeftStr(IntToStr(Round(Hip))+#32#32#32, 3) + ', ' +
                    LeftStr(IntToStr(Round(gr))+#32#32#32, 3) + ') ';
end;

procedure TNat.TimerCsqTimer(Sender: TObject);
begin
  FTimerCsq.Enabled:= False;

  outportb($378, 0);
  outportb($278, 0);

  EndTrial;
end;

procedure TNat.TimerLatModTimer(Sender: TObject);
begin
  Inc(FLatMod);
end;

procedure TNat.TimerLatCmpTimer(Sender: TObject);
begin
  Inc(FLatCmp);
end;

procedure TNat.PanelCompMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var catO, catA: Integer; Hip, sin, arsin, gr: Extended;
begin
  If FFlagResp then begin
    FTimerLatCmp.Enabled:= False;
    Application.ProcessMessages;

    Try
      catO:= (FSupportC.Panel.Height div 2)-Y;
      catA:= X-(FSupportC.Panel.Width div 2);
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

    FDataCMsg:= LeftStr(IntToStr(Round(Hip))+#32#32#32, 3) + ', ' + LeftStr(IntToStr(Round(gr))+#32#32#32, 3);

    FDataCsq:= FSupportC.Csq;

    FResult:= FSupportC.Res;

    FNextTrial:= IntToStr(FSupportC.Nxt);

    outportb($378, FSupportC.Csq);
    outportb($278, FSupportC.Csq);
    FTimerCsq.Enabled:= True;
  end;
end;

procedure TNat.PanelSampleMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var catO, catA: Integer; Hip, sin, arsin, gr: Extended;
begin
  If FFlagResp then begin
    FSupportS.Panel.Visible:= False;
    FTimerLatMod.Enabled:= False;
    Application.ProcessMessages;

    Try
      catO:= (FSupportS.Panel.Height div 2)-Y;
      catA:= X-(FSupportS.Panel.Width div 2);
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

    FDataSMsg:= LeftStr(IntToStr(Round(Hip))+#32#32#32, 3) + ', ' + LeftStr(IntToStr(Round(gr))+#32#32#32, 3);

    FSupportC.Panel.Visible:= True;
    FTimerLatCmp.Enabled:= True;
  end;
end;

procedure TNat.EndTrial;
var Pos_Mod, Resp_Mod, Lat_Mod, Pos_Mask, Res_Mask, Lat_Mask, Disp: String[8];
begin
{
  FHeader:= 'Pos.Mod.' +#9+
            'Res.Mod.' +#9+
            'Lat.Mod.' +#9+
            'Pos.Msk.' +#9+
            'Res.Msk.' +#9+
            'Lat.Msk.' +#9+
            'Disp.   ' +#9+
            'Out.Res.';
}

  If FSupportS.Msg = '' then FSupportS.Msg:= '--------';
  Pos_Mod:= LeftStr(FSupportS.Msg+#32#32#32#32#32#32#32#32, 8);

  If FDataSMsg = '' then FDataSMsg:= '--------';
  Resp_Mod:= LeftStr(FDataSMsg+#32#32#32#32#32#32#32#32, 8);

  Lat_Mod:= LeftStr(IntToStr(FLatMod*10)+#32#32#32#32#32#32, 6)+'ms';

  If FSupportC.Msg = '' then FSupportC.Msg:= '--------';
  Pos_Mask:= LeftStr(FSupportC.Msg+#32#32#32#32#32#32#32#32, 8);

  If FDataCMsg = '' then FDataCMsg:= '--------';
  Res_Mask:= LeftStr(FDataCMsg+#32#32#32#32#32#32#32#32, 8);

  Lat_Mask:= LeftStr(IntToStr(FLatCmp*10)+#32#32#32#32#32#32, 6)+'ms';

  Disp:= RightStr(IntToBin(FDataCsq)+#0, 8);

  FData:= Pos_Mod+#9+Resp_Mod+#9+Lat_Mod+#9+Pos_Mask+#9+Res_Mask+#9+Lat_Mask+#9+Disp+#9+
          FDataOtherResps;

  If Assigned(OnEndTrial) then FOnEndTrial(Self);
end;

procedure TNat.Paint;
begin

end;

procedure TNat.PaintWindow(DC: HDC);
begin
  Canvas.Handle:= DC;
  Paint;
end;

procedure TNat.Play(TestMode: Boolean);
var s1: String; R: TRect;
begin
  FNextTrial:= '-1';
  Color:= StrToIntDef(FCfgTrial.SList.Values['BkGnd'], 0);

  If TestMode then Cursor:= 0
  else Cursor:= StrToIntDef(FCfgTrial.SList.Values['Cursor'], 0);

  With FSupportS do begin
    Panel.Cursor:= Self.Cursor;
    Panel.Parent:= Self;
    Panel.OnMouseDown:= PanelSampleMouseDown;

    s1:= FCfgTrial.SList.Values['SBnd'];
    R.Left:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    R.Top:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    R.Right:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    R.Bottom:= StrToIntDef(s1, 0);
    Panel.SetBounds(R.Left, R.Top, R.Right, R.Bottom);

    Panel.Color:= clWhite;

    Msg:= FCfgTrial.SList.Values['SMsg'];
  end;

  With FSupportC do begin
    Panel.Visible:= False;
    Panel.Cursor:= Self.Cursor;
    Panel.Parent:= Self;
    Panel.OnMouseDown:= PanelCompMouseDown;

    s1:= FCfgTrial.SList.Values['CBnd'];
    R.Left:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    R.Top:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    R.Right:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    R.Bottom:= StrToIntDef(s1, 0);
    Panel.SetBounds(R.Left, R.Top, R.Right, R.Bottom);

    Panel.Color:= clWhite;

    Csq:= StrToIntDef(FCfgTrial.SList.Values['CCsq'], 255);

    Msg:= FCfgTrial.SList.Values['CMsg'];
    Res:= FCfgTrial.SList.Values['CRes'];
    Nxt:= StrToIntDef(FCfgTrial.SList.Values['CNxt'], 0)-1;
  end;

  With FKPlus do begin
    Csq:= StrToIntDef(FCfgTrial.SList.Values['K+Csq'], 255);
    Msg:= FCfgTrial.SList.Values['K+Msg'];
    Res:= FCfgTrial.SList.Values['K+Res'];
    Nxt:= StrToIntDef(FCfgTrial.SList.Values['K+Nxt'], 0)-1;
  end;

  With FKMinus do begin
    Csq:= StrToIntDef(FCfgTrial.SList.Values['K-Csq'], 0);
    Msg:= FCfgTrial.SList.Values['K-Msg'];
    Res:= FCfgTrial.SList.Values['K-Res'];
    Nxt:= StrToIntDef(FCfgTrial.SList.Values['K+Nxt'], 0)-1;
  end;

  FTimerLatMod.Enabled:= True;
end;

end.
