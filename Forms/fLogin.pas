unit fLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, uUserList;

type
  TFmLogin = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmLogin: TFmLogin;

implementation

uses fUnit1;

{$R *.dfm}

procedure TFmLogin.FormCreate(Sender: TObject);
begin
  UserList.GetList(ComboBox1.Items);
  ComboBox1.ItemIndex:= 0;
end;

procedure TFmLogin.CheckBox1Click(Sender: TObject);
begin
  If CheckBox1.Checked then Edit1.PasswordChar:= '*'
  else Edit1.PasswordChar:= #0;
end;

procedure TFmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If Log.TryLog(ComboBox1.Text, Edit1.Text) then begin
    Form1.Enabled:= True;
    Action:= caFree;
  end else begin
    Edit1.Text:= '';
    Edit1.SetFocus;
    Action:= caNone;
  end;
end;

procedure TFmLogin.BitBtn2Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
