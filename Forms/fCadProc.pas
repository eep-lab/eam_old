unit fCadProc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, Grids, StdCtrls, CheckLst, Buttons, IniFiles;

type
  TFMCadProc = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Panel4: TPanel;
    Panel8: TPanel;
    Panel6: TPanel;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Panel3: TPanel;
    ListView1: TListView;
    Panel5: TPanel;
    DrawGrid1: TDrawGrid;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    Panel7: TPanel;
    SpeedButton10: TSpeedButton;
    SpeedButton8: TSpeedButton;
    Label2: TLabel;
    ComboBox1: TComboBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Splitter1: TSplitter;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMCadProc: TFMCadProc;

implementation

{$R *.DFM}

end.
