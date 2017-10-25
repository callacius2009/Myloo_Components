unit Myloo.Phonetic.Utils;

interface

uses
  System.SysUtils,
  System.classes,
  Myloo.Phonetic.Interfaces,
  Myloo.Patterns.Singleton;

type
  TUtilsPhonetic = class
    class function RemoveAccents(AText: string): string;
    class function RemoveOfStr(AText:string;APattern:Array of string): string;
    class function RemoveDuplicate(AText: string): string;
    class function StrReplace(const AText: string;AOldChar:array of string;ANewChar:string):string;
    class function AdaptStr(AText: string): string;
  end;

  TSUtilsPhonetic = TSingleton<TUtilsPhonetic>;

implementation

{ TUtilsPhonetic }

class function TUtilsPhonetic.AdaptStr(AText: string): string;
var
  n:Integer;
  NewStr:string;
begin
  Result := EmptyStr;
  for n := 1 to Length(AText) do
  begin
    case AText[n] of
      'B','D','F','J','K','L','M','N','R','T','V','X': NewStr := Format('%s%s',[NewStr,AText[n]]);{Ignorar A,E,I,O,U,Y,H e Espaços}
      'C': { CH = X}
      begin
        if AText[n+1] = 'H' then NewStr := Format('%sX',[NewStr]){CH = X}
        else if CharInSet(AText[n+1],['A','O','U']) then NewStr := Format('%sK',[NewStr]) {Carol = Karol}
        else if CharInSet(AText[n+1],['E','I']) then NewStr := Format('%sS',[NewStr]); {Celina = Selina, Cintia = Sintia}
      end;
      'G': if AText[n+n] = 'E' then NewStr := Format('%sJ',[NewStr]) else NewStr := Format('%sG',[NewStr]); {Jeferson = Geferson}
      'P': if AText[n+1] = 'H' then NewStr := Format('%sF',[NewStr]) else NewStr := Format('%sP',[NewStr]); {Phelipe = Felipe}
      'Q': if AText[n+1] = 'U' then NewStr := Format('%sK',[NewStr]) else NewStr := Format('%sQ',[NewStr]); {Keila = Queila}
      'S': if AText[n+1] = 'H' then NewStr := Format('%sX',[NewStr]); {SH = X}
      'A','E','I','O','U': if CharInSet(AText[n-1],['A','E','I','O','U']) then NewStr := Format('%sZ',[NewStr]) else NewStr := Format('%sS',[NewStr]); {S entre duas vogais = Z}
      'W': NewStr := Format('%sV',[NewStr]); {Walter = Valter}
      'Z': if ((n = Length(AText)) or (AText[n+1] = EmptyStr)) then NewStr := Format('%sS',[NewStr]) else NewStr := Format('%sZ',[NewStr]); {No final do nome Tem som de S -> Luiz = Luis}
    end;
  end;
  Result := NewStr;
end;

class function TUtilsPhonetic.RemoveAccents(AText: string): string;
var
  NewStr:string;
begin
  Result := EmptyStr;
  NewStr := Trim(UpperCase(AText));
  NewStr := StrReplace(NewStr,['Á', 'Â', 'Ã', 'À', 'Ä', 'Å'],'A');
  NewStr := StrReplace(NewStr,['É', 'Ê', 'È', 'Ë'],'E');
  NewStr := StrReplace(NewStr,['Í', 'Î', 'Ì', 'Ï'],'I');
  NewStr := StrReplace(NewStr,['Ó', 'Ô', 'Õ', 'Ò', 'Ö'],'O');
  NewStr := StrReplace(NewStr,['Ú', 'Û', 'Ù', 'Ü'],'U');
  NewStr := StrReplace(NewStr,['Ý', 'Ÿ', 'Y'],'Y');
  NewStr := StrReplace(NewStr,['Ç'],'C');
  NewStr := StrReplace(NewStr,['Ñ'],'N');
  Result := NewStr;
end;

class function TUtilsPhonetic.RemoveDuplicate(AText: string): string;
var
  n:Integer;
  NewStr:string;
begin
  Result := EmptyStr;
  NewStr := UpperCase(Trim(AText));
  for n := 1 to Pred(Length(AText)) do
  begin
    if NewStr[n] = NewStr[n+1] then
      Delete(NewStr,n,1);
  end;
  Result := NewStr;
end;

class function TUtilsPhonetic.RemoveOfStr(AText: string;
  APattern: array of string): string;
var
  n,p:Integer;
  NewStr:string;
begin
  Result := EmptyStr;
  NewStr := UpperCase(Trim(AText));
  for n := low(APattern) to High(APattern) do
  begin
    p:= Pos(APattern[n],NewStr);
    while p > 0 do
    begin
      Delete(NewStr,p,Length(APattern[n]));
      p:= Pos(APattern[n],NewStr);
    end;
  end;
  Result := NewStr;
end;

class function TUtilsPhonetic.StrReplace(const AText: string;
  AOldChar: array of string; ANewChar: string): string;
var
  n:Integer;
  New:TStringBuilder;
begin
  New := TStringBuilder.Create;
  New.Clear;
  New.Append(AText);
  for n := Low(AOldChar) to High(AOldChar) do
  begin
    New.Replace(AOldChar[n],ANewChar);
  end;
  Result := New.ToString;
end;

end.
