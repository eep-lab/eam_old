unit uCfgDefTentMan;

interface

uses Classes, Controls,
     uCfgSes, uEditCfgDefTent, uObjIns, uTentMaker, uAbsTent;

type
  TCfgSeqMan = class(TComponent)
  private
    FAbsCfgTent: TAbsCfgTent;
    FAbsCfgTentLoaded: Boolean;
    FConteiner: TWinControl;
    FEditSeq: TEditSeq;
    FObjIns: TObjIns;
    FTentMaker: TTentMaker;
    procedure AbsCfgTentValueChange(IndItem, IndValue: Integer);
    procedure ObjInsItemChange(IndItem: Integer);
    procedure ObjInsValueChange(IndItem, IndValue: Integer; AValue: TValue);
    procedure SetConteiner(WinControl: TWinControl);
  public
    constructor Create(AOwner: TComponent; CfgSes: TCfgSes); reintroduce;
    destructor Destroy; override;

    procedure SelectCfgDefTent(Name: String);
    procedure ChangeType(AType: String);

    property Conteiner: TWinControl read FConteiner write SetConteiner;
    property EditSeq: TEditSeq read FEditSeq;
    property ObjIns: TObjIns read FObjIns;
    property TentMaker: TTentMaker read FTentMaker;
  end;

implementation

procedure TCfgSeqMan.AbsCfgTentValueChange(IndItem, IndValue: Integer);
begin
  FObjIns.SetValue(IndItem, IndValue, FAbsCfgTent.VetItem^[IndItem].VetValue[IndValue]);
  FEditSeq.Selected.Value[FAbsCfgTent.VetItem^[IndItem].VetValue[IndValue].Key]:=
                          FAbsCfgTent.VetItem^[IndItem].VetValue[IndValue].Val;
end;

procedure TCfgSeqMan.ObjInsItemChange(IndItem: Integer);
begin
  FObjIns.SetValues(@FAbsCfgTent.VetItem^[IndItem].VetValue);
end;

procedure TCfgSeqMan.ObjInsValueChange(IndItem, IndValue: Integer; AValue: TValue);
begin
  If FAbsCfgTentLoaded then begin
    FAbsCfgTent.SetValue(IndItem, IndValue, AValue);
    FEditSeq.Selected.Value[AValue.Key]:= AValue.Val;
  end;
end;

procedure TCfgSeqMan.SetConteiner(WinControl: TWinControl);
begin
  FConteiner:= WinControl;
  If FAbsCfgTentLoaded then begin
    FAbsCfgTent.Parent:= FConteiner;
    FAbsCfgTent.Align:= alClient;    
  end;
end;

constructor TCfgSeqMan.Create(AOwner: TComponent; CfgSes: TCfgSes);
begin
  FEditSeq:= TEditSeq.Create(Self, CfgSes);
  With FEditSeq do begin
  
  end;

  FObjIns:= TObjIns.Create(Self);
  With FObjIns do begin
    OnItemChange:= ObjInsItemChange;
    OnValueChange:= ObjInsValueChange;
  end;

  FTentMaker:= TTentMaker.Create(Self);
  With FTentMaker do begin

  end;
end;

destructor TCfgSeqMan.Destroy;
begin

end;

procedure TCfgSeqMan.SelectCfgDefTent(Name: String);
var a1, a2: Integer;
begin
  If FAbsCfgTentLoaded then begin
    FAbsCfgTent.Free;
    FObjIns.Clear;
  end;

  FEditSeq.SelectCfgDefTent(Name);

  FAbsCfgTentLoaded:= FTentMaker.CreateAbsCfgTent(FEditSeq.Selected.Tipe, FAbsCfgTent);
  If FAbsCfgTentLoaded then begin
    SetConteiner(FConteiner);

    For a1:= 0 to High(FAbsCfgTent.VetItem^) do
      For a2:= 0 to High(FAbsCfgTent.VetItem^[a1].VetValue) do
        FAbsCfgTent.VetItem^[a1].VetValue[a2].Val:=
        FEditSeq.Selected.Value[FAbsCfgTent.VetItem^[a1].VetValue[a2].Key];

    FAbsCfgTent.Load;

    FObjIns.SetItems(FAbsCfgTent.VetItem);
    
    FAbsCfgTent.OnValueChange:= AbsCfgTentValueChange;
  end;
end;

procedure TCfgSeqMan.ChangeType(AType: String);
var a1, a2: Integer;
begin
  If Assigned(FEditSeq.Selected) then begin
    If FAbsCfgTentLoaded then begin
      FAbsCfgTent.Free;
      FObjIns.Clear;
    end;

    FAbsCfgTentLoaded:= FTentMaker.CreateAbsCfgTent(AType, FAbsCfgTent);
    If FAbsCfgTentLoaded then begin
      SetConteiner(FConteiner);

      FAbsCfgTent.VetItem^[0].VetValue[0].Val:= FEditSeq.Selected.Value[FAbsCfgTent.VetItem^[0].VetValue[0].Key];
      For a1:= 0 to High(FAbsCfgTent.VetItem^) do
        For a2:= 0 to High(FAbsCfgTent.VetItem^[a1].VetValue) do
          FEditSeq.Selected.Value[FAbsCfgTent.VetItem^[a1].VetValue[a2].Key]:= FAbsCfgTent.VetItem^[a1].VetValue[a2].Val;

      FAbsCfgTent.Load;

      FObjIns.SetItems(@FAbsCfgTent.VetItem^);

      FAbsCfgTent.OnValueChange:= AbsCfgTentValueChange;

      FEditSeq.Selected.Tipe:= AType;
    end else
      FEditSeq.Selected.Tipe:= '';
  end;
end;

end.
