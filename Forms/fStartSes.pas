unit fStartSes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFmStartSes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    ComboBox3: TComboBox;
    Memo1: TMemo;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    Edit2: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    ComboBox2: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmStartSes: TFmStartSes;

implementation

{$R *.dfm}

uses fUnit1, uSubjList, uUserList, uProcList, uLog;

procedure TFmStartSes.FormCreate(Sender: TObject);
var a1: Integer;
begin
  ComboBox1.Clear;
  For a1:= 0 to UserList.User[Log.UserList.ItemIndex].NumSubj-1 do
    ComboBox1.Items.Add(UserList.User[Log.UserList.ItemIndex].VetSubj[a1]);
  ComboBox1.Text:= 'Escolha o Sujeito';
end;

procedure TFmStartSes.ComboBox1Change(Sender: TObject);
var a1: Integer;
begin
  If ComboBox1.ItemIndex > -1 then begin
    ComboBox2.Clear;
    For a1:= 0 to SubjList.Subj[ComboBox1.Text].NumProc-1 do
      ComboBox2.Items.Add(SubjList.Subj[ComboBox1.Text].VetProc[a1]);
    ComboBox2.Text:= 'Escolha o Procedimento';
    ComboBox2.Enabled:= True;
    Label6.Enabled:= True;
  end else begin
    ComboBox2.Text:= '';
    ComboBox2.Enabled:= False;
    Label6.Enabled:= False;
  end;
  ComboBox2Change(nil);
end;

procedure TFmStartSes.ComboBox2Change(Sender: TObject);
var a1: Integer;
begin
  If ComboBox2.ItemIndex > -1 then begin
    ComboBox3.Clear;
    For a1:= 0 to ProcList.Proc[ComboBox2.Text].NumCfgS-1 do
      ComboBox3.Items.Add(ProcList.Proc[ComboBox2.Text].VetCfgS[a1]);
    ComboBox3.Text:= 'Escolha a Configuração de Sessão';
    ComboBox3.Enabled:= True;
    Label2.Enabled:= True;
  end else begin
    ComboBox3.Text:= '';
    ComboBox3.ItemIndex:= -1;
    ComboBox3.Enabled:= False;
    Label2.Enabled:= False;
  end;
  ComboBox3Change(nil);
end;

procedure TFmStartSes.ComboBox3Change(Sender: TObject);
begin
  If ComboBox3.ItemIndex > -1 then begin
    Label5.Enabled:= True;
    Edit2.Enabled:= True;
    Label4.Enabled:= True;
    Memo1.Enabled:= True;
    BitBtn1.Enabled:= True;
  end else begin
    Label5.Enabled:= False;
    Edit2.Enabled:= False;
    Label4.Enabled:= False;
    Memo1.Enabled:= False;
    BitBtn1.Enabled:= False;
  end;
end;

procedure TFmStartSes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

end.
