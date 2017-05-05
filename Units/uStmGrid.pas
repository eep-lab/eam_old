unit uStmGrid;

interface

uses Classes, Grids, Types, Graphics, SysUtils, Controls, Forms, ExtCtrls;

Type
  TFig = record
    BitMap: TBitmap;
    Loaded: Boolean;
    StmName: String;
  end;

  TDragFig = class(TDragObjectEx)
  private
    FImage: TImage;
    FPanel: TPanel;
    FBitMap: TBitMap;
    FStmName: String;
    FIndCnj: Integer;
    FIndCls: Integer;
  public
    constructor Create(AParent: TWinControl; P: TPoint; Bitmap: TBitmap; StmName: String;
                                                                                   IndCnj, IndCls: Integer); reintroduce;
    destructor Destroy; override;
    procedure MoveFig(X, Y: Integer);
    property BitMap: TBitMap read FBitMap;
    property StmName: String read FStmName;
    property IndCnj: Integer read FIndCnj;
    property IndCls: Integer read FIndCls;

  end;

  TDragFigDropEvent = procedure (StmName: String; IndCnj, IndCls: Integer) of Object;
  TStartDragFigEvent = procedure (StmName: String; IndCnj, IndCls: Integer; var Remove: Boolean) of Object;

  TStmGrid = class(TCustomDrawGrid)
  private
    FAcceptDragFig: Boolean;
    FCurPos: TPoint;
    FOnDragFigDrop: TDragFigDropEvent;
    FOnStartDragFig: TStartDragFigEvent;
    FVetBitMap: Array [0..19] of Array [0..19] of TFig;
    procedure StartDrag(Sender: TObject; var DragObject: TDragObject);
    function GetFig(IndCnj, IndCls: Integer): TFig;
  protected
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DeleteBitmap(IndCnj, IndCls: Integer);
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure InsertBitmap(Bitmap: TBitMap; IndCnj, IndCls: Integer; StmName: String);
    property AcceptDragFig: Boolean read FAcceptDragFig write FAcceptDragFig;
    property Fig[IndCnj, IndCls: Integer]: TFig read GetFig;
    property OnDragFigDrop: TDragFigDropEvent read FOnDragFigDrop write FOnDragFigDrop;
    property OnStartDragFig: TStartDragFigEvent read FOnStartDragFig write FOnStartDragFig;
    property ColWidths;
    property RowHeights;
  end;

implementation

constructor TStmGrid.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
//  BorderStyle:= bsNone;
  DragMode:= dmAutomatic;
  DefaultDrawing:= False;
  Color:= clBlack;
  DefaultRowHeight:= 54;
  DefaultColWidth:= 72;
  FixedCols:= 2;
  FixedRows:= 2;
  ColCount:= 22;
  RowCount:= 22;
  ColWidths[0]:= 30;
  RowHeights[0]:= 30;
  ColWidths[1]:= 40;
  RowHeights[1]:= 40;
  FAcceptDragFig:= True;
  Options:= Options + [goThumbTracking];	
  OnStartDrag:= StartDrag;
end;

destructor TStmGrid.Destroy;
var a1, a2: Integer;
begin
  For a1:= 0 to 19 do
    For a2:= 0 to 19 do
      If FVetBitMap[a1, a2].Loaded then
        FVetBitMap[a1, a2].BitMap.Free;
  Inherited Destroy;
end;

procedure TStmGrid.DeleteBitmap(IndCnj, IndCls: Integer);
begin
  If FVetBitMap[IndCnj, IndCls].Loaded then
    FVetBitMap[IndCnj, IndCls].BitMap.Free;
  FVetBitMap[IndCnj, IndCls].Loaded:= False;
end;

procedure TStmGrid.DragDrop(Source: TObject; X, Y: Integer);
var ACol, ARow: Integer;
begin
  If Source is TDragFig then begin
    MouseToCell(X, Y, ACol, ARow);
    InsertBitmap(TDragFig(Source).BitMap, ACol-2, ARow-2, TDragFig(Source).StmName);
    Refresh;
    If Assigned(OnDragFigDrop) then FOnDragFigDrop(TDragFig(Source).StmName, ACol-2, ARow-2);
  end;
end;

procedure TStmGrid.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var ACol, ARow: Integer;
begin
  If Source is TDragFig then
    TDragFig(Source).MoveFig(Mouse.CursorPos.X, Mouse.CursorPos.Y);

  MouseToCell(X, Y, ACol, ARow);
  Accept:= FAcceptDragFig and (Source is TDragFig) and (ACol > 1) and (ARow > 1);
end;

procedure TStmGrid.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  FCurPos.X:= X;
  FCurPos.Y:= Y;
end;

procedure TStmGrid.InsertBitmap(Bitmap: TBitMap; IndCnj, IndCls: Integer; StmName: String);
begin
  If not FVetBitMap[IndCnj, IndCls].Loaded then begin
    FVetBitMap[IndCnj, IndCls].BitMap:= TBitmap.Create;
    FVetBitMap[IndCnj, IndCls].BitMap.Width:= DefaultColWidth;
    FVetBitMap[IndCnj, IndCls].BitMap.Height:= DefaultRowHeight;
    FVetBitMap[IndCnj, IndCls].Loaded:= True;
  end;
  FVetBitMap[IndCnj, IndCls].BitMap.Canvas.Lock;
  FVetBitMap[IndCnj, IndCls].BitMap.Canvas.StretchDraw(Rect(0, 0, DefaultColWidth, DefaultRowHeight), Bitmap);
  FVetBitMap[IndCnj, IndCls].BitMap.Canvas.Unlock;
  FVetBitMap[IndCnj, IndCls].StmName:= StmName;
end;

constructor TDragFig.Create(AParent: TWinControl; P: TPoint; Bitmap: TBitmap; StmName: String; IndCnj, IndCls: Integer);
begin
  Inherited Create;

  FBitMap:= TBitmap.Create;
  FBitMap.Assign(Bitmap);
  FIndCnj:= IndCnj;
  FIndCls:= IndCls;
  FStmName:= StmName;

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
  FBitMap.Free;
  Inherited Destroy;
end;

procedure TDragFig.MoveFig(X, Y: Integer);
begin
  FPanel.SetBounds(X, Y, FImage.Width, FImage.Height);
end;

procedure TStmGrid.StartDrag(Sender: TObject; var DragObject: TDragObject);
var ACol, ARow: Integer; AControl: TWinControl; b1: Boolean;
begin
  AControl:= TWinControl(Sender);
  While (not (AControl is TForm)) or (AControl = nil) do
    AControl:= AControl.Parent;

  MouseToCell(FCurPos.X, FCurPos.Y, ACol, ARow);
  If (ACol > 1) and (ARow > 1) then
    If FVetBitmap[ACol-2, ARow-2].Loaded then begin
      DragObject:= TDragFig.Create(AControl, Mouse.CursorPos, FVetBitmap[ACol-2, ARow-2].BitMap,
                                                                     FVetBitmap[ACol-2, ARow-2].StmName, ACol-2, ARow-2);
      If Assigned(OnStartDragFig) then FOnStartDragFig('', ACol-2, ARow-2, b1);
      If b1 then begin
        DeleteBitmap(ACol-2, ARow-2);
        Refresh;
      end;
    end;
end;

function TStmGrid.GetFig(IndCnj, IndCls: Integer): TFig;
begin
  Result:= FVetBitmap[IndCnj, IndCls];
end;

procedure TStmGrid.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var Size: TSize; s1: String; a1, a2: Integer;
begin
  With Canvas do begin
    If (ARow = 0) or (ACol = 0) then begin
      Brush.Color:= clBtnFace;
      If ARow = 0 then begin
        FillRect(Rect(ARect.Left, ARect.Top, ARect.Right+1, ARect.Bottom));
        Font.Name:= 'Arial';
        Font.Size:= 18;
        Font.Style:= [];
        TextOut(340, 1, 'Conjuntos');
      end;
      If ACol = 0 then begin
        FillRect(Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom+1));
        Font.Name:= 'Arial';
        Font.Size:= 18;
        Font.Style:= [];
        a1:= 200;
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
        If ARow = 0 then begin
          Pen.Color:= clBlack;
          PenPos:= Point(0, 0);
          LineTo(ARect.Right, ARect.Bottom);
        end;
      end;
    end else begin
      If (ARow = 1) or (ACol = 1) then begin
        Brush.Color:= clBtnFace;
        FillRect(ARect);
        Pen.Color:= clWhite;
        PenPos:= Point(ARect.Left, ARect.Bottom-2);
        LineTo(ARect.Left, ARect.Top);
        LineTo(ARect.Right-1, ARect.Top);
        Pen.Color:= clBtnShadow;
        LineTo(ARect.Right-1, ARect.Bottom-1);
        LineTo(ARect.Left, ARect.Bottom-1);
        Font.Size:= 18;
        Font.Color:= clBlack;
        Font.Style:= [];
        If ARow = 1 then begin
          s1:= Chr(ACol+63);
          If ACol = 1 then s1:= '';
        end else s1:= IntToStr(ARow-1);
        Size:= TextExtent(s1);
        Size.cx:= ((ARect.Right-ARect.Left-Size.cx) div 2) + ARect.Left;
        Size.cy:= ((ARect.Bottom-ARect.Top-Size.cy) div 2) + ARect.Top;
        TextOut(Size.cx, Size.cy, s1);
      end else begin
        If FVetBitMap[ACol-2, ARow-2].Loaded then
          Draw(ARect.Left, ARect.Top, FVetBitMap[ACol-2, ARow-2].BitMap)
        else begin
          Brush.Color:= clBlack;
          FillRect(ARect);
        end;
      end;
    end;
  end;
end;

end.
 