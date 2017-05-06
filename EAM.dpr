program EAM40b;

uses
  Forms,
  SysUtils,
  fUnit1 in 'Forms\fUnit1.pas' {Form1},
  fUnit2 in 'Forms\fUnit2.pas' {Form2},
  fSplash in 'Forms\fSplash.pas' {FmSplash},
  fAbout in 'Forms\fAbout.pas' {FmAbout},
  uCfgSes in 'Units\uCfgSes.pas',
  uSess in 'Units\uSess.pas',
  uTrial in 'Units\uTrial.pas',
  uKey in 'Units\uKey.pas',
  uRegData in 'Units\uRegData.pas',
  uTrialMTS in 'Units\uTrialMTS.pas',
  fUnit3 in 'Forms\fUnit3.pas' {Form3},
  uTrialNat in 'Units\uTrialNat.pas',
  uTrialMar in 'Units\uTrialMar.pas',
  uTrialNatC in 'Units\uTrialNatC.pas',
  uBlc in 'Units\uBlc.pas',
  uSchMan in 'Units\uSchMan.pas',
  uSch in 'Units\uSch.pas',
  uTrialSimpl in 'Units\uTrialSimpl.pas',
  uTrialMTSPgl in 'Units\uTrialMTSPgl.pas',
  uTrialAbraa in 'Units\uTrialAbraa.pas',
  uTrialMsg in 'Units\uTrialMsg.pas',
  fUnit4 in 'Forms\fUnit4.pas' {Form4};

{$R *.res}

begin
  FmSplash:= TFmSplash.Create(Application);
  FmSplash.TimerSplash.Interval:= 1;
  FmSplash.ShowModal;
  FmSplash.TimerSplash.Interval:= 2;
  FmSplash.Show;

  Application.Initialize;
  Application.Title := 'EAM 4.0';
  Application.CreateForm(TForm1, Form1);
  Application.OnException:= Form1.ApplicationException;
  Application.Run;
end.
