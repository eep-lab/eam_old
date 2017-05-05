unit uAbsTent;

interface

uses Windows, classes, controls, uChave;

type
  TDatas = Array of String;

  PDatas = ^TDatas;

  TEndTentEvent = procedure (Sender: TObject; Datas: TDatas) of Object;

  TAbstractTentativa = class(TCustomControl)
  protected
    FEfeitoSonoro: Boolean;
    FEndSes: TNotifyEvent;
    FEndTent: TEndTentEvent;
    FID: Integer;
    function  GetMatChv(Ind1, Ind2: Integer): TChave; virtual; abstract;
    function  GetMatPar(Ind1, Ind2: Integer): Variant; virtual; abstract;
    procedure SetMatPar(Ind1, Ind2: Integer; Value: Variant); virtual; abstract;
  public
    function  InsertChv(Ind1, Ind2: Integer; AChave: TChave): Boolean; virtual; abstract;
    procedure Play; virtual; abstract;
    procedure Reset; virtual; abstract;
    property Align;
    property Cursor;
    property EfeitoSonoro: Boolean read FEfeitoSonoro write FEfeitoSonoro;
    property ID: Integer read FID write FID;
    property MatChv[Ind1, Ind2: Integer]: TChave read GetMatChv;
    property MatPar[Ind1, Ind2: Integer]: Variant read GetMatPar Write SetMatPar;
    property OnEndSes: TNotifyEvent read FEndSes write FEndSes;
    property OnEndTent: TEndTentEvent read FEndTent write FEndTent;
  end;

implementation

end.
