unit fUnit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm3 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn3: TBitBtn;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses fUnit1;

procedure TForm3.FormCreate(Sender: TObject);
begin
  Edit3.Text:= Form1.SaveDialog1.FileName;
end;

procedure TForm3.BitBtn3Click(Sender: TObject);
begin
  If Form1.SaveDialog1.Execute then
    Edit3.Text:= Form1.SaveDialog1.FileName;
end;

end.
