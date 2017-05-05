unit uBlcMan;

interface

uses Classes, Controls, IniFiles,
     uCfgSes, uTentMaker, uAbsTent;

type
  TBlcMan = class(TComponent)
  private
    FCfgSes: TCfgSes;
    FConteiner: TWinControl;
    FAbsCfgTent: TAbsCfgTent;
    FAbsCfgTentLoaded: Boolean;
    FTentMaker: TTentMaker;
    FBlc: TBlc;
    FBlcLoaded: Boolean;
    function GetNumTent: Integer;
    function GetTentValue(IndTent: Integer; Key: String): String;
  public
    constructor Create(AOwner: TComponent; CfgSes: TCfgSes; TentMaker: TTentMaker); reintroduce;

    procedure GetSeqNames(SList: TStrings);
    function SeqNumTent(IndSeq: Integer): Integer;

    procedure InsertTent(Index, IndSeq, IndTent: Integer);
    procedure NewTent(IndSeq, IndTent: Integer);
    procedure SelectTent(IndSeq, IndTent: Integer);

    function SelectBlc(BlcName: String): Boolean;
    function NewBlc(BlcName: String): String;
    procedure GetBlcNames(SList: TStrings);

    property Conteiner: TWinControl read FConteiner write FConteiner;
    property NumTent: Integer read GetNumTent;
    property TentValue[IndTent: Integer; Key: String]: String read GetTentValue;
  end;

implementation

function TBlcMan.GetNumTent: Integer;
begin
  If FBlcLoaded then
    Result:= FBlc.NumTent
  else Result:= 0;
end;

function TBlcMan.GetTentValue(IndTent: Integer; Key: String): String;
var RefTent: TRefTent;
begin
  If FBlcLoaded then begin
    RefTent:= FBlc.RefTent[IndTent];
    If RefTent.IndTent < FCfgSes.Seq[RefTent.IndSeq].NumTent then
      Result:= FCfgSes.Seq[RefTent.IndSeq].Tent[RefTent.IndTent].Value[Key];
  end;
end;

constructor TBlcMan.Create(AOwner: TComponent; CfgSes: TCfgSes; TentMaker: TTentMaker);
begin
  Inherited Create(AOWner);
  FCfgSes:= CfgSes;
  FTentMaker:= TentMaker;
end;

procedure TBlcMan.GetSeqNames(SList: TStrings);
var a1: Integer;
begin
  SList.Clear;
  For a1:= 0 to FCfgSes.NumSeq-1 do
    SList.Add(FCfgSes.Seq[a1].Name);
end;

procedure TBlcMan.SelectTent(IndSeq, IndTent: Integer);
var DefTent: TDefTent;// Tent: TDefTent; a1, a2: Integer;
begin
  If FAbsCfgTentLoaded then FAbsCfgTent.Free;
  If FCfgSes.DefTentByName(FCfgSes.Seq[IndSeq].DefTentName, DefTent) then begin
    FAbsCfgTentLoaded:= FTentMaker.CreateAbsCfgTent(DefTent.Tipe, FAbsCfgTent);
    If FAbsCfgTentLoaded then begin
      FAbsCfgTent.Parent:= FConteiner;
      FAbsCfgTent.Align:= alClient;

//      Tent:= FCfgSes.Seq[IndSeq].Tent[Indtent];

{
      For a1:= 0 to High(FAbsCfgTent.VetItem^) do
        For a2:= 0 to High(FAbsCfgTent.VetItem^[a1].VetValue) do
          If Tent.ValueExists[FAbsCfgTent.VetItem^[a1].VetValue[a2].Key] then
            FAbsCfgTent.SetValue(a1, a2, Tent.Value[FAbsCfgTent.VetItem^[a1].VetValue[a2].Key])
            else FAbsCfgTent.SetValue(a1, a2, DefTent.Value[FAbsCfgTent.VetItem^[a1].VetValue[a2].Key]);
}            
    end;
  end;
end;

function TBlcMan.SeqNumTent(IndSeq: Integer): Integer;
begin
  Result:= FCfgSes.Seq[IndSeq].NumTent;
end;

procedure TBlcMan.InsertTent(Index, IndSeq, IndTent: Integer);
begin
  If FBlcLoaded then
    FBlc.InsertTent(Index, IndSeq, IndTent);
end;

procedure TBlcMan.NewTent(IndSeq, IndTent: Integer);
begin
  If FBlcLoaded then
    FBlc.NewTent(IndSeq, IndTent);
end;

function TBlcMan.NewBlc(BlcName: String): String;
begin
  FBlcLoaded:= FCfgSes.NewBlc(BlcName, FBlc);
  Result:= FBlc.Name;
end;

procedure TBlcMan.GetBlcNames(SList: TStrings);
var a1: Integer;
begin
  SList.Clear;
  For a1:= 0 to FCfgSes.NumBlc-1 do
    SList.Add(FCfgSes.Blc[a1].Name);
end;

function TBlcMan.SelectBlc(BlcName: String): Boolean;
begin
  FBlcLoaded:= FCfgSes.BlcByName(BlcName, FBlc);
  Result:= FBlcLoaded;
end;

end.
