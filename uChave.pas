unit uChave;

interface

uses
  Windows, Controls, StdCtrls, ExtCtrls, comctrls, Graphics,
  Classes, Dialogs, SysUtils, menus, Forms, MPlayer, inifiles;

type
  TKind = set of (stmText, stmImage);

  TplAlignment = (plTopLeft, plTop, plTopRight,
                  plCenterLeft, plCenter, plCenterRight,
                  plBottonLeft, plBotton, plBottonRight);

  TText = Record
    Name: String;
    Text: String;
    Alignment: TplAlignment;
    FontSize: Integer;
    FontName: String;
    FontColor: TColor;
  end;

  PText = ^TText;

  TChave = class(TGraphicControl)
  private
    FAlignment: TplAlignment;
    FAutoSize: Boolean;
    FBitMap: TBitMap;
    FBorderColor: TColor;
    FFileName: String;
    FFlagAutoSizing: Boolean;
    FFlagHAlignment: Boolean;
    FFlagVAlignment: Boolean;
    FID: Integer;
    FInitPos: TPoint;
    FKind: TKind;
    FLabelChv: String;
    FLabelStm: String;
    FShortFileName: String;
    FShowBorder: Boolean;
    FText: TText;
    procedure FontChange(Sender: TObject);
    function  GetPlHeight: Integer;
    function  GetPlLeft: Integer;
    function  GetPlTop: Integer;
    function  GetPlWidth: Integer;
    function  GetText: PText;
    function  GetTransparent: Boolean;
    function  LoadImage(Path: String): Boolean;
    function  LoadText(Path: String): Boolean;
    procedure PaintText;
    procedure SetAutoSize(Value: Boolean);
    procedure SetAlignment(Value: TplAlignment);
    procedure SetBorderColor(AColor: TColor);
    procedure SetFileName(Path: String);
    procedure SetPlHeight(Value: Integer);
    procedure SetPlLeft(Value: Integer);
    procedure SetPlTop(Value: Integer);
    procedure SetPlWidth(Value: Integer);
    procedure SetShowBorder(Value: Boolean);
    procedure SetTransparent(Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Reset;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property Alignment: TplAlignment read FAlignment write SetAlignment;
    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property BitMap: TBitMap read FBitMap;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property FileName: String read FFileName write SetFileName;
    property ID: Integer read FID write FID;
    property Kind: TKind read FKind;
    property LabelChv: String read FLabelChv write FLabelChv;
    property LabelStm: String read FLabelStm write FLabelStm;
    property OnClick;
    property plHeight: Integer read GetPlHeight write SetPlHeight;
    property plLeft: Integer read GetPlLeft write SetPlLeft;
    property plTop: Integer read GetPlTop write SetPlTop;
    property plWidth: Integer read GetPlWidth write SetPlWidth;
    property ShortFileName: String read FShortFileName;
    property ShowBorder: Boolean read FShowBorder write SetShowBorder;
    property Text: PText read GetText;
    property Transparent: Boolean read GetTransparent write SetTransparent;
  end;

implementation

constructor TChave.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FBitMap:= TBitMap.Create;
  FBitMap.Canvas.Font.OnChange:= FontChange;
  Height:= 45;
  Width:= 60;
  FAlignment:= plTopLeft;
  Reset;
end;

destructor TChave.Destroy;
begin
  FBitMap.Free;
  Inherited Destroy;
end;

procedure TChave.FontChange(Sender: TObject);
begin
  PaintText;
end;

function TChave.GetPlHeight: Integer;
begin
  Result:= Inherited Height;
end;

function TChave.GetplLeft: Integer;
begin
  Result:= FInitPos.x;
end;

function TChave.GetText: PText;
begin
  Result:= @FText;
end;

function TChave.GetPlTop: Integer;
begin
  Result:= FInitPos.y;
end;

function TChave.GetTransparent: Boolean;
begin
  Result:= FBitMap.Transparent;
end;

function TChave.GetPlWidth: Integer;
begin
  Result:= Inherited Width;
end;

procedure TChave.Reset;
begin
  FKind:= [];
  FFileName:= '';
  With FText do begin
    Name:= '';
    Text:= '';
    Alignment:= plCenter;
    FontSize:= 14;
    FontName:= 'Arial';
    FontColor:= clBlack;
  end;
  With FBitMap do begin
    PixelFormat:= pf24bit;
    Height:= 0;
    Width:= 0;
    Canvas.Brush.Color:= clNone;
    Height:= Self.Height;
    Width:= Self.Width;
  end;
  Repaint;
end;

procedure TChave.Paint;
begin
  With Canvas do begin
    StretchDraw(Rect(0, 0, Width, Height), FBitMap);
    If FShowBorder then begin
      Brush.Color:= FBorderColor;
      FrameRect(Rect(0, 0, Width, Height));
    end;
  end;
end;

procedure TChave.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  If FFlagHAlignment then FInitPos.x:= ALeft;
  If FFlagVAlignment then  FInitPos.y:= ATop;
  FFlagHAlignment:= True;
  FFlagVAlignment:= True;
  Case Integer(FAlignment) of
    1: ALeft:= FInitPos.x-(AWidth div 2);
    2: ALeft:= FInitPos.x-AWidth;
    3: ATop:= FInitPos.y-(AHeight div 2);
    4: begin ALeft:= FInitPos.x-(AWidth div 2); ATop:= FInitPos.y-(AHeight div 2); end;
    5: begin ALeft:= FInitPos.x-AWidth; ATop:= FInitPos.y-(AHeight div 2); end;
    6: ATop:= FInitPos.y-AHeight;
    7: begin ALeft:= FInitPos.x-(AWidth div 2); ATop:= FInitPos.y-AHeight; end;
    8: begin ALeft:= FInitPos.x-AWidth; ATop:= FInitPos.y-AHeight; end;
  end;
  Inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TChave.SetPlWidth(Value: Integer);
begin
  FFlagHAlignment:= False;
  FFlagVAlignment:= False;
  Inherited Width:= Value;
end;

procedure TChave.SetAutoSize(Value: Boolean);
begin
  FAutoSize:= Value;
  If FAutoSize then
    If (stmText in FKind) then PaintText;
    If (stmImage in FKind) then begin
      FFlagAutoSizing:= True;
      plWidth:= FBitMap.Width;
      plHeight:= FBitMap.Height;
      FFlagAutoSizing:= False;
    end;
end;

procedure TChave.SetAlignment(Value: TplAlignment);
begin
  FAlignment:= Value;
  SetBounds(plLeft, plTop, plWidth, plHeight);
end;

procedure TChave.SetBorderColor(AColor: TColor);
begin
  FBorderColor:= AColor;
  Repaint;
end;

procedure TChave.SetplTop(Value: Integer);
begin
  FFlagHAlignment:= False;
  Inherited Top:= Value;
end;

procedure TChave.SetTransparent(Value: Boolean);
begin
  FBitMap.Transparent:= Value;
  Repaint;
end;

procedure TChave.SetShowBorder(Value: Boolean);
begin
  FShowBorder:= Value;
  Repaint;
end;

procedure TChave.SetFileName(Path: String);
var s1, s2: String;
begin
  Reset;
  If FileExists(Path) then begin
    s1:= UpperCase(ExtractFileExt(Path));
    If s1 = '.EST' then If LoadText(Path) then FKind:= FKind+[stmText];
    If s1 = '.BMP' then If LoadImage(Path) then FKind:= FKind+[stmImage];
    If FKind <> [] then begin
      FFileName:= Path;
      s2:= ExtractFileName(Path);
      Delete(s2, Pos(s1, s2), 4);      
      FShortFileName:= s2;
    end;
  end;
end;

procedure TChave.SetPlHeight(Value: Integer);
begin
  FFlagVAlignment:= False;
  FFlagHAlignment:= False;
  Inherited Height:= Value;
end;

procedure TChave.SetPlLeft(Value: Integer);
begin
  FFlagVAlignment:= False;
  Inherited Left:= Value;
end;

function TChave.LoadImage(Path: String): Boolean;
begin
  Result:= True;
  Try FBitMap.LoadFromFile(Path);
  Except Result:= False; end;
end;

function TChave.LoadText(Path: String): Boolean;
var IniFile: TIniFile;
begin
  Result:= True;
  Try
    IniFile := TIniFile.Create(Path);
    With FText do begin
      Name:= IniFile.ReadString('TextStimuli', 'Name', '');
      Text:= IniFile.ReadString('TextStimuli', 'Text', '');
      Alignment:= TplAlignment(IniFile.ReadInteger('TextStimuli', 'Alignment', 4));
      FontSize:= IniFile.ReadInteger('TextStimuli', 'FontSize', 14);
      FontName:= IniFile.ReadString('TextStimuli', 'FontName', 'Arial');
      FontColor:= IniFile.ReadInteger('TextStimuli', 'FontColor', 0);
    end;
    IniFile.Free;
    PaintText;
  Except Result:= False; end;
end;

procedure TChave.PaintText;
var a1, a2: Integer; S: TSize;
begin
  FBitMap.Canvas.Font.OnChange:= nil;
  FBitMap.Canvas.Font.Name:= FText.FontName;
  FBitMap.Canvas.Font.Color:= FText.FontColor;
  FBitMap.Canvas.Font.Size:= FText.FontSize;
  S:= FBitMap.Canvas.TextExtent(FText.Text);
  If FAutoSize then begin
    FBitMap.Width:= S.cx;
    FBitMap.Height:= S.cy;
    FBitMap.Canvas.TextOut(0, 0, FText.Text);
    FFlagAutoSizing:= True;
    plWidth:= FBitMap.Width;
    plHeight:= FBitMap.Height;
    FFlagAutoSizing:= False;
  end else begin
    FBitMap.Width:= 0;
    FBitMap.Height:= 0;
    FBitMap.Width:= Width;
    FBitMap.Height:= Height;
    Case Integer(FText.Alignment) of
      1: begin a1:= (FBitMap.Width-S.cx) div 2; a2:= 0 end;
      2: begin a1:= FBitMap.Width-S.cx; a2:= 0 end;
      3: begin a1:= 0; a2:= (FBitMap.Height-S.cy) div 2; end;
      4: begin
           a1:= (FBitMap.Width-S.cx) div 2;
           a2:= (FBitMap.Height-S.cy) div 2;
         end;
      5: begin a1:= FBitMap.Width-S.cx; a2:= (FBitMap.Height-S.cy) div 2; end;
      6: begin a1:= 0; a2:= FBitMap.Height-S.cy; end;
      7: begin a1:= (FBitMap.Width-S.cx) div 2; a2:= FBitMap.Height-S.cy; end;
      8: begin a1:= FBitMap.Width-S.cx; a2:= FBitMap.Height-S.cy; end;
      else begin a1:= 0; a2:= 0; end;
    end;
    FBitMap.Canvas.TextOut(a1, a2, FText.Text);
  end;
  Repaint;
  FBitMap.Canvas.Font.OnChange:= FontChange;
end;

end.
