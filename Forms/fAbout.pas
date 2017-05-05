unit fAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFmAbout = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmAbout: TFmAbout;

implementation

{$R *.dfm}

uses fUnit1;

procedure TFmAbout.FormCreate(Sender: TObject);
begin
  Caption:= 'Sobre o '+ Titulo;
end;

end.
