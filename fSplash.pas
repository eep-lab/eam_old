unit fSplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TSplash = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure TimerSplashTimer(Sender: TObject);
  public
    { Public declarations }
    FTimerSplash: TTimer;
    Flag: Boolean;
  end;

var
  Splash: TSplash;

implementation

{$R *.dfm}


procedure TSplash.FormCreate(Sender: TObject);
begin
  FTimerSplash:= TTimer.Create(Self);
  With FTimerSplash do begin
    Enabled:= False;
    OnTimer:= TimerSplashTimer;
  end;
  Flag:= False;
end;

procedure TSplash.FormShow(Sender: TObject);
begin
  If Flag then FTimerSplash.Enabled:= True;
end;

procedure TSplash.TimerSplashTimer(Sender: TObject);
begin
  FTimerSplash.Enabled:= False;
  Close;
end;

end.
