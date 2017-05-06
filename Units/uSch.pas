unit uSch;

interface

uses Classes, SysUtils;

type
  TAbsSch = class(TComponent)
  private
    FOnReinforce: TNotifyEvent;
    FValue: Integer;
    FVariation: Integer;
  public
    procedure Clock; virtual; abstract;
    procedure DoResponse; virtual; abstract;
    procedure Reset; virtual; abstract;
    property OnReinforce: TNotifyEvent read FOnReinforce write FOnReinforce;
    property Value: Integer read FValue write FValue;
    property Variation: Integer read FVariation write FVariation;
  end;

  TSchRR = class(TAbsSch)
  private
    FCountResp: Integer;
    FNumResp: Integer;
  public
    procedure Clock; override;
    procedure DoResponse; override;
    procedure Reset; override;
  end;

  TSchRI = class(TAbsSch)
  private
    FFlagFirst: Boolean;
    FFlagReinf: Boolean;
    FInterval: Integer;
    FTimeCount: Integer;
    procedure Reinf;
    procedure SetInterval;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Clock; override;
    procedure DoResponse; override;
    procedure Reset; override;
  end;

  TSchRT = class(TAbsSch)
  private
    FCountTime: Integer;
    FInterval: Integer;
  public
    procedure Clock; override;
    procedure DoResponse; override;
    procedure Reset; override;
  end;

  TSchDRL = class(TAbsSch)
  private
    FCountTime: Integer;
    FFlagTime: Boolean;
    FInterval: Integer;
  public
    procedure Clock; override;
    procedure DoResponse; override;
    procedure Reset; override;
  end;

implementation

procedure TSchRR.Clock;
begin

end;

procedure TSchRR.DoResponse;
begin
  Inc(FCountResp);
  If FCountResp = FNumResp then begin
    FCountResp:= 0;
    FNumResp:= FValue-FVariation+Random((2*Variation)+1);
    If Assigned(OnReinforce) then FOnReinforce(Self);
  end;
end;

procedure TSchRR.Reset;
begin
  FCountResp:= 0;
  FNumResp:= FValue-FVariation+Random((2*Variation)+1);
end;

procedure TSchDRL.Clock;
begin
  If FFlagTime then
    Inc(FCountTime);
end;

procedure TSchDRL.DoResponse;
begin
  If not FFlagTime then
    FFlagTime:= True;
  If FInterval <= FCountTime then begin
    FCountTime:= 0;
    FInterval:= FValue-FVariation+Random((2*Variation)+1);
    If Assigned(OnReinforce) then FOnReinforce(Self);
  end else begin
    FCountTime:= 0;
  end;
end;

procedure TSchDRL.Reset;
begin
  FCountTime:= 0;
  FFlagTime:= False;
  FInterval:= FValue-FVariation+Random((2*Variation)+1);
end;

procedure TSchRT.Clock;
begin
  Inc(FCountTime);
  If FCountTime >= FInterval then
    If Assigned(OnReinforce) then FOnReinforce(Self);
end;

procedure TSchRT.DoResponse;
begin

end;

procedure TSchRT.Reset;
begin
  FCountTime:= 0;
  FInterval:= FValue-FVariation+Random((2*Variation)+1);
end;

constructor TSchRI.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FFlagFirst:= True;
  FFlagReinf:= False;
end;

procedure TSchRI.SetInterval;
begin
  FInterval:= FValue-FVariation+(Random((2*FVariation)+1));
end;

procedure TSchRI.DoResponse;
begin
  If FFlagFirst then begin
    SetInterval;
    FFlagFirst:= False;
  end;
  If FFlagReinf then Reinf;
end;

procedure TSchRI.Reset;
begin

end;

procedure TSchRI.Clock;
begin
  If not FFlagFirst then begin
    Inc(FTimeCount);
    FFlagReinf:= FTimeCount >= FInterval;
  end;
end;

procedure TSchRI.Reinf;
begin
  FFlagReinf:= False;
  SetInterval;
  FTimeCount:= 0;
  If Assigned(FOnReinforce) then FOnReinforce(Self);
  FFlagReinf:= FInterval = 0;
end;

end.

