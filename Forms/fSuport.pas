unit fSuport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons;

type
  TFmSup = class(TForm)
    SpeedButton1: TSpeedButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmSup: TFmSup;

implementation

uses fUnit1;

{$R *.DFM}

procedure TFmSup.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (ssAlt in Shift) and (Key = 115) then
//    FreeAndNil(Sessao);
end;

procedure TFmSup.SpeedButton1Click(Sender: TObject);
begin
 SpeedButton1.Visible:= False;
// Sessao.Play;
end;

end.
