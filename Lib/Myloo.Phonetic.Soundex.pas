unit Myloo.Phonetic.Soundex;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.classes,
  Myloo.Phonetic.Interfaces,
  Myloo.Patterns.Singleton,
  Myloo.Strings.Utils;

type
  TSoundexBr = class//(TInterfacedObject, IPhoneticMatching)
  public
    class function PhoneticMatching(AText:string):string;
//    function PhoneticMatching(AText:string):string;overload;
//    function Int(const AText: string): Integer;
//    function DecodeInt(AValue: Integer): string;
//    function Word(const AText: string): Word;
//    function DecodeWord(AValue: Word): string;
//    function Similar(const AText, AOther: string): Boolean;
//    function Compare(const AText, AOther: string): Integer;
//    function Proc(const AText, AOther: string): Boolean;
  end;

  TSSoundexBr = TSingleton<TSoundexBr>;

implementation

{ TSoundexBr }

class function TSoundexBr.PhoneticMatching(AText: string): string;
begin
  //
end;

//function TSoundexBr.Int(const AText: string): Integer;
//var
//  LResult: string;
//  I: Integer;
//begin
//  Result := 0;
//  if AText <> '' then
//  begin
//    LResult := PhoneticMatching(AText);
//    Result := Ord(LResult[1]) - Ord('A');
//    if ALength > 1 then
//    begin
//      Result := Result * 26 + StrToInt(LResult[2]);
//      for I := 3 to ALength do
//        Result := Result * 7 + StrToInt(LResult[I]);
//    end;
//    Result := Result * 9 + ALength;
//  end;
//end;
//
//function TSoundexBr.DecodeInt(AValue: Integer): string;
//var
//  I, LLength: Integer;
//begin
//  Result := '';
//  LLength := AValue mod 9;
//  AValue := AValue div 9;
//  for I := LLength downto 3 do
//  begin
//    Result := IntToStr(AValue mod 7) + Result;
//    AValue := AValue div 7;
//  end;
//  if LLength > 2 then
//    Result := IntToStr(AValue mod 26) + Result;
//  AValue := AValue div 26;
//  Result := Chr(AValue + Ord('A')) + Result;
//end;
//
//function TSoundexBr.Word(const AText: string): Word;
//var
//  LResult: string;
//begin
//  LResult := Soundex(AText, 4);
//  Result := Ord(LResult[1]) - Ord('A');
//  Result := Result * 26 + StrToInt(LResult[2]);
//  Result := Result * 7 + StrToInt(LResult[3]);
//  Result := Result * 7 + StrToInt(LResult[4]);
//end;
//
//function TSoundexBr.DecodeWord(AValue: Word): string;
//begin
//  Result := IntToStr(AValue mod 7) + Result;
//  AValue := AValue div 7;
//  Result := IntToStr(AValue mod 7) + Result;
//  AValue := AValue div 7;
//  Result := IntToStr(AValue mod 26) + Result;
//  AValue := AValue div 26;
//  Result := Chr(AValue + Ord('A')) + Result;
//end;
//
//function TSoundexBr.Similar(const AText, AOther: string): Boolean;
//begin
//  Result := PhoneticMatching(AText) = PhoneticMatching(AOther);
//end;
//
//function TSoundexBr.Compare(const AText, AOther: string): Integer;
//begin
//  Result := AnsiCompareStr(PhoneticMatching(AText), PhoneticMatching(AOther));
//end;
//
//function TSoundexBr.Proc(const AText, AOther: string): Boolean;
//begin
//  Result := Similar(AText, AOther);
//end;

end.
