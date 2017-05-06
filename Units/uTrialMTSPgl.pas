unit uTrialMTSPgl;

interface

uses Classes, Controls, SysUtils, ExtCtrls, StdCtrls, Types, MPlayer, StrUtils,
     uTrial, uKey;

type
  TGnd = class(TGraphicControl)
  public
    procedure Paint; override;
    property Color;
  end;

  TSupportKey = Record
    ALabel: TLabel;
    Key: TKey;
    Csq: String;
    Msg: String;
    Nxt: String;
    Res: String;
  end;

  TMTSPgl = Class(TTrial)
  protected
    FDataResp: String;
    FHoot: String;
    FBkGnd: TGnd;
    FFrGnd: TPanel;
    FPanelModel: TPanel;
    FSupportS: TSupportKey;
    FVetSupportC: Array of TSupportKey;
    FMPMsgRpt: TMediaPlayer;
    FMPMsgCsq: TMediaPlayer;
    FTimerMsgRpt: TTimer;
    procedure Resize; override;
    procedure KeyCResponse(Sender: TObject);
    procedure LabelCMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ProcessResponse(IndResp: Byte);
    procedure MPMsgRptNotify(Sender: TObject);
    procedure MPMsgCsqNotify(Sender: TObject);
    procedure TimerMsgRptTimer(Sender: TObject);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure EndTrial;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Play(TestMode: Boolean); override;
  end;

implementation

uses Graphics;

procedure TGnd.Paint;
begin
  With Canvas do begin
    Brush.Color:= Color;
    FillRect(Rect(0, 0, Width, Height));
  end;
end;

constructor TMTSPgl.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);

  FTimerMsgRpt:= TTimer.Create(Self);
  With FTimerMsgRpt do begin
    Enabled:= False;
    Interval:= 1500;
    OnTimer:= TimerMsgRptTimer;
  end;

  FBkGnd:= TGnd.Create(Self);
  With FBkGnd do begin
    Align:= alClient;
    Parent:= Self;
    Color:= 8421440;
  end;

  FFrGnd:= TPanel.Create(Self);
  With FFrGnd do begin
    BevelInner:= bvNone;
    BevelOuter:= bvNone;
    Parent:= Self;
  end;

  FPanelModel:= TPanel.Create(Self);
  With FPanelModel do begin
    SetBounds(229, 4, 178, 153);
    Color:= clBlack;
    BevelWidth:= 1;
    BorderWidth:= 3;
    BevelInner:= bvLowered;
    BevelOuter:= bvRaised;
  end;

  FMPMsgRpt:= TMediaPlayer.Create(Self);
  With FMPMsgRpt do begin
    OnNotify:= MPMsgRptNotify;
  end;

  FMPMsgCsq:= TMediaPlayer.Create(Self);
  With FMPMsgCsq do begin
    OnNotify:= MPMsgCsqNotify;
  end;
end;

procedure TMTSPgl.Resize;
begin
  FFrGnd.SetBounds((Width-FFrGnd.Width) div 2, (Height-FFrGnd.Height) div 2, 640, 480);
end;

procedure TMTSPgl.KeyCResponse(Sender: TObject);
begin
  ProcessResponse(TKey(Sender).Tag);
end;

procedure TMTSPgl.LabelCMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ProcessResponse(TLabel(Sender).Tag);
end;

procedure TMTSPgl.ProcessResponse(IndResp: Byte);
begin
  FTimerMsgRpt.Enabled:= False;
  If (FMPMsgRpt.Mode = mpStopped) or (FMPMsgRpt.Mode = mpPlaying) then begin
    FMPMsgRpt.Stop;
    FMPMsgRpt.Close;
  end;

  FNextTrial:= FVetSupportC[IndResp].Nxt;
  FDataResp:= FVetSupportC[IndResp].Msg;

  If FileExists(FHoot+FVetSupportC[IndResp].Csq) then begin
    FMPMsgCsq.Visible:= False;
    FMPMsgCsq.Parent:= Self;
    FMPMsgCsq.FileName:= FHoot+FVetSupportC[IndResp].Csq;
    Try
      FMPMsgCsq.Open;
      FMPMsgCsq.Play;
    Except
      EndTrial;
    end;
  end else EndTrial;
end;

procedure TMTSPgl.MPMsgRptNotify(Sender: TObject);
begin
  FTimerMsgRpt.Enabled:= True;
end;

procedure TMTSPgl.MPMsgCsqNotify(Sender: TObject);
begin
  EndTrial;
end;

procedure TMTSPgl.TimerMsgRptTimer(Sender: TObject);
begin
  FTimerMsgRpt.Enabled:= False;
  If FMPMsgRpt.Mode = mpStopped then
    FMPMsgRpt.Play;
end;

procedure TMTSPgl.KeyDown(var Key: Word; Shift: TShiftState);
begin
  If ssCtrl in Shift then
    If Key = 13 then begin
      EndTrial;
    end;

  If Key = 27 then
//    FFlagResp:= False;
end;

procedure TMTSPgl.EndTrial;
begin
  If (FMPMsgRpt.Mode = mpStopped) or (FMPMsgRpt.Mode = mpPlaying) then begin
    FMPMsgRpt.Stop;
    FMPMsgRpt.Close;
  end;
  If (FMPMsgCsq.Mode = mpStopped) or (FMPMsgCsq.Mode = mpPlaying) then begin
    FMPMsgCsq.Stop;
    FMPMsgCsq.Close;
  end;

  FHeader:= 'Modelo  ' + #9 +
            'Resposta';

  FData:= LeftStr(FSupportS.Msg+#32#32#32#32#32#32#32#32, 8) + #9 +
          LeftStr(FDataResp+#32#32#32#32#32#32#32#32, 8);

  If Assigned(OnEndTrial) then FOnEndTrial(Self);
end;

procedure TMTSPgl.Play(TestMode: Boolean);
var a1: Integer; s1: String;
const VetP: Array [0..2] of TPoint = ((X:4; Y:264), (X:244; Y:376), (X:630; Y:264));
begin
  FNextTrial:= '-1';

  FHoot:= FCfgTrial.SList.Values['HootMedia'];

  s1:= FCfgTrial.SList.Values['MsgRpt'];
  If FileExists(FHoot + s1) then begin
    FMPMsgRpt.Visible:= False;
    FMPMsgRpt.Parent:= Self;
    FMPMsgRpt.FileName:= FHoot + s1;
    Try FMPMsgRpt.Open;
    Except End;
  end;

  With FSupportS do begin
    Key:= TKey.Create(Self);
    ALabel:= TLabel.Create(Self);

    Msg:= FCfgTrial.SList.Values['SMsg'];
    
    s1:= FCfgTrial.SList.Values['SStm'];
    If FileExists(FHoot + s1) then begin
      FPanelModel.Parent:= FFrGnd;
      Key.SetBounds(5, 5, 167, 143);
      Key.Parent:= FPanelModel;
      Key.FileName:= FHoot + s1;
      Key.SchMan.Kind:= 'CRF';
    end;

    s1:= FCfgTrial.SList.Values['STxt'];
    If s1 > #0 then begin
      ALabel.Parent:= FFrGnd;
      ALabel.AutoSize:= True;
      ALabel.Transparent:= True;
      ALabel.Font.Name:= 'Arial';
      ALabel.Font.Size:= 48;
      ALabel.Caption:= s1;
      ALabel.SetBounds((FFrGnd.Width-ALabel.Width) div 2, 16, ALabel.Width, ALabel.Height);
    end;
  end;

  SetLength(FVetSupportC, 3);
  For a1:= 0 to 2 do begin
    With FVetSupportC[a1] do begin
      Key:= TKey.Create(Self);
      ALabel:= TLabel.Create(Self);

      s1:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Stm'];
      If FileExists(FHoot + s1) then begin
        Key.Tag:= a1;
        Key.Parent:= FFrGnd;
        Key.OnResponse:= KeyCResponse;
        Key.FileName:= FHoot + s1;
        Key.SchMan.Kind:= 'CRF';
        Case a1 of
          0: FVetSupportC[0].Key.SetBounds(019, 208, 148, 129);
          1: FVetSupportC[1].Key.SetBounds(244, 348, 148, 129);
          2: FVetSupportC[2].Key.SetBounds(472, 208, 148, 129);
        end;
      end;

      s1:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Txt'];
      If s1 > #0 then begin
        ALabel.Tag:= a1;
        ALabel.Parent:= FFrGnd;
        ALabel.AutoSize:= True;
        ALabel.Transparent:= True;
        ALabel.Font.Name:= 'Arial';
        ALabel.Font.Size:= 48;
        ALabel.Caption:= s1;
        ALabel.OnMouseDown:= LabelCMouseDown;
        Case a1 of
          0: ALabel.SetBounds(VetP[a1].X, VetP[a1].Y, ALabel.Width, ALabel.Height);
          1: ALabel.SetBounds((FFrGnd.Width-ALabel.Width) div 2, VetP[a1].Y, ALabel.Width, ALabel.Height);
          2: ALabel.SetBounds(VetP[a1].X- ALabel.Width, VetP[a1].Y, ALabel.Width, ALabel.Height);
        end;
      end;

      Csq:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Csq'];

      Msg:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Msg'];
      Res:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Res'];
      Nxt:= FCfgTrial.SList.Values['C'+IntToStr(a1+1)+'Nxt'];
    end;
  end;

  FPanelModel.Invalidate;
  TimerMsgRptTimer(nil);
end;

end.
