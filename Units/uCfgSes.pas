unit uCfgSes;

interface

uses
  SysUtils, IniFiles, Classes, Types;

type

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

  TRefTent = Record
    IndSeq, IndTent: Integer;
  end;

  TBlc = class(TComponent)
  private
    FIniFile: TIniFile;
    FIdent: String;
    function GetName: String;
    function GetNum: Integer;
    function GetRefTent(Ind: Integer): TRefTent;
  public
    constructor Create(AOwner: TComponent; IniFile: TIniFile; Ident: String); reintroduce;
    procedure InsertTent(Index, IndSeq, IndTent: Integer);
    procedure NewTent(IndSeq, IndTent: Integer);
    property Name: String read GetName;
    property NumTent: Integer read GetNum;
    property RefTent[Ind: Integer]: TRefTent read GetRefTent;
  end;

  TCsq = class(TComponent)
  public
    constructor Create(IniFile: TIniFile; Ident: String); reintroduce;
  end;

  TDefTent = class(TComponent)
  private
    FIniFile: TIniFile;
    FIdent: String;
    function GetName: String;
    function GetTipe: String;
    function GetValue(Key: String): String;
    function GetValueExists(Key: String): Boolean;
    procedure SetName(Value: String); reintroduce;
    procedure SetTipe(Value: String);
    procedure SetValue(Key, Value: String);
  public
    constructor Create(IniFile: TIniFile; Ident: String); reintroduce;
    property Name: String read GetName write SetName;
    property Tipe: String read GetTipe write SetTipe;
    property Value[Key: String]: String read GetValue write SetValue;
    property ValueExists[Key: String]: Boolean read GetValueExists;
    property Ident: String read FIdent write FIdent;
  end;

  TSeq = class(TComponent)
  private
    FIniFile: TIniFile;
    FIdent: String;
    FVetTent: Array of TDefTent;
    function GetName: String;
    function GetDefTentName: String;
    function GetNumTent: Integer;
    function GetTent(Ind: Integer): TDefTent;
    procedure SetDefTentName(NewDefTentName: String);
  public
    constructor Create(IniFile: TIniFile; Ident: String); reintroduce;
    procedure DeleteAllTent;
    procedure DeleteTent(IndTent: Integer);
    function NewTent: TDefTent;
    property Name: String read GetName;
    property DefTentName: String read GetDefTentName write SetDefTentName;
    property Tent[Ind: Integer]: TDefTent read GetTent;
    property NumTent: Integer read GetNumTent;
    property Ident: String read FIdent write FIdent;
  end;

  TCfgSes = class(TIniFile)
  private
    { Private declarations }
    FMatStm: TMatStm;
    FNumBlc: Integer;
    FNumCsq: Integer;
    FNumDefTent: Integer;
    FNumSeq: Integer;
    FVetBlc: Array of TBlc;
    FVetCsq: Array of TCsq;
    FVetDefTent: Array of TDefTent;
    FVetSeq: Array of TSeq;
    function GetBlc(Ind: Integer): TBlc;
    function GetCsq(Ind: Integer): TCsq;
    function GetDefTent(Ind: Integer): TDefTent;
    function GetMatStm: TMatStm;
    function GetSeq(Ind: Integer): TSeq;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; FileName: String); reintroduce;
    destructor Destroy; override;

    function NewDefTent(DefTentName: String; var DefTent: TDefTent): Boolean;
    function DeleteDefTent(DefTentName: String): Boolean;
    function DefTentByName(DefTentName: String; var DefTent: TDefTent): Boolean;

    function DeleteSeq(SeqName: String): Boolean;
    function NewSeq(SeqName: String): TSeq;
    function SeqByName(SeqName: String; var Seq: TSeq): Boolean;

    function NewBlc(BlcName: String; var Blc: TBlc): Boolean;
    function BlcByName(BlcName: String; var Blc: TBlc): Boolean;

    property MatStm: TMatStm read GetMatStm;

    property NumCsq: Integer read FNumCsq;
    property Csq[Ind: Integer]: TCsq read GetCsq;

    property NumDefTent: Integer read FNumDefTent;
    property DefTent[Ind: Integer]: TDefTent read GetDefTent;

    property NumSeq: Integer read FNumSeq;
    property Seq[Ind: Integer]: TSeq read GetSeq;

    property NumBlc: Integer read FNumBlc;
    property Blc[Ind: Integer]: TBlc read GetBlc;
  end;

implementation

constructor TMatStm.Create(IniFile: TIniFile);
begin
  Inherited Create(nil);
  FIniFile:= IniFile;
end;

destructor TMatStm.Destroy;
begin
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

procedure TMatStm.ReadCfg(SList: TStrings);
begin
  FIniFile.ReadSectionValues('MatStm', SList);
  SList.Insert(0, 'ResPath='+FResPath);
end;

procedure TMatStm.SetFileName(IndCnj, IndCls: Integer; AName: String);
begin
  If (IndCls > -1) and (IndCls < 21) and (IndCnj > -1) and (IndCnj < 21) then
    FIniFile.WriteString('MatStm', Chr(IndCnj+65)+IntToStr(IndCls+1), AName);
end;

function TBlc.GetName: String;
begin
  Result:= FIniFile.ReadString(FIdent, 'Name', '');
end;

function TBlc.GetNum: Integer;
begin
  Result:= FIniFile.ReadInteger(FIdent, 'NumTent', 0);
end;

function TBlc.GetRefTent(Ind: Integer): TRefTent;
var RefTent: TRefTent;
begin
  RefTent.IndSeq:= FIniFile.ReadInteger(FIdent, 'T'+IntToStr(Ind)+'.IndSeq', -1);
  RefTent.IndTent:= FIniFile.ReadInteger(FIdent, 'T'+IntToStr(Ind)+'.IndTent', -1);
  Result:= RefTent;
end;

constructor TBlc.Create(AOwner: TComponent; IniFile: TIniFile; Ident: String);
begin
  Inherited Create(AOwner);
  FIniFile:= IniFile;
  FIdent:= Ident;
end;

procedure TBlc.InsertTent(Index, IndSeq, IndTent: Integer);
var a1: Integer;
begin
  If (Index > -1) and (Index < NumTent) then begin
    NewTent(IndSeq, IndTent);
    For a1:= NumTent-2 downto Index do begin
      FIniFile.WriteInteger(FIdent, 'T'+IntToStr(a1+1)+'.IndSeq',
                            FIniFile.ReadInteger(FIdent, 'T'+IntToStr(a1)+'.IndSeq', -1));
      FIniFile.WriteInteger(FIdent, 'T'+IntToStr(a1+1)+'.IndTent',
                            FIniFile.ReadInteger(FIdent, 'T'+IntToStr(a1)+'.IndTent', -1));
    end;
    FIniFile.WriteInteger(FIdent, 'T'+IntToStr(Index)+'.IndSeq', IndSeq);
    FIniFile.WriteInteger(FIdent, 'T'+IntToStr(Index)+'.IndTent', IndTent);
  end else NewTent(IndSeq, IndTent);
end;

procedure TBlc.NewTent(IndSeq, IndTent: Integer);
begin
  FIniFile.WriteInteger(FIdent, 'NumTent', NumTent+1);
  FIniFile.WriteInteger(FIdent, 'T'+IntToStr(NumTent-1)+'.IndSeq', IndSeq);
  FIniFile.WriteInteger(FIdent, 'T'+IntToStr(NumTent-1)+'.IndTent', IndTent);
end;

function TDefTent.GetName: String;
begin
  Result:= FIniFile.ReadString(FIdent, 'Name', '');
end;

function TDefTent.GetTipe: String;
begin
  Result:= FIniFile.ReadString(FIdent, 'Type', '');
end;

function TDefTent.GetValue(Key: String): String;
begin
  If Key > '' then
    Result:= FIniFile.ReadString(FIdent, Key, '');
end;

function TDefTent.GetValueExists(Key: String): Boolean;
begin
  If Key > '' then
    Result:= FIniFile.ValueExists(FIdent, Key)
  else  Result:= False;
end;

procedure TDefTent.SetName(Value: String);
begin
  FIniFile.WriteString(FIdent, 'Name', Value);
end;

procedure TDefTent.SetTipe(Value: String);
begin
  FIniFile.WriteString(FIdent, 'Type', Value);
end;

procedure TDefTent.SetValue(Key, Value: String);
begin
  If Key > '' then
    FIniFile.WriteString(FIdent, Key, Value);
end;

constructor TDefTent.Create(IniFile: TIniFile; Ident: String);
begin
  Inherited Create(nil);
  FIniFile:= IniFile;
  FIdent:= Ident;
end;

constructor TCsq.Create(IniFile: TIniFile; Ident: String);
begin

end;

function TSeq.GetName: String;
begin
  Result:= FIniFile.ReadString(FIdent, 'Name', '');
end;

function TSeq.GetDefTentName: String;
begin
  Result:= FIniFile.ReadString(FIdent, 'DefTent', '');
end;

function TSeq.GetNumTent: Integer;
begin
  Result:= FIniFile.ReadInteger(FIdent, 'NumTent', 0);
end;

function TSeq.GetTent(Ind: Integer): TDefTent;
begin
  If Ind < NumTent then begin
    If not Assigned(FVetTent[Ind]) then
      FVetTent[Ind]:= TDefTent.Create(FIniFile, FIdent+' Tent '+IntToStr(Ind));
    Result:= FVetTent[Ind];
  end else Result:= nil;
end;

procedure TSeq.SetDefTentName(NewDefTentName: String);
begin
  FIniFile.WriteString(FIdent, 'DefTent', NewDefTentName);
end;

constructor TSeq.Create(IniFile: TIniFile; Ident: String);
var a1: Integer;
begin
  Inherited Create(nil);
  FIniFile:= IniFile;
  FIdent:= Ident;
  SetLength(FVetTent, NumTent);
  For a1:= 0 to NumTent-1 do
    FVetTent[a1]:= TDefTent.Create(FIniFile, FIdent+' Tent '+IntToStr(a1));
end;

procedure TSeq.DeleteAllTent;
var a1: Integer;
begin
  For a1:= NumTent-1 downto 0 do
    DeleteTent(a1);
end;

procedure TSeq.DeleteTent(IndTent: Integer);
var a1, a2: Integer; SList: TStringList;
begin
  If (IndTent > -1) and (IndTent < NumTent) then begin
    FIniFile.WriteString(FIdent, 'NumTent', IntToStr(NumTent-1));
    FIniFile.EraseSection(FIdent+' Tent '+IntToStr(IndTent));
    FVetTent[IndTent].Free;
    SList:= TStringList.Create;
    For a1:= IndTent to NumTent-1 do begin
      FVetTent[a1]:= FVetTent[a1+1];
      FIniFile.ReadSectionValues(FIdent+' Tent '+IntToStr(a1+1), SList);
      For a2:= 0 to SList.Count-1 do
        FIniFile.WriteString(FIdent+' Tent '+IntToStr(a1), SList.Names[a2], SList.Values[SList.Names[a2]]);
      FVetTent[a1].Ident:= FIdent+' Tent '+IntToStr(a1);
      FIniFile.EraseSection(FIdent+' Tent '+IntToStr(a1+1));
    end;
    SList.Free;
  end;
end;

function TSeq.NewTent: TDefTent;
begin
  FIniFile.WriteString(FIdent, 'NumTent', IntToStr(NumTent+1));
  SetLength(FVetTent, NumTent);
  FVetTent[NumTent-1]:= TDefTent.Create(FIniFile, FIdent+' Tent '+IntToStr(NumTent-1));
  Result:= FVetTent[NumTent-1];
end;

function TCfgSes.GetBlc(Ind: Integer): TBlc;
begin
  If Ind < FNumBlc then begin
    If not Assigned(FVetBlc[Ind]) then FVetBlc[Ind].Create(nil, Self, 'Blc '+IntToStr(Ind));
    Result:= FVetBlc[Ind];
  end else Result:= nil;
end;

function TCfgSes.GetDefTent(Ind: Integer): TDefTent;
begin
  If Ind < FNumDefTent then begin
    If not Assigned(FVetDefTent[Ind]) then
      FVetDefTent[Ind]:= TDefTent.Create(Self, 'DefTent '+IntToStr(Ind));
    Result:= FVetDefTent[Ind];
  end else Result:= nil;
end;

function TCfgSes.GetCsq(Ind: Integer): TCsq;
begin
  If Ind < FNumCsq then begin
    If not Assigned(FVetCsq[Ind]) then FVetCsq[Ind].Create(Self, 'Csq '+IntToStr(Ind));
    Result:= FVetCsq[Ind];
  end else Result:= nil;
end;

function TCfgSes.GetMatStm: TMatStm;
begin
  Result:= FMatStm;
end;

function TCfgSes.GetSeq(Ind: Integer): TSeq;
begin
  If Ind < FNumSeq then begin
    If not Assigned(FVetSeq[Ind]) then FVetSeq[Ind]:= TSeq.Create(Self, 'Seq '+IntToStr(Ind));
    Result:= FVetSeq[Ind];
  end else Result:= nil;
end;

constructor TCfgSes.Create(AOwner: TComponent; FileName: String);
var a1: Integer;
begin
  Inherited Create(FileName);

  FNumBlc:= ReadInteger('Main', 'NumBlc', 0);
  SetLength(FVetBlc, FNumBlc);
  For a1:= 0 to FNumBlc-1 do
    FVetBlc[a1]:= TBlc.Create(nil, Self, 'Blc '+IntToStr(a1));

  FNumCsq:= ReadInteger('Main', 'NumCsq', 0);
  FNumDefTent:= ReadInteger('Main', 'NumDefTent', 0);
  FNumSeq:= ReadInteger('Main', 'NumSeq', 0);

  SetLength(FVetCsq, FNumCsq);
  SetLength(FVetDefTent, FNumDefTent);
  SetLength(FVetSeq, FNumSeq);

  FMatStm:= TMatStm.Create(Self);
  FileName:= ExtractFileDir(FileName); FileName:= ExtractFileDir(FileName);
  FMatStm.ResPath:= FileName+'\Files Stm\';
end;

destructor TCfgSes.Destroy;
begin
  Inherited Destroy;
end;

function TCfgSes.NewDefTent(DefTentName: String; var DefTent: TDefTent): Boolean;
var s1: String; a1: Integer; dt: TDefTent;
begin
  a1:= 1;
  s1:= DefTentName;
  While DefTentByName(s1, dt) do begin
    Inc(a1);
    s1:= DefTentName+' '+IntToStr(a1);
  end;

  Inc(FNumDefTent);
  WriteString('Main', 'NumDefTent', IntToStr(FNumDefTent));
  SetLength(FVetDefTent, FNumDefTent);
  FVetDefTent[FNumDefTent-1]:= TDefTent.Create(Self, 'DefTent '+IntToStr(FNumDefTent-1));
  DefTent:= FVetDefTent[FNumDefTent-1];
  WriteString('DefTent '+IntToStr(FNumDefTent-1), 'Name', s1);
  Result:= True;
end;

function TCfgSes.DeleteDefTent(DefTentName: String): Boolean;
var a1, a2, a3: Integer; SList: TStringList; b1: Boolean;
begin
  a1:= 0;
  b1:= False;
  While (a1 < FNumDefTent) and not b1 do begin
    If FVetDefTent[a1].Name = DefTentName then b1:= True;
    Inc(a1);
  end;
  Dec(a1);
  If b1 then begin
    Dec(FNumDefTent);
    WriteString('Main', 'NumDefTent', IntToStr(FNumDefTent));
    EraseSection(FVetDefTent[a1].Ident);
    FVetDefTent[a1].Free;
    SList:= TStringList.Create;
    For a2:= a1 to FNumDefTent-1 do begin
      FVetDefTent[a1]:= FVetDefTent[a1+1];
      ReadSectionValues('DefTent '+IntToStr(a2+1), SList);
      For a3:= 0 to SList.Count-1 do
        WriteString('DefTent '+IntToStr(a2), SList.Names[a3], SList.Values[SList.Names[a3]]);
      FVetDefTent[a2].Ident:= 'DefTent '+IntToStr(a2);
    end;
    EraseSection('DefTent '+IntToStr(FNumDefTent));
    SList.Free;
  end;
  Result:= not b1;
end;

function TCfgSes.DefTentByName(DefTentName: String; var DefTent: TDefTent): Boolean;
var a1: Integer; b1: Boolean;
begin
  a1:= 0;
  b1:= False;
  While (a1 < FNumDefTent) and not b1 do begin
    If FVetDefTent[a1].Name = DefTentName then b1:= True;
    Inc(a1);
  end;
  If b1 then DefTent:= FVetDefTent[a1-1];
  Result:= b1;
end;

function TCfgSes.DeleteSeq(SeqName: String): Boolean;
var a1, a2, a3: Integer; SList: TStringList; b1: Boolean;
begin
  a1:= 0;
  b1:= False;
  While (a1 < FNumSeq) and not b1 do begin
    If FVetSeq[a1].Name = SeqName then b1:= True;
    Inc(a1);
  end;
  Dec(a1);
  If b1 then begin
    For a2:= 0 to FVetSeq[a1].NumTent-1 do
      FVetSeq[a1].DeleteAllTent;
    Dec(FNumSeq);
    WriteString('Main', 'NumSeq', IntToStr(FNumSeq));
    EraseSection(FVetSeq[a1].Ident);
    FVetSeq[a1].Free;
    SList:= TStringList.Create;
    For a2:= a1 to FNumSeq-1 do begin
      FVetSeq[a1]:= FVetSeq[a1+1];
      ReadSectionValues('Seq '+IntToStr(a2+1), SList);
      For a3:= 0 to SList.Count-1 do
        WriteString('Seq '+IntToStr(a2), SList.Names[a3], SList.Values[SList.Names[a3]]);
      FVetSeq[a2].Ident:= 'Seq '+IntToStr(a2);
    end;
    EraseSection('Seq '+IntToStr(FNumSeq));
    SList.Free;
  end;
  Result:= not b1;
end;

function TCfgSes.NewSeq(SeqName: String): TSeq;
var s1: String; a1: Integer; seq: TSeq;
begin
  a1:= 1;
  s1:= SeqName;
  While SeqByName(s1, seq) do begin
    Inc(a1);
    s1:= SeqName+' '+IntToStr(a1);
  end;

  Inc(FNumSeq);
  WriteString('Main', 'NumSeq', IntToStr(FNumSeq));
  SetLength(FVetSeq, FNumSeq);
  FVetSeq[FNumSeq-1]:= TSeq.Create(Self, 'Seq '+IntToStr(FNumSeq-1));
  WriteString('Seq '+IntToStr(FNumSeq-1), 'Name', s1);
  Result:= FVetSeq[FNumSeq-1];
end;

function TCfgSes.SeqByName(SeqName: String; var Seq: TSeq): Boolean;
var a1: Integer; b1: Boolean;
begin
  a1:= 0;
  b1:= False;
  While (a1 < FNumSeq) and not b1 do begin
    If FVetSeq[a1].Name = SeqName then b1:= True;
    Inc(a1);
  end;
  If b1 then Seq:= FVetSeq[a1-1];
  Result:= b1;
end;

function TCfgSes.NewBlc(BlcName: String; var Blc: TBlc): Boolean;
var s1: String; a1: Integer; blc1: TBlc;
begin
  a1:= 1;
  s1:= BlcName;
  While BlcByName(s1, blc1) do begin
    Inc(a1);
    s1:= BlcName+' '+IntToStr(a1);
  end;

  Inc(FNumBlc);
  WriteString('Main', 'NumBlc', IntToStr(FNumBlc));
  SetLength(FVetBlc, FNumBlc);
  FVetBlc[FNumBlc-1]:= TBlc.Create(nil, Self, 'Blc '+IntToStr(FNumBlc-1));
  WriteString('Blc '+IntToStr(FNumBlc-1), 'Name', s1);
  Blc:= FVetBlc[FNumBlc-1];
  Result:= True;
end;

function TCfgSes.BlcByName(BlcName: String; var Blc: TBlc): Boolean;
var a1: Integer; b1: Boolean;
begin
  a1:= 0;
  b1:= False;
  While (a1 < FNumBlc) and not b1 do begin
    If FVetBlc[a1].Name = BlcName then b1:= True;
    Inc(a1);
  end;
  If b1 then Blc:= FVetBlc[a1-1];
  Result:= b1;
end;

end.
