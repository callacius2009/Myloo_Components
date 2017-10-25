unit MylooComp.Reg;

interface

uses
  System.Classes,
  DataComboDbx,
  DataComboZeos,
  DBDataComboDBX,
  DBDataComboZeos;

procedure Register;

implementation

procedure Register;
begin
     RegisterComponents('Myloo Componentes', [TDataComboDbx, TDataComboZeos, TDBDataComboDBX,TDBDataComboZeos]);
end;

end.
