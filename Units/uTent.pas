unit uTent;

interface

uses Windows, Classes, SysUtils, Graphics, Controls, ExtCtrls, Forms,
     uAbsTent, uChave, uStmGrid, uCfgSes, uObjIns;

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

  TValueChangeEvent = procedure (IndCnj, IndCls: Integer; Value: String) of Object;

  TResizer = class(TGraphicControl)
  private
    FNewLeft, FNewTop, FNewWidth, FNewHeight: Integer;
    FIndObj: Integer;
    FChave: TChave;
    FPoint: TPoint;
    FVetPanel: Array [0..7] of TPanel;
    FOnValueChange: TValueChangeEvent;
    procedure SetChave(Chave: TChave);
    procedure PanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SetNewLeft(Value: Integer);
    procedure SetNewTop(Value: Integer);
    procedure SetNewWidth(Value: Integer);
    procedure SetNewHeight(Value: Integer);
  protected
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
  public
    constructor Create(AOwner: TComponent; Chave: TChave; IndObj: Integer); reintroduce;
    destructor Destroy; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure NewSetBounds(ALeft, ATop, AWidth, AHeight: Integer);
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure Resize; override;
    procedure Select(Value: Boolean);
    procedure SetParent(AParent: TWinControl); override;

    property IndObj: Integer read FIndObj write FIndObj;

    property Chave: TChave write SetChave;
    property OnValueChange: TValueChangeEvent read FOnValueChange write FOnValueChange;

    property NewLeft: Integer read FNewLeft write SetNewLeft;
    property NewTop: Integer read FNewTop write SetNewTop;
    property NewWidth: Integer read FNewWidth write SetNewWidth;
    property NewHeight: Integer read FNewHeight write SetNewHeight;
  end;

  TMask = class(TComponent)
  private
    FGlass: TGlass;
    FOnValueChange: TValueChangeEvent;
    FParent: TWinControl;
    FAssocCtrl: TControl;
    FNumResizer: Integer;
    FVetResizer: Array of TResizer;
    procedure SetParent(AParent: TWinControl);
    procedure SetAssociatedControl(AControl: TControl);
    function GetResizer(IndObj: Integer): TResizer;
    procedure ResizerValueChange(IndCnj, IndCls: Integer; Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    procedure NewResizer(Chave: TChave; IndObj, IndProp: Integer);

    property Parent: TWinControl write SetParent;
    property AssocCtrl: TControl write SetAssociatedControl;
    property Resizer[IndObj: Integer]: TResizer read GetResizer;
    property OnValueChange: TValueChangeEvent read FOnValueChange write FOnValueChange;
  end;

  TCfgTent = class(TAbsCfgTent)
  private
    FTent: TTent;
    FMatStm: TMatStm;
    FMask: TMask;
    procedure MaskValueChange(IndObj, IndProp: Integer; Value: String);
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
           NewSetBounds(Self.Left+X, Self.Top+Y, Abs(Self.Width-X), Abs(Self.Height-Y));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 0, IntToStr(FNewLeft));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 1, IntToStr(FNewTop));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 2, IntToStr(FNewWidth));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 3, IntToStr(FNewHeight));
         end;
      1: If ssLeft in Shift then begin
           SetBounds(Left, Top+Y, 6, 6);
           NewSetBounds(Self.Left, Self.Top+Y, Abs(Self.Width), Abs(Self.Height-Y));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 0, IntToStr(FNewLeft));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 1, IntToStr(FNewTop));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 2, IntToStr(FNewWidth));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 3, IntToStr(FNewHeight));
         end;
      2: If ssLeft in Shift then begin
           SetBounds(Left+X, Top+Y, 6, 6);
           NewSetBounds(Self.Left, Self.Top+Y, Abs(Self.Width+X), Abs(Self.Height-Y));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 0, IntToStr(FNewLeft));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 1, IntToStr(FNewTop));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 2, IntToStr(FNewWidth));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 3, IntToStr(FNewHeight));
         end;
      3: If ssLeft in Shift then begin
           SetBounds(Left+X, Top, 6, 6);
           NewSetBounds(Self.Left, Self.Top, Abs(Self.Width+X), Abs(Self.Height));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 0, IntToStr(FNewLeft));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 1, IntToStr(FNewTop));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 2, IntToStr(FNewWidth));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 3, IntToStr(FNewHeight));
         end;
      4: If ssLeft in Shift then begin
           SetBounds(Left+X, Top+Y, 6, 6);
           NewSetBounds(Self.Left, Self.Top, Abs(Self.Width+X), Abs(Self.Height+Y));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 0, IntToStr(FNewLeft));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 1, IntToStr(FNewTop));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 2, IntToStr(FNewWidth));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 3, IntToStr(FNewHeight));
         end;
      5: If ssLeft in Shift then begin
           SetBounds(Left, Top+Y, 6, 6);
           NewSetBounds(Self.Left, Self.Top, Abs(Self.Width), Abs(Self.Height+Y));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 0, IntToStr(FNewLeft));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 1, IntToStr(FNewTop));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 2, IntToStr(FNewWidth));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 3, IntToStr(FNewHeight));
         end;
      6: If ssLeft in Shift then begin
           SetBounds(Left+X, Top+Y, 6, 6);
           NewSetBounds(Self.Left+X, Self.Top, Abs(Self.Width-X), Abs(Self.Height+Y));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 0, IntToStr(FNewLeft));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 1, IntToStr(FNewTop));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 2, IntToStr(FNewWidth));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 3, IntToStr(FNewHeight));
         end;
      7: If ssLeft in Shift then begin
           SetBounds(Left+X, Top, 6, 6);
           NewSetBounds(Self.Left+X, Self.Top, Abs(Self.Width-X), Abs(Self.Height));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 0, IntToStr(FNewLeft));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 1, IntToStr(FNewTop));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 2, IntToStr(FNewWidth));
           If Assigned(OnValueChange) then FOnValueChange(FIndObj, 3, IntToStr(FNewHeight));
         end;
    end;
  end;
end;

procedure TResizer.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:= True;
end;

constructor TResizer.Create(AOwner: TComponent; Chave: TChave; IndObj: Integer);
var a1: Integer;
begin
  Inherited Create(AOwner);
  FIndObj:= IndObj;
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
  SetChave(Chave);  
end;

destructor TResizer.Destroy;
begin
  Inherited Destroy;
end;

procedure TResizer.SetNewLeft(Value: Integer);
begin
  FNewLeft:= Value;
  If Assigned(Parent) then
    Left:= Round(FNewLeft*Parent.Width/1000);
end;

procedure TResizer.SetNewTop(Value: Integer);
begin
  FNewTop:= Value;
  If Assigned(Parent) then
    Top:= Round(FNewTop*Parent.Height/1000);
end;

procedure TResizer.SetNewWidth(Value: Integer);
begin
  FNewWidth:= Value;
  If Assigned(Parent) then
    Width:= Round(FNewWidth*Parent.Width/1000);
end;

procedure TResizer.SetNewHeight(Value: Integer);
begin
  FNewHeight:= Value;
  If Assigned(Parent) then
    Height:= Round(FNewHeight*Parent.Height/1000);
end;

procedure TResizer.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Select(True);
end;

procedure TResizer.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  If ssLeft in Shift then begin
    NewSetBounds(Left+X-FPoint.X, Top+Y-FPoint.Y, Width, Height);
    If Assigned(OnValueChange) then FOnValueChange(FIndObj, 0, IntToStr(FNewLeft));
    If Assigned(OnValueChange) then FOnValueChange(FIndObj, 1, IntToStr(FNewTop));
    If Assigned(OnValueChange) then FOnValueChange(FIndObj, 2, IntToStr(FNewWidth));
    If Assigned(OnValueChange) then FOnValueChange(FIndObj, 3, IntToStr(FNewHeight));
  end else begin
    FPoint.X:= X;
    FPoint.Y:= Y;
  end;
end;

procedure TResizer.NewSetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  If Assigned(Parent) then begin
    If Parent.Width > 0 then FNewLeft:= Round(Left*1000/Parent.Width);
    If Parent.Height > 0 then FNewTop:= Round(Top*1000/Parent.Height);
    If Parent.Width > 0 then FNewWidth:= Round(Width*1000/Parent.Width);
    If Parent.Height > 0 then FNewHeight:= Round(Height*1000/Parent.Height);
  end;
  SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TResizer.DragDrop(Source: TObject; X, Y: Integer);
begin
  If Source is TDragFig then begin
    If Assigned(OnValueChange) then FOnValueChange(FIndObj, 5, IntToStr(FNewLeft));
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

procedure TMask.SetParent(AParent: TWinControl);
begin
  FParent:= AParent;
end;

procedure TMask.SetAssociatedControl(AControl: TControl);
begin
  FAssocCtrl:= AControl;
  If Assigned(FParent) then begin
    FGlass.Parent:= FParent;
    FGlass.SetBounds(FAssocCtrl.Left, FAssocCtrl.Top, FAssocCtrl.Width, FAssocCtrl.Height);
  end;
end;

function TMask.GetResizer(IndObj: Integer): TResizer;
begin
  If (-1 < IndObj) and (IndObj < FNumResizer) then
    Result:= FVetResizer[IndObj]
  else Result:= nil;
end;

procedure TMask.ResizerValueChange(IndCnj, IndCls: Integer; Value: String);
begin
  If Assigned(OnValueChange) then FOnValueChange(IndCnj, IndCls, Value);
end;

constructor TMask.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FNumResizer:= 0;
  FGlass:= TGlass.Create(Self);
end;

procedure TMask.NewResizer(Chave: TChave; IndObj, IndProp: Integer);
begin
  Inc(FNumResizer);
  SetLength(FVetResizer, FNumResizer);
  FVetResizer[FNumResizer-1]:= TResizer.Create(Self, Chave, IndObj);
  With FVetResizer[FNumResizer-1] do begin
    Parent:= FParent;
    FVetResizer[FNumResizer-1].OnValueChange:= ResizerValueChange;
  end;
end;

procedure TCfgTent.MaskValueChange(IndObj, IndProp: Integer; Value: String);
begin
  If Assigned(OnValueChange) then
    FOnValueChange(IndObj, IndProp, Value);
end;

procedure TCfgTent.SetItems;
var a1: Integer; s1: String;
begin
  FNumObj:= 11;
  SetLength(FVetObj, FNumObj);

  With FVetObj[0] do begin
    Cap:= 'Tentativa M1C9';
    NumAtrb:= 1;
    SetLength(VetAtrb, NumAtrb);

    VetAtrb[0].Cap:= 'Cor de Fundo';
    VetAtrb[0].DefVal:= '$00FF00';
    VetAtrb[0].ValType:= vtColor;
//    VetValue[0].VetDefVal[
    VetAtrb[0].LockState:= lsUnLocked;
    VetAtrb[0].LockStates:= [lsLocked, lsClosed, lsUnLocked];
    VetAtrb[0].Key:= 'Color';
  end;

  With FVetObj[1] do begin
    Cap:= 'Chave de Modelo';
    NumAtrb:= 5;
    SetLength(VetAtrb, NumAtrb);

    VetAtrb[0].Cap:= 'Posição Horizontal';
    VetAtrb[0].DefVal:= '10';
    VetAtrb[0].ValType:= vtInteger;
//    VetAtrb[0].VetDefVal[
    VetAtrb[0].LockState:= lsUnLocked;
    VetAtrb[0].LockStates:= [lsLocked, lsClosed, lsUnLocked];
    VetAtrb[0].Key:= 'CM.L';

    VetAtrb[1].Cap:= 'Posição Vertical';
    VetAtrb[1].DefVal:= '10';
    VetAtrb[1].ValType:= vtInteger;
//    VetAtrb[1].VetDefVal[
    VetAtrb[1].LockState:= lsUnLocked;
    VetAtrb[1].LockStates:= [lsLocked, lsClosed, lsUnLocked];
    VetAtrb[1].Key:= 'CM.T';

    VetAtrb[2].Cap:= 'Largura';
    VetAtrb[2].DefVal:= '500';
    VetAtrb[2].ValType:= vtInteger;
//    VetAtrb[2].VetDefVal[
    VetAtrb[2].LockState:= lsUnLocked;
    VetAtrb[2].LockStates:= [lsLocked, lsClosed, lsUnLocked];
    VetAtrb[2].Key:= 'CM.W';

    VetAtrb[3].Cap:= 'Altura';
    VetAtrb[3].DefVal:= '500';
    VetAtrb[3].ValType:= vtInteger;
//    VetAtrb[3].VetDefVal[
    VetAtrb[3].LockState:= lsUnLocked;
    VetAtrb[3].LockStates:= [lsLocked, lsClosed, lsUnLocked];
    VetAtrb[3].Key:= 'CM.H';

    VetAtrb[4].Cap:= 'Estímulo';
    VetAtrb[4].DefVal:= '';
    VetAtrb[4].ValType:= vtInteger;
//    VetAtrb[4].VetDefVal[
    VetAtrb[4].LockState:= lsUnLocked;
    VetAtrb[4].LockStates:= [lsLocked, lsClosed, lsUnLocked];
    VetAtrb[4].Key:= 'CM.Stm';
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
  SetValue(1, 0, GetValue(1, 0));
  SetValue(1, 1, GetValue(1, 1));
  SetValue(1, 2, GetValue(1, 2));
  SetValue(1, 3, GetValue(1, 3));
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

{
  FGlass:= TGlass.Create(nil);
  With FGlass do begin
    Parent:= FTent;
    Align:= alClient;
    OnMouseDown:= GlassMouseDown;
  end;

  FResizer:= TResizer.Create(nil);
  With FResizer do begin
    Tag:= 1;
    Parent:= FTent;
    Chave:= FTent.ChvMod;
    OnSelfResize:= ResizerResize;
    OnStmChange:= ResizerStmChange;
  end;
}
  FMask:= TMask.Create(nil);
  With FMask do begin
    Parent:= FTent;
    AssocCtrl:= FTent;
    NewResizer(FTent.ChvMod, 1, 0);
    OnValueChange:= MaskValueChange;
  end;

  For a1:= 0 to FNumObj-1 do
    For a2:= 0 to FVetObj[a1].NumAtrb-1 do  begin
      SetValue(a1, a2, FVetObj[a1].VetAtrb[a2].DefVal);
    end;
end;

destructor TCfgTent.Destroy;
begin
  FMask.Free;
  FTent.Free;  
  Inherited Destroy;
end;

function TCfgTent.GetValue(IndObj, IndProp: Integer): String;
begin
  Case IndObj of
    0: Case IndProp of
         0: Result:= IntToStr(FTent.Color);
       end;
    1: Case IndProp of
         0: Result:= IntToStr(FMask.Resizer[0].NewLeft);
         1: Result:= IntToStr(FMask.Resizer[0].NewTop);
         2: Result:= IntToStr(FMask.Resizer[0].NewWidth);
         3: Result:= IntToStr(FMask.Resizer[0].NewHeight);
         4: Result:= FTent.ChvMod.FileName;
       end;
    2..10:
       Case IndProp of
         0: Result:= IntToStr(Round(FTent.ChvCmp[IndObj-2].Left*1000/FTent.Width));
         1: Result:= IntToStr(Round(FTent.ChvCmp[IndObj-2].Top*1000/FTent.Height));
         2: Result:= IntToStr(Round(FTent.ChvCmp[IndObj-2].Width*1000/FTent.Width));
         3: Result:= IntToStr(Round(FTent.ChvCmp[IndObj-2].Height*1000/FTent.Height));
       end;
  end;
end;

procedure TCfgTent.SetValue(IndObj, IndProp: Integer; Value: String);
begin
  Case IndObj of
    0: Case IndProp of
         0: FTent.Color:= StrToIntDef(Value, 0);
       end;
    1: Case IndProp of
         0: FMask.Resizer[0].NewLeft:= StrToInt(Value);
         1: FMask.Resizer[0].NewTop:= StrToInt(Value);
         2: FMask.Resizer[0].NewWidth:= StrToInt(Value);
         3: FMask.Resizer[0].NewHeight:= StrToInt(Value);
         4: FTent.ChvMod.FileName:= FMatStm.GetFullFileName(Value);
       end;
    2..10:
       Case IndProp of
         0: FTent.ChvCmp[IndObj-2].Left:= Round((StrToIntDef(Value, 0)*FTent.Width/1000));
         1: FTent.ChvCmp[IndObj-2].Top:= Round((StrToIntDef(Value, 0)*FTent.Height/1000));
         2: FTent.ChvCmp[IndObj-2].Width:= Round((StrToIntDef(Value, 0)*FTent.Width/1000));
         3: FTent.ChvCmp[IndObj-2].Height:= Round((StrToIntDef(Value, 0)*FTent.Height/1000));
       end;
  end;
end;

end.

