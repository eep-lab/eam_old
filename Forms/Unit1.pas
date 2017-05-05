unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, CheckLst, Buttons, Grids,
  Spin, TeeProcs, TeEngine, Chart, ValEdit, Series, ActnList, StdActns,
  ActnMan, ToolWin, ActnCtrls, ActnMenus,
  uObjIns, uStmGrid, uSessMan, uChave, uAbsTent;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    Panel8: TPanel;
    Splitter1: TSplitter;
    Panel9: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    ListView1: TListView;
    Panel13: TPanel;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    SpeedButton10: TSpeedButton;
    SpeedButton8: TSpeedButton;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Panel5: TPanel;
    Label1: TLabel;
    ComboBox2: TComboBox;
    Panel4: TPanel;
    Panel6: TPanel;
    Splitter2: TSplitter;
    Panel7: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Edit1: TEdit;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Label3: TLabel;
    ComboBox3: TComboBox;
    Edit2: TEdit;
    Panel19: TPanel;
    Label4: TLabel;
    ComboBox4: TComboBox;
    Panel20: TPanel;
    Splitter3: TSplitter;
    Panel21: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    PageControl2: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    Panel24: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    SpinEdit1: TSpinEdit;
    Label6: TLabel;
    PageControl3: TPageControl;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    Panel25: TPanel;
    Panel27: TPanel;
    Panel29: TPanel;
    ListView2: TListView;
    Panel33: TPanel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    ComboBox5: TComboBox;
    Edit3: TEdit;
    Panel28: TPanel;
    Splitter4: TSplitter;
    Panel31: TPanel;
    Panel34: TPanel;
    Splitter5: TSplitter;
    PageControl4: TPageControl;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    Panel30: TPanel;
    ListView3: TListView;
    Panel32: TPanel;
    Panel26: TPanel;
    CheckListBox1: TCheckListBox;
    Splitter6: TSplitter;
    SpeedButton7: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Panel10: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListView1StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Panel14Resize(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Panel21Resize(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure TabSheet4Resize(Sender: TObject);
    procedure ListView2DrawItem(Sender: TCustomListView; Item: TListItem;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListView2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListView3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TabSheet4Show(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure ListView3SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListView3StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure ListView2DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure SpeedButton6Click(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure PageControl3DrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure Splitter5Moved(Sender: TObject);
    procedure Splitter6Moved(Sender: TObject);
    procedure Panel31Resize(Sender: TObject);
    procedure PageControl4DrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
  private
    { Private declarations }
    FChave: TChave;
    FObjIns1: TObjIns;
    FObjIns2: TObjIns;
    FStmGrid1: TStmGrid;
    FStmGrid2: TStmGrid;

    FSessMan: TSessMan;

    FColSort: Integer;
    FSpinSort: Boolean;

    procedure InitializeMatStm;
    procedure InitializeDefTent;
    procedure InitializeSeq;
    procedure InitializeBlc;

    procedure ChaveClick(Sender: TObject);
    procedure StmGrid1DragFigDrop(StmName: String; IndCnj, IndCls: Integer);
    procedure StmGrid2DragFigDrop(StmName: String; IndCnj, IndCls: Integer);
    procedure StmGrid1StartDragFig(StmName: String; IndCnj, IndCls: Integer; var Remove: Boolean);
    procedure StmGrid2StartDragFig(StmName: String; IndCnj, IndCls: Integer; var Remove: Boolean);

    procedure SessManDefTenValueChange(IndItem, IndProp: Integer; Value: String);
    procedure SeqManValueChange(IndItem, IndProp: Integer; Value: String);

    procedure LoadObjIns1;
    procedure ObjIns1ValueChange(IndItem, IndValue: Integer; Value: String);
    procedure ObjIns1LockValue(IndItem, IndValue: Integer; Locked: TLockState);
  public
    { Public declarations }
  end;

  TDragTent = class(TDragObject)
  private
    FIndSeq: Integer;
    FIndTent: Integer;
  public
    constructor Create(IndSeq, Indtent: Integer); reintroduce;
    property IndSeq: Integer read FIndSeq;
    property IndTent: Integer read FIndTent;
  end;

var
  Form1: TForm1;
  CurPath: String;

implementation

uses uSeqMan, uDefTentMan, uBlcMan, uCfgSes;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  CurPath:= GetCurrentDir;

  FSessMan:= TSessMan.Create(Self, CurPath);
  With FSessMan do begin
    OnDefTenValueChange:= SessManDefTenValueChange;
    SeqMan.Conteiner:= Panel22;
  end;

  InitializeMatStm;
  InitializeDefTent;
  InitializeSeq;
  InitializeBlc;
end;

procedure TForm1.InitializeMatStm;
var F: TSearchRec; s1: String; ListItem: TListItem; a1, a2: Integer; Chave: TChave;
begin
  FChave:= TChave.Create(Self);
  With FChave do begin
    Parent:= Panel13;
    SetBounds(30, 30, 180, 120);
    OnClick:= ChaveClick;
  end;

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

  FStmGrid1:= TStmGrid.Create(Self);
  With FStmGrid1 do begin
    Align:= alClient;
    Parent:= Panel11;
    OnDragFigDrop:= StmGrid1DragFigDrop;
    OnStartDragFig:= StmGrid1StartDragFig;

    For a1:= 0 to 19 do
      For a2:= 0 to 19 do
        If FSessMan.MatStmMan.StmLoaded[a1, a2] then begin
          Chave:= TChave.Create(Self);
          Chave.SetBounds(0, 0, 72, 54);
          Chave.FileName:= FSessMan.MatStmMan.FullFileName[a1, a2];
          InsertBitmap(Chave.BitMap, a1, a2, FSessMan.MatStmMan.FileName[a1, a2]);
        end;
  end;
end;

procedure TForm1.InitializeDefTent;
var a1: Integer;
begin
  FSessMan.DefTentMan.Conteiner:= Panel15;

  ComboBox1.Clear;
  For a1:= 0 to FSessMan.DefTentMan.NumDefTent-1 do
    ComboBox1.Items.Add(FSessMan.DefTentMan.DefTentName[a1]);

  FSessMan.TentMaker.GetTypes(ComboBox2.Items);

  FObjIns1:= TObjIns.Create(Self);
  With FObjIns1 do begin
    Align:= alClient;
    Parent:= Panel7;
    OnValueChange:= ObjIns1ValueChange;
    OnLockStateChange:= ObjIns1LockValue;
  end;
end;

procedure TForm1.InitializeSeq;
var a1, a2: Integer; 
begin
  PageControl2.OwnerDraw:= True;
  PageControl3.OwnerDraw:= True;

  FStmGrid2:= TStmGrid.Create(Self);
  With FStmGrid2 do begin
    AcceptDragFig:= False;
    ColWidths[0]:= 0;
    RowHeights[0]:= 0;
    Align:= alClient;
    Parent:= TabSheet5;
    OnDragFigDrop:= StmGrid2DragFigDrop;
    OnStartDragFig:= StmGrid2StartDragFig;

    For a1:= 0 to 9 do
      For a2:= 0 to 9 do
        If FStmGrid1.Fig[a1, a2].Loaded then
          InsertBitmap(FStmGrid1.Fig[a1, a2].BitMap, a1, a2, FStmGrid1.Fig[a1, a2].StmName);
  end;

  FObjIns2:= TObjIns.Create(Self);
  With FObjIns2 do begin
    Align:= alClient;
    Parent:= TabSheet6;
    OnValueChange:= ObjIns1ValueChange;
  end;

  FSessMan.SeqMan.GetSeqNames(ComboBox3.Items);

  ComboBox4.Clear;
  For a1:= 0 to FSessMan.DefTentMan.NumDefTent-1 do
    ComboBox4.Items.Add(FSessMan.DefTentMan.DefTentName[a1]);

  FSessMan.SeqMan.OnValueChange:= SeqManValueChange;
end;

procedure TForm1.InitializeBlc;
begin
  PageControl4.OwnerDraw:= True;
  Panel31.Height:= 200;
  Splitter5Moved(nil);
  FSessMan.BlcMan.GetSeqNames(CheckListBox1.Items);
  FSessMan.BlcMan.GetBlcNames(ComboBox5.Items);
  FSessMan.BlcMan.Conteiner:= Panel34;  
end;

procedure TForm1.ChaveClick(Sender: TObject);
begin
  FChave.Play;
end;

procedure TForm1.StmGrid1DragFigDrop(StmName: String; IndCnj, IndCls: Integer);
begin
  FSessMan.MatStmMan.FileName[IndCnj, IndCls]:= StmName;
end;

procedure TForm1.StmGrid2DragFigDrop(StmName: String; IndCnj, IndCls: Integer);
begin

end;

procedure TForm1.StmGrid1StartDragFig(StmName: String; IndCnj, IndCls: Integer; var Remove: Boolean);
begin
  Remove:= True;
  FSessMan.MatStmMan.FileName[IndCnj, IndCls]:= '';
end;

procedure TForm1.StmGrid2StartDragFig(StmName: String; IndCnj, IndCls: Integer; var Remove: Boolean);
begin
  Remove:= False;
end;

procedure TForm1.SessManDefTenValueChange(IndItem, IndProp: Integer; Value: String);
begin
  FObjIns1.SetValue(IndItem, IndProp, Value);
end;

procedure TForm1.SeqManValueChange(IndItem, IndProp: Integer; Value: String);
begin

end;

procedure TForm1.LoadObjIns1;
var a1, a2: Integer; Prop: TProp; Atrb: TAtrb;
begin
  FObjIns1.Clear;
  For a1:= 0 to FSessMan.DefTentMan.NumObj-1 do begin
    FObjIns1.AddItem(FSessMan.DefTentMan.Obj_Name[a1]);
    For a2:= 0 to FSessMan.DefTentMan.Obj_NumAtrb[a1]-1 do begin
      Atrb:= FSessMan.DefTentMan.Obj_Atrb[a1, a2];
      Prop.Cap:= Atrb.Cap;
      Prop.Val:= FSessMan.DefTentMan.Value[a1, a2];
      Prop.ValType:= Atrb.ValType;
      Prop.LockState:= Atrb.LockState;
      Prop.LockStates:= Atrb.LockStates;
      FObjIns1.AddProp(a1, Prop);
    end;
  end;
end;

procedure TForm1.ObjIns1ValueChange(IndItem, IndValue: Integer; Value: String);
begin
  FSessMan.DefTentMan.Value[IndItem, IndValue]:= Value;
end;

procedure TForm1.ObjIns1LockValue(IndItem, IndValue: Integer; Locked: TLockState);
begin
//  FSessMan.DefTentMan.SetLock(IndItem, IndValue, LockState);
end;

procedure TForm1.ListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  If FColSort = Column.Index then
    FSpinSort:= not FSpinSort
  else begin
    FColSort:= Column.Index;
    FSpinSort:= True;
  end;
  ListView1.AlphaSort;
end;

procedure TForm1.ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
begin
  If FColSort = 0 then begin
    If FSpinSort then Compare:= CompareText(Item1.Caption, Item2.Caption)
    else Compare:= CompareText(Item2.Caption, Item1.Caption)
  end else begin
    If FSpinSort then Compare:= CompareText(Item1.SubItems[FColSort-1], Item2.SubItems[FColSort-1])
    else Compare:= CompareText(Item2.SubItems[FColSort-1], Item1.SubItems[FColSort-1]);
  end;
end;

procedure TForm1.ListView1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  TDragFig(Source).MoveFig(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  Accept:= False;
end;

procedure TForm1.ListView1StartDrag(Sender: TObject;
  var DragObject: TDragObject);
var AControl: TWinControl; BitMap: TBitmap;
begin
  AControl:= TWinControl(Sender);
  While (not (AControl is TForm)) or (AControl = nil) do
    AControl:= AControl.Parent;

  If Sender is TListView then begin
    BitMap:= TBitmap.Create;
    BitMap.Width:= 72;
    BitMap.Height:= 54;
    BitMap.Canvas.StretchDraw(Rect(0, 0, 72, 54), FChave.BitMap);
    DragObject:= TDragFig.Create(AControl, Mouse.CursorPos, BitMap, ListView1.Selected.Caption, 0, 0);
    BitMap.Free;
  end;
end;

procedure TForm1.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  If Selected then
    FChave.FileName:= CurPath+'\Files Stm\'+Item.Caption;
end;

procedure TForm1.Panel14Resize(Sender: TObject);
var a1, a2: Integer; MainPanel, ChieldPanel: TPanel;
begin
  MainPanel:= Panel14;
  ChieldPanel:= Panel15;
  a1:= MainPanel.Width*9 div 10;
  a2:= MainPanel.Height*9 div 10;
  If a2 < 1 then a2:= 1;
  If a1/a2 <= 4/3 then begin
    ChieldPanel.Width:= a1;
    If ChieldPanel.Width > 0 then
      ChieldPanel.Height:= Round(3/4*ChieldPanel.Width);
  end else begin
    ChieldPanel.Height:= a2;
    If ChieldPanel.Height > 0 then
      ChieldPanel.Width:= Round(4/3*ChieldPanel.Height);
  end;
  ChieldPanel.Left:= (MainPanel.Width-ChieldPanel.Width) div 2;
  ChieldPanel.Top:= (MainPanel.Height-ChieldPanel.Height) div 2;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  FSessMan.DefTentMan.SelectDefTent(ComboBox1.Items[ComboBox1.ItemIndex]);
  LoadObjIns1;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  FSessMan.DefTentMan.ChangeType(ComboBox2.Items[ComboBox2.ItemIndex]);
end;

procedure TForm1.Panel21Resize(Sender: TObject);
var a1, a2: Integer; MainPanel, ChieldPanel: TPanel;
begin
  MainPanel:= Panel21;
  ChieldPanel:= Panel22;
  a1:= MainPanel.Width*9 div 10;
  a2:= MainPanel.Height*9 div 10;
  If a2 < 1 then a2:= 1;
  If a1/a2 <= 4/3 then begin
    ChieldPanel.Width:= a1;
    If ChieldPanel.Width > 0 then
      ChieldPanel.Height:= Round(3/4*ChieldPanel.Width);
  end else begin
    ChieldPanel.Height:= a2;
    If ChieldPanel.Height > 0 then
      ChieldPanel.Width:= Round(4/3*ChieldPanel.Height);
  end;
  ChieldPanel.Left:= (MainPanel.Width-ChieldPanel.Width) div 2;
  ChieldPanel.Top:= (MainPanel.Height-ChieldPanel.Height) div 2;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var s1: String;
begin
  s1:= FSessMan.SeqMan.NewSeq('Nova Seqüência');

  ComboBox3.Items.Add(s1);
  ComboBox3.ItemIndex:= ComboBox3.Items.IndexOf(s1);
  ComboBox4.ItemIndex:= ComboBox4.Items.IndexOf(FSessMan.SeqMan.DefTentName);
  Label6.Caption:= IntToStr(FSessMan.SeqMan.NumTent);
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
  FSessMan.SeqMan.SelectSeq(ComboBox3.Items[ComboBox3.ItemIndex]);

  ComboBox4.ItemIndex:= ComboBox4.Items.IndexOf(FSessMan.SeqMan.DefTentName);

  Label6.Caption:= IntToStr(FSessMan.SeqMan.NumTent);
{
  SpinEdit1.MaxValue:= FSessMan.SeqMan.NumTent;
  If SpinEdit1.MaxValue > 0 then begin
    SpinEdit1.Value:= 1;
    SpinEdit1.Enabled:= True;
  end else begin
    SpinEdit1.Value:= 0;
//    SpinEdit1.Enabled:= False;
  end;
}
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  FSessMan.SeqMan.NewTent;

  Label6.Caption:= IntToStr(FSessMan.SeqMan.NumTent);
{
  SpinEdit1.MaxValue:= FSessMan.SeqMan.NumTent;
  If SpinEdit1.MaxValue > 0 then begin
    SpinEdit1.Value:= SpinEdit1.MaxValue;
    SpinEdit1.Enabled:= True;
  end else begin
    SpinEdit1.Value:= 0;
//    SpinEdit1.Enabled:= False;
  end;
}  
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  FSessMan.SeqMan.SelectTent(SpinEdit1.Value-1);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  FSessMan.SeqMan.DeleteTent(SpinEdit1.Value-1);

  Label6.Caption:= IntToStr(FSessMan.SeqMan.NumTent);
{
  SpinEdit1.MaxValue:= FSessMan.SeqMan.NumTent;
  If SpinEdit1.MaxValue > 0 then begin
    SpinEdit1Change(nil);
    SpinEdit1.Enabled:= True;
  end else begin
    SpinEdit1.Value:= 0;
//    SpinEdit1.Enabled:= False;
  end;
}  
end;

procedure TForm1.ComboBox4Change(Sender: TObject);
begin
  FSessMan.SeqMan.DefTentName:= ComboBox4.Items[ComboBox4.ItemIndex];
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  FSessMan.SeqMan.DeleteSeq(ComboBox3.Items[ComboBox3.ItemIndex]);
end;

procedure TForm1.TabSheet4Resize(Sender: TObject);
begin
  Panel28.Width:= TabSheet4.ClientWidth div 2;
//  Panel30.Width:= Panel28.Width;
end;

procedure TForm1.ListView2DrawItem(Sender: TCustomListView;
  Item: TListItem; Rect: TRect; State: TOwnerDrawState);
begin
  With ListView2.Canvas do begin
    If odSelected in State then begin
      Font.Color:= clWhite;
      Brush.Color:= clHighlight;
    end else begin
      Font.Color:= clBlack;
      Brush.Color:= clWhite;
    end;
    TextRect(Rect, Rect.Left, Rect.Top, Item.Caption);
  end;
end;

procedure TForm1.ListView2DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept:= True;
  ListView2.Selected:= ListView2.GetItemAt(X, Y);
end;

procedure TForm1.ListView3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If ssLeft in Shift then
    ListView3.BeginDrag(False);
end;

procedure TForm1.TabSheet4Show(Sender: TObject);
begin
//  FSessMan.BlcMan.GetSeqNames(CheckListBox1.Items);
end;

procedure TForm1.CheckListBox1ClickCheck(Sender: TObject);
var a1, a2, a3: Integer;
begin
  ListView3.Clear;
  a3:= -1;
  For a1:= 0 to CheckListBox1.Items.Count-1 do begin
    If CheckListBox1.Checked[a1] then
      For a2:= 0 to FSessMan.BlcMan.SeqNumTent(a1)-1 do begin
        ListView3.Items.Add;
        Inc(a3);
        ListView3.Items[a3].Data:= TDragTent.Create(a1, a2);
        ListView3.Items[a3].Caption:= IntToStr(a3+1);
        ListView3.Items[a3].SubItems.Add('A');
      end;
  end;
end;

procedure TForm1.ListView3SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  If Selected then begin
    If Assigned(Item.Data) then
      FSessMan.BlcMan.SelectTent(TDragTent(Item.Data).IndSeq, TDragTent(Item.Data).IndTent);
  end;
end;

constructor TDragTent.Create(IndSeq, Indtent: Integer);
begin
  Inherited Create;
  FIndSeq:= IndSeq;
  FIndTent:= Indtent;
end;

procedure TForm1.ListView3StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  If Assigned(ListView3.Selected) then
    If Assigned(ListView3.Selected.Data) then
      DragObject:= TDragTent(ListView3.Selected.Data);
end;

procedure TForm1.ListView2DragDrop(Sender, Source: TObject; X, Y: Integer);
var ListItem: TListItem;
begin
  If Source is TDragTent then begin
    ListItem:= ListView2.GetItemAt(X, Y);
    If Assigned(ListItem) then
      FSessMan.BlcMan.InsertTent(ListItem.Index, TDragTent(Source).IndSeq, TDragTent(Source).IndTent)
    else FSessMan.BlcMan.NewTent(TDragTent(Source).IndSeq, TDragTent(Source).IndTent);
  end;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
var s1: String;
begin
  s1:= FSessMan.BlcMan.NewBlc('Novo Bloco');
  ComboBox5.Items.Add(s1);
  ComboBox5.ItemIndex:= ComboBox5.Items.IndexOf(s1);
end;

procedure TForm1.ComboBox5Change(Sender: TObject);
var a1: Integer;
begin
  If ComboBox5.ItemIndex > -1 then begin
    FSessMan.BlcMan.SelectBlc(ComboBox5.Items[ComboBox5.ItemIndex]);

    ListView2.Clear;
    For a1:= 0 to FSessMan.BlcMan.NumTent-1 do begin
      ListView2.Items.Add;
//      ListView2.Items[a1].Data:= TDragTent.Create(a1, a2);
      ListView2.Items[a1].Caption:= IntToStr(a1+1);
      ListView2.Items[a1].SubItems.Add(FSessMan.BlcMan.TentValue[a1, 'Name']);
      ListView2.Items[a1].SubItems.Add(FSessMan.BlcMan.TentValue[a1, 'CM.L']);
    end;
  end;
end;

procedure TForm1.PageControl3DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
  With Control.Canvas do begin
    If Active then Brush.Color:= clWindow
    else Brush.Color:= clBtnFace;
    TextRect(Rect, Rect.Left+5, Rect.Top+3, TPageControl(Control).Pages[TabIndex].Caption);
  end;
end;

procedure TForm1.Splitter5Moved(Sender: TObject);
begin
  Panel26.Height:= Panel31.Height-27;
end;

procedure TForm1.Splitter6Moved(Sender: TObject);
begin
  Panel31.Height:= Panel26.Height+27;
end;

procedure TForm1.Panel31Resize(Sender: TObject);
var a1, a2: Integer; MainPanel, ChieldPanel: TPanel;
begin
  MainPanel:= Panel31;
  ChieldPanel:= Panel34;
  a1:= MainPanel.Width*9 div 10;
  a2:= MainPanel.Height*9 div 10;
  If a2 < 1 then a2:= 1;
  If a1/a2 <= 4/3 then begin
    ChieldPanel.Width:= a1;
    If ChieldPanel.Width > 0 then
      ChieldPanel.Height:= Round(3/4*ChieldPanel.Width);
  end else begin
    ChieldPanel.Height:= a2;
    If ChieldPanel.Height > 0 then
      ChieldPanel.Width:= Round(4/3*ChieldPanel.Height);
  end;
  ChieldPanel.Left:= (MainPanel.Width-ChieldPanel.Width) div 2;
  ChieldPanel.Top:= (MainPanel.Height-ChieldPanel.Height) div 2;
end;

procedure TForm1.PageControl4DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
  With Control.Canvas do begin
    If Active then Brush.Color:= clWindow
    else Brush.Color:= clBtnFace;
    TextRect(Rect, Rect.Left+5, Rect.Top+3, TPageControl(Control).Pages[TabIndex].Caption);
  end;
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
var s1: String; 
begin
  s1:= FSessMan.DefTentMan.NewDefTent('Nova Configuração');
  ComboBox1.Items.Add(s1);
  ComboBox1.ItemIndex:= ComboBox1.Items.IndexOf(s1);
end;

procedure TForm1.SpeedButton10Click(Sender: TObject);
begin
  FSessMan.DefTentMan.DeleteDefTent(ComboBox1.Items[ComboBox1.ItemIndex]);
  ComboBox1.Items.Delete(ComboBox1.ItemIndex);
  ComboBox2.ItemIndex:= -1;  
end;

end.
