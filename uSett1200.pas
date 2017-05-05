unit uSett1200;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Dialogs,
  MPlayer, extctrls, Controls, stdctrls, buttons, forms,
  uAbsTent, uChave;

type
  TSett1200 = class(TAbstractTentativa)
  private
    FData: TDatas;
    FDoParalellReinf: Boolean;
    FFrame1: TWinControl;
    FFrame2: TWinControl;
    FIndChvCor: Integer;
    FLatencia: Integer;
    FMatChv: Array of Array of TChave;
    FTimer1: TTimer;
    FTimer2: TTimer;
    procedure Chv1Click(Sender: TObject);
    procedure EndTent;
    function  SetChv1(Ind:  Integer; AChave: TChave): Boolean;
    function  SetChv2(Ind:  Integer; AChave: TChave): Boolean;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  protected
    function  GetMatChv(Ind1, Ind2: Integer): TChave; override;
    function  GetMatPar(Ind1, Ind2: Integer): Variant; override;
    procedure SetMatPar(Ind1, Ind2: Integer; Value: Variant); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function  InsertChv(Ind1, Ind2: Integer; AChave: TChave): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Paint; override;
    procedure PaintWindow(DC: HDC); override;
    procedure Play; override;
    procedure Reset; override;
  end;

implementation

constructor TSett1200.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  Color:= clBlack;
  FTimer1:= TTimer.Create(Self);
  With FTimer1 do begin
    Enabled:= False;
    OnTimer:= Timer1Timer;
    Interval:= 100;
  end;
  FTimer2:= TTimer.Create(Self);
  With FTimer2 do begin
    Enabled:= False;
    OnTimer:= Timer2Timer;
    Interval:= 100;
  end;
  FFrame1:= TWinControl.Create(Self);
  With FFrame1 do begin
    Align:= alClient;
    FFrame1.Parent:= Self;
  end;
  FFrame2:= TWinControl.Create(Self);
  With FFrame2 do begin
    Visible:= False;
    Align:= alClient;
    FFrame2.Parent:= Self;
  end;
  Height:= 150;
  Width:= 350;
  SetLength(FMatChv, 2);
//  SetLength(FData, 14);
end;

destructor TSett1200.Destroy;
begin
  Inherited Destroy;
end;

procedure TSett1200.Chv1Click(Sender: TObject);
var a1: Integer;
begin
  FTimer2.Enabled:= False;
  a1:= TChave(Sender).ID;
  FData[2]:= FMatChv[1, FIndChvCor].LabelChv;
  FData[3]:= FMatChv[1, a1].LabelChv;
  FData[5]:= FMatChv[1, FIndChvCor].LabelStm;
  FData[6]:= FMatChv[1, a1].LabelStm;
  FData[8]:= FMatChv[1, FIndChvCor].ShortFileName;
  FData[9]:= FMatChv[1, a1].ShortFileName;
  If FDoParalellReinf then FData[11]:= 'Programado'
  else FData[11]:= 'Não Programado';
  If a1 = FIndChvCor then begin
    FData[10]:= 'Correta';
    If FDoParalellReinf then begin
      FData[12]:= 'Liberado';
      asm
        mov dx, $378
        mov al, 255
        out dx, al
      end;
    end else FData[12]:= 'Não Liberado';
    If FEfeitoSonoro then Beep;
  end else begin
    FData[10]:= 'Errada';
    FData[12]:= 'Não Liberado';
  end;
  FData[13]:= IntToStr(FLatencia);
//  Visible:= False;
  FTimer1.Enabled:= True;
end;

procedure TSett1200.EndTent;
var a1, a2: Integer;
begin
  For a1:= 0 to High(FMatChv) do
    For a2:= 0 to High(FMatChv[a1]) do
      If Assigned(FMatChv[a1, a2]) then FMatChv[a1, a2].Parent:= nil;
  If Assigned(OnEndTent) then FEndTent(Self, FData);
end;

function TSett1200.SetChv1(Ind:  Integer; AChave: TChave): Boolean;
begin
  If Ind > High(FMatChv[1]) then SetLength(FMatChv[1], Ind+1);
  FMatChv[1, Ind]:= AChave;
  If Assigned(FMatChv[1, Ind]) then
    With FMatChv[1, Ind] do begin
      OnClick:= Chv1Click;
      ID:= Ind;
      Parent:= FFrame1;
    end;
  Result:= True;
end;

function TSett1200.SetChv2(Ind:  Integer; AChave: TChave): Boolean;
begin
  Result:= False;
  If ((Ind > -1) and (Ind < 2)) then begin
    FMatChv[2, Ind]:= AChave;
    If Assigned(FMatChv[2, Ind]) then
      With FMatChv[2, Ind] do begin
        Parent:= FFrame2;
      end;
    Result:= True;
  end;
end;

procedure TSett1200.Timer1Timer(Sender: TObject);
begin
  FTimer1.Enabled:= False;
  asm
    mov dx, $378
    mov al, 0
    out dx, al
  end;
  EndTent;
end;

procedure TSett1200.Timer2Timer(Sender: TObject);
begin
  Inc(FLatencia, 100);
end;

function TSett1200.GetMatChv(Ind1, Ind2: Integer): TChave;
begin
  If (Ind1 > -1) and (Ind1 < Length(FMatChv)) then begin
    If (Ind2 > -1) and (Ind2 < Length(FMatChv[Ind1])) then
      Result:= FMatChv[Ind1, Ind2]
    else Result:= nil;
  end else Result:= nil;
end;

function TSett1200.GetMatPar(Ind1, Ind2: Integer): Variant;
begin

end;

procedure TSett1200.SetMatPar(Ind1, Ind2: Integer; Value: Variant);
begin
  Case Ind1 of
    0: Case Ind2 of
         0: FIndChvCor:= Value;
       end;
    1: Case Ind2 of
         0: FDoParalellReinf:= Value;
         1: begin
              Cursor:= Value;
              FFrame1.Cursor:= Cursor;
              FFrame2.Cursor:= Cursor;
            end;
       end;
  end;
end;

function TSett1200.InsertChv(Ind1, Ind2: Integer; AChave: TChave): Boolean;
begin
  Result:= False;
  Case Ind1 of
    1: Result:= SetChv1(Ind2, AChave);
    2: Result:= SetChv2(Ind2, AChave);
  end;
end;

procedure TSett1200.KeyDown(var Key: Word; Shift: TShiftState);
var a1, a2: Integer;
begin
  If (ssCtrl in Shift) then
    Case Key of
      115: EndTent;
      13: begin
            For a1:= 0 to High(FMatChv) do
              For a2:= 0 to High(FMatChv[a1]) do
                If Assigned(FMatChv[a1, a2]) then FMatChv[a1, a2].Parent:= nil;
            If Assigned(OnEndSes) then FEndSes(Self);
          end;
    end;
end;

procedure TSett1200.Paint;
begin

end;

procedure TSett1200.PaintWindow(DC: HDC);
begin
  Canvas.Handle:= DC;
  Paint;
end;

procedure TSett1200.Play;
begin
  asm
    mov dx, $378
    mov al, 0
    out dx, al
  end;
  If CanFocus then SetFocus;
  FFrame1.Visible:= True;
  FLatencia:= 0;
  FTimer2.Enabled:= True;
end;

procedure TSett1200.Reset;
begin
  FFrame1.Cursor:= Cursor;
  FFrame2.Cursor:= Cursor;
  FIndChvCor:= -1;
  SetLength(FData, 0);
  SetLength(FData, 14);
end;

end.
