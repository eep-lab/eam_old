unit uDefTentMan;

interface

uses Classes, Controls,
     uCfgSes, uObjIns, uTentMaker, uAbsTent;

type
  TDefTentMan = class(TComponent)
  private
    FAbsCfgTent: TAbsCfgTent;
    FAbsCfgTentLoaded: Boolean;
    FCfgSes:  TCfgSes;
    FConteiner: TWinControl;
    FDefTent: TDefTent;
    FDefTentLoaded: Boolean;
    FOnValueChange: TValueChangeEvent;
    FTentMaker: TTentMaker;
    procedure AbsCfgTentValueChange(IndItem, IndValue: Integer; Value: String);
    function GetNumDefTent: Integer;
    function GetNumObj: Integer;
    function GetObj_Name(Ind: Integer): String;
    function GetObj_NumAtrb(Ind: Integer): Integer;
    function GetObj_Atrb(IndObj, IndAtrb: Integer): TAtrb;

    function GetDefTentName(Ind: Integer): String;
    procedure SetDefTentName(Ind: Integer; Name: String);

    function GetValue(IndObj, IndProp: Integer): String;
    procedure SetValue(IndObj, IndProp: Integer; Value: String);
  public
    constructor Create(AOwner: TComponent; CfgSes: TCfgSes; TentMaker: TTentMaker); reintroduce;
    destructor Destroy; override;

    function NewDefTent(DefTentName: String): String;
    procedure SelectDefTent(DefTentName: String);
    procedure DeleteDefTent(DefTentName: String);

    procedure ChangeType(AType: String);

    property NumDefTent: Integer read GetNumDefTent;
    property NumObj: Integer read GetNumObj;
    property Obj_Name[Ind: Integer]: String read GetObj_Name;
    property Obj_NumAtrb[Ind: Integer]: Integer read GetObj_NumAtrb;
    property Obj_Atrb[IndObj, IndAtrb: Integer]: TAtrb read GetObj_Atrb;

    property Value[IndObj, IndProp: Integer]: String read GetValue write SetValue;

    property DefTentName[Ind: Integer]: String read GetDefTentName write SetDefTentName;
    property OnValueChange: TValueChangeEvent read FOnValueChange write FOnValueChange;
    property Conteiner: TWinControl read FConteiner write FConteiner;
  end;

implementation

procedure TDefTentMan.AbsCfgTentValueChange(IndItem, IndValue: Integer; Value: String);
begin
  If Assigned(OnValueChange) then FOnValueChange(IndItem, IndValue, Value);
  If FDefTentLoaded then
    If FAbsCfgTentLoaded then
      FDefTent.Value[FAbsCfgTent.Obj_Atrb[IndItem, IndValue].Key]:= Value;
end;

function TDefTentMan.GetNumDefTent: Integer;
begin
  Result:= FCfgSes.NumDefTent;
end;

function TDefTentMan.GetDefTentName(Ind: Integer): String;
begin
  Result:= FCfgSes.DefTent[Ind].Name;
end;

function TDefTentMan.GetNumObj: Integer;
begin
  If FAbsCfgTentLoaded then
    Result:= FAbsCfgTent.NumObj
  else Result:= 0;
end;

function TDefTentMan.GetObj_Name(Ind: Integer): String;
begin
  If FAbsCfgTentLoaded then
    Result:= FAbsCfgTent.Obj_Name[Ind];
end;

function TDefTentMan.GetObj_NumAtrb(Ind: Integer): Integer;
begin
  If FAbsCfgTentLoaded then
    Result:= FAbsCfgTent.Obj_NumAtrb[Ind]
  else Result:= 0;
end;

function TDefTentMan.GetObj_Atrb(IndObj, IndAtrb: Integer): TAtrb;
begin
  If FAbsCfgTentLoaded then
    Result:= FAbsCfgTent.Obj_Atrb[IndObj, IndAtrb];
end;

procedure TDefTentMan.SetDefTentName(Ind: Integer; Name: String);
begin
  FCfgSes.DefTent[Ind].Name:= Name;
end;

function TDefTentMan.GetValue(IndObj, IndProp: Integer): String;
begin
  If FDefTentLoaded then begin
    If FAbsCfgTentLoaded then begin
      Result:= FAbsCfgTent.Value[IndObj, IndProp];
    end;
  end;
end;

procedure TDefTentMan.SetValue(IndObj, IndProp: Integer; Value: String);
begin
  If FDefTentLoaded then begin
    If FAbsCfgTentLoaded then begin
      FAbsCfgTent.Value[IndObj, IndProp]:= Value;
      FDefTent.Value[FAbsCfgTent.Obj_Atrb[IndObj, IndProp].Key]:= Value;
    end;
  end;
end;

constructor TDefTentMan.Create(AOwner: TComponent; CfgSes: TCfgSes; TentMaker: TTentMaker);
begin
  Inherited Create(AOwner);
  FCfgSes:= CfgSes;
  FTentMaker:= TentMaker;
end;

destructor TDefTentMan.Destroy;
begin
  Inherited Destroy;
end;

function TDefTentMan.NewDefTent(DefTentName: String): String;
begin
  FDefTentLoaded:= FCfgSes.NewDefTent(DefTentName, FDefTent);
  If FDefTentLoaded then begin
    Result:= FDefTent.Name;
    If FAbsCfgTentLoaded then FAbsCfgTent.Free;
    FAbsCfgTentLoaded:= False;
  end;
end;

procedure TDefTentMan.SelectDefTent(DefTentName: String);
var a1, a2: Integer;
begin
  FDefTentLoaded:= FCfgSes.DefTentByName(DefTentName, FDefTent);
  If FDefTentLoaded then begin
    If FAbsCfgTentLoaded then FAbsCfgTent.Free;
    FAbsCfgTentLoaded:= FTentMaker.CreateAbsCfgTent(FDefTent.Tipe, FAbsCfgTent);
      If FAbsCfgTentLoaded then begin
        FAbsCfgTent.Parent:= FConteiner;
        FAbsCfgTent.Align:= alClient;
        FAbsCfgTent.OnValueChange:= AbsCfgTentValueChange;
        For a1:= 0 to FAbsCfgTent.NumObj-1 do
          For a2:= 0 to FAbsCfgTent.Obj_NumAtrb[a1]-1 do
            FAbsCfgTent.Value[a1, a2]:= FDefTent.Value[FAbsCfgTent.Obj_Atrb[a1, a2].Key];
      end;
  end;
end;

procedure TDefTentMan.DeleteDefTent(DefTentName: String);
begin
  FDefTentLoaded:= FCfgSes.DeleteDefTent(DefTentName);
  If FAbsCfgTentLoaded then FAbsCfgTent.Free;
  FAbsCfgTentLoaded:= False;
end;

procedure TDefTentMan.ChangeType(AType: String);
var a1, a2: Integer;
begin
  If FDefTentLoaded then begin
    If FAbsCfgTentLoaded then FAbsCfgTent.Free;
    FAbsCfgTentLoaded:= FTentMaker.CreateAbsCfgTent(AType, FAbsCfgTent);
    If FAbsCfgTentLoaded then begin
      FAbsCfgTent.Parent:= FConteiner;
      FAbsCfgTent.Align:= alClient;
      FAbsCfgTent.OnValueChange:= AbsCfgTentValueChange;

      For a1:= 0 to FAbsCfgTent.NumObj-1 do
        For a2:= 0 to FAbsCfgTent.Obj_NumAtrb[a1]-1 do
          FDefTent.Value[FAbsCfgTent.Obj_Atrb[a1, a2].Key]:= FAbsCfgTent.Value[a1, a2];

    end;
    FDefTent.Tipe:= AType;
  end;
end;

end.
