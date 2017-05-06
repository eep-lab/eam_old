unit uTrial;


interface

uses Controls, Classes,
     uCfgSes;

type
  TTrial = class(TCustomControl)
  protected
    FCfgTrial: TCfgTrial;
    FOnEndTrial: TNotifyEvent;
    FResult: String;                               
    FHeader: String;
    FData: String;
    FNextTrial: String;
  public
    procedure Play(TestMode: Boolean); virtual; abstract;

    property CfgTrial: TCfgTrial write FCfgTrial;
    property OnEndTrial: TNotifyEvent read FOnEndTrial write FOnEndTrial;
    property Result: String read FResult;
    property Header: String read FHeader;
    property Data: String read FData;
    property NextTrial: String read FNextTrial;
  end;

function inportb(EndPorta: Integer): BYTE stdcall; external 'inpout32.DLL' name 'Inp32';
procedure outportb(EndPorta: Integer; Valor:BYTE); stdcall; external 'inpout32.DLL' name 'Out32';

implementation

end.
