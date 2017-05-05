program EAM;

uses
  Forms,
  fUnit1 in 'fUnit1.pas' {Form1},
  fSuport in 'fSuport.pas' {FormSup},
  uCfgSes in 'uCfgSes.pas',
  uSessao in 'uSessao.pas',
  uTentativa in 'uTentativa.pas',
  uRegData in 'uRegData.pas',
  uChave in 'uChave.pas',
  uBloco in 'uBloco.pas',
  Windows,
  uConseq in 'uConseq.pas',
  fSplash in 'fSplash.pas' {Splash},
  fSobre in 'fSobre.pas' {Sobre},
  fGabarito in 'fGabarito.pas' {Gabaritos};

{$R *.res}

begin
  Splash:= TSplash.Create(Application);
  Splash.FTimerSplash.Interval:= 2000;
  Splash.Flag:= True;
  Splash.ShowModal;
  Splash.Flag:= False;
  Splash.Show;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Screen.Cursors[1]:= LoadCursor(HInstance, 'EAM1');
  Screen.Cursors[2]:= LoadCursor(HInstance, 'EAM2');
  Application.Run;
end.
