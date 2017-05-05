unit uSeqMan;

interface

uses Windows, Classes, Controls, SysUtils,
     uCfgSes, uTentMaker, uAbsTent, uObjIns;

type
  TSeqMan = class(TComponent)
  private
    FAbsCfgTent: TAbsCfgTent;
    FAbsCfgTentLoaded: Boolean;
    FCfgSes: TCfgSes;
    FConteiner: TWinControl;
    FDefTent: TDefTent;
    FDefTentLoaded: Boolean;
    FSeq: TSeq;
    FSeqLoaded: Boolean;
    FOnValueChange: TValueChangeEvent;
    FTent: TDefTent;
    FTentLoaded: Boolean;
    FTentMaker: TTentMaker;
    procedure AbsCfgTentValueChange(IndItem, IndValue: Integer; Value: String);
    function GetDefTentName: String;
    function GetNumTent: Integer;

    procedure CreateTent;
    procedure LoadTent;

    procedure SetDefTentName(DefTentName: String);
  public
    constructor Create(AOwner: TComponent; CfgSes: TCfgSes; TentMaker: TTentMaker); reintroduce;

    function  NewSeq(SeqName: String): String;
//            SetSeqName(SeqName: String);
    procedure SelectSeq(Name: String);
//            SeqSaveAs(SourceSeqName, DestSeqName: String);
    procedure DeleteSeq(SeqName: String);

    procedure NewTent;
    procedure SelectTent(IndTent: Integer);
    procedure DeleteTent(IndTent: Integer);

    procedure GetSeqNames(SList: TStrings);

    property DefTentName: String read GetDefTentName write SetDefTentName;
    property NumTent: Integer read GetNumTent;
    property OnValueChange: TValueChangeEvent read FOnValueChange write FOnValueChange;
    property Conteiner: TWinControl read FConteiner write FConteiner;
  end;

implementation

procedure TSeqMan.CreateTent;
begin
//Pré
  If not FSeqLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If not FDefTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;

  If FAbsCfgTentLoaded then begin
    If FAbsCfgTent.Tipe <> FDefTent.Tipe then begin
      FAbsCfgTent.Free;
      FAbsCfgTentLoaded:= FTentMaker.CreateAbsCfgTent(FDefTent.Tipe, FAbsCfgTent);
      If FAbsCfgTentLoaded then begin
        FAbsCfgTent.OnValueChange:= AbsCfgTentValueChange;
        FAbsCfgTent.Visible:= False;
        FAbsCfgTent.Parent:= FConteiner;
        FAbsCfgTent.Align:= alClient;
      end;
    end;
  end else begin
    FAbsCfgTentLoaded:= FTentMaker.CreateAbsCfgTent(FDefTent.Tipe, FAbsCfgTent);
    If FAbsCfgTentLoaded then begin
      FAbsCfgTent.OnValueChange:= AbsCfgTentValueChange;
      FAbsCfgTent.Visible:= False;
      FAbsCfgTent.Parent:= FConteiner;
      FAbsCfgTent.Align:= alClient;
    end;
  end;

//Pós
  If not FSeqLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If not FDefTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
end;

procedure TSeqMan.LoadTent;
//var a1, a2: Integer;
begin
//Pré
  If not FSeqLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If not FDefTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If not FTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If not FAbsCfgTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;

  If FAbsCfgTentLoaded and FTentLoaded and FDefTentLoaded and FSeqLoaded then
    FAbsCfgTent.Visible:= True;
{
    For a1:= 0 to High(FAbsCfgTent.VetItem^) do
      For a2:= 0 to High(FAbsCfgTent.VetItem^[a1].VetValue) do
        If FTent.ValueExists[FAbsCfgTent.VetItem^[a1].VetValue[a2].Key] then
          FAbsCfgTent.SetValue(a1, a2, FTent.Value[FAbsCfgTent.VetItem^[a1].VetValue[a2].Key])
          else FAbsCfgTent.SetValue(a1, a2, FDefTent.Value[FAbsCfgTent.VetItem^[a1].VetValue[a2].Key]);
}

//Pós
  If not FSeqLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If not FDefTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If not FTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If not FAbsCfgTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
end;

procedure TSeqMan.AbsCfgTentValueChange(IndItem, IndValue: Integer; Value: String);
begin
  If Assigned(OnValueChange) then FOnValueChange(IndItem, IndValue, Value);
  If FTentLoaded and FAbsCfgTentLoaded then
//    FTent.Value[FAbsCfgTent.VetItem^[IndItem].VetValue[IndValue].Key]:= Value;
end;

function TSeqMan.GetDefTentName: String;
begin
  If FDefTentLoaded then
    Result:= FDefTent.Name;
end;

function TSeqMan.GetNumTent: Integer;
begin
  If FSeqLoaded then
    Result:= FSeq.NumTent
  else Result:= 0;
end;

procedure TSeqMan.SetDefTentName(DefTentName: String);
begin
//Pré
//  FSeqLoaded = True

  If FSeqLoaded then begin
    FDefTentLoaded:= FCfgSes.DefTentByName(DefTentName, FDefTent);
    If FDefTentLoaded then begin
      FSeq.DefTentName:= FDefTent.Name;
      CreateTent;
      If FAbsCfgTentLoaded then begin
        If FTentLoaded then
          LoadTent;
      end else FSeq.DeleteAllTent;
    end else begin
      If FAbsCfgTentLoaded then begin
        FAbsCfgTent.Free;
        FAbsCfgTentLoaded:= False;
      end;
    end;
  end else begin Beep; Exit; end;

//Pós
  If not FSeqLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If FSeqLoaded then begin
    If FDefTentLoaded then begin
    end else begin
      If not FAbsCfgTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
    end;
  end;
end;

constructor TSeqMan.Create(AOwner: TComponent; CfgSes: TCfgSes; TentMaker: TTentMaker);
begin
  Inherited Create(AOwner);
  FCfgSes:= CfgSes;
  FTentMaker:= TentMaker;
end;

function TSeqMan.NewSeq(SeqName: String): String;
begin
//Pré

  FSeq:= FCfgSes.NewSeq(SeqName);
  FSeqLoaded:= True;
  FDefTentLoaded:= False;
  FTentLoaded:= False;
  If FAbsCfgTentLoaded then FAbsCfgTent.Free;
  FAbsCfgTentLoaded:= False;
  Result:= FSeq.Name;

// Pos
  If not FSeqLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If FDefTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If FTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If FAbsCfgTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
end;

procedure TSeqMan.DeleteSeq(SeqName: String);
begin
//Pré
//  FSeqLoaded = True

  If FSeqLoaded then begin
    FSeqLoaded:= FCfgSes.DeleteSeq(FSeq.Name);
    FDefTentLoaded:= False;
    FTentLoaded:= False;
    FAbsCfgTentLoaded:= False;
    FAbsCfgTent.Free;
  end else begin Beep; Exit; end;

//Pós
  If FSeqLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If FDefTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If FTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If FAbsCfgTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
end;

procedure TSeqMan.DeleteTent(IndTent: Integer);
begin
//Pré
//  FSeqLoaded = True
//  FTentLoaded = True

  If FSeqLoaded and FTentLoaded then begin
    FSeq.DeleteTent(IndTent);
    FTentLoaded:= False;
  end else begin Beep; Exit; end;

//Pós
  If not FSeqLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If FTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
end;

procedure TSeqMan.GetSeqNames(SList: TStrings);
var a1: Integer;
begin
  SList.Clear;
  For a1:= 0 to FCfgSes.NumSeq-1 do
    SList.Add(FCfgSes.Seq[a1].Name);
end;

procedure TSeqMan.NewTent;
begin
//Pré
//  FSeqLoaded = True
//  FDefTentLoaded = True

  If FSeqLoaded and FDefTentLoaded then begin
    FTent:= FSeq.NewTent;
    FTentLoaded:= True;
  end else begin Beep; Exit; end;

//Pós
  If not FSeqLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If not FDefTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If FTentLoaded then begin
//    If not FAbsCfgTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  end else begin
    If FAbsCfgTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  end;
end;

procedure TSeqMan.SelectSeq(Name: String);
begin
//Pré

  FSeqLoaded:= FCfgSes.SeqByName(Name, FSeq);
  If FSeqLoaded then begin
    FDefTentLoaded:= FCfgSes.DefTentByName(FSeq.DefTentName, FDefTent);
    If FDefTentLoaded then CreateTent;
  end else begin
    FDefTentLoaded:= False;
    FTentLoaded:= False;
  end;

//Pós
  If not FSeqLoaded then
    If FDefTentLoaded or FTentLoaded or FAbsCfgTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
end;

procedure TSeqMan.SelectTent(IndTent: Integer);
begin
//Pré
//  FSeqLoade = True
//  FDefTentLoaded = True

  If FSeqLoaded and FDefTentLoaded then begin
    FTentLoaded:= (IndTent <  FSeq.NumTent) and (IndTent >  -1);
    If FTentLoaded then begin
      FTent:= FSeq.Tent[IndTent];
      If FAbsCfgTentLoaded then
        LoadTent;
    end else
      If FAbsCfgTentLoaded then FAbsCfgTent.Visible:= False;
  end else begin Beep; Exit; end;

//Pós
  If not FSeqLoaded then begin Windows.Beep(1000, 1000); Exit; end;
  If not FDefTentLoaded then begin Windows.Beep(1000, 1000); Exit; end;
end;

end.
