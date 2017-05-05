unit fUnit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, Buttons, StdCtrls, MPlayer, ExtCtrls, ToolWin, inifiles,
  ImgList, fUnit2, fAbout, uCfgSes, uSess;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Abrir1: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    ToolButton1: TToolButton;
    Sair1: TMenuItem;
    ImageList1: TImageList;
    N1: TMenuItem;
    RodarSesso1: TMenuItem;
    Ajuda1: TMenuItem;
    SobreoGalileu1: TMenuItem;
    Image1: TImage;
    N4: TMenuItem;
    OpenDialog1: TOpenDialog;
    ToolButton2: TToolButton;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure SobreoGalileu1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure RodarSesso1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
  private
    { Private declarations }
    procedure SessEndSess(Sender: TObject);
  public
    FCfgSes: TCfgSes;
    FSess: TSess;
    procedure ApplicationException(Sender: TObject; E: Exception);    
    { Public declarations }
  end;

const
  Titulo: String = 'EAM 4.0.03';

var
  Form1: TForm1;
  CurPath: String;


implementation

uses fUnit3;

{$R *.DFM}

procedure TForm1.ApplicationException(Sender: TObject; E: Exception);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CurPath:= GetCurrentDir;

  Caption:= Titulo;
  RodarSesso1.Enabled:= False;
  ToolButton1.Enabled:= False;

  OpenDialog1.InitialDir:= CurPath;
  SaveDialog1.InitialDir:= CurPath;

  Form2:= TForm2.Create(Application);

  FCfgSes:= TCfgSes.Create(Application);

  FSess:= TSess.Create(Application);
  With FSess do begin
    Support:= Form2;
    OnEndSess:= SessEndSess;
  end;
end;

procedure TForm1.SobreoGalileu1Click(Sender: TObject);
begin
  FmAbout:= TFmAbout.Create(Self);
  FmAbout.ShowModal;
  FmAbout.Free;
end;

procedure TForm1.Abrir1Click(Sender: TObject);
begin
  If OpenDialog1.Execute then begin
    If FCfgSes.LoadFromFile(OpenDialog1.FileName{CurPath+'\Files Settings\Sessão.txt'}) then begin
      Caption:= Titulo + ' - ' + FCfgSes.Name;
      RodarSesso1.Enabled:= True;
    end else begin
      Caption:= Titulo;
      RodarSesso1.Enabled:= False;
    end;
    ToolButton1.Enabled:= RodarSesso1.Enabled;
  end;
end;

procedure TForm1.RodarSesso1Click(Sender: TObject);
begin
  Form2.Show;
  Form3:= TForm3.Create(Self);
  If Form3.ShowModal = mrOK then begin
    FSess.TestMode:= Form3.CheckBox1.Checked;
    FSess.SubjName:= Form3.Edit1.Text;
    FSess.SessName:= Form3.Edit2.Text;
    Form2.SpeedButton1.Visible:= True;
  end else begin
    Form2.SpeedButton1.Visible:= False;
    Form2.Close;
  end;
  Form3.Free;
end;

procedure TForm1.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.SessEndSess(Sender: TObject);
begin
  Form2.Close;
end;

end.
