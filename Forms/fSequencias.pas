unit fSequencias;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, Grids, Buttons, Spin, IniFiles, CheckLst,
  uCfgSes, uObjIns, uDefTentMan, uSeqMan;

type
  TFmSequencias = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    Panel5: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    PageControl2: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel7: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Label2: TLabel;
    ComboBox3: TComboBox;
    Edit2: TEdit;
    Panel10: TPanel;
    Label1: TLabel;
    ComboBox4: TComboBox;
    DrawGrid1: TDrawGrid;
    TabSheet5: TTabSheet;
    procedure Panel3Resize(Sender: TObject);
    procedure Panel5Resize(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
  private
    { Private declarations }
    FSeqMan: TSeqMan;
    FObjIns: TObjIns;
  public
    { Public declarations }
  end;

var
  FmSequencias: TFmSequencias;

implementation

Uses Unit1;

{$R *.DFM}

procedure TFmSequencias.Panel3Resize(Sender: TObject);
begin
  If Panel5.Width < Splitter1.MinSize then
    Panel4.Width:= Panel3.Width-(Splitter1.MinSize+Splitter1.Width);
end;

procedure TFmSequencias.Panel5Resize(Sender: TObject);
var a1, a2: Integer;
begin
  a1:= Panel5.Width*9 div 10;
  a2:= Panel5.Height*9 div 10;
  If a1/a2 <= 4/3 then begin
    Panel6.Width:= a1;
    Panel6.Height:= Round(3/4*Panel6.Width);
  end else begin
    Panel6.Height:= a2;
    Panel6.Width:= Round(4/3*Panel6.Height);
  end;
  Panel6.Left:= (Panel5.Width-Panel6.Width) div 2;
  Panel6.Top:= (Panel5.Height-Panel6.Height) div 2;
end;

procedure TFmSequencias.TabSheet1Show(Sender: TObject);
begin
  Panel4.Width:= 500;
end;

end.
