unit uAbsTent;

interface

uses Classes, Controls, Graphics,
     uObjIns;

type
  TAbsTent = class(TCustomControl)
  protected
    FOnEndTent: TNotifyEvent;
    FResult: String;
  public
    procedure Play; virtual; abstract;
    property OnEndTent: TNotifyEvent read FOnEndTent write FOnEndTent;
    property Result: String read FResult;
    property Parent;
    property Align;
    property Color;
  end;

  TAtrb = record
    Cap: String;
    DefVal: String;
    ValType: TValType;
    VetDefVal: Array of String;
    LockState: TLockState;
    LockStates: TLockStates;
    Key: String;
  end;

  TObj = record
    Cap: String;
    NumAtrb: Integer;
    VetAtrb: Array of TAtrb;
  end;

  TValueChangeEvent = procedure (IndItem, IndProp: Integer; Value: String) of Object;

  TAbsCfgTent = class(TCustomControl)
  protected
    FType: String;
    FOnValueChange: TValueChangeEvent;
    FNumObj: Integer;
    FVetObj: Array of TObj;
    function GetObj_Name(Ind: Integer): String; virtual; abstract;
    function GetObj_NumAtrb(Ind: Integer): Integer; virtual; abstract;
    function GetObj_Atrb(IndObj, IndAtrb: Integer): TAtrb; virtual; abstract;

    function GetValue(IndObj, IndProp: Integer): String; virtual; abstract;
    procedure SetValue(IndObj, IndProp: Integer; Value: String); virtual; abstract;
  public
    property Tipe: String read FType;

    property Value[IndObj, IndProp: Integer]: String read GetValue write SetValue;

    property NumObj: Integer read FNumObj;
    property Obj_Name[Ind: Integer]: String read GetObj_Name;
    property Obj_NumAtrb[Ind: Integer]: Integer read GetObj_NumAtrb;
    property Obj_Atrb[IndObj, IndAtrb: Integer]: TAtrb read GetObj_Atrb;

    property OnValueChange: TValueChangeEvent read FOnValueChange write FOnValueChange;
  end;

implementation

end.
