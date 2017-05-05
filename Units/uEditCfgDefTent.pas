unit uEditCfgDefTent;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, Spin, CheckLst, IniFiles, Buttons, Menus, Grids,
  uCfgSes, uTentMaker, uAbsTent, uObjIns;

Type
  TEditSeq = class(TComponent)
  private
    FCfgDefTent: TDefTent;
    FCfgSes: TCfgSes;
    function GetNumDefTent: Integer;
  public
    constructor Create(AOwner: TComponent; CfgSes: TCfgSes); reintroduce;
    destructor Destroy; override;

    procedure CfgSeqDel(AName: String);
    procedure CfgSeqNew;
    procedure GetCfgDefTentNames(SList: TStrings);

    procedure SelectCfgDefTent(Name: String);

    property NumCfgDefTent: Integer read GetNumDefTent;
    property Selected: TDefTent read FCfgDefTent;

  end;

implementation

function TEditSeq.GetNumDefTent: Integer;
begin
  Result:= FCfgSes.NumDefTent;
end;

constructor TEditSeq.Create(AOwner: TComponent; CfgSes: TCfgSes);
begin
  Inherited Create(AOwner);
  FCfgSes:= CfgSes;
end;

destructor TEditSeq.Destroy;
begin
  Inherited Destroy;
end;

procedure TEditSeq.GetCfgDefTentNames(SList: TStrings);
var a1: Integer;
begin
  If Assigned(SList) then begin
    SList.Clear;
    For a1:= 0 to FCfgSes.NumDefTent-1 do
      SList.Add(FCfgSes.DefTent[a1].Name);
  end;
end;

procedure TEditSeq.SelectCfgDefTent(Name: String);
var a1, a2: Integer;
begin
  a2:= -1;
  FCfgDefTent:= nil;
  For a1:= 0 to FCfgSes.NumDefTent-1 do
    If FCfgSes.DefTent[a1].Name = Name then
      a2:= a1;
  FCfgDefTent:= FCfgSes.DefTent[a2];
end;

procedure TEditSeq.CfgSeqNew;
begin
  FCfgSes.AddCfgDefTent('Nova Configuração de Tentativa');
end;

procedure TEditSeq.CfgSeqDel(AName: String);
begin

end;

end.
