unit uTrialMsg;

interface

uses Controls, Classes, ExtCtrls, SysUtils, StdCtrls, Graphics, Forms,
     uTrial;

type

  TMSG = class(TTrial)
  protected
    FMemo: TMemo;
    FMemoPrompt: TLabel;
    FLat: Integer;
    FTimerLat: TTimer;
    procedure TimerLatTimer(Sender: TObject);
    procedure EndTrial;
    procedure MemoEnter(Sender: TObject);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MemoClick(Sender: TObject);
    procedure Click; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Play(TestMode: Boolean); override;
  end;

implementation

constructor TMSG.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);

  FMemo:= TMemo.Create(Self);
  With FMemo do begin
    Text:= #0;
    Parent:= Self;
    Font.Name:= 'TimesNewRoman';
    Font.Color:= clWhite;
    ReadOnly:= True;
    BorderStyle:= bsNone;
    Color:= clBlack;
    OnEnter:= MemoEnter;
    Alignment:= taCenter;
    OnClick:= MemoClick;
  end;

  FMemoPrompt:= TLabel.Create(Self);
  With FMemoPrompt do begin
    Caption:= 'Click com o Mouse ou Pressione  <<Control>> + <<Enter>>  para Avançar';
    Parent:= Self;
    Font.Name:= 'TimesNewRoman';
    Font.Size:= 14;
    OnClick:= MemoClick;
  end;

  FTimerLat:= TTimer.Create(Self);
  With FTimerLat do begin
    Enabled:= False;
    OnTimer:= TimerLatTimer;
  end;
end;

destructor TMSG.Destroy;
begin
  Inherited Destroy;
end;

procedure TMSG.KeyDown(var Key: Word; Shift: TShiftState);
begin
  If ssCtrl in Shift then
    If Key = 13 then begin
      EndTrial;
    end;
end;

procedure TMSG.MemoClick(Sender: TObject);
begin
  EndTrial;
end;

procedure TMSG.Click;
begin
  EndTrial;
end;

procedure TMSG.TimerLatTimer(Sender: TObject);
begin
  Inc(FLat);
end;

procedure TMSG.EndTrial;
begin
  FHeader:= 'Mensagem';

  FData:= FMemo.Lines.Text;

  If Assigned(OnEndTrial) then FOnEndTrial(Self);
end;

procedure TMSG.MemoEnter(Sender: TObject);
begin
  SetFocus;
end;

procedure TMSG.Play(TestMode: Boolean);
var H: Integer;
begin
  FNextTrial:= '-1';

  Color:= StrToIntDef(FCfgTrial.SList.Values['BkGnd'], 0);

  If TestMode then Cursor:= 0
  else Cursor:= StrToIntDef(FCfgTrial.SList.Values['Cursor'], 0);

  FMemo.Text:= FCfgTrial.SList.Values['Msg'];
  FMemo.Width:= StrToIntDef(FCfgTrial.SList.Values['MsgWidth'], 640);
  FMemo.Font.Size:= StrToIntDef(FCfgTrial.SList.Values['MsgFontSize'], 28);
  FMemo.Font.Color:= StrToIntDef(FCfgTrial.SList.Values['MsgFontColor'], clWhite);
  FMemo.Color:= StrToIntDef(FCfgTrial.SList.Values['MsgBkGndColor'], clBlack);

  H:= (FMemo.Lines.Count+2)*FMemo.Font.Height*-1;
  FMemo.SetBounds((Width-FMemo.Width)div 2, (Height-H)div 2, FMemo.Width, H);

  FMemo.Parent:= Self;
  If Cursor = 0 then FMemo.Cursor:= crArrow
  else FMemo.Cursor:= Cursor;

  FMemoPrompt.Visible:= StrToBoolDef(FCfgTrial.SList.Values['Prompt'], True);
  If FMemoPrompt.Visible then begin
    FMemoPrompt.SetBounds((Width-FMemoPrompt.Width)div 2, (Height-FMemoPrompt.Height)-20, FMemoPrompt.Width, FMemoPrompt.Height);
    FMemoPrompt.Font.Color:= FMemo.Font.Color;
  end;

  FTimerLat.Enabled:= True;
end;

end.
