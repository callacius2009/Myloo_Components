unit Myloo.Patterns.Singleton;

interface

uses
  Winapi.Windows,
  System.Classes,
  System.Generics.Defaults,
  System.Generics.Collections,
  System.Rtti,
  System.TypInfo,
  System.RTLConsts,
  System.SysUtils;

type
  TSingleton<T: class, constructor> = class
  strict private
    class var FInstance : T;
  public
    class function GetInstance(): T;
    class procedure ReleaseInstance();
  end;

implementation

{ TSingleton }

class function TSingleton<T>.GetInstance: T;
begin
  if not Assigned(Self.FInstance) then
    Self.FInstance := T.Create();
  Result := Self.FInstance;
end;

class procedure TSingleton<T>.ReleaseInstance;
begin
  if Assigned(Self.FInstance) then
    Self.FInstance.Free;
end;



end.
