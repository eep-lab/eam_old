unit fUnit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TForm2 = class(TForm)
    SpeedButton1: TSpeedButton;
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses fUnit1;

{$R *.dfm}

procedure TForm2.FormResize(Sender: TObject);
begin
  SpeedButton1.Left:= (Width-SpeedButton1.Width) div 2;
  SpeedButton1.Top:= (Height-SpeedButton1.Height) div 2;  
end;

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If ssCtrl in Shift then begin
    If Key = 32 then SpeedButton1Click(nil);
  end;
  If Key = 27 then begin
    SpeedButton1.Visible:= False;
    Form1.RodarSesso1Click(nil);
  end;
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
  Cursor:= -1;
  SpeedButton1.Visible:= False;
  Form1.FSess.Play(Form1.FCfgSes, Form1.SaveDialog1.FileName);
end;

end.
