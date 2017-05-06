unit uSchMan;

interface

uses Classes, SysUtils,
     uSch;

type
  TSchMan = class(TComponent)
  protected
    FAbsSch: TAbsSch;
    FAbsSchLoaded: Boolean;
    FOnReinforce: TNotifyEvent;

    procedure AbsSchReinforce(Sender: TObject);
    procedure SetKind(Kind: String);
  public
    procedure Clock;
    procedure DoResponse;
    procedure Play;

    property Kind: String write SetKind;
    property OnReinforce: TNotifyEvent read FOnReinforce write FOnReinforce;
  end;

implementation

procedure TSchMan.AbsSchReinforce(Sender: TObject);
begin
  If Assigned(OnReinforce) then FOnReinforce(Self);
end;

procedure TSchMan.SetKind(Kind: String);
var s1, s2, s3: String;
begin
  If FAbsSchLoaded then begin
    FAbsSch.Free;
    FAbsSchLoaded:= False;
  end;

  Kind:= Kind+#32;
  s1:= Copy(Kind, 0, Pos(#32, Kind)-1);
  Delete(Kind, 1, pos(#32, Kind)); If Length(Kind)>0 then While Kind[1]=' ' do Delete(Kind, 1, 1);
  s2:= Copy(Kind, 0, Pos(#32, Kind)-1);
  Delete(Kind, 1, pos(#32, Kind)); If Length(Kind)>0 then While Kind[1]=' ' do Delete(Kind, 1, 1);
  s3:= Copy(Kind, 0, Pos(#32, Kind)-1);

  If s1 = 'CRF' then begin
    FAbsSch:= TSchRR.Create(Self);
    FAbsSch.Value:= 1;
    FAbsSch.Variation:= 0;
  end;

  If (s1 = 'FR') or (s1 = 'FI') or (s1 = 'FT') then begin
    If s1 = 'FR' then FAbsSch:= TSchRR.Create(Self);
    If s1 = 'FI' then FAbsSch:= TSchRI.Create(Self);
    If s1 = 'FT' then FAbsSch:= TSchRT.Create(Self);

    FAbsSch.Value:= StrToIntDef(s2, 0);
    FAbsSch.Variation:= 0;
  end;

  If (s1 = 'RR') or (s1 = 'RI') or (s1 = 'RT') then begin
    If s1 = 'RR' then FAbsSch:= TSchRR.Create(Self);
    If s1 = 'RI' then FAbsSch:= TSchRI.Create(Self);
    If s1 = 'RT' then FAbsSch:= TSchRT.Create(Self);

    FAbsSch.Value:= StrToIntDef(s2, 0);
    FAbsSch.Variation:= StrToIntDef(s3, 0);
  end;

  If s1 = 'DRL' then begin
    FAbsSch:= TSchDRL.Create(Self);
    FAbsSch.Value:= StrToIntDef(s2, 0);
  end;

  FAbsSchLoaded:= Assigned(FAbsSch);

  If FAbsSchLoaded then begin
    FAbsSch.OnReinforce:= AbsSchReinforce;
    FAbsSch.Reset;
  end;
end;

procedure TSchMan.Clock;
begin
  If FAbsSchLoaded then
    FAbsSch.Clock;
end;

procedure TSchMan.DoResponse;
begin
  If FAbsSchLoaded then
    FAbsSch.DoResponse;
end;

procedure TSchMan.Play;
begin
  If FAbsSchLoaded then
    FAbsSch.Reset;
end;

end.

