unit uSess;

interface

uses Classes, Controls, SysUtils,
     uCfgSes, uRegData, uBlc;

type

  TSess = class(TComponent)
  private
    FRegData: TRegData;
    FBlc: TBlc;
    FCfgSes: TCfgSes;
    FIndBlc: Integer;
    FIndTent: Integer;
    FOnEndSess: TNotifyEvent;
    FSubjName: String;
    FSessName: String;
    FBackGround: TWinControl;
    FTestMode: Boolean;
    procedure BlcEndBlc(Sender: TObject);
    procedure EndSess;
    procedure SetBackGround(BackGround: TWinControl);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoEndSess;
    procedure Play(CfgSes: TCfgSes; FileData: String);
    procedure PlayBlc;
    property OnEndSess: TNotifyEvent read FOnEndSess write FOnEndSess;
    property BackGround: TWinControl read FBackGround write SetBackGround;
    property SessName: String write FSessName;
    property SubjName: String write FSubjName;
    property TestMode: Boolean write FTestMode;
  end;

implementation

procedure TSess.BlcEndBlc(Sender: TObject);
var a1: Integer; s1, s2: String;
begin
  If FBlc.NextBlc = 'end' then a1:= FCfgSes.NumBlc
  else begin
    s1:= FBlc.NextBlc;
    s2:= Copy(s1, 0, Pos(#32, s1)-1);
    a1:= StrToIntDef(s2, 0)-1;
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    FIndTent:= StrToIntDef(s1, 1)-1;
  end;

  If a1 > -1 then FIndBlc:= a1
  else begin
    Inc(FIndBlc);
    FIndTent:= 0;
  end;
  
  PlayBlc;
end;

procedure TSess.EndSess;
begin
  FRegData.SaveData('Hora de Término: '+ TimeToStr(Time) + #13#10);

  FRegData.Free;

  If Assigned(OnEndSess) then FOnEndSess(Self);
end;

procedure TSess.SetBackGround(BackGround: TWinControl);
begin
  FBackGround:= BackGround;
end;

constructor TSess.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);

  FBlc:= TBlc.Create(Self);
  With FBlc do begin
    OnEndBlc:= BlcEndBlc;
  end;
end;

destructor TSess.Destroy;
begin
  Inherited Destroy;
end;

procedure TSess.DoEndSess;
begin
  FRegData.SaveData(#13#10+'Sessão Cancelada' + #13#10);
  EndSess;
end;

procedure TSess.Play(CfgSes: TCfgSes; FileData: String);
begin
  FCfgSes:= CfgSes;

  If FileData = #0 then FileData:= 'Dados.txt';
  FRegData:= TRegData.Create(Self, FCfgSes.HootData+FileData);

  FBlc.RegData:= FRegData;
  FBlc.BackGround:= FBackGround;

  FRegData.SaveData('Sujeito: ' + FSubjName + #13#10);
  If FTestMode then FSessName:= FSessName + ' (Modo de Teste)';
  FRegData.SaveData('Sessão: ' + FSessName +  #13#10);
  FRegData.SaveData('Data: '+ DateTimeToStr(Date)+ #13#10);
  FRegData.SaveData('Hora de Início: '+ TimeToStr(Time)+ #13#10 + #13#10);

  FIndBlc:= 0;
  FIndTent:= 0;
  PlayBlc;
end;

procedure TSess.PlayBlc;
begin
  If FIndBlc < FCfgSes.NumBlc then FBlc.Play(FCfgSes.CfgBlc[FIndBlc], FIndTent, FTestMode)
  else EndSess;
end;

end.


