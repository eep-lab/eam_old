unit fEstimulos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, Grids, StdCtrls, CheckLst, Buttons, IniFiles,
  uChave;

type
  TFormEstimulos = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    Panel2: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Panel3: TPanel;
    ListView1: TListView;
    Panel5: TPanel;
    DrawGrid1: TDrawGrid;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    Splitter1: TSplitter;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure Panel5Resize(Sender: TObject);
    procedure DrawGrid1TopLeftChanged(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
  private
    { Private declarations }
    FChave: TChave;
    BMapTitH: TBitMap;
    BMapTitV: TBitMap;
    MatChv: Array of Array of TChave;
    TitHLeft: Integer;
    TitVTop: Integer;
    procedure CalculaTitPos;
    function  IntToCls(Value: Integer): String;
    function  MakeBackUpFile(FileName, DestPath: String): String;
    procedure SetBitMap(Orientation: Integer; BitMap: TBitMap; Text: String);
  public
    { Public declarations }
  end;

var
  FormEstimulos: TFormEstimulos;

implementation

{$R *.DFM}

procedure TFormEstimulos.FormCreate(Sender: TObject);
begin
  FChave:= TChave.Create(Self);
  With FChave do begin
    SetBounds(0, 0, Panel3.Width, Panel3.Height);
    Parent:= Panel3;
  end;
  BMapTitH:= TBitMap.Create;
  BMapTitV:= TBitMap.Create;
  DrawGrid1.ColWidths[0]:= 40;
  DrawGrid1.RowHeights[0]:= 40;
  SetBitMap(0, BMapTitH, 'Conjuntos');
  SetBitMap(90, BMapTitV, 'Classes');  
end;

procedure TFormEstimulos.CalculaTitPos;
begin
  TitHLeft:= ((Drawgrid1.Width-Drawgrid1.ColWidths[0]-BMapTitH.Width) div 2)+
                                         {PaintBox2.Width+}Drawgrid1.ColWidths[0];
  TitVTop:= ((Drawgrid1.Height-Drawgrid1.RowHeights[0]-BMapTitV.Height) div 2)+
                                                        Drawgrid1.RowHeights[0];
end;

function TFormEstimulos.IntToCls(Value: Integer): String;
var s1: String;
begin
  Dec(Value);
  If Value div 26 > 0 then
    s1:= IntToCls(Value div 26);
  Result:= s1+Chr((Value mod 26)+65);
end;

procedure TFormEstimulos.SetBitMap(Orientation: Integer; BitMap: TBitMap; Text: String);
var Size: TSize; a1, a2: Integer; BMap: TBitMap;
begin
  BMap:= TBitmap.Create;
  With Bmap do begin
    Canvas.Font.Size:= 18;
    Canvas.Font.Name:= 'Arial';
    Size:= Canvas.TextExtent(Text);
    Width:= Size.cx;
    Height:= Size.cy;
    Canvas.TextOut(0, 0, Text);
  end;
  Case Orientation of
    0 : BitMap.Assign(Bmap);
    90: begin
          BitMap.Width:= BMap.Height;
          BitMap.Height:= BMap.Width;
          For a1:= 0 to BMap.Width-1 do
            For a2:= 0 to BMap.Height-1 do
              With BitMap do begin
                  Canvas.Pixels[a2, Height-a1]:= BMap.Canvas.Pixels[a1, a2];
              end;
      end;
  end;
  BitMap.Transparent:= True;
  CalculaTitPos;
  PaintBox1.Repaint;
  PaintBox2.Repaint;
end;

procedure TFormEstimulos.DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var Size: TSize; s1: String;
begin
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
      If (ARow <> 0) or (ACol <> 0) then begin
        If (ARow = 0) then s1:= IntToStr(ACol)
        else s1:= IntToCls(ARow);
        Size:= TextExtent(s1);
        Size.cx:= ((Rect.Right-Rect.Left-Size.cx) div 2) + Rect.Left;
        Size.cy:= ((Rect.Bottom-Rect.Top-Size.cy) div 2) + Rect.Top;
        TextOut(Size.cx, Size.cy, s1);
      end;
    end else begin
      If Length(MatChv) > ACol-1 then
        If Length(MatChv[ACol-1]) > ARow-1 then
          StretchDraw(Rect, MatChv[ACol-1, ARow-1].BitMap);
    end;
  end;
end;

procedure TFormEstimulos.PaintBox1Paint(Sender: TObject);
begin
  With PaintBox1 do begin
    Canvas.Draw(TitHLeft, 0, BMapTitH);
  end;
end;

procedure TFormEstimulos.PaintBox2Paint(Sender: TObject);
begin
  With PaintBox2 do begin
    Canvas.Draw(0, TitVTop, BMapTitV);
  end;
end;

procedure TFormEstimulos.Panel5Resize(Sender: TObject);
begin
  CalculaTitPos;
end;

procedure TFormEstimulos.DrawGrid1TopLeftChanged(Sender: TObject);
begin
  With DrawGrid1 do begin
    If LeftCol > ColCount-10 then ColCount:= ColCount+1;
    If TopRow > RowCount-10 then RowCount:= RowCount+1;    
  end;
end;

procedure TFormEstimulos.SpeedButton5Click(Sender: TObject);
begin
  If OpenDialog1.Execute then
    FChave.FileName:= OpenDialog1.FileName;
end;

function TFormEstimulos.MakeBackUpFile(FileName, DestPath: String): String;
var f1, f2: File;
//    s1, s2, s3: String;
    a1, a2: Integer;
    Buf: array[1..2048] of Char;
begin
  If FileExists(FileName) then begin
    AssignFile(f1, FileName);
    AssignFile(f2, Result);
    System.Reset(f1, 1);
    Rewrite(f2, 1);
    Repeat
      BlockRead(f1, Buf, SizeOf(Buf), a1);
      BlockWrite(f2, Buf, a1, a2);
    Until (a1 = 0) or (a2 <> a1);
    CloseFile(f1);
    CloseFile(f2);
  end else Result:= FileName;
end;

end.
