program EAM;

uses
  Forms,
  fUnit1 in 'fUnit1.pas' {Form1},
  fInitSes in 'fInitSes.pas' {Form2},
  fSuport in 'fSuport.pas' {FormSup},
  uCfgSes in 'uCfgSes.pas',
  uChave in 'uChave.pas',
  uSett1100 in 'uSett1100.pas',
  uAbsTent in 'uAbsTent.pas',
  uSessao in 'uSessao.pas',
  fEstimulos in 'fEstimulos.pas' {FormEstimulos},
  fSplash in 'fSplash.pas' {Form3},
  uSett1200 in 'uSett1200.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TFormSup, FormSup);
  Application.CreateForm(TFormEstimulos, FormEstimulos);
  Application.Run;
end.