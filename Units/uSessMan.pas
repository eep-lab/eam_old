unit uSessMan;

interface

uses Classes,
     uCfgSes, uTentMaker, uMatStmMan, uDefTentMan, uSeqMan, uAbsTent, uBlcMan;

type
  TSessMan = class(TComponent)
  private
    FCfgSes: TCfgSes;
    FBlcMan: TBlcMan;
    FTentMaker: TTentMaker;
    FMatStmMan: TMatStmMan;
    FDefTentMan: TDefTentMan;
    FSeqMan: TSeqMan;
    FOnDefTenValueChange: TValueChangeEvent;
    procedure DefTentManValueChange(IndItem, IndProp: Integer; Value: String);
  public
    constructor Create(AOwner: TComponent; CurPath: String); reintroduce;
    property MatStmMan: TMatStmMan read FMatStmMan write FMatStmMan;
    property DefTentMan: TDefTentMan read FDefTentMan write FDefTentMan;
    property TentMaker: TTentMaker read FTentMaker;
    property SeqMan: TSeqMan read FSeqMan;
    property BlcMan: TBlcMan read FBlcMan;
    property OnDefTenValueChange: TValueChangeEvent read FOnDefTenValueChange write FOnDefTenValueChange; 
  end;

implementation

procedure TSessMan.DefTentManValueChange(IndItem, IndProp: Integer; Value: String);
begin
  If Assigned(OnDefTenValueChange) then FOnDefTenValueChange(IndItem, IndProp, Value);
end;

constructor TSessMan.Create(AOwner: TComponent; CurPath: String);
begin
  Inherited Create(AOwner);
  FCfgSes:= TCfgSes.Create(Self, CurPath+'\Files Settings\CfgSes V4.txt');
  FTentMaker:= TTentMaker.Create(Self, FCfgSes.MatStm);
  FMatStmMan:= TMatStmMan.Create(Self, FCfgSes);

  FDefTentMan:= TDefTentMan.Create(Self, FCfgSes, FTentMaker);
  With FDefTentMan do begin
    OnValueChange:= DefTentManValueChange;
  end;

  FSeqMan:= TSeqMan.Create(Self, FCfgSes, FTentMaker);

  FBlcMan:= TBlcMan.Create(Self, FCfgSes, FTentMaker);  
end;

end.
