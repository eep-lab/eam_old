unit fEstimulos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, Grids, StdCtrls, CheckLst, Buttons, IniFiles, Menus,
  uChave, uCfgSes;

type
  TFig = record
    BitMap: TBitmap;
    Loaded: Boolean;
  end;
  PFig = ^TFig;

  TMatFig = Array [0..9] of Array [0..9] of TFig;
  PMatFig = ^TMatFig;

  TNotifyValues = procedure (Val1, Val2: Integer) of Object;

  TThrNotify = class(TThread)
  private
    FOnNotify: TNotifyValues;
  public
    procedure Execute; override;
    property OnNotify: TNotifyValues read FOnNotify write FOnNotify;
  end;

  TEditMatStm = class(TComponent)
  private
    FChave: TChave;
    FDefWidth, FDefHeight: Integer;
    FMatFig: TMatFig;
    FMatStm: TMatStm;
    FOnEndLoad: TNotifyValues;
    FThrNotify: TThrNotify;
    procedure Load(IndCnj, IndCls: Integer);
    function GetMatFig(IndCnj, IndCls: Integer): PFig;
    function GetFileName(IndCnj, IndCls: Integer): String;
    function GetFullFileName(IndCnj, IndCls: Integer): String;
  public
    constructor Create(AOwner: TComponent; MatStm: TMatStm); reintroduce;
    destructor Destroy; override;
    procedure Delete(IndCnj, IndCls: Integer);
    procedure Insert(IndCnj, IndCls: Integer; ShortName: String);
    procedure SetBitmapDim(W, H: Integer);
    property FileName[IndCnj, IndCls: Integer]: String read GetFileName;
    property FullFileName[IndCnj, IndCls: Integer]: String read GetFullFileName;
    property MatFig[IndCnj, IndCls: Integer]: PFig read GetMatFig;
    property OnEndLoad: TNotifyValues read FOnEndLoad write FOnEndLoad;
  end;

{
  TDragFig = class(TDragObjectEx)
  private
    FImage: TImage;
    
    FPanel: TPanel;
    FShortName: String;
  public
    constructor Create(AParent: TWinControl; P: TPoint; Bitmap: TBitmap; ShortName: String); reintroduce;
    destructor Destroy; override;
    procedure MoveFig(X, Y: Integer);
    property ShortName: String read FShortName;
  end;
}

  TSupFile = record
    FileName: String;
    Kind: String;
  end;
  PSupFile = ^TSupFile;

  TFmEstimulos = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Panel4: TPanel;
    Panel8: TPanel;
    Panel6: TPanel;
    ListView1: TListView;
    Panel5: TPanel;
    DrawGrid1: TDrawGrid;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    Splitter1: TSplitter;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure DrawGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure DrawGrid1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DrawGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DrawGrid1StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure DrawGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
  private
    { Private declarations }
//    FColSort: Integer;
//    FSpinSort: Boolean;
    FChave: TChave;
//    FCurPos: TPoint;
    FDragBitMap: TBitMap;
//    procedure ChaveClick(Sender: TObject);
  public
    { Public declarations }
    FEditMatStm: TEditMatStm;
  end;

var
  FmEstimulos: TFmEstimulos;

implementation

uses Unit1;

{$R *.DFM}

procedure TThrNotify.Execute;
var a1, a2: Integer;
begin
  FreeOnTerminate:= True;
  For a1:= 0 to 9 do
    For a2:= 0 to 9 do
      If Assigned(FOnNotify) then
        FOnNotify(a1, a2);
end;

procedure TEditMatStm.Load(IndCnj, IndCls: Integer);
begin
  FChave:= TChave.Create(Self);
  FChave.SetBounds(0, 0, FDefWidth, FDefHeight);
  FChave.FileName:= FMatStm.GetFullFileName(IndCnj, IndCls);
  If FChave.Kind = stmNone then begin
    If FMatFig[IndCnj, IndCls].Loaded then
      FMatFig[IndCnj, IndCls].BitMap.Free;
    FMatFig[IndCnj, IndCls].Loaded:= False;
  end else begin
    If not FMatFig[IndCnj, IndCls].Loaded then begin
      FMatFig[IndCnj, IndCls].BitMap:= TBitmap.Create;
      FMatFig[IndCnj, IndCls].BitMap.Width:= FChave.Width;
      FMatFig[IndCnj, IndCls].BitMap.Height:= FChave.Height;
      FMatFig[IndCnj, IndCls].Loaded:= True;
    end;
    FMatFig[IndCnj, IndCls].BitMap.Canvas.Lock;
    FMatFig[IndCnj, IndCls].BitMap.Canvas.StretchDraw(Rect(0, 0, FChave.Width, FChave.Height), FChave.BitMap);
    FMatFig[IndCnj, IndCls].BitMap.Canvas.Unlock;
  end;
  If Assigned(OnEndLoad) then FOnEndLoad(IndCnj, IndCls);
  FChave.Free;
end;

function TEditMatStm.GetMatFig(IndCnj, IndCls: Integer): PFig;
begin
  If (IndCnj > -1) and (IndCls < 10) and (IndCls > -1) and (IndCls < 10) then
    Result:= @FMatFig[IndCnj, IndCls]
  else Result:= nil;
end;

function TEditMatStm.GetFileName(IndCnj, IndCls: Integer): String;
begin
  Result:= FMatStm.GetFileName(IndCnj, IndCls);
end;

function TEditMatStm.GetFullFileName(IndCnj, IndCls: Integer): String;
begin
  Result:= FMatStm.GetFullFileName(IndCnj, IndCls);
end;

constructor TEditMatStm.Create(AOwner: TComponent; MatStm: TMatStm);
begin
  Inherited Create(AOwner);
  FMatStm:= MatStm;

  SetBitmapDim(72, 54);

  FThrNotify:= TThrNotify.Create(True);
  FThrNotify.OnNotify:= Load;
  FThrNotify.Resume;

end;

destructor TEditMatStm.Destroy;
var a1, a2: Integer;
begin
  For a1:= 0 to 9 do
    For a2:= 0 to 9 do
      If FMatFig[a1, a2].Loaded then
        FMatFig[a1, a2].BitMap.Free;

  Inherited Destroy;
end;

procedure TEditMatStm.SetBitmapDim(W, H: Integer);
begin
  FDefWidth:= W;
  FDefHeight:= H;
end;

{
constructor TDragFig.Create(AParent: TWinControl; P: TPoint; Bitmap: TBitmap; ShortName: String);
begin
  Inherited Create;
  FShortName:= ShortName;

  FImage:= TImage.Create(nil);
  If Assigned(Bitmap) then begin
    FImage.SetBounds(0, 0, Bitmap.Width, Bitmap.Height);
    FImage.Picture.Assign(Bitmap);
  end;

  FPanel:= TPanel.Create(nil);
  FPanel.SetBounds(P.X, P.Y, FImage.Width, FImage.Height);
  FPanel.Parent:= AParent;

  FImage.Parent:= FPanel;
end;

destructor TDragFig.Destroy;
begin
  FImage.Free;
  FPanel.Free;
  Inherited Destroy;
end;

procedure TDragFig.MoveFig(X, Y: Integer);
begin
  FPanel.SetBounds(X, Y, FImage.Width, FImage.Height);
end;
}

procedure TEditMatStm.Delete(IndCnj, IndCls: Integer);
begin
  If (IndCnj > -1) and (IndCls > -1) and (IndCnj < 10) and (IndCls < 10) then begin
    FMatStm.SetFileName(IndCnj, IndCls, '');

    If FMatFig[IndCnj, IndCls].Loaded then begin
      FMatFig[IndCnj, IndCls].Loaded:= False;
      FMatFig[IndCnj, IndCls].BitMap.Free;
    end;
  end;
end;

procedure TEditMatStm.Insert(IndCnj, IndCls: Integer; ShortName: String);
begin
  If FileExists(FMatStm.ResPath+'\'+ShortName) then begin
    FMatStm.SetFileName(IndCnj, IndCls, ShortName);

    Load(IndCnj, IndCls);
  end;
end;

procedure TFmEstimulos.FormCreate(Sender: TObject);
//var F: TSearchRec; s1: String; ListItem: TListItem;
begin
{
  DrawGrid1.ColWidths[0]:= 40;
  DrawGrid1.RowHeights[0]:= 40;


  FChave:= TChave.Create(Self);
  With FChave do begin
    Parent:= Panel2;
    SetBounds(10, 10, 180, 120);
    OnClick:= ChaveClick;
  end;
}

//  FEditMatStm:= TEditMatStm.Create(Self, CfgSes.MatStm);

  FDragBitMap:= TBitmap.Create;
  FDragBitMap.Width:= 72;
  FDragBitMap.Height:= 54;

{
  With ListView1 do begin
    Clear;
    s1:= CurPath+'\Files Stm\*.*';
    If FindFirst(s1, $20, F) = 0 then begin
      ListItem:= Items.Add;
      ListItem.Caption:= F.Name;
      s1:= UpperCase(ExtractFileExt(F.Name));
      If s1 = '.WAV' then ListItem.SubItems.Add('Som')
      else If s1 = '.BMP' then ListItem.SubItems.Add('Imagem Bitmap')
           else If s1 = '.JPG' then ListItem.SubItems.Add('Imagem JPeg')
                else ListItem.SubItems.Add('');
    end;
    While FindNext(F) = 0 do begin
      ListItem:= Items.Add;
      ListItem.Caption:= F.Name;
      s1:= UpperCase(ExtractFileExt(F.Name));
      If s1 = '.WAV' then ListItem.SubItems.Add('Som')
      else If s1 = '.BMP' then ListItem.SubItems.Add('Imagem Bitmap')
           else If s1 = '.JPG' then ListItem.SubItems.Add('Imagem JPeg')
                else ListItem.SubItems.Add('');
    end;
    FindClose(F);
    FSpinSort:= True;
    AlphaSort;
  end;
}
end;

{
procedure TFmEstimulos.ChaveClick(Sender: TObject);
begin
  FChave.Play;
end;
}

{
procedure TFmEstimulos.EditMatStmEndLoad(IndCnj, IndCls: Integer);
begin

  DrawGrid1.Refresh;
end;
}

procedure TFmEstimulos.DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
//var Size: TSize; s1: String;
begin
{
  With DrawGrid1.Canvas do begin
    If (ARow = 0) or (ACol = 0) then begin
      Brush.Color:= clBtnFace;
      FillRect(Rect);
      Pen.Color:= clWhite;
      PenPos:= Point(Rect.Left, Rect.Bottom-2);
      LineTo(Rect.Left, Rect.Top);
      LineTo(Rect.Right-1, Rect.Top);
      Pen.Color:= clBtnShadow;
      LineTo(Rect.Right-1, Rect.Bottom-1);
      LineTo(Rect.Left, Rect.Bottom-1);
      Font.Size:= 18;
      Font.Color:= clBlack;
      Font.Style:= [];
      If ARow = 0 then begin
        s1:= Chr(ACol+64);
        If ACol = 0 then s1:= '';
      end else s1:= IntToStr(aRow);
      Size:= TextExtent(s1);
      Size.cx:= ((Rect.Right-Rect.Left-Size.cx) div 2) + Rect.Left;
      Size.cy:= ((Rect.Bottom-Rect.Top-Size.cy) div 2) + Rect.Top;
      TextOut(Size.cx, Size.cy, s1);
    end else begin
      If FEditMatStm.MatFig[ACol-1, ARow-1].Loaded then
        Draw(Rect.Left, Rect.Top, FEditMatStm.MatFig[ACol-1, ARow-1].BitMap)
      else begin
        Brush.Color:= clBlack;
        FillRect(Rect);
      end;
    end;
  end;
}
end;

procedure TFmEstimulos.DrawGrid1DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
//var ACol, ARow: Integer;
begin
{
  If Source is TDragFig then
    TDragFig(Source).MoveFig(Mouse.CursorPos.X, Mouse.CursorPos.Y);

  DrawGrid1.MouseToCell(X, Y, ACol, ARow);
  Accept:= (Source is TDragFig) and (ACol > 0) and (ACol < 11) and (ARow > 0) and (ARow < 11);
}
end;

procedure TFmEstimulos.ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  If Selected then
//    FChave.FileName:= CfgSes.MatStm.ResPath+Item.Caption;
end;

procedure TFmEstimulos.DrawGrid1DragDrop(Sender, Source: TObject; X, Y: Integer);
//var ACol, ARow: Integer;
begin
{
  DrawGrid1.MouseToCell(X, Y, ACol, ARow);
  FEditMatStm.Insert(ACol-1, ARow-1, TDragFig(Source).ShortName);
  DrawGrid1.Refresh;
}
end;

procedure TFmEstimulos.DrawGrid1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
{
  FCurPos.X:= X;
  FCurPos.Y:= Y;
}  
end;

procedure TFmEstimulos.ListView1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
{
  TDragFig(Source).MoveFig(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  Accept:= False
  }
end;

procedure TFmEstimulos.DrawGrid1StartDrag(Sender: TObject; var DragObject: TDragObject);
//var ACol, ARow: Integer; AControl: TWinControl; BitMap: TBitmap;
begin
{
  AControl:= TWinControl(Sender);
  While (not (AControl is TForm)) or (AControl = nil) do
    AControl:= AControl.Parent;

  If Sender is TListView then begin
    BitMap:= TBitmap.Create;
    BitMap.Width:= DrawGrid1.DefaultColWidth;
    BitMap.Height:= DrawGrid1.DefaultRowHeight;
    BitMap.Canvas.StretchDraw(Rect(0, 0, DrawGrid1.DefaultColWidth, DrawGrid1.DefaultRowHeight), FChave.BitMap);
    DragObject:= TDragFig.Create(AControl, Mouse.CursorPos, BitMap, ListView1.Selected.Caption);
    BitMap.Free;
  end else begin
    DrawGrid1.MouseToCell(FCurPos.X, FCurPos.Y, ACol, ARow);
    If (ACol > 0) and (ARow > 0) then
      If Assigned(FEditMatStm.MatFig[ACol-1, ARow-1].BitMap) then
        DragObject:= TDragFig.Create(AControl, Mouse.CursorPos, FEditMatStm.MatFig[ACol-1, ARow-1].BitMap,
                                                                FEditMatStm.FileName[ACol-1, ARow-1]);
    FEditMatStm.Delete(ACol-1, ARow-1);
  end;
  DrawGrid1.Refresh;
}
end;

procedure TFmEstimulos.DrawGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var ACol, ARow: Integer;
begin
  DrawGrid1.MouseToCell(X, Y, ACol, ARow);
  FChave.FileName:=  FEditMatStm.FullFileName[ACol-1, ARow-1];

  If ssRight in Shift then FChave.Play;
end;

procedure TFmEstimulos.ListView1Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
{
  If FColSort = 0 then begin
    If FSpinSort then Compare:= CompareText(Item1.Caption, Item2.Caption)
    else Compare:= CompareText(Item2.Caption, Item1.Caption)
  end else begin
    If FSpinSort then Compare:= CompareText(Item1.SubItems[FColSort-1], Item2.SubItems[FColSort-1])
    else Compare:= CompareText(Item2.SubItems[FColSort-1], Item1.SubItems[FColSort-1]);
  end;
}  
end;

procedure TFmEstimulos.ListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
begin
{
  If FColSort = Column.Index then
    FSpinSort:= not FSpinSort
  else begin
    FColSort:= Column.Index;
    FSpinSort:= True;
  end;
  ListView1.AlphaSort;
}  
end;

procedure TFmEstimulos.ListView1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = 13 then FChave.Play;
end;

procedure TFmEstimulos.PaintBox1Paint(Sender: TObject);
begin
{
  With PaintBox1.Canvas do begin
    Font.Name:= 'Arial';
    Font.Size:= 20;
    Font.Style:= [];
    TextOut(350, 5, 'Conjuntos');
  end;
}  
end;

procedure TFmEstimulos.PaintBox2Paint(Sender: TObject);
//var a1, a2: Integer;
begin
{
  With PaintBox2.Canvas do begin
    Font.Name:= 'Arial';
    Font.Size:= 20;
    Font.Style:= [];
    a1:= 160;
    a2:= 3;
    TextOut(a2+2, a1, 'C');
    Inc(a1, 27);
    TextOut(a2+8, a1, 'l');
    Inc(a1, 26);
    TextOut(a2+3, a1, 'a');
    Inc(a1, 26);
    TextOut(a2+3, a1, 's');
    Inc(a1, 26);
    TextOut(a2+3, a1, 's');
    Inc(a1, 26);
    TextOut(a2+3, a1, 'e');
    Inc(a1, 26);
    TextOut(a2+3, a1, 's');
  end;
}  
end;

end.

