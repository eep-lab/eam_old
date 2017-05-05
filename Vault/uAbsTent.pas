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

  TValueChangeEvent = procedure (IndItem, IndProp: Integer; Value: String) of Object;

  TAbsCfgTent = class(TCustomControl)
  protected
    FType: String;
    FOnValueChange: TValueChangeEvent;
    FVetItem: TVetItem;
    function GetVetItem: TVetItem; virtual; abstract;
  public
    procedure Load(SLMatStm, SLCfgSeq, SLCfgTent: TStringList); overload; virtual; abstract;
    procedure Load; overload; virtual; abstract;
    procedure SetValue(IndItem, IndValue: Integer; Value: String); virtual; abstract;
    property VetItem: TVetItem read GetVetItem;
    property OnValueChange: TValueChangeEvent read FOnValueChange write FOnValueChange;
    property Tipe: String read FType;
  end;

implementation

end.
