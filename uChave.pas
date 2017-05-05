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
    property FileName: String read FFileName write SetFileName;
    property Kind: TKind read FKind;
    property OnClick;
    property OnMouseDown;
    property OnEndMedia: TNotifyEvent read FOnEndMedia write FOnEndMedia;
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
    FreeAndNil(FMPLayer);
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
    If s1 = '.WAV' then
      Try
        FMPlayer:= TMediaPlayer.Create(Self);
        FMPlayer.FileName:= Path;
        FMPlayer.ParentWindow:= Application.Handle;
        FMPlayer.Open;
        FMPlayer.OnNotify:= MPlayerNotify;
        FKind:= stmSound;
        FFileName:= Path;
      Except end;
  end;
  Repaint;
end;

procedure TChave.MPlayerNotify(Sender: TObject);
begin
  If Assigned(OnEndMedia) then FOnEndMedia(Self);
end;

end.
