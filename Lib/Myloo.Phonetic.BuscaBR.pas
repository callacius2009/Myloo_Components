//Read more: http://www.linhadecodigo.com.br/artigo/2237/implementando-algoritmo-buscabr.aspx#ixzz4kmJj5J00
unit Myloo.Phonetic.BuscaBR;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.classes,
  Myloo.Phonetic.Interfaces,
  Myloo.Patterns.Singleton,
  Myloo.Strings.Utils;

type
  TBuscaBR = class(TInterfacedObject, IPhoneticMatching)
  public
    class function PhoneticMatching(AText:string):string;overload;
    function Phonetic(AText:string):string;overload;
    function Similar(const AText, AOther: string): Boolean;
    function Compare(const AText, AOther: string): Integer;
    function Proc(const AText, AOther: string): Boolean;
  end;

  TSBuscaBR = TSingleton<TBuscaBR>;

implementation

{ TBuscaBR }

class function TBuscaBR.PhoneticMatching(AText: string): string;
var
  NewStr:string;
begin
  Result := EmptyStr;
  NewStr := RemoveAccents(AText);
  NewStr := StrReplace(NewStr,['BL','BR'],'B');
  NewStr := StrReplace(NewStr,['PH'],'F');
  NewStr := StrReplace(NewStr,['GL','GR','MG','NG','RG'],'G');
  NewStr := StrReplace(NewStr,['Y'],'I');
  NewStr := StrReplace(NewStr,['GE','GI','RJ','MJ'],'J');
  NewStr := StrReplace(NewStr,['CA','CO','CU','CK','Q'],'K');
  NewStr := StrReplace(NewStr,['N','AO','AUM','GM','MD','OM','ON'],'M');
  NewStr := StrReplace(NewStr,['PR'],'P');
  NewStr := StrReplace(NewStr,['L'],'R');
  NewStr := StrReplace(NewStr,['Ç','CE','CI','CH','CS','RS','TS','X','Z'],'S');
  NewStr := StrReplace(NewStr,['TR','TL','CT','RT','ST','PT'],'T');
  NewStr := ReplaceInitialChar(NewStr,['U','W'],'V');
  NewStr := StrReplace(NewStr,['RM'],'SM');
  NewStr := ReplaceFinalChar(NewStr,['M','R','S'],#0);
  NewStr := StrReplace(NewStr,['H','A','E','I','O','U'],EmptyStr);
  NewStr := RemoveSpecialCharacters(NewStr);
  Result := NewStr;
end;

function TBuscaBR.Phonetic(AText: string): string;
var
  NewStr:string;
begin
  Result := EmptyStr;
  NewStr := RemoveAccents(AText);
  NewStr := StrReplace(NewStr,['BL','BR'],'B');
  NewStr := StrReplace(NewStr,['PH'],'F');
  NewStr := StrReplace(NewStr,['GL','GR','MG','NG','RG'],'G');
  NewStr := StrReplace(NewStr,['Y'],'I');
  NewStr := StrReplace(NewStr,['GE','GI','RJ','MJ'],'J');
  NewStr := StrReplace(NewStr,['CA','CO','CU','CK','Q'],'K');
  NewStr := StrReplace(NewStr,['N','AO','AUM','GM','MD','OM','ON'],'M');
  NewStr := StrReplace(NewStr,['PR'],'P');
  NewStr := StrReplace(NewStr,['L'],'R');
  NewStr := StrReplace(NewStr,['Ç','CE','CI','CH','CS','RS','TS','X','Z'],'S');
  NewStr := StrReplace(NewStr,['TR','TL','CT','RT','ST','PT'],'T');
  NewStr := ReplaceInitialChar(NewStr,['U','W'],'V');
  NewStr := StrReplace(NewStr,['RM'],'SM');
  NewStr := ReplaceFinalChar(NewStr,['M','R','S'],#0);
  NewStr := StrReplace(NewStr,['H','A','E','I','O','U'],EmptyStr);
  NewStr := RemoveSpecialCharacters(NewStr);
  Result := NewStr;
end;

function TBuscaBR.Similar(const AText, AOther: string): Boolean;
begin
  Result := Phonetic(AText) = Phonetic(AOther); // compara se as 2 strings são iguais e retorna boolean
end;

function TBuscaBR.Compare(const AText, AOther: string): Integer; // Compara se as 2 strings são iguais e retorna inteiro
begin
  Result := AnsiCompareStr(Phonetic(AText), Phonetic(AOther));
end;

function TBuscaBR.Proc(const AText, AOther: string): Boolean; // compara se os 4 primeiros caracteres são iguais e retorna boolean
begin
  Result := Similar(LeftStr(AText,4), LeftStr(AOther,4));
end;

end.
