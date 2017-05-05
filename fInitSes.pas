unit fInitSes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SaveDialog1: TSaveDialog;
    Button3: TButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    MR: TModalResult;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses fUnit1;

{$R *.DFM}

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
  If SaveDialog1.Execute then
    Edit3.Text:= SaveDialog1.FileName;
end;

procedure TForm2.CheckBox1Click(Sender: TObject);
begin
  Label3.Enabled:= CheckBox1.Checked;
  Edit3.Enabled:= CheckBox1.Checked;
  SpeedButton1.Enabled:= CheckBox1.Checked;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  With Sessao do begin
    SaveData:= CheckBox1.Checked;
    SubjectsName:= Edit1.Text;
    SessionName:= Edit2.Text;
    OutputFile:= SaveDialog1.FileName;
    EfeitoSonoro:= False;
  end;
  MR:= mrOk;
  Close;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ModalResult:= MR;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  MR:= mrCancel;
  Close;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  SaveDialog1.FileName:= CurPath+'\Sessão1.xls';
  Edit3.Text:= SaveDialog1.FileName;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  If MessageDlg('Tem certeza de que deseja rodar um teste?', mtConfirmation,
                                            [mbYes, mbNo], 0) = mrYes then begin
    Sessao.EfeitoSonoro:= True;
    MR:= mrOk;
    Close;
  end;
end;

end.
