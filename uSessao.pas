unit uSessao;

interface

uses Windows, classes, controls, Sysutils, Graphics, Forms, extctrls, Dialogs,
     uCfgSes, uTentativa, uRegData, uBloco;

type
  TSessao = class(TComponent)
  private
    FCfgSes: TCfgSes;
    FIndBlc: Integer;
    FOnEndSess: TNotifyEvent;
    FRegData: TRegData;
    FSaveDialog: TSaveDialog;
    FSupport: TWinControl;
    FTentativa: TTentativa;
    FVetBloco: Array of TBloco;
    FCountRptBlc: Integer;
    procedure BlocoEndBlc(Sender: TObject; Datas: String; Result: Integer);
    procedure EndSessao;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure EnabledTS(Value: Boolean);
    procedure NextTent(Ind: Integer);
    procedure Play;
    procedure Reset(CfgSes: TCfgSes);
    property Support: TWinControl read FSupport write FSupport;
    property OnEndSess: TNotifyEvent read FOnEndSess write FOnEndSess;
  end;

implementation

uses fUnit1;

constructor TSessao.Create(AOwner: TComponent);
var s1: String;
begin
  Inherited Create(AOwner);
  FSaveDialog:= TSaveDialog.Create(Self);
  With FSaveDialog do begin
    DefaultExt:= 'xls';
    Filter:= 'Arquivo de texto com separadores de colunas (*.xls)|*.xls';
    FileName:= 'Dados.xls';
  end;
  If FSaveDialog.Execute then  s1:= FSaveDialog.FileName
  else s1:= 'Dados.xls';
  SetCurrentDir(CurPath);
  FRegData:= TRegData.Create(Self, s1);
  FTentativa:= TTentativa.Create(Self);
  FTentativa.Visible:= False;
end;

destructor TSessao.Destroy;
begin
  Inherited Destroy;
end;

procedure TSessao.NextTent(Ind: Integer);
begin
  FVetBloco[FIndBlc].NextTent(Ind);
end;

procedure TSessao.Play;
begin
  FTentativa.Visible:= True;
  If (FCountRptBlc < FCfgSes.VetBlc[FIndBlc].NumMaxExecBlc) then begin
    FVetBloco[FIndBlc].Reset(FCfgSes.VetBlc[FIndBlc], FTentativa);
    FVetBloco[FIndBlc].OnEndBlc:= BlocoEndBlc;
//    FVetBloco[FIndBlc].Play;
  end else EndSessao;
end;

procedure TSessao.Reset(CfgSes: TCfgSes);
var a1: Integer;
begin
  If Assigned(FCfgSes) then
    For a1:= 0 to FCfgSes.NumBlc-1 do FreeAndNil(FVetBloco[a1]);
  FIndBlc:= 0;
  FCfgSes:= CfgSes;
  FCountRptBlc:= 0;
  SetLength(FVetBloco, FCfgSes.NumBlc);
  FTentativa.Parent:= FSupport;
  FTentativa.Align:= alClient;
  FTentativa.SetCfgTent(FCfgSes.CfgTent);
  For a1:= 0 to FCfgSes.NumBlc-1 do
    FVetBloco[a1]:= TBloco.Create(Self);
end;

procedure TSessao.BlocoEndBlc(Sender: TObject; Datas: String; Result: Integer);
begin
  Datas:= FCfgSes.VetBlc[FIndBlc].Name+#10+Datas;
  FRegData.SaveData(Datas);

  If (Result > FCfgSes.VetBlc[FIndBlc].NumMaxErros) then begin
    Inc(FCountRptBlc);
    Play;
  end else begin
    If (FCfgSes.NumBlc-1 > FIndBlc) then begin
      Inc(FIndBlc);
      FCountRptBlc:= 0;
      Play;
    end else EndSessao;
  end;
end;

procedure TSessao.EndSessao;
begin
  FRegData.Free;
  If Assigned(OnEndSess) then FOnEndSess(Self);
end;

procedure TSessao.EnabledTS(Value: Boolean);
begin
  FTentativa.FEnabledTS:= Value;
end;

end.


