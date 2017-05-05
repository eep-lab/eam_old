unit uCfgSes;

interface

uses
  SysUtils, Classes, Graphics, IniFiles, Controls, uChave;

type
  TStm = Record
    FileName: String;
    LabelStm: String;
    Chave: TChave;
  end;

  TCfgStm = Record
    Name: String;
    NumLin: Integer;
    NumCol: Integer;
    MatStm: Array of Array of TStm;
  end;

  TChv = Record
    Alignment: TplAlignment;
    AutoSize: Boolean;
    BorderColor: TColor;
    Height: Integer;
    LabelChv: String;
    Left: Integer;
    ShowBorder: Boolean;
    Top: Integer;
    Transparent: Boolean;
    Width: Integer;
  end;

  TListCfgChv = Record
    NumCfgChv: Integer;
    VetCfgChv: Array of TChv;
  end;

  TCfgTent = Record
    Name: AnsiString;
    NumListCfgChv: Integer;
    VetListCfgChv: Array of TListCfgChv;
  end;

  TPtStm = Record
    CfgStm: String;
    Col:Integer;
    FileName: String;
    IndCfgStm: Integer;
    Lin:Integer;
  end;

  TListChv = Record
    NumPtStm: Integer;
    VetPtStm: Array of TPtStm;
  end;

  TListPar = Record
    NumPar: Integer;
    VetPar: Array of Variant;
  end;

  TTent = Record
    NumListChv: Integer;
    NumListPar: Integer;
    VetListChv: Array of TListChv;
    VetListPar: Array of TListPar;
  end;

  TSeq = Record
    CfgTent: String;
    IndCfgTent: Integer;
    Nome: AnsiString;
    NumTent: Integer;
    VetTent: Array of TTent;
  end;

  TPtTent = Record
    IndSeq: Integer;
    IndTent: Integer;
    Seq: AnsiString;
  end;

  TBlc = class(TPersistent)
  public
    ITI: Integer;
    Name: AnsiString;
    NumTent: Integer;
    VetPtTent: Array of TPtTent;
  end;

  TCfgSes = class(TComponent)
  private
    { Private declarations }
    FBlc: Array of TBlc;
    FCfgStm: Array of TCfgStm;
    FCfgTent: Array of TCfgTent;
    FName: String;
    FNumBlc,
    FNumCfgStm,
    FNumCfgTent,
    FNumListStm,
    FNumSeq: Integer;
    FSeq: Array of TSeq;
    function GetBlc(Ind: Integer): TBlc;
    function GetCfgStm(Ind: Integer): TCfgStm;
    function GetCfgTent(Ind: Integer): TCfgTent;
    function GetSeq(Ind: Integer): TSeq;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromFile(Path: String);
    procedure SaveToFile(Path: AnsiString);
    property Blc[Ind: Integer]: TBlc read GetBlc;
    property CfgStm[Ind: Integer]: TCfgStm read GetCfgStm;
    property CfgTent[Ind: Integer]: TCfgTent read GetCfgTent;
    property Name: String read FName write FName;
    property NumBlc: Integer read FNumBlc;
    property NumCfgStm: Integer read FNumCfgStm;
    property NumCfgTent: Integer read FNumCfgTent;
    property NumListStm: Integer read FNumListStm;
    property NumSeq: Integer read FNumSeq;
    property Seq[Ind: Integer]: TSeq read GetSeq;
  end;

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
var IniFile: TIniFile;
    a1, a2, a3: Integer;
    s1, s2: AnsiString;
  procedure LoadTent(var Tent: TTent);
  var a3, a4, a5: Integer;
  begin
    Tent.NumListPar:= IniFile.ReadInteger(s1, 'MA['+IntToStr(a2)+'].NumListPar', 0);
    SetLength(Tent.VetListPar, Tent.NumListPar);
    For a3:= 0 to Tent.NumListPar-1 do begin
      Tent.VetListPar[a3].NumPar:= IniFile.ReadInteger(s1, 'MA['+IntToStr(a2)+','+IntToStr(a3)+'].NumPar', 0);
      SetLength(Tent.VetListPar[a3].VetPar, Tent.VetListPar[a3].NumPar);
      For a4:= 0 to Tent.VetListPar[a3].NumPar-1 do
        Tent.VetListPar[a3].VetPar[a4]:= IniFile.ReadInteger(s1, 'MA['+IntToStr(a2)+','+IntToStr(a3)+','+IntToStr(a4)+']', -1);
    end;

    Tent.NumListChv:= IniFile.ReadInteger(s1, 'MB['+IntToStr(a2)+'].NumListChv', 0);
    SetLength(Tent.VetListChv, Tent.NumListChv);
    For a3:= 0 to Tent.NumListChv-1 do begin
      Tent.VetListChv[a3].NumPtStm:= IniFile.ReadInteger(s1, 'MB['+IntToStr(a2)+','+IntToStr(a3)+'].NumChv', 0);
      SetLength(Tent.VetListChv[a3].VetPtStm, Tent.VetListChv[a3].NumPtStm);
      For a4:= 0 to Tent.VetListChv[a3].NumPtStm-1 do
        With Tent.VetListChv[a3].VetPtStm[a4] do begin
          Lin:= IniFile.ReadInteger(s1, 'MB['+IntToStr(a2)+','+IntToStr(a3)+','+IntToStr(a4)+'].Lin', -1);
          Col:= IniFile.ReadInteger(s1, 'MB['+IntToStr(a2)+','+IntToStr(a3)+','+IntToStr(a4)+'].Col', -1);
          CfgStm:= IniFile.ReadString(s1, 'MB['+IntToStr(a2)+','+IntToStr(a3)+','+IntToStr(a4)+'].CfgStm', '');
          For a5:= 0 to FNumCfgStm-1 do
            If FCfgStm[a5].Name = CfgStm then begin
              IndCfgStm:= a5;
              Break
            end;
          If (Col > -1) and (Col < Length(FCfgStm[IndCfgStm].MatStm)) then
            If (Lin > -1) and (Lin < Length(FCfgStm[IndCfgStm].MatStm[Col])) then
              FileName:= FCfgStm[IndCfgStm].MatStm[Col, Lin].FileName;
        end;
    end;
  end;
begin
  IniFile := TIniFile.Create(Path);

  FName:= IniFile.ReadString('CfgSes', 'Nome', '');
  FNumCfgStm:= IniFile.ReadInteger('CfgSes', 'NumCfgStm', 0);
  FNumCfgTent:= IniFile.ReadInteger('CfgSes', 'NumCfgTent', 0);
  FNumSeq:= IniFile.ReadInteger('CfgSes', 'NumSeq', 0);
  FNumBlc:= IniFile.ReadInteger('CfgSes', 'NumBlc', 0);

  SetLength(FCfgStm, FNumCfgStm);
  For a1:= 0 to FNumCfgStm-1 do begin
    s1:= IniFile.ReadString('CfgStm', IntToStr(a1+1), '');
    FCfgStm[a1].Name:= Copy(s1, 2, Length(s1)-1);
    FCfgStm[a1].NumLin := IniFile.ReadInteger(s1, 'NumLin', 0);
    FCfgStm[a1].NumCol := IniFile.ReadInteger(s1, 'NumCol', 0);
    SetLength(FCfgStm[a1].MatStm, FCfgStm[a1].NumCol);
    For a2:= 0 to FCfgStm[a1].NumCol-1 do begin
      SetLength(FCfgStm[a1].MatStm[a2], FCfgStm[a1].NumLin);
      For a3:= 0 to FCfgStm[a1].NumLin-1 do begin
        FCfgStm[a1].MatStm[a2, a3].FileName:= IniFile.ReadString(s1, 'MatFile[' + IntToStr(a2) + ',' + IntToStr(a3)+'].FileName', '');
        FCfgStm[a1].MatStm[a2, a3].LabelStm:= IniFile.ReadString(s1, 'MatFile[' + IntToStr(a2) + ',' + IntToStr(a3)+'].LabelStm', '');        
      end;
    end;
  end;

  SetLength(FCfgTent, FNumCfgTent);
  For a1:= 0 to FNumCfgTent-1 do begin
    s1:= IniFile.ReadString('CfgTent', IntToStr(a1+1), '');
    FCfgTent[a1].Name:= Copy(s1, 2, Length(s1)-1);
    FCfgTent[a1].NumListCfgChv:= IniFile.ReadInteger(s1, 'NumListCfgChv', 0);
    SetLength(FCfgTent[a1].VetListCfgChv, FCfgTent[a1].NumListCfgChv);
    For a2:= 0 to FCfgTent[a1].NumListCfgChv-1 do begin
      FCfgTent[a1].VetListCfgChv[a2].NumCfgChv:= IniFile.ReadInteger(s1, 'M['+IntToStr(a2)+'].NumCfgChv', 0);
      SetLength(FCfgTent[a1].VetListCfgChv[a2].VetCfgChv, FCfgTent[a1].VetListCfgChv[a2].NumCfgChv);
      For a3:= 0 to FCfgTent[a1].VetListCfgChv[a2].NumCfgChv-1 do
        With FCfgTent[a1].VetListCfgChv[a2].VetCfgChv[a3] do begin
          s2:= 'M['+IntToStr(a2)+','+IntToStr(a3)+'].';
          AutoSize:= IniFile.ReadBool(s1, s2+'AutoSize', False);
          BorderColor:= IniFile.ReadInteger(s1, s2+'BorderColor', $00FFFF);
          Alignment:= TplAlignment(IniFile.ReadInteger(s1, s2+'Alignment', 0));
          Height:= IniFile.ReadInteger(s1, s2+'Height', 100);
          Left:= IniFile.ReadInteger(s1, s2+'Left', 397);
          ShowBorder:= IniFile.ReadBool(s1, s2+'ShowBorder', True);
          Top:= IniFile.ReadInteger(s1, s2+'Top', 61);
          Transparent:= IniFile.ReadBool(s1, s2+'Transparent', False);
          Width:= IniFile.ReadInteger(s1, s2+'Width', 100);
          LabelChv:= IniFile.ReadString(s1, s2+'LabelChv', '');
        end;
    end;
  end;

  SetLength(FSeq, FNumSeq);
  For a1:= 0 to FNumSeq-1 do begin
    s1:= IniFile.ReadString('Seq', IntToStr(a1+1), '');
    FSeq[a1].Nome:= Copy(s1, 2, Length(s1)-1);
    FSeq[a1].CfgTent:= IniFile.ReadString(s1, 'CfgTent','');
    FSeq[a1].NumTent:= IniFile.ReadInteger(s1, 'NumTent', 0);
    For a2:= 0 to FNumCfgTent-1 do
      If FCfgTent[a2].Name = FSeq[a1].CfgTent then
        FSeq[a1].IndCfgTent:= a2;
    SetLength(FSeq[a1].VetTent, FSeq[a1].NumTent);
    For a2:= 0 to FSeq[a1].NumTent-1 do
      LoadTent(FSeq[a1].VetTent[a2]);
  end;

  SetLength(FBlc, FNumBlc);
  For a1:= 0 to FNumBlc-1 do begin
    FBlc[a1]:= TBlc.Create;
    s1:= IniFile.ReadString('Blc', IntToStr(a1+1), '');
    FBlc[a1].Name:= Copy(s1, 2, Length(s1)-1);
    FBlc[a1].NumTent:= IniFile.ReadInteger(s1, 'NumTent', 0);
    FBlc[a1].ITI:= IniFile.ReadInteger(s1, 'ITI', 0);
    SetLength(FBlc[a1].VetPtTent, FBlc[a1].NumTent);
    For a2:= 0 to FBlc[a1].NumTent-1 do begin
      FBlc[a1].VetPtTent[a2].Seq:= IniFile.ReadString( s1, 'VetPtTent['+IntToStr(a2)+'].Seq', '');
      FBlc[a1].VetPtTent[a2].IndTent:= IniFile.ReadInteger(s1, 'VetPtTent['+IntToStr(a2)+'].Ind', -1);
      For a3:= 0 to FNumSeq-1 do
        If FBlc[a1].VetPtTent[a2].Seq = FSeq[a3].Nome then
          FBlc[a1].VetPtTent[a2].IndSeq:= a3;
    end;
  end;
end;

procedure TCfgSes.SaveToFile(Path: AnsiString);
var IniFile: TIniFile;
    a1, a2, a3, a4: Integer;
    s1, s2: AnsiString;
begin
  IniFile:= TIniFile.Create(Path);

  IniFile.WriteString('CfgSes', 'Nome', ExtractFileName(Path));
  IniFile.WriteInteger('CfgSes', 'NumCfgStm', FNumCfgStm);
  IniFile.WriteInteger('CfgSes', 'NumCfgTent', FNumCfgTent);
  IniFile.WriteInteger('CfgSes', 'NumSeq', FNumSeq);
  IniFile.WriteInteger('CfgSes', 'NumBlc', FNumBlc);

  For a1:= 0 to FNumCfgStm-1 do begin
    s1:= 'A'+FCfgStm[a1].Name;
    IniFile.WriteString('CfgStm', IntToStr(a1+1), s1);
    IniFile.WriteInteger(s1, 'NumLin', FCfgStm[a1].NumLin);
    IniFile.WriteInteger(s1, 'NumCol', FCfgStm[a1].NumCol);
    For a2:= 0 to FCfgStm[a1].NumCol-1 do
      For a3:= 0 to FCfgStm[a1].NumLin-1 do
        If FCfgStm[a1].MatStm[a2, a3].FileName > '' then begin
          IniFile.WriteString(s1, 'MatFile['+IntToStr(a2)+','+IntToStr(a3)+'].FileName', FCfgStm[a1].MatStm[a2, a3].FileName);
        end;
  end;

  For a1:= 0 to FNumCfgTent-1 do begin
    s1:= 'B'+FCfgTent[a1].Name;
    IniFile.WriteString('CfgTent', IntToStr(a1+1), s1);
    IniFile.WriteInteger(s1, 'NumListCfgChv', FCfgTent[a1].NumListCfgChv);
    For a2:= 0 to FCfgTent[a1].NumListCfgChv-1 do begin
      IniFile.WriteInteger(s1, 'M['+IntToStr(a2)+'].NumCfgChv', FCfgTent[a1].VetListCfgChv[a2].NumCfgChv);
      For a3:= 0 to FCfgTent[a1].VetListCfgChv[a2].NumCfgChv-1 do
        With FCfgTent[a1].VetListCfgChv[a2].VetCfgChv[a3] do begin
          s2:= 'M['+IntToStr(a2)+','+IntToStr(a3)+']';
          IniFile.WriteBool(   s1, s2+'.AutoSize', AutoSize);
          IniFile.WriteInteger(s1, s2+'.BorderColor', BorderColor);
          IniFile.WriteInteger(s1, s2+'.HAlignment', Integer(Alignment));
          IniFile.WriteInteger(s1, s2+'.Height', Height);
          IniFile.WriteInteger(s1, s2+'.Left', Left);
          IniFile.WriteBool(   s1, s2+'.ShowBorder', ShowBorder);
          IniFile.WriteInteger(s1, s2+'.Top', Top);
          IniFile.WriteBool(   s1, s2+'.Transparent', Transparent);
          IniFile.WriteInteger(s1, s2+'.Width', Width);
          IniFile.WriteString (s1, s2+'.LabelChv', LabelChv);
        end;
    end;
  end;

  For a1:= 0 to FNumSeq-1 do begin
    s1:= 'C'+FSeq[a1].Nome;
    IniFile.WriteString('Seq', IntToStr(a1+1), s1);
    IniFile.WriteString(s1, 'CfgTent', FSeq[a1].CfgTent);
    IniFile.WriteInteger(s1, 'NumTent', FSeq[a1].NumTent);
    For a2:= 0 to FSeq[a1].NumTent-1 do begin
      IniFile.WriteInteger(s1, 'MA['+IntToStr(a2)+'].NumListPar', FSeq[a1].VetTent[a2].NumListPar);
      For a3:= 0 to FSeq[a1].VetTent[a2].NumListPar-1 do begin
        IniFile.WriteInteger(s1, 'MA['+IntToStr(a2)+','+IntToStr(a3)+'].NumPar', FSeq[a1].VetTent[a2].VetListPar[a3].NumPar);
        For a4:= 0 to FSeq[a1].VetTent[a2].VetListPar[a3].NumPar-1 do
          IniFile.WriteString(s1, 'MA['+IntToStr(a2)+','+IntToStr(a3)+','+IntToStr(a4)+']',
                              FSeq[a1].VetTent[a2].VetListPar[a3].VetPar[a4]);
      end;

      IniFile.WriteInteger(s1, 'M['+IntToStr(a2)+'].NumListChv', FSeq[a1].VetTent[a2].NumListChv);
      For a3:= 0 to FSeq[a1].VetTent[a2].NumListChv-1 do begin
        IniFile.WriteInteger(s1, 'M['+IntToStr(a2)+','+IntToStr(a3)+'].NumChv', FSeq[a1].VetTent[a2].VetListChv[a3].NumPtStm);
        For a4:= 0 to FSeq[a1].VetTent[a2].VetListChv[a3].NumPtStm-1 do
          With FSeq[a1].VetTent[a2].VetListChv[a3].VetPtStm[a4] do begin
            s2:=  'M['+IntToStr(a2)+','+IntToStr(a3)+','+IntToStr(a4)+']';
            IniFile.WriteString( s1, s2+'.CfgStm', CfgStm);
            IniFile.WriteInteger(s1, s2+'.Col', Col);
            IniFile.WriteInteger(s1, s2+'.Lin', Lin);
          end;
      end;
    end;
  end;

  For a1:= 0 to FNumBlc-1 do begin
    s1:= 'D'+FBlc[a1].Name;
    IniFile.WriteString('Blc', IntToStr(a1+1), s1);
    IniFile.WriteInteger(s1, 'NumTent', FBlc[a1].NumTent);
    IniFile.WriteInteger(s1, 'ITI', FBlc[a1].ITI);
    For a2:= 0 to FBlc[a1].NumTent-1 do begin
      IniFile.WriteString( s1, 'VetPtTent['+IntToStr(a2)+'].Seq', FBlc[a1].VetPtTent[a2].Seq);
      IniFile.WriteInteger(s1, 'VetPtTent['+IntToStr(a2)+'].Ind', FBlc[a1].VetPtTent[a2].IndTent);
    end;
  end;

end;

function TCfgSes.GetCfgStm(Ind: Integer): TCfgStm;
begin
  If (Ind > -1) and (Ind < FNumCfgStm) then
    Result:= FCfgStm[Ind];
end;

function TCfgSes.GetCfgTent(Ind: Integer): TCfgTent;
begin
  If (Ind > -1) and (Ind < FNumCfgTent) then
    Result:= FCfgTent[Ind];
end;

function TCfgSes.GetSeq(Ind: Integer): TSeq;
begin
  If (Ind > -1) and (Ind < FNumSeq) then
    Result:= FSeq[Ind];
end;

function TCfgSes.GetBlc(Ind: Integer): TBlc;
begin
  Result:= nil;
  If (Ind > -1) and (Ind < FNumBlc) then
    Result:= FBlc[Ind];
end;

end.



