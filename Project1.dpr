program Project1;

uses
  Forms,
  Unit1 in 'Forms\Unit1.pas' {Form1},
  uChave in 'Units\uChave.pas',
  uCfgSes in 'Units\uCfgSes.pas',
  uTentMaker in 'Units\uTentMaker.pas',
  uAbsTent in 'Units\uAbsTent.pas',
  uTent in 'Units\uTent.pas',
  uObjIns in 'Units\uObjIns.pas',
  uDefTentMan in 'Units\uDefTentMan.pas',
  uSeqMan in 'Units\uSeqMan.pas',
  uSessMan in 'Units\uSessMan.pas',
  uStmGrid in 'Units\uStmGrid.pas',
  uMatStmMan in 'Units\uMatStmMan.pas',
  uBlcMan in 'Units\uBlcMan.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
