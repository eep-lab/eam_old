unit fTentativas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, Spin, CheckLst, IniFiles, Buttons, Menus, Grids,
  uDefTentMan;

type
  TFmTentativas = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel8: TPanel;
    SpeedButton10: TSpeedButton;
    SpeedButton8: TSpeedButton;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Panel5: TPanel;
    Label1: TLabel;
    ComboBox2: TComboBox;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Splitter1: TSplitter;
    PopupMenu1: TPopupMenu;
    Renomear1: TMenuItem;
    Edit1: TEdit;
    Panel9: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Panel6Resize(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    { Private declarations }
   procedure SetComboBox1;
  public
    { Public declarations }
    FDefTentMan: TDefTentMan;
  end;

var
  FmTentativas: TFmTentativas;

implementation

uses Unit1;

{$R *.DFM}

procedure TFmTentativas.FormCreate(Sender: TObject);
begin
//  FCfgSeqMan:= TCfgSeqMan.Create(Self, CfgSes);
//  With FDefTentMan do begin
//    Conteiner:= Panel7;
//  end;

{
  With FDefTentMan.ObjIns do begin
    Parent:= Panel4;
    Align:= alClient;
  end;
}

//  FDefTentMan.TentMaker.GetTypes(ComboBox2.Items);
  
  SetComboBox1;
end;

procedure TFmTentativas.Panel6Resize(Sender: TObject);
//var a1, a2: Integer; MainPanel, ChieldPanel: TPanel;
begin
{
  MainPanel:= Panel6;
  ChieldPanel:= Panel7;
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
}
end;

procedure TFmTentativas.SetComboBox1;
begin
  ComboBox1.Clear;
end;

procedure TFmTentativas.SpeedButton10Click(Sender: TObject);
begin
  Beep;
  If MessageDlg('Tem certeza que deseja excluir esta Configuração de Sequência?', mtConfirmation, [mbYes, mbCancel], 0) = mrYes then begin
  end;
end;

procedure TFmTentativas.ComboBox1Change(Sender: TObject);
begin
  FDefTentMan.SelectDefTent(ComboBox1.Items[ComboBox1.ItemIndex]);
end;

procedure TFmTentativas.ComboBox2Change(Sender: TObject);
begin
  FDefTentMan.ChangeType(ComboBox2.Items[ComboBox2.ItemIndex]);
end;

end.
