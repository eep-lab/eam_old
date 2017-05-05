unit uCsq;

interface

uses Classes, uCfgSes;

type
  TCsq = class(TComponent)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

constructor TCsq.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
end;

destructor TCsq.Destroy;
begin
  Inherited Destroy;
end;

end.
