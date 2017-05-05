unit uCfgSes;

interface

uses
  SysUtils, IniFiles, Classes, Types;

type
  TCfgCsq = class(TComponent)
  private
    FInd: Integer;
    FIniFile: TIniFile;
    function GetChv_Bounds(Ind: Integer): TRect;
    function GetChv_FileName(Ind: Integer): String;
    function GetNumChv: Integer;
    function GetParl_Time: Integer;
    function GetParl_Value: Integer;
  public
    constructor Create(IniFile: TIniFile); reintroduce;
    destructor Destroy; override;
    property Chv_Bounds[Ind: Integer]: TRect read GetChv_Bounds;
    property Chv_FileName[Ind: Integer]: String read GetChv_FileName;
    property Ind: Integer read FInd write FInd;
    property NumChv: Integer read GetNumChv;
    property Parl_Time: Integer read GetParl_Time;
    property Parl_Value: Integer read GetParl_Value;
  end;

  TCfgTent = class(TComponent)
  private
    FInd: Integer;
    FIndSeq: Integer;
    FIniFile: TIniFile;
  public
    constructor Create(IniFile: TIniFile); reintroduce;
    destructor Destroy; override;
    procedure ReadCfg(SList: TStrings);
    property Ind: Integer read FInd write FInd;
    property IndSeq: Integer read FIndSeq write FIndSeq;
  end;

  TRefTent = class(TComponent)
  private
    FInd: Integer;
    FIndBlc: Integer;
    FIniFile: TIniFile;
    function GetCrt_Act(Ind: Integer): String;
    function GetCrt_Msg(Ind: Integer): String;
    function GetCrt_IndBlc(Ind: Integer): Integer;
    function GetCrt_IndTent(Ind: Integer): Integer;
    function GetIndSeq: Integer;
    function GetIndTent: Integer;
    function GetNumCrt: Integer;
  public
    constructor Create(IniFile: TIniFile); reintroduce;
    destructor Destroy; override;
    property Crt_Act[Ind: Integer]: String read GetCrt_Act;
    property Crt_Msg[Ind: Integer]: String read GetCrt_Msg;
    property Crt_IndBlc[Ind: Integer]: Integer read GetCrt_IndBlc;
    property Crt_IndTent[Ind: Integer]: Integer read GetCrt_IndTent;
    property Ind: Integer read FInd write FInd;
    property IndBlc: Integer read FIndBlc write FIndBlc;
    property IndSeq: Integer read GetIndSeq;
    property IndTent: Integer read GetIndTent;
    property NumCrt: Integer read GetNumCrt;
  end;

  TCfgSeq = class(TComponent)
  private
    FCfgTent: TCfgTent;
    FInd: Integer;
    FIniFile: TIniFile;
    function GetCfgTent(Ind: Integer): TCfgTent;

    function GetChvCmp_Bounds(Ind: Integer): TRect;
    function GetChvMod_Bounds: TRect;

    function GetComents: String;
    function GetName: String;
    function GetType_: String;

    function GetNumTent: Integer;
    function GetValue(AName: String): String;

    procedure SetComents(AComent: String);
    procedure SetName(AName: String); reintroduce;
    procedure SetType_(AType: String);
    procedure SetValue(AName, AValue: String);
  public
    constructor Create(IniFile: TIniFile); reintroduce;
    destructor Destroy; override;
    procedure ReadCfg(SList: TStrings);
    property CfgTent[Ind: Integer]: TCfgTent read GetCfgTent;
    property ChvCmp_Bounds[Ind: Integer]: TRect read GetChvCmp_Bounds;
    property ChvMod_Bounds: TRect read GetChvMod_Bounds;
    property Coments: String read GetComents write SetComents;
    property Ind: Integer read FInd write FInd;
    property Name: String read GetName write SetName;
    property NumTent: Integer read GetNumTent;
    property Type_: String read GetType_ write SetType_;
    property Value[AName: String]: String read GetValue write SetValue;
  end;

  TCfgBlc = class(TComponent)
  private
    FInd: Integer;
    FIniFile: TIniFile;
    FRefTent: TRefTent;
    function GetColor: Integer;
    function GetITI: Integer;
    function GetNome: String;
    function GetNumTent: Integer;
    function GetRefTent(Ind: Integer): TRefTent;
  public
    constructor Create(IniFile: TIniFile); reintroduce;
    destructor Destroy; override;
    property Color: Integer read GetColor;
    property Ind: Integer read FInd write FInd;
    property ITI: Integer read GetITI;
    property Nome: String read GetNome;
    property NumTent: Integer read GetNumTent;
    property RefTent[Ind: Integer]: TRefTent read GetRefTent;
  end;

  TMatStm = class(TComponent)
  private
    FIniFile: TIniFile;
    FResPath: String;
  public
    constructor Create(IniFile: TIniFile); reintroduce;
    destructor Destroy; override;
    function GetFileName(Key: String): String; overload;
    function GetFileName(IndCnj, IndCls: Integer): String; overload;
    function GetFullFileName(Key: String): String; overload;
    function GetFullFileName(IndCnj, IndCls: Integer): String; overload;
    procedure ReadCfg(SList: TStrings);
    procedure SetFileName(IndCnj, IndCls: Integer; AName: String);
    property ResPath: String read FResPath write FResPath;
  end;

  TCfgSes = class(TIniFile)
  private
    { Private declarations }
    FCfgBlc: TCfgBlc;
    FCfgCsq: TCfgCsq;
    FCfgSeq: TCfgSeq;
    FMatStm: TMatStm;
    function GetCfgBlc(Ind: Integer): TCfgBlc;
    function GetCfgCsq(Ind: Integer): TCfgCsq;
    function GetCfgSeq(Ind: Integer): TCfgSeq;
    function GetCfgSeqByName(AName: String): TCfgSeq;
    function GetMatStm: TMatStm;
    function GetNome: String;
    function GetNumCfgBlc: Integer;
    function GetNumCfgSeq: Integer;
    function GetNumCfgCsq: Integer;
  public
    { Public declarations }
    constructor Create(FileName: String);
    destructor Destroy; override;
    function NewCfgSeq(AName: String): String;
    function SetSeqName(AName: String; Ind: Integer): Boolean;
    procedure DeleteSeq(Ind: Integer);
    property CfgBlc[Ind: Integer]: TCfgBlc read GetCfgBlc;
    property CfgCsq[Ind: Integer]: TCfgCsq read GetCfgCsq;

    property CfgSeq[Ind: Integer]: TCfgSeq read GetCfgSeq;
    property CfgSeqByName[AName: String]: TCfgSeq read GetCfgSeqByName;

    property MatStm: TMatStm read GetMatStm;
    property Nome: String read GetNome;
    property NumCfgBlc: Integer read GetNumCfgBlc;
    property NumCfgCsq: Integer read GetNumCfgCsq;
    property NumCfgSeq: Integer read GetNumCfgSeq;
  end;

implementation

function TCfgCsq.GetChv_Bounds(Ind: Integer): TRect;
begin
  Result.Left:= FIniFile.ReadInteger('Csq '+IntToStr(FInd), 'Chv'+IntToStr(Ind)+'.L', 0);
  Result.Top:= FIniFile.ReadInteger('Csq '+IntToStr(FInd), 'Chv'+IntToStr(Ind)+'.T', 0);
  Result.Right:= FIniFile.ReadInteger('Csq '+IntToStr(FInd), 'Chv'+IntToStr(Ind)+'.W', 0);
  Result.Bottom:= FIniFile.ReadInteger('Csq '+IntToStr(FInd), 'Chv'+IntToStr(Ind)+'.H', 0);
end;

function TCfgCsq.GetChv_FileName(Ind: Integer): String;
begin
  Result:= FIniFile.ReadString('Csq '+IntToStr(FInd), 'Chv'+IntToStr(Ind)+'.FileName', '');
end;

function TCfgCsq.GetNumChv: Integer;
begin
  Result:= FIniFile.ReadInteger('Csq '+IntToStr(FInd), 'NumChv', 0);
end;

function TCfgCsq.GetParl_Time: Integer;
begin
  Result:= FIniFile.ReadInteger('Csq '+IntToStr(FInd), 'Parl.Time', 0);
end;

function TCfgCsq.GetParl_Value: Integer;
begin
  Result:= FIniFile.ReadInteger('Csq '+IntToStr(FInd), 'Parl.Value', 0);
end;

constructor TCfgCsq.Create(IniFile: TIniFile);
begin
  Inherited Create(nil);
  FIniFile:= IniFile;
end;

destructor TCfgCsq.Destroy; 
begin
  Inherited Destroy;
end;

constructor TCfgTent.Create(IniFile: TIniFile);
begin
  Inherited Create(nil);
  FIniFile:= IniFile;
end;

destructor TCfgTent.Destroy;
begin
  Inherited Destroy;
end;

procedure TCfgTent.ReadCfg(SList: TStrings);
begin
  FIniFile.ReadSectionValues('S'+IntToStr(FIndSeq)+'T'+IntToStr(FInd), SList);
end;

function TRefTent.GetCrt_Act(Ind: Integer): String;
begin
  Result:= FIniFile.ReadString('B'+IntToStr(FIndBlc)+'T'+IntToStr(FInd), 'Crt'+IntToStr(Ind)+'.Act', '');
end;

function TRefTent.GetCrt_Msg(Ind: Integer): String;
begin
  Result:= FIniFile.ReadString('B'+IntToStr(FIndBlc)+'T'+IntToStr(FInd), 'Crt'+IntToStr(Ind)+'.Msg', '');
end;

function TRefTent.GetCrt_IndBlc(Ind: Integer): Integer;
begin
  Result:= FIniFile.ReadInteger('B'+IntToStr(FIndBlc)+'T'+IntToStr(FInd), 'Crt'+IntToStr(Ind)+'.IndBlc', 0);
end;

function TRefTent.GetCrt_IndTent(Ind: Integer): Integer;
begin
  Result:= FIniFile.ReadInteger('B'+IntToStr(FIndBlc)+'T'+IntToStr(FInd), 'Crt'+IntToStr(Ind)+'.IndTent', 0);
end;

function TRefTent.GetIndSeq: Integer;
begin
  Result:= FIniFile.ReadInteger('B'+IntToStr(FIndBlc)+'T'+IntToStr(FInd), 'IndSeq', -1);
end;

function TRefTent.GetIndTent: Integer;
begin
  Result:= FIniFile.ReadInteger('B'+IntToStr(FIndBlc)+'T'+IntToStr(FInd), 'IndTent', -1);
end;

function TRefTent.GetNumCrt: Integer;
begin
  Result:= FIniFile.ReadInteger('B'+IntToStr(FIndBlc)+'T'+IntToStr(FInd), 'NumCrt', 0);
end;

constructor TRefTent.Create(IniFile: TIniFile);
begin
  Inherited Create(nil);
  FIniFile:= IniFile;
end;

destructor TRefTent.Destroy;
begin
  Inherited Destroy;
end;

function TCfgSeq.GetCfgTent(Ind: Integer): TCfgTent;
begin
  FCfgTent.Ind:= Ind;
  FCfgTent.IndSeq:= FInd;
  Result:= FCfgTent;
end;

function TCfgSeq.GetChvCmp_Bounds(Ind: Integer): TRect;
begin
  Result.Left:= FIniFile.ReadInteger('Seq '+IntToStr(FInd), 'CC'+IntToStr(Ind)+'.L', 0);
  Result.Top:= FIniFile.ReadInteger('Seq '+IntToStr(FInd), 'CC'+IntToStr(Ind)+'.T', 0);
  Result.Right:= FIniFile.ReadInteger('Seq '+IntToStr(FInd), 'CC'+IntToStr(Ind)+'.W', 0);
  Result.Bottom:= FIniFile.ReadInteger('Seq '+IntToStr(FInd), 'CC'+IntToStr(Ind)+'.H', 0);
end;

function TCfgSeq.GetChvMod_Bounds: TRect;
begin
  Result.Left:= FIniFile.ReadInteger('Seq '+IntToStr(FInd), 'CM.L', 0);
  Result.Top:= FIniFile.ReadInteger('Seq '+IntToStr(FInd), 'CM.T', 0);
  Result.Right:= FIniFile.ReadInteger('Seq '+IntToStr(FInd), 'CM.W', 0);
  Result.Bottom:= FIniFile.ReadInteger('Seq '+IntToStr(FInd), 'CM.H', 0);
end;

function TCfgSeq.GetName: String;
begin
  Result:= FIniFile.ReadString('Seq '+IntToStr(FInd), 'Name', '');
end;

function TCfgSeq.GetNumTent: Integer;
begin
  Result:= FIniFile.ReadInteger('Seq '+IntToStr(FInd), 'NumTent', 0);
end;

function TCfgSeq.GetValue(AName: String): String;
begin
  Result:= FIniFile.ReadString('Seq '+IntToStr(FInd), AName, '');
end;

function TCfgSeq.GetType_: String;
begin
  Result:= FIniFile.ReadString('Seq '+IntToStr(FInd), 'Type', '');
end;

function TCfgSeq.GetComents: String;
begin
  Result:= FIniFile.ReadString('Seq '+IntToStr(FInd), 'Coments', '');
end;

procedure TCfgSeq.SetName(AName: String);
begin
  FIniFile.WriteString('Seq '+IntToStr(FInd), 'Name', AName);
end;

procedure TCfgSeq.SetType_(AType: String);
begin
  FIniFile.WriteString('Seq '+IntToStr(FInd), 'Type', AType);
end;

procedure TCfgSeq.SetValue(AName, AValue: String);
begin
  FIniFile.WriteString('Seq '+IntToStr(FInd), AName, AValue);
end;

procedure TCfgSeq.SetComents(AComent: String);
begin
  FIniFile.WriteString('Seq '+IntToStr(FInd), 'Coments', AComent);
end;

constructor TCfgSeq.Create(IniFile: TIniFile);
begin
  Inherited Create(nil);
  FIniFile:= IniFile;
  FCfgTent:= TCfgTent.Create(FIniFile);
end;

destructor TCfgSeq.Destroy;
begin
  Inherited Destroy;
end;

procedure TCfgSeq.ReadCfg(SList: TStrings);
begin
  FIniFile.ReadSectionValues('Seq '+IntToStr(FInd), SList);
end;

function TCfgBlc.GetColor: Integer;
begin
  Result:= FIniFile.ReadInteger('Blc '+IntToStr(FInd), 'Color', 0);
end;

function TCfgBlc.GetITI: Integer;
begin
  Result:= FIniFile.ReadInteger('Blc '+IntToStr(FInd), 'ITI', 0);
end;

function TCfgBlc.GetNome: String;
begin
  Result:= FIniFile.ReadString('Blc '+IntToStr(FInd), 'Nome', '');
end;

function TCfgBlc.GetNumTent: Integer;
begin
  Result:= FIniFile.ReadInteger('Blc '+IntToStr(FInd), 'NumTent', 0);
end;

function TCfgBlc.GetRefTent(Ind: Integer): TRefTent;
begin
  FRefTent.FIndBlc:= FInd;
  FRefTent.Ind:= Ind;
  Result:= FRefTent;
end;

constructor TCfgBlc.Create(IniFile: TIniFile);
begin
  Inherited Create(nil);
  FIniFile:= IniFile;
  FRefTent:= TRefTent.Create(IniFile);
end;

destructor TCfgBlc.Destroy;
begin
  FRefTent.Destroy;
  Inherited Destroy;
end;

function TMatStm.GetFileName(Key: String): String;
begin
  If Key > '' then Result:= FIniFile.ReadString('MatStm', Key, '')
  else Result:= '';
end;

function TMatStm.GetFileName(IndCnj, IndCls: Integer): String;
begin
  Result:= FIniFile.ReadString('MatStm', Chr(IndCnj+65)+IntToStr(IndCls+1), '')
end;

function TMatStm.GetFullFileName(Key: String): String;
begin
  Result:= FResPath+ GetFileName(Key);
end;

function TMatStm.GetFullFileName(IndCnj, IndCls: Integer): String;
begin
  Result:= FResPath+ GetFileName(IndCnj, IndCls);
end;

procedure TMatStm.SetFileName(IndCnj, IndCls: Integer; AName: String);
begin
  If (IndCls > -1) and (IndCls < 10) and (IndCnj > -1) and (IndCnj < 10) then
    FIniFile.WriteString('MatStm', Chr(IndCnj+65)+IntToStr(IndCls+1), AName);
end;

constructor TMatStm.Create(IniFile: TIniFile);
begin
  Inherited Create(nil);
  FIniFile:= IniFile;
end;

destructor TMatStm.Destroy;
begin
  Inherited Destroy;
end;

procedure TMatStm.ReadCfg(SList: TStrings);
begin
  FIniFile.ReadSectionValues('MatStm', SList);
  SList.Insert(0, 'ResPath='+FResPath);
end;

function TCfgSes.GetCfgBlc(Ind: Integer): TCfgBlc;
begin
  FCfgBlc.Ind:= Ind;
  Result:= FCfgBlc;
end;

function TCfgSes.GetCfgCsq(Ind: Integer): TCfgCsq;
begin
  FCfgCsq.Ind:= Ind;
  Result:= FCfgCsq;
end;

function TCfgSes.GetCfgSeq(Ind: Integer): TCfgSeq;
begin
  FCfgSeq.Ind:= Ind;
  Result:= FCfgSeq;
end;

function TCfgSes.GetCfgSeqByName(AName: String): TCfgSeq;
var a1: Integer;
begin
  a1:= 0;
  While (CfgSeq[a1].Name <> AName) and (a1 < NumCfgSeq-1) do Inc(a1);
  If a1 < NumCfgSeq-1 then Result:= CfgSeq[a1]
  else Result:= nil;
end;

function TCfgSes.GetMatStm: TMatStm;
begin
  Result:= FMatStm;
end;

function TCfgSes.GetNome: String;
begin
  Result:= ReadString('Main', 'Nome', '');
end;

function TCfgSes.GetNumCfgBlc: Integer;
begin
  Result:= ReadInteger('Main', 'NumCfgBlc', 0);
end;

function TCfgSes.GetNumCfgSeq: Integer;
begin
  Result:= ReadInteger('Main', 'NumCfgSeq', 0);
end;

function TCfgSes.GetNumCfgCsq: Integer;
begin
  Result:= ReadInteger('Main', 'NumCfgCsq', 0);
end;

constructor TCfgSes.Create(FileName: String);
begin
  Inherited Create(FileName);

  FMatStm:= TMatStm.Create(Self);
  FileName:= ExtractFileDir(FileName); FileName:= ExtractFileDir(FileName);
  FMatStm.ResPath:= FileName+'\Files Stm\';

  FCfgBlc:= TCfgBlc.Create(Self);
  FCfgSeq:= TCfgSeq.Create(Self);
  FCfgCsq:= TCfgCsq.Create(Self);
end;

destructor TCfgSes.Destroy;
begin
  FCfgCsq.Destroy;
  FCfgSeq.Destroy;
  FCfgBlc.Destroy;
  FMatStm.Destroy;
  Inherited Destroy;
end;

function TCfgSes.NewCfgSeq(AName: String): String;
var a1, a2, a3: Integer; s1: String; b1: Boolean;
begin
  a1:= NumCfgSeq;
  WriteInteger('Main', 'NumCfgSeq', a1+1);

  a2:= 1;
  b1:= False;
  s1:= AName;
  While not b1 do begin
    b1:= True;
    For a3:= 0 to a1-1 do
      If s1 = CfgSeq[a3].Name then begin
        b1:= False;
        Inc(a2);
        s1:= AName+' '+IntToStr(a2);
      end;
  end;

  WriteString('Seq '+IntToStr(a1), 'Nome', s1);
  Result:= s1;
end;

function TCfgSes.SetSeqName(AName: String; Ind: Integer): Boolean;
var a1: Integer; b1: Boolean;
begin
  b1:= True;
  For a1:= 0 to NumCfgSeq-1 do
    If CfgSeq[a1].Name = AName then
      b1:= False;
  If b1 then CfgSeq[Ind].Name:= AName;
  Result:= b1;
end;

procedure TCfgSes.DeleteSeq(Ind: Integer);
var a1, a2, a3: Integer; SList: TStrings;
begin
  EraseSection('Seq '+IntToStr(Ind));

  a3:= ReadInteger('Main', 'NumCfgSeq', 0)-1;

  SList:= TStringList.Create;
  For a1:= Ind+1 to a3 do begin
    SList.Clear;
    ReadSectionValues('Seq '+IntToStr(a1), SList);
    For a2:= 0 to SList.Count-1 do
      WriteString('Seq '+IntToStr(a1-1), SList.Names[a2], SList.Values[SList.Names[a2]]);
  end;
  SList.Free;

  EraseSection('Seq '+IntToStr(a3));
  WriteInteger('Main', 'NumCfgSeq', a3);
end;

end.
