unit fUnit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, Buttons, StdCtrls, MPlayer, ExtCtrls, ToolWin, inifiles,
  ImgList,
  fUnit2, fAbout, uCfgSes, uSess, uBlc;

type
  TThreadSess = class(TThread)
  protected
    procedure Execute; override;
  end;

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
    ToolButton3: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure SobreoGalileu1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure RodarSesso1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
  private
    FSess: TSess;
    FThreadSess: TThreadSess;
    procedure Form2Close(Sender: TObject; var Action: TCloseAction);
    procedure SessEndSess(Sender: TObject);
    procedure ThreadSessTerminate(Sender: TObject);
  public
    FCfgSes: TCfgSes;
    procedure ApplicationException(Sender: TObject; E: Exception);
  end;


const
  Titulo: String = 'EAM 4.0.04';

var
  Form1: TForm1;
  CurPath: String;

implementation

uses fUnit3, fUnit4;

{$R *.DFM}

procedure TThreadSess.Execute;
begin
  Suspend;
end;

procedure TForm1.ApplicationException(Sender: TObject; E: Exception);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//  SetCurrentDir(GetCurrentDir+'\Files Settings');
  CurPath:= GetCurrentDir;

  Caption:= Titulo;
  RodarSesso1.Enabled:= False;
  ToolButton1.Enabled:= False;

  OpenDialog1.InitialDir:= CurPath;

  FCfgSes:= TCfgSes.Create(Application);
end;

procedure TForm1.Abrir1Click(Sender: TObject);
begin
  If OpenDialog1.Execute then begin
    If FCfgSes.LoadFromFile(OpenDialog1.FileName) then begin
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
  Form2:= TForm2.Create(Application);
  Form2.Show;

  Form3:= TForm3.Create(Self);
  If Form3.ShowModal = mrOK then begin
    FThreadSess:= TThreadSess.Create(False);
    FThreadSess.OnTerminate:= ThreadSessTerminate;

    Form2.OnClose:= Form2Close;

    FSess:= TSess.Create(Application);
    FSess.BackGround:= Form2;
    FSess.OnEndSess:= SessEndSess;

    FSess.TestMode:= Form3.CheckBox1.Checked;
    FSess.SubjName:= Form3.Edit1.Text;
    FSess.SessName:= Form3.Edit2.Text;

    FSess.Play(FCfgSes, Form3.Edit3.Text);

  end else Form2.Free;

  Form3.Free;
end;

procedure TForm1.SessEndSess(Sender: TObject);
begin
  FThreadSess.Resume;
end;

procedure TForm1.Form2Close(Sender: TObject; var Action: TCloseAction);
begin
  FSess.DoEndSess;
end;

procedure TForm1.ThreadSessTerminate(Sender: TObject);
begin
  FSess.Free;
  Form2.Free;
end;

procedure TForm1.SobreoGalileu1Click(Sender: TObject);
begin
  FmAbout:= TFmAbout.Create(Self);
  FmAbout.ShowModal;
  FmAbout.Free;
end;

procedure TForm1.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  Form4:= TForm4.Create(Self);
  Form4.PageControl1.Parent:= Self;
end;

end.
