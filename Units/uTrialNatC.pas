unit uTrialNatC;

interface

uses Types, SysUtils, Graphics, Classes, Windows,
     uTrialNat;

type                                                 
TNatC = class(TNat)
public
  procedure Play(TestMode: Boolean); override;
end;

implementation

uses uTrial;

procedure TNatC.Play(TestMode: Boolean);
var Rgn: HRgn;
begin
  Inherited Play(TestMode);

  Rgn:= CreateEllipticRgn(0, 0, FSupportS.Panel.Width, FSupportS.Panel.Height);
  SetWindowRgn(FSupportS.Panel.Handle, Rgn, False);

  Rgn:= CreateEllipticRgn(0, 0, FSupportC.Panel.Width, FSupportC.Panel.Height);
  SetWindowRgn(FSupportC.Panel.Handle, Rgn, False);
end;

end.
