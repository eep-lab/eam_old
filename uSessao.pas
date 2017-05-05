unit uSessao;

interface

uses Windows, classes, controls, Sysutils, Graphics, Forms,
     uCfgSes, uAbsTent, uChave, uSett1100, uSett1200, extctrls, 
     Dialogs;

type
  PTent = ^TTent;

  TSessao = class(TComponent)
  private
    FEfeitoSonoro: Boolean;
    FEndSess: TNotifyEvent;
    FIndBlc: Integer;
    FIndTent: Integer;
    FNumData: Integer;
    FOutputFile: String;
    FSaveData: Boolean;
    FSessionName: String;
    FSourcePath: String;
    FSubjectsName: String;
    FSuportTent: TWinControl;
    FTent: TAbstractTentativa;
    FTimer1: TTimer;
    FVetData: Array of TDatas;
    FVetTent: Array of TAbstractTentativa;
    procedure EndBlc;
    procedure EndTent(Sender: TObject; Datas: TDatas);
    procedure EndSess;
    procedure LoadSession;
    procedure TentEndSes(Sender: TObject);
    procedure RunBlc(IndBlc, IndTent: Integer);
    procedure SaveDataToFile;
    procedure SetTentativa(Tent: TAbstractTentativa;IndSeq, IndTent: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure WriteDatas(Datas: TDatas);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Play;
    property EfeitoSonoro: Boolean read FEfeitoSonoro write FEfeitoSonoro;
    property SessionName: String read FSessionName write FSessionName;
    property SaveData: Boolean read FSaveData write FSaveData;
    property SourcePath: String read FSourcePath write FSourcePath;
    property SubjectsName: String read FSubjectsName write FSubjectsName;
    property SuportTent: TWinControl read FSuportTent write FSuportTent;
    property OnEndSess: TNotifyEvent read FEndSess write FEndSess;
    property OutputFile: String read FOutputFile write FOutputFile;
  end;

const
  DataLabels: Array [0..15] of String = ('Número da Tentativa',
    'Posição do Modelo', 'Posição Correta', 'Posição da Resposta',
    'Nome do Modelo', 'Nome Correto', 'Nome da Resposta',
    'Arquivo do Modelo', 'Arquivo Correto', 'Arquivo da Resposta',
    'Resposta Correta/Errada', 'Reforço Programado', 'Reforço Liberado',
    'Latência',
    'Sujeito: ', 'Sessão: ');
  Mensagem1: String = 'Não foi possível salvar os dados. '+
    'Possivelmente o arquivo de dados esteja sendo utilizado '+
    'por outro aplicativo. Feche-o agora e clique em OK para salvar os dados.';

implementation

uses fUnit1;

constructor TSessao.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FTimer1:= TTimer.Create(Self);
  With FTimer1 do begin
    Enabled:= False;
    OnTimer:= Timer1Timer;
    Interval:= 0;
  end;
  SetLength(FVetTent, 2);
  FVetTent[0]:= TSett1100.Create(Self);
  FVetTent[1]:= TSett1200.Create(Self);
end;

destructor TSessao.Destroy;
begin
  Inherited Destroy;
end;

procedure TSessao.LoadSession;
var a1, a2, a3, a4: Integer;
begin
  For a1:= 0 to CfgSes.NumSeq-1 do begin
    For a2:= 0 to CfgSes.Seq[a1].NumTent-1 do begin
      For a3:= 0 to CfgSes.Seq[a1].VetTent[a2].NumListChv-1 do
        For a4:= 0 to CfgSes.Seq[a1].VetTent[a2].VetListChv[a3].NumPtStm-1 do
          With CfgSes.Seq[a1].VetTent[a2].VetListChv[a3].VetPtStm[a4] do begin
            If not Assigned(CfgSes.CfgStm[IndCfgStm].MatStm[Col, Lin].Chave) then begin
              CfgSes.CfgStm[IndCfgStm].MatStm[Col, Lin].Chave:= TChave.Create(Self);
              CfgSes.CfgStm[IndCfgStm].MatStm[Col, Lin].Chave.FileName:=
                 FSourcePath+CfgSes.CfgStm[IndCfgStm].MatStm[Col, Lin].FileName;
              CfgSes.CfgStm[IndCfgStm].MatStm[Col, Lin].Chave.LabelStm:=
                             CfgSes.CfgStm[IndCfgStm].MatStm[Col, Lin].LabelStm;
            end;
          end;
    end;
  end;
end;

procedure TSessao.Play;
begin
  FIndBlc:= 0;
  FIndTent:= 0;
  LoadSession;
  RunBlc(FIndBlc, FIndTent);
end;

procedure TSessao.EndBlc;
begin
  Inc(FIndBlc);
  FIndTent:= 0;
  If FIndBlc < CfgSes.NumBlc then begin
    RunBlc(FIndBlc, 0);
  end else EndSess;
end;

procedure TSessao.EndTent(Sender: TObject; Datas: TDatas);
begin
  WriteDatas(Datas);
  With TAbstractTentativa(Sender) do begin
    Visible:= False;
    Inc(FIndTent);
    If FTimer1.Interval > 0 then FTimer1.Enabled:= True
    else RunBlc(FIndBlc, FIndTent);
  end;
end;

procedure TSessao.TentEndSes(Sender: TObject);
begin
  EndSess;
end;

procedure TSessao.EndSess;
begin
  FSuportTent.Visible:= False;
  SaveDataToFile;
  If Assigned(OnEndSess) then FEndSess(Self);
end;

procedure TSessao.SetTentativa(Tent: TAbstractTentativa;IndSeq, IndTent: Integer);
var s1: String; a1, a2: Integer;
begin
  s1:= FSourcePath;
  With Tent do begin
    Reset;
    OnEndTent:= EndTent;
    OnEndSes:= TentEndSes;
    Align:= alClient;
    ID:= FIndTent;
    EfeitoSonoro:= Self.EfeitoSonoro;
    For a1:= 0 to CfgSes.Seq[IndSeq].VetTent[IndTent].NumListPar-1 do
      For a2:= 0 to CfgSes.Seq[IndSeq].VetTent[IndTent].VetListPar[a1].NumPar-1 do
        MatPar[a1, a2]:= CfgSes.Seq[IndSeq].VetTent[IndTent].VetListPar[a1].VetPar[a2];
    For a1:= 0 to CfgSes.Seq[IndSeq].VetTent[IndTent].NumListChv-1 do
      For a2:= 0 to CfgSes.Seq[IndSeq].VetTent[IndTent].VetListChv[a1].NumPtStm-1 do begin
        With CfgSes.Seq[IndSeq].VetTent[IndTent].VetListChv[a1].VetPtStm[a2] do
          InsertChv(a1, a2, CfgSes.CfgStm[IndCfgStm].MatStm[Col, Lin].Chave);
        If Assigned(MatChv[a1, a2]) then
          With CfgSes.CfgTent[CfgSes.Seq[IndSeq].IndCfgTent].VetListCfgChv[a1].VetCfgChv[a2] do begin
            MatChv[a1, a2].AutoSize:= AutoSize;
            MatChv[a1, a2].BorderColor:= BorderColor;

            MatChv[a1, a2].plWidth:= Width;
            MatChv[a1, a2].plHeight:= Height;

            MatChv[a1, a2].plLeft:= Left;
            MatChv[a1, a2].plTop:= Top;

            MatChv[a1, a2].Alignment:= Alignment;

            MatChv[a1, a2].ShowBorder:= ShowBorder;
            MatChv[a1, a2].Transparent:= Transparent;

            MatChv[a1, a2].LabelChv:= LabelChv;
          end;
    end;
    Parent:= FSuportTent;
  end;
end;

procedure TSessao.Timer1Timer(Sender: TObject);
begin
  FTimer1.Enabled:= False;
  RunBlc(FIndBlc, FIndTent);
end;

procedure TSessao.RunBlc(IndBlc, IndTent: Integer);
begin
  If IndBlc < CfgSes.NumBlc then begin
    If IndTent < CfgSes.Blc[IndBlc].NumTent then begin
      FTimer1.Interval:= CfgSes.Blc[IndBlc].ITI;
      With CfgSes.Blc[IndBlc].VetPtTent[IndTent] do begin
        If (CfgSes.CfgTent[CfgSes.Seq[IndSeq].IndCfgTent].Script > -1) and
           (CfgSes.CfgTent[CfgSes.Seq[IndSeq].IndCfgTent].Script < Length(FVetTent)) then
          FTent:= FVetTent[CfgSes.CfgTent[CfgSes.Seq[IndSeq].IndCfgTent].Script];
        SetTentativa(FTent, IndSeq, IndTent);
      end;
      FTent.Visible:= True;
      FTent.Play;
    end else EndBlc;
  end else EndBlc;
end;

procedure TSessao.SaveDataToFile;
var a1, a2: Integer; Arq: TextFile;
begin
  If DirectoryExists(ExtractFilePath(FOutputFile)) then begin
    AssignFile(Arq, FOutputFile);
    Try
      Rewrite(Arq);
      For a1:= 0 to 13 do begin
        Write(Arq, DataLabels[a1]);
        Write(Arq, #9);
      end;
      Write(Arq, DataLabels[14]+FSubjectsName);
      Write(Arq, #9);
      WriteLn(Arq, DataLabels[15]+FSessionName);

      For a1:= 0 to FNumData-1 do begin
        For a2:= 0 to 12 do begin
          Write(Arq, FVetData[a1, a2]);
          Write(Arq, #9);
        end;
        WriteLn(Arq, FVetData[a1, 13]);
      end;
    Except
      If MessageDlg(Mensagem1, mtError, [mbOK, mbCancel], 0) = 1 then begin
        SaveDataToFile;
      end;
      Exit;
    end;
    CloseFile(Arq);
  end;
  FNumData:= 0;
end;

procedure TSessao.WriteDatas(Datas: TDatas);
var a1: Integer;
begin
  Inc(FNumData);
  SetLength(FVetData, FNumData, Length(Datas));
  FVetData[FNumData-1, 0]:= IntToStr(FNumData);
  For a1:= 1 to High(Datas) do
    FVetData[FNumData-1, a1]:= Datas[a1];
end;

end.


