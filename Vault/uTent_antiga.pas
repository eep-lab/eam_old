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
    procedure RefreshValue(IndItem, IndValue: Integer; Value: String);
    procedure ResizerResize(Sender: TObject);
    procedure ResizerStmChange(Sender: TObject; IndCnj, IndCls: Integer);
    procedure SetItems;
  protected
    function GetVetItem: TVetItem; override;
  public
    constructor Create(AOwner: TComponent; MatStm: TMatStm); reintroduce;
    destructor Destroy; override;
    procedure Load(SLMatStm, SLCfgSeq, SLCfgTent: TStringList); overload; override;
    procedure Load; overload; override;
    procedure SetValue(IndItem, IndValue: Integer; Value: String); override;
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

function TCfgTent.GetVetItem: TVetItem;
begin
  Result:= FVetItem;
end;

procedure TCfgTent.RefreshValue(IndItem, IndValue: Integer; Value: String);
begin
  Case IndItem of
    0: Case IndValue of
         0: ;
         1: ;
         2: ;
         3: FTent.Color:= StrToIntDef(Value, 0);
       end;
    1: Case IndValue of
         0: FResizer.Left:= StrToIntDef(Value, 0);
         1: FResizer.Top:= StrToIntDef(Value, 0);
         2: FResizer.Width:= StrToIntDef(Value, 0);
         3: FResizer.Height:= StrToIntDef(Value, 0);
         4: FTent.ChvMod.FileName:= FMatStm.GetFullFileName(Value);
       end;
    2..10:
       Case IndValue of
         0: FTent.ChvCmp[IndItem-2].Left:= StrToIntDef(Value, 0);
         1: FTent.ChvCmp[IndItem-2].Top:= StrToIntDef(Value, 0);
         2: FTent.ChvCmp[IndItem-2].Width:= StrToIntDef(Value, 0);
         3: FTent.ChvCmp[IndItem-2].Height:= StrToIntDef(Value, 0);
       end;
  end;
end;

procedure TCfgTent.ResizerResize(Sender: TObject);
begin
  If Assigned(OnValueChange) then FOnValueChange(TControl(Sender).Tag, 0, IntToStr(TControl(Sender).Left));
  If Assigned(OnValueChange) then FOnValueChange(TControl(Sender).Tag, 1, IntToStr(TControl(Sender).Top));
  If Assigned(OnValueChange) then FOnValueChange(TControl(Sender).Tag, 2, IntToStr(TControl(Sender).Width));
  If Assigned(OnValueChange) then FOnValueChange(TControl(Sender).Tag, 3, IntToStr(TControl(Sender).Height));
end;

procedure TCfgTent.ResizerStmChange(Sender: TObject; IndCnj, IndCls: Integer);
begin
  RefreshValue(1, 4, Chr(IndCnj+65)+IntToStr(IndCls+1));
  If Assigned(OnValueChange) then FOnValueChange(1, 4, Chr(IndCnj+65)+IntToStr(IndCls+1));
end;

procedure TCfgTent.SetItems;
var a1: Integer; s1: String;
begin
  SetLength(FVetItem, 11);
  With FVetItem[0] do begin
    Cap:= 'Tentativa M1C9';
    SetLength(VetValue, 4);

    VetValue[0].Cap:= 'Nome da Configuraçao';
    VetValue[0].Key:= 'Name';
    VetValue[0].Val:= '';

    VetValue[1].Cap:= 'Tipo de Tentativa';
    VetValue[1].Key:= 'Type';
    VetValue[1].Val:= 'M1C9';

    VetValue[2].Cap:= 'Comentarios';
    VetValue[2].Key:= 'Coments';
    VetValue[2].Val:= 'Sem Comentarios';

    VetValue[3].Cap:= 'Cor de Fundo';
    VetValue[3].Key:= 'Color';
    VetValue[3].Val:= '$00FF00'
  end;

  With FVetItem[1] do begin
    Cap:= 'Chave de Modelo';
    SetLength(VetValue, 5);

    VetValue[0].Cap:= 'Posição Horizontal';
    VetValue[0].Key:= 'CM.L';
    VetValue[0].Val:= '200';

    VetValue[1].Cap:= 'Posição Vertical';
    VetValue[1].Key:= 'CM.T';
    VetValue[1].Val:= '200';

    VetValue[2].Cap:= 'Largura';
    VetValue[2].Key:= 'CM.W';
    VetValue[2].Val:= '150';

    VetValue[3].Cap:= 'Altura';
    VetValue[3].Key:= 'CM.H';
    VetValue[3].Val:= '50';

    VetValue[4].Cap:= 'Estímulo';
    VetValue[4].Key:= 'CM.Stm';
    VetValue[4].Val:= '';
  end;

  For a1:= 2 to 10 do begin
    With FVetItem[a1] do begin
      Cap:= 'Chave de Comparação '+IntToStr(a1-1);
      SetLength(VetValue, 4);
      s1:= IntToStr(a1-2);

      VetValue[0].Cap:= 'Posição Horizontal';
      VetValue[0].Key:= 'CC'+s1+'.L';
      VetValue[0].Val:= IntToStr(20*a1);

      VetValue[1].Cap:= 'Posição Vertical';
      VetValue[1].Key:= 'CC'+s1+'.T';
      VetValue[1].Val:= IntToStr(20*a1);

      VetValue[2].Cap:= 'Largura';
      VetValue[2].Key:= 'CC'+s1+'.W';
      VetValue[2].Val:= '15';

      VetValue[3].Cap:= 'Altura';
      VetValue[3].Key:= 'CC'+s1+'.H';
      VetValue[3].Val:= '15';
    end;
  end;
end;

constructor TCfgTent.Create(AOwner: TComponent; MatStm: TMatStm);
var a1: Integer;
begin
  Inherited Create(AOwner);
  FType:= 'M1C9';
  SetItems;

  FMatStm:= MatStm;

  FTent:= TTent.Create(nil);
  With FTent do begin
    Parent:= Self;
    Align:= alClient;
    Play;
    For a1:= 0 to 8 do FVetChvCmp[a1].Visible:= True;
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
end;

destructor TCfgTent.Destroy;
begin
  FGlass.Free;
  FResizer.Free;
  FTent.Free;
  Inherited Destroy;
end;

procedure TCfgTent.Load(SLMatStm, SLCfgSeq, SLCfgTent: TStringList);
var a1: Integer;
begin
  If SLCfgSeq.Values['Tipo'] = 'M1C9' then begin
    With FTent do begin
      ChvMod.SetBounds(StrToIntDef(SLCfgTent.Values['CM.L'], StrToIntDef(SLCfgSeq.Values['CM.L'], 0)),
                       StrToIntDef(SLCfgTent.Values['CM.T'], StrToIntDef(SLCfgSeq.Values['CM.T'], 0)),
                       StrToIntDef(SLCfgTent.Values['CM.W'], StrToIntDef(SLCfgSeq.Values['CM.W'], 0)),
                       StrToIntDef(SLCfgTent.Values['CM.H'], StrToIntDef(SLCfgSeq.Values['CM.H'], 0)));

      For a1:= 0 to 8 do
        ChvCmp[a1].SetBounds(StrToIntDef(SLCfgTent.Values['CC'+IntToStr(a1)+'.L'], StrToIntDef(SLCfgSeq.Values['CC'+IntToStr(a1)+'.L'], 0)),
                             StrToIntDef(SLCfgTent.Values['CC'+IntToStr(a1)+'.T'], StrToIntDef(SLCfgSeq.Values['CC'+IntToStr(a1)+'.T'], 0)),
                             StrToIntDef(SLCfgTent.Values['CC'+IntToStr(a1)+'.W'], StrToIntDef(SLCfgSeq.Values['CC'+IntToStr(a1)+'.W'], 0)),
                             StrToIntDef(SLCfgTent.Values['CC'+IntToStr(a1)+'.H'], StrToIntDef(SLCfgSeq.Values['CC'+IntToStr(a1)+'.H'], 0)));

      Color:= StrToIntDef(SLCfgTent.Values['Color'], StrToIntDef(SLCfgSeq.Values['Color'], 0));
      Cursor:= StrToIntDef(SLCfgTent.Values['Cursor'], StrToIntDef(SLCfgTent.Values['Cursor'], -1));
//      := StrToInt(SLCfgTent.Values['Tempo máximo sem resposta']);

      ChvMod.FileName:= SLMatStm.Values['ResPath']+SLMatStm.Values[SLCfgTent.Values['CM.Stm']];
//      RespModSchedule:= SLCfgTent.Values['CM.Sch'];

      For a1:= 0 to 8 do begin
        ChvCmp[a1].FileName:= SLMatStm.Values['ResPath']+SLMatStm.Values[SLCfgTent.Values['CC'+IntToStr(a1)+'.Stm']];
//        := SLCfgTent.Values['CM'+IntToStr(a1)+'.Sch'];
//        := SLCfgTent.Values['CC'+IntToStr(a1)+'.Csq'];
//        := SLCfgTent.Values['CC'+IntToStr(a1)+'.Msg'];
//        := SLCfgTent.Values['CC'+IntToStr(a1)+'.Act'];
      end;
    end;
  end;
end;

procedure TCfgTent.Load;
begin

end;

procedure TCfgTent.SetValue(IndItem, IndValue: Integer; Value: String);
begin
  RefreshValue(IndItem, IndValue, Value);
end;

end.

