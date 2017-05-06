unit uKey;

interface

uses Controls, Graphics, Classes, SysUtils, Jpeg, MPlayer, Forms,
     uSchMan;

type
  TKind = (stmNone, stmImage, stmSound);

  TKey = class(TGraphicControl)
  private
    FOnResponse: TNotifyEvent;
    FSchMan: TSchMan;
    FBitMap: TBitMap;
    FBorderColor: TColor;
    FFileName: String;
    FKind: TKind;
    FMPlayer: TMediaPlayer;
    FOnEndMedia: TNotifyEvent;
    procedure SetFileName(Path: String);
    procedure MPlayerNotify(Sender: TObject);
    procedure SchReinforce(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Play;
    procedure Stop;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    property BorderColor: TColor read FBorderColor write FBorderColor;
    property FileName: String read FFileName write SetFileName;
    property Kind: TKind read FKind;
    property OnClick;
    property OnMouseDown;
    property OnResponse: TNotifyEvent read FOnResponse write FOnResponse;
    property OnEndMedia: TNotifyEvent read FOnEndMedia write FOnEndMedia;
    property SchMan: TSchMan read FSchMan;
  end;

implementation

constructor TKey.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  Height:= 45;
  Width:= 60;
  FBitMap:= TBitMap.Create;

  FSchMan:= TSchMan.Create(Self);
  With FSchMan do begin
    OnReinforce:= SchReinforce;
  end;
end;

destructor TKey.Destroy;
begin
  If Assigned(FMPlayer) then begin
    FMPlayer.Close;
    FreeAndNil(FMPLayer);
  end;
  FBitMap.Free;
  Inherited Destroy;
end;

procedure TKey.Paint;
begin
  With Canvas do begin
    StretchDraw(Rect(0, 0, Width, Height), FBitMap);
//    Brush.Color:= clRed;//FBorderColor;
//    FrameRect(Rect(0, 0, Width, Height));
  end;
end;

procedure TKey.Play;
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

procedure TKey.Stop;
begin
  If Assigned(FMPlayer) then
    If FMPlayer.Mode = mpPlaying then
      FMPlayer.Stop;
end;

procedure TKey.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Inherited MouseDown(Button, Shift, X, Y);
  FSchMan.DoResponse;
end;

procedure TKey.SetFileName(Path: String);
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
        Try
          FMPlayer.Open;
        Except end;
        FMPlayer.OnNotify:= MPlayerNotify;
        FKind:= stmSound;
        FFileName:= Path;
      Except end;
  end;
  Repaint;
end;

procedure TKey.MPlayerNotify(Sender: TObject);
begin
  If Assigned(OnEndMedia) then FOnEndMedia(Self);
end;

procedure TKey.SchReinforce(Sender: TObject);
begin
  If Assigned(OnResponse) then FOnResponse(Self);
end;

end.
