unit fUnit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, Buttons, StdCtrls, MPlayer, ExtCtrls, ToolWin, inifiles,
  ImgList, uUserList, uSubjList, uProcList, uCfgSList, uLog,
  uCfgSes, uSess;

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
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    N1: TMenuItem;
    N3: TMenuItem;
    RodarSesso1: TMenuItem;
    Ajuda1: TMenuItem;
    SobreoGalileu1: TMenuItem;
    Image1: TImage;
    PortaParalela1: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    Logout1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure RodarSesso1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure Logout1Click(Sender: TObject);
  private
    { Private declarations }
  public
    FCanParalel: Boolean;
    { Public declarations }
  end;

const
  Titulo: String = 'EAM 4.0';

var
  Form1: TForm1;

  CurPath: String;

  UserList: TUserList;
  SubjList: TSubjList;
  ProcList: TProcList;
  CfgSList: TCfgSList;

  Log: TLog;

  CfgSes: TCfgSes;
  Sess: TSess;

implementation

uses fSuport, fStartSes, fLogin;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  CurPath:= GetCurrentDir;

  UserList:= TUserList.Create(CurPath+'\Files Settings\UserList.txt');
  SubjList:= TSubjList.Create(CurPath+'\Files Settings\SubjList.txt');
  ProcList:= TProcList.Create(CurPath+'\Files Settings\ProcList.txt');
  CfgSList:= TCfgSList.Create(CurPath+'\Files Settings\CfgSList.txt');

  Log:= TLog.Create(Self, CurPath+'\Files Settings\UserList.txt');

  Caption:= Titulo;
  Height:= 469;
  Width:= 650;
end;

procedure TForm1.RodarSesso1Click(Sender: TObject);
begin
  ToolButton1Click(nil);
end;

procedure TForm1.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
//  FmStartSes:= TFmStartSes.Create(Self);
//  FmStartSes.ShowModal;

  FmSup:= TFmSup.Create(Self);
  FmSup.Show;

  CfgSes:= TCfgSes.Create(CurPath+'\Files Settings\CfgSes desenvolvimento.txt');

  Sess:= TSess.Create(Self, CfgSes);

  Sess.Play;

end;

procedure TForm1.Logout1Click(Sender: TObject);
begin
  Log.Logout;
  Enabled:= False;
  FmLogin:= TFmLogin.Create(Self);
  FmLogin.ShowModal;
end;

end.
