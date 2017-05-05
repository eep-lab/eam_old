unit uCfgSes;

interface

uses
  SysUtils, Classes, IniFiles, Types, IdGlobal;

type
  // CfgStm
  TCfgStm = record
    MatStm: Array [0..9] of Array [0..9] of String;
    VetStm: Array [0..49] of String;
  end;

  // CfgTentativa
  PCfgTent = ^TCfgTent;
  TCfgTent = record
    ChvMod: Array [0..8] of TRect;
    ChvCmp: Array [0..8] of TRect;
    ChvCsqCor: Array [0..1] of TRect;
    ChvCsqInc: Array [0..1] of TRect;    
  end;

  //Blocos
  TRefStm = record
    Conjunto: char;
    Classe: Integer;
    IndCsq: Integer;
    PStm: ^String;
  end;

  PTent = ^TTent;
  TTent = record
    Atraso: Integer;
    IndChvCor: Integer;
    CursorDeFundo: Smallint;
    CursorDasChaves: Smallint;
    CorDeFundo: Integer;
    TempoConseq: Integer;
    DuracaoMaxima: Integer;

    CanParalel: Boolean;
    Paralela: Array [0..1] of Integer;
    Modelo: Array [0..8] of TRefStm;
    Compar: Array [0..8] of TRefStm;
    CsqCor: Array [0..1] of TRefStm;
    CsqInc: Array [0..1] of TRefStm;
  end;

  PBlc = ^TBlc;
  TBlc = record
    Name: String;
    NumTent: Byte;
    ITI: Integer;
    NumMaxErros: Integer;
    NumMaxExecBlc: Integer;
    VetTent: Array of PTent;
  end;

  TCfgSes = class(TComponent)
  private
    { Private declarations }
    FCanParalel: Boolean;
    FCfgStm: TCfgStm;
    FCfgTent: TCfgTent;
    FName: String;
    FNumBlc: Byte;
    FVetBlc: Array of TBlc;
    function GetCfgTent: PCfgTent;
    function GetVetBlc(Index: Integer): PBlc;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromFile(Path: String);
    property CfgStm: TCfgStm read FCfgStm;
    property CfgTent: PCfgTent read GetCfgTent;
    property Name: String read FName;
    property NumBlc: Byte read FNumBlc;
    property VetBlc[Ind: Integer]: PBlc read GetVetBlc;
    property CanParalel: Boolean read FCanParalel write FCanParalel;
  end;

  function BinToInt(Value: String): Integer;

const
  S: String = '';

implementation

constructor TCfgSes.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
end;

destructor TCfgSes.Destroy;
begin
  Inherited Destroy;
end;

procedure TCfgSes.LoadFromFile(Path: String);
var
  IniFile: TIniFile;
  a1, a2, a3: Integer;
  atraso, curfnd, curchv, corfnd, durcsq, durtnt: Integer;
  indcnj, indcls: Integer;
  indcsq: Byte;
  s1, s2: String;
begin
  IniFile:= TIniFile.Create(Path);

  FName:= IniFile.ReadString('Sessão', 'Nome da Sessão', '');
  FNumBlc:= IniFile.ReadInteger('Sessão', 'Número de Blocos', 0);

// CfgStm
  For a1:= 0 to 9 do
    For a2:= 0 to 9 do
      FCfgStm.MatStm[a2, a1]:= 'Files\'+IniFile.ReadString('Estímulos', Chr(a2+65)+IntToStr(a1+1), '');

  For a1:= 0 to 49 do
    FCfgStm.VetStm[a1]:= 'Files\'+IniFile.ReadString('Conseqüências', 'CS'+IntToStr(a1+1), '');

// CfgTent
  For a1:= 0 to 8 do begin
    s1:= IniFile.ReadString('Posição das Chaves de Modelo', 'Chave de Modelo '+IntToStr(a1+1), '');
    FCfgTent.ChvMod[a1].Left:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    FCfgTent.ChvMod[a1].Top:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    FCfgTent.ChvMod[a1].Right:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 10);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    FCfgTent.ChvMod[a1].Bottom:= StrToIntDef(s1, 10);
  end;

  For a1:= 0 to 8 do begin
    s1:= IniFile.ReadString('Posição das Chaves de Comparação', 'Chave de Comparação '+IntToStr(a1+1), '0 0 0 0');
    FCfgTent.ChvCmp[a1].Left:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    FCfgTent.ChvCmp[a1].Top:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    FCfgTent.ChvCmp[a1].Right:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    FCfgTent.ChvCmp[a1].Bottom:= StrToIntDef(s1, 0);
  end;

  For a1:= 0 to 1 do begin
    s1:= IniFile.ReadString('Posição das Chaves de Conseqüência',
                            'Chave de Conseqüência para Resposta Correta '+IntToStr(a1+1), '0 0 0 0');
    FCfgTent.ChvCsqCor[a1].Left:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    FCfgTent.ChvCsqCor[a1].Top:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    FCfgTent.ChvCsqCor[a1].Right:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    FCfgTent.ChvCsqCor[a1].Bottom:= StrToIntDef(s1, 0);
  end;

  For a1:= 0 to 1 do begin
    s1:= IniFile.ReadString('Posição das Chaves de Conseqüência',
                            'Chave de Conseqüência para Resposta Incorreta '+IntToStr(a1+1), '0 0 0 0');
    FCfgTent.ChvCsqInc[a1].Left:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    FCfgTent.ChvCsqInc[a1].Top:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    FCfgTent.ChvCsqInc[a1].Right:= StrToIntDef(Copy(s1, 0, pos(' ', s1)-1), 0);
    Delete(s1, 1, pos(' ', s1)); If Length(s1)>0 then While s1[1]=' ' do Delete(s1, 1, 1);
    FCfgTent.ChvCsqInc[a1].Bottom:= StrToIntDef(s1, 0);
  end;

// Blocos
  SetLength(FVetBlc, FNumBlc);
  For a1:= 0 to FNumBlc-1 do begin
    FVetBlc[a1].Name:= IniFile.ReadString('Bloco'+IntToStr(a1+1), 'Nome do Bloco', '');
    FVetBlc[a1].NumTent:= IniFile.ReadInteger('Bloco'+IntToStr(a1+1), 'Número de Tentativas do Bloco', 0);
    FVetBlc[a1].NumMaxErros:= IniFile.ReadInteger('Bloco'+IntToStr(a1+1), 'Número Máximo de Erros no Bloco', 0);
    FVetBlc[a1].NumMaxExecBlc:= IniFile.ReadInteger('Bloco'+IntToStr(a1+1), 'Número Máximo de Execuções do Bloco', 0);
    FVetBlc[a1].ITI:= IniFile.ReadInteger('Bloco'+IntToStr(a1+1), 'Intervalo entre Tentativas (ITI)', 0);

    atraso:= IniFile.ReadInteger('Bloco'+IntToStr(a1+1), 'Atraso da Conseqüência', 0);
    curfnd:= IniFile.ReadInteger('Bloco'+IntToStr(a1+1), 'Tipo de Cursor de Fundo', -2);
    curchv:= IniFile.ReadInteger('Bloco'+IntToStr(a1+1), 'Tipo de Cursor para as Chaves', -2);
    corfnd:= IniFile.ReadInteger('Bloco'+IntToStr(a1+1), 'Cor de Fundo das Tentativas', 0);
    durcsq:= IniFile.ReadInteger('Bloco'+IntToStr(a1+1), 'Duração da Apresentação da Conseqüência Visual', 1000);
    durtnt:= IniFile.ReadInteger('Bloco'+IntToStr(a1+1), 'Duração Máxima da Tentativa', 0);

    SetLength(FVetBlc[a1].VetTent, FVetBlc[a1].NumTent);
    For a2:= 0 to FVetBlc[a1].NumTent-1 do begin
      new(FVetBlc[a1].VetTent[a2]);

      FVetBlc[a1].VetTent[a2].Atraso:= atraso;
      FVetBlc[a1].VetTent[a2].CursorDeFundo:= curfnd;
      FVetBlc[a1].VetTent[a2].CursorDasChaves:= curchv;
      FVetBlc[a1].VetTent[a2].CorDeFundo:= corfnd;
      FVetBlc[a1].VetTent[a2].TempoConseq:= durcsq;
      FVetBlc[a1].VetTent[a2].DuracaoMaxima:= durtnt;

      For a3:= 0 to 8 do begin
        s1:= IniFile.ReadString('Bloco'+IntToStr(a1+1), 'T'+IntToStr(a2+1)+' Chv Mod '+IntToStr(a3+1), '');
        If Length(s1) < 2 then s1:= '  ';
        FVetBlc[a1].VetTent[a2].Modelo[a3].Conjunto:= s1[1];
        FVetBlc[a1].VetTent[a2].Modelo[a3].Classe:= StrToIntDef(s1[2]+s1[3], 0);
        indcnj:= Ord(FVetBlc[a1].VetTent[a2].Modelo[a3].Conjunto)-65;
        indcls:= FVetBlc[a1].VetTent[a2].Modelo[a3].Classe-1;
        If ((indcnj>-1)and(indcnj<10)and(indcls>-1)and(indcls<10)) then
          FVetBlc[a1].VetTent[a2].Modelo[a3].PStm:= @FCfgStm.MatStm[indcnj, indcls]
        else FVetBlc[a1].VetTent[a2].Modelo[a3].PStm:= @S;
      end;

      For a3:= 0 to 8 do begin
        s1:= IniFile.ReadString('Bloco'+IntToStr(a1+1), 'T'+IntToStr(a2+1)+' Chv Cmp '+IntToStr(a3+1), '');
        If Length(s1) < 2 then s1:= '  ';
        FVetBlc[a1].VetTent[a2].Compar[a3].Conjunto:= s1[1];
        FVetBlc[a1].VetTent[a2].Compar[a3].Classe:= StrToIntDef(s1[2]+s1[3], 0);
        indcnj:= Ord(FVetBlc[a1].VetTent[a2].Compar[a3].Conjunto)-65;
        indcls:= FVetBlc[a1].VetTent[a2].Compar[a3].Classe-1;
        If ((indcnj>-1)and(indcnj<10)and(indcls>-1)and(indcls<10)) then
          FVetBlc[a1].VetTent[a2].Compar[a3].PStm:= @FCfgStm.MatStm[indcnj, indcls]
        else FVetBlc[a1].VetTent[a2].Compar[a3].PStm:= @S;
      end;

      FVetBlc[a1].VetTent[a2].IndChvCor:= IniFile.ReadInteger('Bloco'+IntToStr(a1+1),
                                                              'T'+IntToStr(a2+1)+' Número da Chave Correta', 0)-1;

      For a3:= 0 to 1 do begin
        s1:= IniFile.ReadString('Bloco'+IntToStr(a1+1), 'T'+IntToStr(a2+1)+' Chv Csq Correta '+IntToStr(a3+1), '');
        If Length(s1) < 2 then s1:= '    ';
        FVetBlc[a1].VetTent[a2].CsqCor[a3].IndCsq:= StrToIntDef(s1[3]+s1[4], 0);
        indcsq:= FVetBlc[a1].VetTent[a2].CsqCor[a3].IndCsq-1;
        If indcsq < 50 then
          FVetBlc[a1].VetTent[a2].CsqCor[a3].PStm:= @FCfgStm.VetStm[indcsq]
        else FVetBlc[a1].VetTent[a2].CsqCor[a3].PStm:= @S;
      end;

      For a3:= 0 to 1 do begin
        s1:= IniFile.ReadString('Bloco'+IntToStr(a1+1), 'T'+IntToStr(a2+1)+' Chv Csq Incorreta '+IntToStr(a3+1), '');
        If Length(s1) < 2 then s1:= '    ';
        FVetBlc[a1].VetTent[a2].CsqInc[a3].IndCsq:= StrToIntDef(s1[3]+s1[4], 0);
        indcsq:= FVetBlc[a1].VetTent[a2].CsqInc[a3].IndCsq-1;
        If indcsq < 50 then
          FVetBlc[a1].VetTent[a2].CsqInc[a3].PStm:= @FCfgStm.VetStm[indcsq]
        else FVetBlc[a1].VetTent[a2].CsqInc[a3].PStm:= @S;
      end;

      s1:= IniFile.ReadString('Bloco'+IntToStr(a1+1), 'T'+IntToStr(a2+1)+' Paralel Correta', '');
      FVetBlc[a1].VetTent[a2].Paralela[0]:= BinToInt(s1);

      s2:= IniFile.ReadString('Bloco'+IntToStr(a1+1), 'T'+IntToStr(a2+1)+' Paralel Incorreta', '');
      FVetBlc[a1].VetTent[a2].Paralela[1]:= BinToInt(s2);

      FVetBlc[a1].VetTent[a2].CanParalel:= ((Length(s1)=8)or(Length(s2)=8)) and FCanParalel;

    end;
  end;
end;

function TCfgSes.GetCfgTent: PCfgTent;
begin
  Result:= @FCfgTent;
end;

function TCfgSes.GetVetBlc(Index: Integer): PBlc;
begin
  If (Index > -1) and (Index < FNumBlc) then Result:= @FVetBlc[Index]
  else Result:= nil;
end;

function BinToInt(Value: String): Integer;
var a1: Integer;
begin
  Result:= 0;
  If Length(Value)=8 then
    For a1:= 0 to 255 do
      If Copy(IntToBin(a1), 25, 8) = Value then begin
        Result:= a1;
        Break;
      end;
end;

end.



