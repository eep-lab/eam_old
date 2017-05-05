unit fUnit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, Buttons, StdCtrls, MPlayer, ExtCtrls, ToolWin, inifiles,
  ImgList, uSessao, uCfgSes, uTentativa;

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
    Image1: TImage;
    Gabaritos1: TMenuItem;
    N800x6001: TMenuItem;
    PortaParalela1: TMenuItem;
    N2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure RodarSesso1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure SobreoGalileu1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N800x6001Click(Sender: TObject);
    procedure PortaParalela1Click(Sender: TObject);
  private
    { Private declarations }
    FTimerSplash: TTimer;
    procedure TimerSplashTimer(Sender: TObject);
    procedure SessaoEndSess(Sender: TObject);
  public
    FCanParalel: Boolean;
    { Public declarations }
  end;

const
  Titulo: String = 'EAM 3.0';

var
  Form1: TForm1;
  CurPath: String;
  CfgSes: TCfgSes;
  Sessao: TSessao;

implementation

uses fSuport, fSplash, fSobre, fGabarito;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FTimerSplash:= TTimer.Create(Self);
  With FTimerSplash do begin
    Enabled:= False;
    Interval:= 3000;
    OnTimer:= TimerSplashTimer;
  end;
  CurPath:= GetCurrentDir;
  OpenDialog1.InitialDir:= CurPath;
  Caption:= Titulo;
  Height:= 469;
  Width:= 650;

// Para o Win98SE em portugüês a função GetVersion retorna 3221228036
  Try
    asm
      mov dx, $378
      mov al, 0
      out dx, al
      mov dx, $278
      mov al, 0
      out dx, al
    end;
    FCanParalel:= True;
  Except FCanParalel:= False end;

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
    CfgSes.CanParalel:= FCanParalel;
    CfgSes.LoadFromFile(OpenDialog1.FileName);
    Caption:= Titulo+' - '+CfgSes.Name+'  [ '+ ExtractFileName(OpenDialog1.FileName)+' ]';
    ToolButton1.Enabled:= True;
  end;
  SetCurrentDir(CurPath);
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
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  FormSup:= TFormSup.Create(Self);
  With FormSup do begin
    Show;
  end;
  FreeAndNil(Sessao);
  Sessao:= TSessao.Create(Self);
  With Sessao do begin
    OnEndSess:= SessaoEndSess;
    Support:= FormSup;
    Reset(CfgSes);
  end;
end;

procedure TForm1.SessaoEndSess(Sender: TObject);
begin
  FormSup.Close;
end;

procedure TForm1.SobreoGalileu1Click(Sender: TObject);
begin
  Sobre:= TSobre.Create(Self);
  Sobre.ShowModal;
  Sobre.Free;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  FTimerSplash.Enabled:= True;
end;

procedure TForm1.TimerSplashTimer(Sender: TObject);
begin
  FTimerSplash.Enabled:= False;
  Splash.Free;
  Enabled:= True;
end;

procedure TForm1.N800x6001Click(Sender: TObject);
begin
  Gabaritos:= TGabaritos.Create(Self);
  Gabaritos.ShowModal;
  Gabaritos.Free;
end;

procedure TForm1.PortaParalela1Click(Sender: TObject);
var s1: String;
begin
  If FCanParalel then s1:= 'ativado.' else s1:= 'desativado.';
  ShowMessage('O controle da Porta Paralela está '+s1+#13#10+
              'O controle da Porta Paralela é automaticamente desativado quando rodando sobre o a plataforma '+
              'NT (Windows 2000, XP e 2003). Para utilizar o controle da Porta Paralela com o EAM 3.0 é preciso '+
              'usar uma versão anterior do Windows.');
end;

end.
