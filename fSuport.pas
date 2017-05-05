unit fSuport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls;

type
  TFormSup = class(TForm)
    SpeedButton1: TSpeedButton;
    Timer1: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSup: TFormSup;

implementation

uses fUnit1;

{$R *.DFM}

procedure TFormSup.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = 27) then Sessao.EnabledTS(False);
  If (Key = 32) then Sessao.NextTent(0);
  If (Key = 107) then Sessao.NextTent(1);
  If (Key = 109) then Sessao.NextTent(2);
  If (ssAlt in Shift) then begin
    If (Key = 115) then FreeAndNil(Sessao);
  end;
  If (Key = 112) and Form1.FCanParalel then begin
      Try
        asm
          mov dx, $378
          mov al, 255
          out dx, al
          mov dx, $278
          mov al, 255
          out dx, al
        end;
        Timer1.Enabled:= True;
      Except end;
  end;
end;

procedure TFormSup.SpeedButton1Click(Sender: TObject);
begin
 SpeedButton1.Visible:= False;
 Sessao.Play;
end;

procedure TFormSup.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = 27) then Sessao.EnabledTS(True);
end;

procedure TFormSup.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:= False;
  If Form1.FCanParalel then begin
    Try
      asm
        mov dx, $378
        mov al, 0
        out dx, al
        mov dx, $278
        mov al, 0
        out dx, al
      end;
    Except end;
  end;
end;

end.
