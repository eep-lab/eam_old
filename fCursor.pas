unit fCursor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TCursor = class(TForm)
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    procedure SpinEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Cursor: TCursor;

implementation

{$R *.dfm}

procedure TCursor.SpinEdit1Change(Sender: TObject);
begin
  GroupBox1.Cursor:= SpinEdit1.Value;
end;

procedure TCursor.FormCreate(Sender: TObject);
begin
  GroupBox1.Cursor:= SpinEdit1.Value;
end;

end.
