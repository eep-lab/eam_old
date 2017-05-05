unit uRegData;

interface

uses SysUtils, Classes;

type
  TRegData = class(TComponent)
  private
    FFile: TextFile;
  public
    constructor Create(AOwner: TComponent; FileName: String); Reintroduce;
    destructor Destroy; override;
    procedure SaveData(Data: String);
  end;

implementation

constructor TRegData.Create(AOwner: TComponent; FileName: String);
var a1: Integer; s1, s2: String;
begin
  Inherited Create(AOwner);
  If FileName = '' then FileName:= 'Dados.txt';
  a1:= 1;
  s1:= Copy(FileName, 0, Length(FileName)-4);
  s2:= Copy(FileName, Length(FileName)-3, 4);
  While FileExists(FileName) do begin
    Inc(a1);
    FileName:= s1+'_'+IntToStr(a1)+s2;
  end;
  AssignFile(FFile, FileName);
  Rewrite(FFile);
end;

destructor TRegData.Destroy;
begin
  CloseFile(FFile);
  Inherited Destroy;
end;

procedure TRegData.SaveData(Data: String);
begin
  Write(FFile, Data);
end;

end.
