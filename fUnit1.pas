unit fUnit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, Buttons, StdCtrls, MPlayer, ExtCtrls, ToolWin,
  ImgList, uSessao, uCfgSes, fEstimulos, inifiles;

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
    OpenDialog1: TOpenDialog;
    Sair1: TMenuItem;
    ImageList1: TImageList;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    N1: TMenuItem;
    N3: TMenuItem;
    RodarSesso1: TMenuItem;
    Ajuda1: TMenuItem;
    SobreoGalileu1: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure RodarSesso1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure SobreoGalileu1Click(Sender: TObject);
  private
    { Private declarations }
    FFlagEditFile: Boolean;
    procedure EndSessao(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  CurPath: String;
  CfgSes: TCfgSes;
  Sessao: TSessao;

const
  Titulo: String = 'EAM (versão Beta 1.1.02)';

implementation

uses fSuport, fInitSes, fSplash;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form3:= TForm3.Create(Self);
  With Form3 do begin
    Show;
  end;
  CurPath:= GetCurrentDir;
  CfgSes:= TCfgSes.Create(Self);
  Sessao:= TSessao.Create(Self);
  With Sessao do begin
    OnEndSess:= EndSessao;
    SourcePath:= CurPath+'\Files\';
  end;
  FormSup:= TFormSup.Create(Self);

  Caption:= Titulo;
  OpenDialog1.InitialDir:= CurPath;
  SaveDialog1.InitialDir:= CurPath;
  Height:= 469;
  Width:= 650;
  FFlagEditFile:= False;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  FormSup.Show;
  Form2:= TForm2.Create(Self);
  If Form2.ShowModal = mrOk then begin
    FreeAndNil(Form2);
    Sessao.SuportTent:= FormSup;
    Sessao.Play;
  end else begin
    FreeAndNil(Form2);
    FormSup.Visible:= False;
  end;
end;

procedure TForm1.Abrir1Click(Sender: TObject);
begin
  ToolButton4Click(nil);
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  If OpenDialog1.Execute then begin
    FreeAndNil(CfgSes);
    CfgSes:= TCfgSes.Create(Self);
    CfgSes.LoadFromFile(OpenDialog1.FileName);
    Caption:= Titulo+' - '+CfgSes.Name;
    ToolButton1.Enabled:= True;
  end;
end;

procedure TForm1.RodarSesso1Click(Sender: TObject);
begin
  ToolButton1Click(nil);
end;

procedure TForm1.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.Fechar1Click(Sender: TObject);
begin
  FreeAndNil(CfgSes);
  Caption:= Titulo;
end;

procedure TForm1.EndSessao(Sender: TObject);
begin
  ToolButton1.Down:= False;
end;

procedure TForm1.SobreoGalileu1Click(Sender: TObject);
begin
  Form3:= TForm3.Create(Self);
  Form3.Show;
end;

end.
