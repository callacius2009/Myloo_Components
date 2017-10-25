unit Myloo.Phonetic.Metaphone;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.classes,
  Myloo.Phonetic.Interfaces,
  Myloo.Patterns.Singleton,
  Myloo.Strings.Utils,
  Myloo.Phonetic.Utils;

type
  TMetaphoneBr = class(TInterfacedObject, IPhoneticMatching)
  public
    class function PhoneticMatching(AText:string):string;
    function Phonetic(AText:string):string;
    function Similar(const AText, AOther: string): Boolean;
    function Compare(const AText, AOther: string): Integer;
    function Proc(const AText, AOther: string): Boolean;
  end;

  TSMetaphoneBr = TSingleton<TMetaphoneBr>;

implementation

{ TMetaphoneBr }

class function TMetaphoneBr.PhoneticMatching(AText: string): string;
var
  NewStr:string;
begin
  Result := EmptyStr;
  NewStr := AnsiUpperCase(AText);
  NewStr := StrReplace(NewStr,['Ç'],'S');
  NewStr := RemoveInitialChar(NewStr,['H']);
  NewStr := RemoveAccents(NewStr);
  NewStr := ReplaceInitialChar(NewStr,['R'],'2');
  NewStr := ReplaceBetweenVowel(NewStr,['S'],'Z');
  NewStr := StrReplace(NewStr,['PH'],'F');
  NewStr := StrReplace(NewStr,['TH'],'T');
  NewStr := StrReplace(NewStr,['GE'],'JE');
  NewStr := StrReplace(NewStr,['GI'],'JI');
  NewStr := StrReplace(NewStr,['GY'],'JY');
  NewStr := StrReplace(NewStr,['GUE'],'GE');
  NewStr := StrReplace(NewStr,['GUI'],'GI');
  NewStr := StrReplace(NewStr,['CH'],'X');
  NewStr := StrReplace(NewStr,['CK'],'K');
  NewStr := StrReplace(NewStr,['CQ'],'K');
  NewStr := StrReplace(NewStr,['CE'],'SE');
  NewStr := StrReplace(NewStr,['CI'],'SI');
  NewStr := StrReplace(NewStr,['CY'],'SY');
  NewStr := StrReplace(NewStr,['CA'],'KA');
  NewStr := StrReplace(NewStr,['CO'],'KO');
  NewStr := StrReplace(NewStr,['CU'],'KU');
  NewStr := StrReplace(NewStr,['C'],'K');
  NewStr := StrReplace(NewStr,['LH'],'1');
  NewStr := StrReplace(NewStr,['NH'],'3');
  NewStr := StrReplace(NewStr,['RR'],'2');
  NewStr := ReplaceFinalChar(NewStr,['R'],'2');
  NewStr := StrReplace(NewStr,['XC'],'SS');
  NewStr := ReplaceFinalChar(NewStr,['Z'],'S');
  NewStr := ReplaceFinalChar(NewStr,['N'],'M');
  NewStr := StrReplace(NewStr,['SS'],'S');
  NewStr := StrReplace(NewStr,['SH'],'X');
  NewStr := StrReplace(NewStr,['SCE'],'SE');
  NewStr := StrReplace(NewStr,['SCI'],'SI');
  NewStr := StrReplace(NewStr,['XCE'],'SE');
  NewStr := StrReplace(NewStr,['XCI'],'SI');
  NewStr := StrReplace(NewStr,['XA'],'KSA');
  NewStr := StrReplace(NewStr,['XO'],'KS0');
  NewStr := StrReplace(NewStr,['XU'],'KSU');
  NewStr := StrReplace(NewStr,['W'],'V');
  NewStr := StrReplace(NewStr,['Q'],'K');
  NewStr := RemoveVowelLessStart(NewStr);
  NewStr := RemoveDuplicateStr(NewStr,['B','C','G','L','T','P','D','F','J','K','M','V','N','Z']);
  NewStr := RemoveSpecialCharacters(NewStr);
  Result := NewStr;
end;

function TMetaphoneBr.Phonetic(AText: string): string;
var
  NewStr:string;
begin
  Result := EmptyStr;
  NewStr := AnsiUpperCase(AText);
  NewStr := StrReplace(NewStr,['Ç'],'S');
  NewStr := RemoveInitialChar(NewStr,['H']);
  NewStr := RemoveAccents(NewStr);
  NewStr := ReplaceInitialChar(NewStr,['R'],'2');
  NewStr := ReplaceBetweenVowel(NewStr,['S'],'Z');
  NewStr := StrReplace(NewStr,['PH'],'F');
  NewStr := StrReplace(NewStr,['TH'],'T');
  NewStr := StrReplace(NewStr,['GE'],'JE');
  NewStr := StrReplace(NewStr,['GI'],'JI');
  NewStr := StrReplace(NewStr,['GY'],'JY');
  NewStr := StrReplace(NewStr,['GUE'],'GE');
  NewStr := StrReplace(NewStr,['GUI'],'GI');
  NewStr := StrReplace(NewStr,['CH'],'X');
  NewStr := StrReplace(NewStr,['CK'],'K');
  NewStr := StrReplace(NewStr,['CQ'],'K');
  NewStr := StrReplace(NewStr,['CE'],'SE');
  NewStr := StrReplace(NewStr,['CI'],'SI');
  NewStr := StrReplace(NewStr,['CY'],'SY');
  NewStr := StrReplace(NewStr,['CA'],'KA');
  NewStr := StrReplace(NewStr,['CO'],'KO');
  NewStr := StrReplace(NewStr,['CU'],'KU');
  NewStr := StrReplace(NewStr,['C'],'K');
  NewStr := StrReplace(NewStr,['LH'],'1');
  NewStr := StrReplace(NewStr,['NH'],'3');
  NewStr := StrReplace(NewStr,['RR'],'2');
  NewStr := ReplaceFinalChar(NewStr,['R'],'2');
  NewStr := StrReplace(NewStr,['XC'],'SS');
  NewStr := ReplaceFinalChar(NewStr,['Z'],'S');
  NewStr := ReplaceFinalChar(NewStr,['N'],'M');
  NewStr := StrReplace(NewStr,['SS'],'S');
  NewStr := StrReplace(NewStr,['SH'],'X');
  NewStr := StrReplace(NewStr,['SCE'],'SE');
  NewStr := StrReplace(NewStr,['SCI'],'SI');
  NewStr := StrReplace(NewStr,['XCE'],'SE');
  NewStr := StrReplace(NewStr,['XCI'],'SI');
  NewStr := StrReplace(NewStr,['XA'],'KSA');
  NewStr := StrReplace(NewStr,['XO'],'KS0');
  NewStr := StrReplace(NewStr,['XU'],'KSU');
  NewStr := StrReplace(NewStr,['W'],'V');
  NewStr := StrReplace(NewStr,['Q'],'K');
  NewStr := RemoveVowelLessStart(NewStr);
  NewStr := RemoveDuplicateStr(NewStr,['B','C','G','L','T','P','D','F','J','K','M','V','N','Z']);
  NewStr := RemoveSpecialCharacters(NewStr);
  Result := NewStr;
end;

function TMetaphoneBr.Similar(const AText, AOther: string): Boolean;
begin
  Result := Phonetic(AText) = Phonetic(AOther);
end;

function TMetaphoneBr.Compare(const AText, AOther: string): Integer;
begin
  Result := AnsiCompareStr(Phonetic(AText), Phonetic(AOther));
end;

function TMetaphoneBr.Proc(const AText, AOther: string): Boolean;
begin
  Result := Similar(LeftStr(AText,4), LeftStr(AOther,4));
end;

end.
