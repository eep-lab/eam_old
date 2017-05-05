program EAM;

uses
  Forms,
  Windows,
  fUnit1 in 'Forms\fUnit1.pas' {Form1},
  fCadUser in 'Forms\fCadUser.pas' {FmCadUser},
  fCadSubj in 'Forms\fCadSubj.pas' {FmCadSubj},
  fCadProc in 'Forms\fCadProc.pas' {FMCadProc},
  uCfgSList in 'Units\uCfgSList.pas',
  uProcList in 'Units\uProcList.pas',
  uSubjList in 'Units\uSubjList.pas',
  uUserList in 'Units\uUserList.pas',
  uLog in 'Units\uLog.pas',
  fLogin in 'Forms\fLogin.pas' {FmLogin},
  fStartSes in 'Forms\fStartSes.pas' {FmStartSes},
  fSuport in 'Forms\fSuport.pas' {FmSup},
  uCfgSes in 'Units\uCfgSes.pas',
  uSess in 'Units\uSess.pas',
  uBlc in 'Units\uBlc.pas',
  uAbsTent in 'Units\uAbsTent.pas',
  uSeq in 'Units\uSeq.pas',
  uCsq in 'Units\uCsq.pas',
  uTent in 'Units\uTent.pas',
  uTentMaker in 'Units\uTentMaker.pas',
  uChave in 'Units\uChave.pas',
  uObjIns in 'Units\uObjIns.pas',
  uStmGrid in 'Units\uStmGrid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFmLogin, FmLogin);
  FmLogin.ShowModal;
  Screen.Cursors[1]:= LoadCursor(HInstance, 'EAM1');
  Screen.Cursors[2]:= LoadCursor(HInstance, 'EAM2');
  Application.Run;
end.
