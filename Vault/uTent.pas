unit uTent;

interface

uses Windows, Classes, SysUtils, Graphics, Controls, ExtCtrls, Forms,
     uAbsTent, uChave, uObjIns, uStmGrid, uCfgSes;

type
  TTent = class(TAbsTent)
  private
    FChvMod: TChave;
    FVetChvCmp: Array [0..8] of TChave;
    function GetChvCmp(Ind: Integer): TChave;
    procedure ChvModClick(Sender: TObject);
    procedure ChvCmpClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Play; override;
    property ChvMod: TChave read FChvMod;
    property ChvCmp[Ind: Integer]: TChave read GetChvCmp;
    property Color;
  end;

  TGlass = class(TGraphicControl)
  private
  protected
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
  public
  end;

  TStmChangeEvent = procedure (Sender: TObject; IndCnj, IndCls: Integer) of Object;

  TResizer = class(TGraphicControl)
  private
    FChave: TChave;
    FOnSelfResize: TNotifyEvent;
    FOnStmChange: TStmChangeEvent;
    FPoint: TPoint;
    FVetPanel: Array [0..7] of TPanel;
    procedure SetChave(Chave: TChave);
    procedure PanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  protected
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure Resize; override;
    procedure Select(Value: Boolean);
    procedure SetParent(AParent: TWinControl); override;
    property Chave: TChave write SetChave;
    property OnSelfResize: TNotifyEvent read FOnSelfResize write FOnSelfResize;
    property OnStmChange: TStmChangeEvent read FOnStmChange write FOnStmChange;
  end;

  TCfgTent = class(TAbsCfgTent)
  private
    FGlass: TGlass;
    FResizer: TResizer;
    FTent: TTent;
    FMatStm: TMatStm;
    procedure ResizerResize(Sender: TObject);
    procedure ResizerStmChange(Sender: TObject; IndCnj, IndCls: Integer);
    procedure SetItems;
    procedure TentResize(Sender: TObject);
  protected
    function GetObj_Name(Ind: Integer): String; override;
    function GetObj_NumAtrb(Ind: Integer): Integer; override;
    function GetObj_Atrb(IndObj, IndAtrb: Integer): TAtrb; override;

    function GetValue(IndObj, IndProp: Integer): String; override;
    procedure SetValue(IndObj, IndProp: Integer; Value: String); override;
  public
    constructor Create(AOwner: TComponent; MatStm: TMatStm); reintroduce;
    destructor Destroy; override;
  end;

implementation

constructor TTent.Create(AOwner: TComponent);
var a1: Integer;
begin
  Inherited Create(AOwner);
  SetBounds(0, 0, 1024, 768);
  FChvMod:= TChave.Create(Self);
  With FChvMod do begin
    Visible:= False;
    Parent:= Self;
    OnClick:= ChvModClick;
  end;
  For a1:= 0 to 8 do begin
    FVetChvCmp[a1]:= TChave.Create(Self);
    With FVetChvCmp[a1] do begin
      Visible:= False;
      Parent:= Self;
      OnClick:= ChvCmpClick;
    end;
  end;
end;

destructor TTent.Destroy;
begin
  Inherited Destroy;
end;

procedure TTent.Paint;
begin

end;

procedure TTent.Play;
begin
  FChvMod.Visible:= True;
end;

function TTent.GetChvCmp(Ind: Integer): TChave;
begin
  If (Ind > -1) and (Ind < 9) then Result:= FVetChvCmp[Ind]
  else Result:= nil;
end;

procedure TTent.ChvModClick(Sender: TObject);
var a1: Integer;
begin
  For a1:= 0 to 8 do
    FVetChvCmp[a1].Visible:= True;
end;

procedure TTent.ChvCmpClick(Sender: TObject);
begin
  FResult:= 'resposta na máscara';
  If Assigned(OnEndTent) then FOnEndTent(Self);
end;

procedure TGlass.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:= False;
end;

procedure TResizer.SetChave(Chave: TChave);
begin
  FChave:= Chave;
  SetBounds(FChave.Left, FChave.Top, FChave.Width, FChave.Height);
end;

procedure TResizer.PanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  With TPanel(Sender) do begin
    Case Tag of
      0: If ssLeft in Shift then begin
           SetBounds(Left+X, Top+Y, 6, 6);
           Self.SetBounds(Self.Left+X, Self.Top+Y, Abs(Self.Width-X), Abs(Self.Height-Y));
           If Assigned(OnSelfResize) then FOnSelfResize(Self);
         end;
      1: If ssLeft in Shift then begin
           SetBounds(Left, Top+Y, 6, 6);
           Self.SetBounds(Self.Left, Self.Top+Y, Abs(Self.Width), Abs(Self.Height-Y));
           If Assigned(OnSelfResize) then FOnSelfResize(Self);
         end;
      2: If ssLeft in Shift then begin
           SetBounds(Left+X, Top+Y, 6, 6);
           Self.SetBounds(Self.Left, Self.Top+Y, Abs(Self.Width+X), Abs(Self.Height-Y));
           If Assigned(OnSelfResize) then FOnSelfResize(Self);
         end;
      3: If ssLeft in Shift then begin
           SetBounds(Left+X, Top, 6, 6);
           Self.SetBounds(Self.Left, Self.Top, Abs(Self.Width+X), Abs(Self.Height));
           If Assigned(OnSelfResize) then FOnSelfResize(Self);
         end;
      4: If ssLeft in Shift then begin
           SetBounds(Left+X, Top+Y, 6, 6);
           Self.SetBounds(Self.Left, Self.Top, Abs(Self.Width+X), Abs(Self.Height+Y));
           If Assigned(OnSelfResize) then FOnSelfResize(Self);
         end;
      5: If ssLeft in Shift then begin
           SetBounds(Left, Top+Y, 6, 6);
           Self.SetBounds(Self.Left, Self.Top, Abs(Self.Width), Abs(Self.Height+Y));
           If Assigned(OnSelfResize) then FOnSelfResize(Self);
         end;
      6: If ssLeft in Shift then begin
           SetBounds(Left+X, Top+Y, 6, 6);
           Self.SetBounds(Self.Left+X, Self.Top, Abs(Self.Width-X), Abs(Self.Height+Y));
           If Assigned(OnSelfResize) then FOnSelfResize(Self);
         end;
      7: If ssLeft in Shift then begin
           SetBounds(Left+X, Top, 6, 6);
           Self.SetBounds(Self.Left+X, Self.Top, Abs(Self.Width-X), Abs(Self.Height));
           If Assigned(OnSelfResize) then FOnSelfResize(Self);
         end;
    end;
  end;
end;

procedure TResizer.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:= True;
end;

constructor TResizer.Create(AOwner: TComponent);
var a1: Integer;
begin
  Inherited Create(AOwner);
  Cursor:= crSizeAll;
  For a1:= 0 to 7 do begin
    FVetPanel[a1]:= TPanel.Create(Self);
    With FVetPanel[a1] do begin
      Tag:= a1;
      BevelInner:= bvNone;
      BevelOuter:= bvNone;
      Visible:= False;
      Color:= clBlack;
      OnMouseMove:= PanelMouseMove;
    end;
  end;
  FVetPanel[0].Cursor:= crSizeNWSE;
  FVetPanel[1].Cursor:= crSizeNS;
  FVetPanel[2].Cursor:= crSizeNESW;
  FVetPanel[3].Cursor:= crSizeWE;
  FVetPanel[4].Cursor:= crSizeNWSE;
  FVetPanel[5].Cursor:= crSizeNS;
  FVetPanel[6].Cursor:= crSizeNESW;
  FVetPanel[7].Cursor:= crSizeWE;
end;

destructor TResizer.Destroy;
begin
  Inherited Destroy;
end;

procedure TResizer.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Select(True);
end;

procedure TResizer.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  If ssLeft in Shift then begin
    SetBounds(Left+X-FPoint.X, Top+Y-FPoint.Y, Width, Height);
    If Assigned(OnSelfResize) then FOnSelfResize(Self);
  end else begin
    FPoint.X:= X;
    FPoint.Y:= Y;
  end;
end;

procedure TResizer.DragDrop(Source: TObject; X, Y: Integer);
begin
  If Source is TDragFig then begin
    If Assigned(OnStmChange) then FOnStmChange(Self, TDragFig(Source).IndCnj, TDragFig(Source).IndCls);
  end;
end;

procedure TResizer.Resize;
begin
  If Assigned(FChave) then
    FChave.SetBounds(Left, Top, Width, Height);
  FVetPanel[0].SetBounds(Left-3, Top-3, 6, 6);
  FVetPanel[1].SetBounds(Left+Width div 2-3, Top-3, 6, 6);
  FVetPanel[2].SetBounds(Left+Width-3, Top-3, 6, 6);
  FVetPanel[3].SetBounds(Left+Width-3, Top+Height div 2-3, 6, 6);
  FVetPanel[4].SetBounds(Left+Width-3, Top+Height-3, 6, 6);
  FVetPanel[5].SetBounds(Left+Width div 2-3, Top+Height-3, 6, 6);
  FVetPanel[6].SetBounds(Left-3, Top+Height-3, 6, 6);
  FVetPanel[7].SetBounds(Left-3, Top+Height div 2-3, 6, 6);
end;

procedure TResizer.Select(Value: Boolean);
var a1: Integer;
begin
  For a1:= 0 to 7 do
    FVetPanel[a1].Visible:= Value;
end;

procedure TResizer.SetParent(AParent: TWinControl);
var a1: Integer;
begin
  Inherited SetParent(AParent);
  For a1:= 0 to 7 do
    FVetPanel[a1].Parent:= AParent;
end;

procedure TCfgTent.ResizerResize(Sender: TObject);
begin
  If FTent.Width > 0 then begin
    If Assigned(OnValueChange) then
      FOnValueChange(TControl(Sender).Tag, 0, IntToStr(Round(TControl(Sender).Left*1000/FTent.Width)));
    If Assigned(OnValueChange) then
      FOnValueChange(TControl(Sender).Tag, 2, IntToStr(Round(TControl(Sender).Width*1000/FTent.Width)));
  end;

  If FTent.Height > 0 then begin
    If Assigned(OnValueChange) then
      FOnValueChange(TControl(Sender).Tag, 1, IntToStr(Round(TControl(Sender).Top*1000/FTent.Height)));
    If Assigned(OnValueChange) then
      FOnValueChange(TControl(Sender).Tag, 3, IntToStr(Round(TControl(Sender).Height*1000/FTent.Height)));
  end;
end;

procedure TCfgTent.ResizerStmChange(Sender: TObject; IndCnj, IndCls: Integer);
begin
  SetValue(1, 4, Chr(IndCnj+65)+IntToStr(IndCls+1));
  If Assigned(OnValueChange) then FOnValueChange(1, 4, Chr(IndCnj+65)+IntToStr(IndCls+1));
end;

procedure TCfgTent.SetItems;
var a1: Integer; s1: String;
begin
  FNumObj:= 11;
  SetLength(FVetObj, FNumObj);
  With FVetObj[0] do begin
    Cap:= 'Tentativa M1C9';
    NumAtrb:= 4;
    SetLength(VetAtrb, NumAtrb);

    VetAtrb[0].Cap:= 'Nome da Configuraçao';
    VetAtrb[0].Key:= 'Name';
    VetAtrb[0].DefVal:= '';

    VetAtrb[1].Cap:= 'Tipo de Tentativa';
    VetAtrb[1].Key:= 'Type';
    VetAtrb[1].DefVal:= 'M1C9';

    VetAtrb[2].Cap:= 'Comentarios';
    VetAtrb[2].Key:= 'Coments';
    VetAtrb[2].DefVal:= 'Sem Comentarios';
    VetAtrb[2].ValType:= vtString;    
    VetAtrb[2].LockState:= lsOpened;
    VetAtrb[2].LockStates:= [lsLocked, lsClosed, lsUnLocked];

    VetAtrb[3].Cap:= 'Cor de Fundo';
    VetAtrb[3].DefVal:= '$00FF00';
    VetAtrb[3].ValType:= vtColor;
//    VetValue[3].VetDefVal[
    VetAtrb[3].LockState:= lsUnLocked;
    VetAtrb[3].LockStates:= [lsLocked, lsClosed, lsUnLocked];
    VetAtrb[3].Key:= 'Color';
  end;

  With FVetObj[1] do begin
    Cap:= 'Chave de Modelo';
    NumAtrb:= 5;
    SetLength(VetAtrb, NumAtrb);

    VetAtrb[0].Cap:= 'Posição Horizontal';
    VetAtrb[0].Key:= 'CM.L';
    VetAtrb[0].DefVal:= '200';
    VetAtrb[0].ValType:= vtString;

    VetAtrb[1].Cap:= 'Posição Vertical';
    VetAtrb[1].Key:= 'CM.T';
    VetAtrb[1].DefVal:= '200';

    VetAtrb[2].Cap:= 'Largura';
    VetAtrb[2].Key:= 'CM.W';
    VetAtrb[2].DefVal:= '150';

    VetAtrb[3].Cap:= 'Altura';
    VetAtrb[3].Key:= 'CM.H';
    VetAtrb[3].DefVal:= '50';

    VetAtrb[4].Cap:= 'Estímulo';
    VetAtrb[4].Key:= 'CM.Stm';
    VetAtrb[4].DefVal:= '';
  end;

  For a1:= 2 to 10 do begin
    With FVetObj[a1] do begin
      Cap:= 'Chave de Comparação '+IntToStr(a1-1);
      NumAtrb:= 4;
      SetLength(VetAtrb, NumAtrb);
      s1:= IntToStr(a1-2);

      VetAtrb[0].Cap:= 'Posição Horizontal';
      VetAtrb[0].Key:= 'CC'+s1+'.L';
      VetAtrb[0].DefVal:= IntToStr(20*a1);

      VetAtrb[1].Cap:= 'Posição Vertical';
      VetAtrb[1].Key:= 'CC'+s1+'.T';
      VetAtrb[1].DefVal:= IntToStr(20*a1);

      VetAtrb[2].Cap:= 'Largura';
      VetAtrb[2].Key:= 'CC'+s1+'.W';
      VetAtrb[2].DefVal:= '15';

      VetAtrb[3].Cap:= 'Altura';
      VetAtrb[3].Key:= 'CC'+s1+'.H';
      VetAtrb[3].DefVal:= '15';
    end;
  end;
end;

procedure TCfgTent.TentResize(Sender: TObject);
begin
  If FTent.Width > 0 then begin
    SetValue(1, 0, IntToStr(Round(FTent.ChvMod.Left*1000/FTent.Width)));
    SetValue(1, 2, IntToStr(Round(FTent.ChvMod.Width*1000/FTent.Width)));
  end;
  If FTent.Height > 0 then begin
    SetValue(1, 1, IntToStr(Round(FTent.ChvMod.Top*1000/FTent.Height)));
    SetValue(1, 3, IntToStr(Round(FTent.ChvMod.Height*1000/FTent.Height)));
  end;
end;

function TCfgTent.GetObj_Name(Ind: Integer): String;
begin
  If (-1 < Ind) and (Ind < FNumObj) then
    Result:= FVetObj[Ind].Cap;
end;

function TCfgTent.GetObj_NumAtrb(Ind: Integer): Integer;
begin
  If (-1 < Ind) and (Ind < FNumObj) then
    Result:= FVetObj[Ind].NumAtrb
  else Result:= 0;
end;

function TCfgTent.GetObj_Atrb(IndObj, IndAtrb: Integer): TAtrb;
begin
  If (-1 < IndObj) and (IndObj < FNumObj) then
    If (-1 < IndAtrb) and (IndAtrb < FVetObj[IndObj].NumAtrb) then
      Result:= FVetObj[IndObj].VetAtrb[IndAtrb];
end;

constructor TCfgTent.Create(AOwner: TComponent; MatStm: TMatStm);
var a1, a2: Integer;
begin
  Inherited Create(AOwner);
  FType:= 'M1C9';
  SetItems;

  FMatStm:= MatStm;

  FTent:= TTent.Create(nil);
  With FTent do begin
    Parent:= Self;
    Align:= alClient;
    ChvMod.Visible:= True;
    For a1:= 0 to 8 do FVetChvCmp[a1].Visible:= True;
    OnResize:= TentResize;
  end;

  FGlass:= TGlass.Create(nil);
  With FGlass do begin
    Parent:= FTent;
    Align:= alClient;
  end;

  FResizer:= TResizer.Create(nil);
  With FResizer do begin
    Tag:= 1;
    Parent:= FTent;
    Chave:= FTent.ChvMod;
    OnSelfResize:= ResizerResize;
    OnStmChange:= ResizerStmChange;
  end;

  For a1:= 0 to FNumObj-1 do
    For a2:= 0 to FVetObj[a1].NumAtrb-1 do
      SetValue(a1, a2, FVetObj[a1].VetAtrb[a2].DefVal);
end;

destructor TCfgTent.Destroy;
begin
  FGlass.Free;
  FResizer.Free;
  FTent.Free;
  Inherited Destroy;
end;

function TCfgTent.GetValue(IndObj, IndProp: Integer): String;
begin
  Case IndObj of
    0: Case IndProp of
         0: ;
         1: ;
         2: ;
         3: Result:= IntToStr(FTent.Color);
       end;
    1: Case IndProp of
         0: Result:= IntToStr(Round(FResizer.Left*1000/FTent.Width));
         1: Result:= IntToStr(Round(FResizer.Top*1000/FTent.Height));
         2: Result:= IntToStr(Round(FResizer.Width*1000/FTent.Width));
         3: Result:= IntToStr(Round(FResizer.Height*1000/FTent.Height));
         4: Result:= FTent.ChvMod.FileName;
       end;
    2..10:
       Case IndProp of
         0: Result:= IntToStr(FTent.ChvCmp[IndObj-2].Left);
         1: Result:= IntToStr(FTent.ChvCmp[IndObj-2].Top);
         2: Result:= IntToStr(FTent.ChvCmp[IndObj-2].Width);
         3: Result:= IntToStr(FTent.ChvCmp[IndObj-2].Height);
       end;
  end;
end;

procedure TCfgTent.SetValue(IndObj, IndProp: Integer; Value: String);
begin
  Case IndObj of
    0: Case IndProp of
         0: ;
         1: ;
         2: ;
         3: FTent.Color:= StrToIntDef(Value, 0);
       end;
    1: Case IndProp of
         0: FResizer.Left:= Round(StrToIntDef(Value, 0)*FTent.Width/1000);
         1: FResizer.Top:= Round(StrToIntDef(Value, 0)*FTent.Height/1000);
         2: FResizer.Width:= Round(StrToIntDef(Value, 0)*FTent.Width/1000);
         3: FResizer.Height:= Round(StrToIntDef(Value, 0)*FTent.Height/1000);
         4: FTent.ChvMod.FileName:= FMatStm.GetFullFileName(Value);
       end;
    2..10:
       Case IndProp of
         0: FTent.ChvCmp[IndObj-2].Left:= Round(StrToIntDef(Value, 0)*FTent.Width/1000);
         1: FTent.ChvCmp[IndObj-2].Top:= Round(StrToIntDef(Value, 0)*FTent.Height/1000);
         2: FTent.ChvCmp[IndObj-2].Width:= Round(StrToIntDef(Value, 0)*FTent.Width/1000);
         3: FTent.ChvCmp[IndObj-2].Height:= Round(StrToIntDef(Value, 0)*FTent.Height/1000);
       end;
  end;
end;

end.

