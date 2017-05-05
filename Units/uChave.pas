unit uChave;

interface

uses Controls, Graphics, Classes, SysUtils, Jpeg, MPlayer, Forms;

type
  TKind = (stmNone, stmImage, stmSound);

  TChave = class(TGraphicControl)
  private
    FBitMap: TBitMap;
    FFileName: String;
    FKind: TKind;
    FMPlayer: TMediaPlayer;
    FOnEndMedia: TNotifyEvent;
    procedure SetFileName(Path: String);
    procedure MPlayerNotify(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Play;
    procedure Stop;
    property BitMap: TBitmap read FBitMap;
    property FileName: String read FFileName write SetFileName;
    property Kind: TKind read FKind;
    property OnClick;
    property OnMouseDown;
    property OnEndMedia: TNotifyEvent read FOnEndMedia write FOnEndMedia;
    property OnResize;
  end;

implementation

constructor TChave.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  Height:= 45;
  Width:= 60;
  FBitMap:= TBitMap.Create;
end;

destructor TChave.Destroy;
begin
  If Assigned(FMPlayer) then begin
    FMPlayer.Close;
    FreeAndNil(FMPLayer);
  end;
  FBitMap.Free;
  Inherited Destroy;
end;

procedure TChave.Paint;
begin
  With Canvas do begin
    StretchDraw(Rect(0, 0, Width, Height), FBitMap);
    Brush.Color:= clBlue;
    FrameRect(Rect(0, 0, Width, Height));
  end;
end;

procedure TChave.Play;
begin
  If Assigned(FMPlayer) then begin
    Try
      FMPlayer.Notify:= True;
      FMPlayer.Play
    Except
      MPlayerNotify(nil);
    end;
  end else MPlayerNotify(nil);
end;

procedure TChave.Stop;
begin
  If Assigned(FMPlayer) then
    If FMPlayer.Mode = mpPlaying then
      FMPlayer.Stop;
end;

procedure TChave.SetFileName(Path: String);
var s1: String; jpg: TJpegImage; 
begin
  FBitMap.Width:= 0;
  FBitMap.Height:= 0;
  FKind:= stmNone;
  FFileName:= '';
  If Assigned(FMPlayer) then begin
    FMPlayer.Close;
    FreeAndNil(FMPlayer);
  end;
  If FileExists(Path) then begin
    s1:= UpperCase(ExtractFileExt(Path));
    If s1 = '.BMP' then
      Try
        FBitMap.LoadFromFile(Path);
        FKind:= stmImage;
        FFileName:= Path;
      Except end;
    If s1 = '.JPG' then
      Try
        jpg:= TJPEGImage.Create;
        jpg.LoadFromFile(Path);
        FBitMap.Assign(jpg);
        jpg.Free;
        FKind:= stmImage;
        FFileName:= Path;
      Except end;
    If s1 = '.WAV' then begin
      FMPlayer:= TMediaPlayer.Create(Self);
      FMPlayer.FileName:= Path;
      FMPlayer.ParentWindow:= Application.Handle;
      Try
        FMPlayer.Open;
      Except end;
      FMPlayer.OnNotify:= MPlayerNotify;
      FKind:= stmSound;
      FFileName:= Path;
      With FBitMap do begin
        Width:= Self.Width;
        Height:= Self.Height;
        Canvas.Brush.Color:= clBlack;
        Canvas.FillRect(Rect(0, 0, Width, Height));
        Canvas.Font.Name:= 'Arial';
        Canvas.Font.Color:= clYellow;
        Canvas.Font.Size:= 10;
        Canvas.Font.Style:= [fsItalic, fsBold];
        Canvas.TextOut((Width div 2)-((Canvas.TextExtent('Som').cx) div 2), Trunc(0.1*Height), 'Som');
        Canvas.Font.Color:= clWhite;
        Canvas.Font.Style:= [];
        Canvas.Font.Size:= 8;
        If Canvas.TextExtent(ExtractFileName(FFileName)).cx > Width then
          Canvas.TextOut(Width-(Canvas.TextExtent(ExtractFileName(FFileName)).cx), Trunc(0.45*Height), ExtractFileName(FFileName))
        else Canvas.TextOut((Width div 2)-((Canvas.TextExtent(ExtractFileName(FFileName)).cx) div 2), Trunc(0.45*Height), ExtractFileName(FFileName));
      end;
    end;
  end;
  Repaint;
end;

procedure TChave.MPlayerNotify(Sender: TObject);
begin
  If Assigned(OnEndMedia) then FOnEndMedia(Self);
end;

end.
