unit uObjIns;

interface

uses Forms, Windows, Classes, Grids, Types, Controls, ExtCtrls, Graphics, StdCtrls, Dialogs,
     Messages, SysUtils, Buttons;

type
  TValType = (vtOther, vtInteger, vtString, vtColor, vtCollection);
  TLockState = (lsNone, lsLocked, lsClosed, lsUnLocked, lsOpened);
  TLockStates = set of TLockState;

  TValueChangeEvent = procedure (IndItem, IndProp: Integer; Value: String) of Object;
  TLockStateChangeEvent = procedure(IndItem, IndProp: Integer; Locked: TLockState) of Object;

  TProp = record
    Cap: String;
    Val: String;
    ValType: TValType;
    VetDefVal: Array of String;
    LockState: TLockState;
    LockStates: TLockStates;
  end;

  PProp = ^TProp;

  TItem = record
    Cap: String;
    NumValue: Integer;
    VetProp: Array of TProp;
  end;

  TSplit = class(TGraphicControl)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
  end;

  TEditHdl = class(TEdit)
  public
    procedure DefaultHandler(var Message); override;
  end;

  TEditor = class(TWinControl)
  private
    FColorDialog: TColorDialog;
    FComboBox: TComboBox;
    FEditHdl: TEditHdl;
    FSpeedButton: TSpeedButton;
    FPProp: PProp;
    FOnValueChange: TValueChangeEvent;
    procedure SetProp(Prop: PProp);
    procedure ExecuteColorDialog(Sender: TObject);
    procedure ValueChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property Prop: PProp write SetProp;
    property OnValueChange: TValueChangeEvent read FOnValueChange write FOnValueChange;
  end;

  TGridObjIns = class(TCustomDrawGrid)
  private
    FBitmapLocked: TBitMap;
    FBitmapClosed: TBitMap;
    FBitmapOpened: TBitMap;
    FBitmapUnLocked: TBitMap;
    FEditor: TEditor;
    FOnValueChange: TValueChangeEvent;
    FOnLockStateChange: TLockStateChangeEvent;
    FSplit: TSplit;
    procedure EditorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SplitMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure EditorValueChange(IndItem, IndProp: Integer; Value: String);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure Resize; override;

    property OnValueChange: TValueChangeEvent read FOnValueChange write FOnValueChange;
    property OnLockStateChange: TLockStateChangeEvent read FOnLockStateChange write FOnLockStateChange;
  end;

  TObjIns = class(TCustomControl)
  private
    FAllowEditLocked: Boolean;
    FComboBox: TComboBox;
    FGridObjIns: TGridObjIns;
    FOnValueChange: TValueChangeEvent;
    FOnLockStateChange: TLockStateChangeEvent;
    FPanel: TPanel;
    FNumItem: Integer;
    FVetItem: Array of TItem;
    FItemIndex: Integer;
    FLockStates: TLockStates;
    procedure ComboBoxChange(Sender: TObject);
    procedure PanelResize(Sender: TObject);
    procedure GridObjInsValueChange(IndItem, IndProp: Integer; Value: String);
    procedure GridObjInsLockStateChange(IndItem, IndProp: Integer; Locked: TLockState);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure PaintWindow(DC: HDC); override;

    procedure AddItem(ItemCaption: String);
    procedure AddProp(IndItem: Integer; Prop: TProp);
    procedure SetValue(IndItem, IndValue: Integer; Value: String);
    procedure Clear;

    property OnValueChange: TValueChangeEvent read FOnValueChange write FOnValueChange;
    property OnLockStateChange: TLockStateChangeEvent read FOnLockStateChange write FOnLockStateChange;

    property LockStates: TLockStates read FLockStates write FLockStates;
    property AllowEditLocked: Boolean read FAllowEditLocked write FAllowEditLocked;
  end;

implementation

constructor TSplit.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
end;

destructor TSplit.Destroy;
begin
  Inherited Destroy;
end;

procedure TSplit.Paint;
begin
//  Canvas.Brush.Color:= Color;
//  Canvas.FillRect(Rect(0, 0, Width, Height));
end;

procedure TEditHdl.DefaultHandler(var Message);
begin
  If not (TMessage(Message).WParam = 13) then
    Inherited DefaultHandler(Message);
end;

procedure TGridObjIns.SplitMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var R: TRect;
begin
  If ssLeft in Shift then begin
    FSplit.Left:= FSplit.Left+X;
    ColWidths[0]:= FSplit.Left+3;
    ColWidths[1]:= Width-ColWidths[0]-6;
    R:= CellRect(1, Row);
    FEditor.SetBounds(R.Left, R.Top+2, ColWidths[1], FEditor.Height);
  end;
end;

procedure TGridObjIns.EditorValueChange(IndItem, IndProp: Integer; Value: String);
begin
  If Assigned(OnValueChange) then FOnValueChange(-1, Row, Value);  
end;

procedure TEditor.SetProp(Prop: PProp);
begin
  FPProp:= Prop;
  FEditHdl.Visible:= False;
  FComboBox.Visible:= False;
  FSpeedButton.Visible:= False;
  Case FPProp.ValType of
    vtInteger, vtString: begin
                           FEditHdl.Visible:= True;
                           FEditHdl.Text:= FPProp.Val;
                         end;
    vtColor: begin
               FSpeedButton.Visible:= True;
               FSpeedButton.OnClick:= ExecuteColorDialog;
               FComboBox.Visible:= True;
             end;
    vtCollection: begin
                    
                  end;
    vtOther: begin
             end;
  end;
end;

procedure TEditor.ExecuteColorDialog(Sender: TObject);
begin
  If FColorDialog.Execute then begin
    FPProp.Val:= IntToStr(FColorDialog.Color);
    Visible:= False;
    If Assigned(OnValueChange) then FOnValueChange(0, 0, FPProp.Val);
  end;
end;

procedure TEditor.ValueChange(Sender: TObject);
begin
  If Assigned(OnValueChange) then FOnValueChange(0, 0, FEditHdl.Text);
end;

constructor TEditor.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FEditHdl:= TEditHdl.Create(Self);
  With FEditHdl do begin
    Align:= alClient;
    Parent:= Self;
    Visible:= False;
    OnExit:= ValueChange;
//    OnKey13:= ValueChange;
  end;

  FComboBox:= TComboBox.Create(Self);
  With FComboBox do begin
    Align:= alClient;
    Parent:= Self;
    Visible:= False;
  end;

  FSpeedButton:= TSpeedButton.Create(Self);
  With FSpeedButton do begin
    Align:= alRight;
    Parent:= Self;
    Visible:= False;
  end;

  FColorDialog:= TColorDialog.Create(Self);
  With FColorDialog do begin

  end;
end;

procedure TGridObjIns.EditorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = 13 then begin
  end;
end;

procedure TGridObjIns.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var ACol, ARow: Integer; R: TRect; PValue: ^TProp; ls1, ls2: TLockState;
begin
  If ssLeft in Shift then begin
    MouseToCell(X, Y, ACol, ARow);
    R:= CellRect(ACol, ARow);
    If (ACol = 0) and (R.Left+3 < X) and (X < R.Left+13) and (R.Top+3 < Y) and (Y < R.Top+13) then begin
      If TObjIns(Owner).FNumItem > 0 then begin
        If TObjIns(Owner).FVetItem[TObjIns(Owner).FItemIndex].NumValue > 0 then begin
          PValue:= @TObjIns(Owner).FVetItem[TObjIns(Owner).FItemIndex].VetProp[ARow];
          If (PValue.LockStates <> []) and (PValue.LockStates <> [lsNone]) then begin
            ls1:= PValue.LockState;
            ls2:= lsNone;
            Case PValue.LockState of
              lsLocked: If lsLocked in PValue.LockStates then
                          If lsClosed in PValue.LockStates then ls2:= lsClosed
                          else If lsUnLocked in PValue.LockStates then ls2:= lsUnLocked
                               else If lsOpened in PValue.LockStates then ls2:= lsOpened
                                    else ls2:= lsLocked;
              lsClosed: If lsClosed in PValue.LockStates then
                          If lsUnLocked in PValue.LockStates then ls2:= lsUnLocked
                          else If lsOpened in PValue.LockStates then ls2:= lsOpened
                               else If lsLocked in PValue.LockStates then ls2:= lsLocked
                                    else ls2:= lsClosed;
              lsUnLocked: If lsUnLocked in PValue.LockStates then
                            If lsOpened in PValue.LockStates then ls2:= lsOpened
                            else If lsLocked in PValue.LockStates then ls2:= lsLocked
                                 else If lsClosed in PValue.LockStates then ls2:= lsClosed
                                      else ls2:= lsUnLocked;
              lsOpened: If lsOpened in PValue.LockStates then
                          If lsLocked in PValue.LockStates then ls2:= lsLocked
                          else If lsClosed in PValue.LockStates then ls2:= lsClosed
                               else If lsUnLocked in PValue.LockStates then ls2:= lsUnLocked
                                    else ls2:= lsOpened;
            end;
            PValue.LockState:= ls2;
            If ls1 <> ls2 then
              If Assigned(OnLockStateChange) then FOnLockStateChange(0, ARow, PValue.LockState);
          end;
        end;
      end;
    end else
      Inherited MouseDown(Button, Shift, X, Y);
  end;
  Refresh;
end;

function TGridObjIns.SelectCell(ACol, ARow: Longint): Boolean;
var R: TRect;
begin
  If not ((lsLocked = TObjIns(Owner).FVetItem[TObjIns(Owner).FItemIndex].VetProp[ARow].LockState) or
          (lsClosed = TObjIns(Owner).FVetItem[TObjIns(Owner).FItemIndex].VetProp[ARow].LockState)) or
                                                                  TObjIns(Owner).FAllowEditLocked then begin
    R:= CellRect(1, ARow);
    FEditor.SetBounds(R.Left, R.Top, R.Right-R.Left, R.Bottom-R.Top);
    FEditor.Prop:= @(TObjIns(Owner).FVetItem[TObjIns(Owner).FItemIndex].VetProp[ARow]);
    FEditor.Visible:= True;
    Result:= Inherited SelectCell(ACol, ARow);
  end else Result:= False;
end;

constructor TGridObjIns.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  ScrollBars:= ssVertical;
  DefaultDrawing:= False;
  Color:= clBtnFace;
  SetBounds(0, 0, 100, 100);
  DefaultColWidth:= 150;
  DefaultRowHeight:= 16;
  ColCount:= 2;
  RowCount:= 0;
  FixedCols:= 0;
  FixedRows:= 0;

  FBitmapLocked:= TBitMap.Create;
  With FBitmapLocked do begin
    Width:= 10;
    Height:= 10;

    Canvas.Brush.Color:= clBtnFace;
    Canvas.FillRect(Rect(0, 0, 10, 10));

    Canvas.Pixels[1,2]:= clRed; Canvas.Pixels[1,3]:= clRed; Canvas.Pixels[1,4]:= clRed;

    Canvas.Pixels[2,1]:= clRed; Canvas.Pixels[2,2]:= clRed;
    Canvas.Pixels[2,3]:= clRed; Canvas.Pixels[2,4]:= clRed;

    Canvas.Pixels[3,1]:= clRed; Canvas.Pixels[4,1]:= clRed; Canvas.Pixels[5,1]:= clRed;

    Canvas.Pixels[6,1]:= clRed;
    Canvas.Pixels[6,2]:= clRed;
    Canvas.Pixels[6,3]:= clRed;
    Canvas.Pixels[6,4]:= clRed;

    Canvas.Pixels[7,2]:= clRed;
    Canvas.Pixels[7,3]:= clRed;
    Canvas.Pixels[7,4]:= clRed;

    Canvas.Brush.Color:= clRed;
    Canvas.FillRect(Rect(1, 5, 8, 9));

    TransparentColor:= clBtnFace;
    Transparent:= False;
  end;

  FBitmapClosed:= TBitMap.Create;
  With FBitmapClosed do begin
    Width:= 10;
    Height:= 10;

    Canvas.Draw(0, 0, FBitmapLocked);
    Canvas.Brush.Color:= clBlack;
    Canvas.FloodFill(1,2, clRed, fsSurface);

    TransparentColor:= clBtnFace;
    Transparent:= True;
  end;

  FBitmapOpened:= TBitMap.Create;
  With FBitmapOpened do begin
    Width:= 10;
    Height:= 10;

    Canvas.Draw(0, 0, FBitmapLocked);
    Canvas.Brush.Color:= clBlue;
    Canvas.FloodFill(1,2, clRed, fsSurface);

    Canvas.Pixels[6,3]:= clBtnFace;
    Canvas.Pixels[7,3]:= clBtnFace;
    Canvas.Pixels[6,4]:= clBtnFace;
    Canvas.Pixels[7,4]:= clBtnFace;

    TransparentColor:= clBtnFace;
    Transparent:= False;
  end;

  FBitmapUnLocked:= TBitMap.Create;
  With FBitmapUnLocked do begin
    Width:= 10;
    Height:= 10;

    Canvas.Draw(0, 0, FBitmapOpened);
    Canvas.Brush.Color:= clGreen;
    Canvas.FloodFill(1,2, clBlue, fsSurface);

    TransparentColor:= clBtnFace;
    Transparent:= True;
  end;

  FBitmapLocked.Transparent:= True;
  FBitmapOpened.Transparent:= True;

  FSplit:= TSplit.Create(Self);
  With FSplit do begin
    Cursor:= crHSplit;
    Parent:= Self;
    OnMouseMove:= SplitMouseMove;
//    FSplit.Color:= clRed;
  end;

  FEditor:= TEditor.Create(Self);
  With FEditor do begin
    ParentFont:= False;
    BorderStyle:= bsNone;
    Visible:= False;
    Parent:= Self;
    OnKeyDown:= EditorKeyDown;
    OnValueChange:= EditorValueChange;
  end;
end;

destructor TGridObjIns.Destroy;
begin
  Inherited Destroy;
end;

procedure TGridObjIns.Resize;
var R: TRect;
begin
  ColWidths[1]:= Width-ColWidths[0]-6;
  FSplit.SetBounds(ColWidths[0]-3, 0, 6, Height);
  R:= CellRect(1, Row);
  FEditor.SetBounds(R.Left, R.Top+2, ColWidths[1], FEditor.Height);
end;

procedure TGridObjIns.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var Prop: TProp;
begin
  With Canvas do begin
    Brush.Color:= clBtnFace;
    FillRect(ARect);

    If TObjIns(Owner).FNumItem > 0 then begin
      If TObjIns(Owner).FVetItem[TObjIns(Owner).FItemIndex].NumValue > 0 then begin
        Prop:= TObjIns(Owner).FVetItem[TObjIns(Owner).FItemIndex].VetProp[ARow];

        If ACol = 0 then begin
          Font.Color:= clBlack;
          TextRect(ARect, ARect.Left+20, ARect.Top+2, Prop.Cap);
          Case Prop.LockState of
            lsLocked: If lsLocked in Prop.LockStates then Draw(ARect.Left+5, ARect.Top+3, FBitmapLocked);
            lsClosed: If lsClosed in Prop.LockStates then Draw(ARect.Left+5, ARect.Top+3, FBitmapClosed);
            lsOpened: If lsOpened in Prop.LockStates then Draw(ARect.Left+5, ARect.Top+3, FBitmapOpened);
            lsUnLocked: If lsUnLocked in Prop.LockStates then Draw(ARect.Left+5, ARect.Top+3, FBitmapUnLocked);
          end;
        end else begin
          Case TObjIns(Owner).FVetItem[TObjIns(Owner).FItemIndex].VetProp[ARow].ValType of
            vtColor: begin
                       Brush.Color:= clBtnFace;
                       Font.Color:= clBlue;
                       TextRect(ARect, ARect.Left+30, ARect.Top+2, Prop.Val);
                       Brush.Color:= StrToInt(TObjIns(Owner).FVetItem[TObjIns(Owner).FItemIndex].VetProp[ARow].Val);
                       FillRect(Rect(ARect.Left+5, ARect.Top+2, ARect.Left+25, ARect.Bottom-2));
                     end;
            else begin
              Font.Color:= clBlue;
              TextRect(ARect, ARect.Left, ARect.Top+2, Prop.Val);
            end;
          end;
        end;
      end;
    end;

    If ARow = Row then begin
      Pen.Color:= clGray;
      PenPos:= ARect.TopLeft;
      LineTo(ARect.Right, ARect.Top);

      Pen.Color:= clMedGray;
      PenPos:= Point(ARect.Left+1, ARect.Top+1);
      LineTo(ARect.Right, ARect.Top+1);
    end;
  end;
end;

procedure TObjIns.PanelResize;
begin
  FComboBox.SetBounds(0, 0, FPanel.Width, FComboBox.Height);
  FComboBox.Invalidate;
end;

procedure TObjIns.GridObjInsLockStateChange(IndItem, IndProp: Integer; Locked: TLockState);
begin
  If Assigned(OnLockStateChange) then FOnLockStateChange(FComboBox.ItemIndex, IndProp, Locked);
end;

procedure TObjIns.GridObjInsValueChange(IndItem, IndProp: Integer; Value: String);
begin
  If Assigned(OnValueChange) then FOnValueChange(FItemIndex, IndProp, Value);
end;

constructor TObjIns.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  SetBounds(0, 0, 300, 500);
  ParentFont:= False;
  ParentColor:= False;
  FNumItem:= 0;
  FAllowEditLocked:= True;

  FLockStates:= [lsLocked, lsClosed, lsUnLocked, lsOpened];

  FPanel:= TPanel.Create(Self);
  With FPanel do begin
    Height:= 25;
    Parent:= Self;
    Align:= alTop;
  end;

  FComboBox:= TComboBox.Create(Self);
  With FComboBox do begin
    ParentFont:= False;
    Style:= csDropDownList;
    DropDownCount:= 30;
    Parent:= FPanel;
    SetBounds(0, 0, FPanel.Width, Height);
    ItemHeight:= 18;
    Sorted:= True;
    OnChange:= ComboBoxChange;
  end;

  FPanel.OnResize:= PanelResize;

  FGridObjIns:= TGridObjIns.Create(Self);
  With FGridObjIns do begin
    Parent:= Self;
    Align:= alClient;
    OnValueChange:= GridObjInsValueChange;
    OnLockStateChange:= GridObjInsLockStateChange;
  end;
end;

destructor TObjIns.Destroy;
begin
  Inherited Destroy;
end;

procedure TObjIns.Clear;
begin
  FGridObjIns.RowCount:= 0;
  FNumItem:= 0;
  SetLength(FVetItem, 0);
  FComboBox.Clear;
  FGridObjIns.Invalidate;
end;

procedure TObjIns.Paint;
begin

end;

procedure TObjIns.PaintWindow(DC: HDC);
begin

end;

procedure TObjIns.AddItem(ItemCaption: String);
begin
  Inc(FNumItem);
  SetLength(FVetItem, FNumItem);
  FVetItem[FNumItem-1].Cap:= ItemCaption;
  FComboBox.Items.Add(FVetItem[FNumItem-1].Cap);
end;

procedure TObjIns.AddProp(IndItem: Integer; Prop: TProp);
begin
  If (-1 < IndItem) and (IndItem < FNumItem) then begin
    Inc(FVetItem[IndItem].NumValue);
    SetLength(FVetItem[IndItem].VetProp, FVetItem[IndItem].NumValue);
    Prop.LockStates:= Prop.LockStates*FLockStates;
    FVetItem[IndItem].VetProp[FVetItem[IndItem].NumValue-1]:= Prop;
  end;
end;

procedure TObjIns.SetValue(IndItem, IndValue: Integer; Value: String);
begin
  If (-1 < IndItem) and (IndItem < FNumItem) then begin
    If (-1 < IndValue) and (IndValue < FVetItem[IndItem].NumValue) then begin
      FVetItem[IndItem].VetProp[IndValue].Val:= Value;
      If IndItem = FItemIndex then FGridObjIns.Invalidate;
    end;
  end;
end;

procedure TObjIns.ComboBoxChange(Sender: TObject);
var a1: Integer;
begin
  FItemIndex:= -1;
  For a1:= 0 to FNumItem-1 do
    If FVetItem[a1].Cap = FComboBox.Items[FComboBox.ItemIndex] then
      FItemIndex:= a1;
  If FItemIndex > -1 then
    FGridObjIns.RowCount:= FVetItem[FItemIndex].NumValue;
  FGridObjIns.Invalidate;
end;

end.

