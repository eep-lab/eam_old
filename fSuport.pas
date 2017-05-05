unit fSuport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TFormSup = class(TForm)
    procedure FormDblClick(Sender: TObject);
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

procedure TFormSup.FormDblClick(Sender: TObject);
begin
  Close;
end;

end.
