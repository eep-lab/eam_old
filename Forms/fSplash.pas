unit fSplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFmSplash = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure TimerSplashTimer(Sender: TObject);
  public
    { Public declarations }
    TimerSplash: TTimer;
  end;

var
  FmSplash: TFmSplash;

implementation

{$R *.dfm}

procedure TFmSplash.FormCreate(Sender: TObject);
begin
  TimerSplash:= TTimer.Create(Self);
  With TimerSplash do begin
    Enabled:= False;
    OnTimer:= TimerSplashTimer;
  end;
end;

procedure TFmSplash.FormShow(Sender: TObject);
begin
  TimerSplash.Enabled:= True;
end;

procedure TFmSplash.TimerSplashTimer(Sender: TObject);
begin
  TimerSplash.Enabled:= False;
  Close;
end;

end.
