unit Myloo.Strings.Utils;

interface
uses
  SysUtils,
  System.StrUtils,
  System.Classes,
  Vcl.Graphics,
  Soap.EncdDecd,
  Myloo.Comp.Coll.Base;

type
  TSplitStringCollection = class(TSequence<string>)
  private type
    TEnumerator = class(TAbstractEnumerator<string>)
    private
      LNowIndex, LPrevIndex, FLength: NativeInt;
    public
      constructor Create(const AOwner: TSplitStringCollection);
      function TryMoveNext(out ACurrent: string): Boolean; override;
    end;

  private
    FInputString: string;
    FSeparator: Char;
    FCount: NativeInt;
  protected
    function GetCount(): NativeInt; override;
  public
    constructor Create(const AString: string; const ASeparator: Char = ' '); overload;
    constructor Create(const ARules: TRules<string>; const AString: string; const ASeparator: Char = ' '); overload;
    function Empty(): Boolean; override;
    property Count: NativeInt read FCount;
    function GetEnumerator(): IEnumerator<string>; override;
  end;
  function SplitString(const AString: string; const ASeparator: Char = ' '): ISequence<string>;
  function ReturnSplitString(AText:string):TStrings;
  function ReturnGroupString(AText:string):TStrings;
  function RemoveAccents(AText: string): string;
  function RemoveOfStr(AText:string;APattern:Array of string): string;
  function RemoveDuplicate(AText: string): string;
  function StrReplace(const AText: string;AOldChar:array of string;ANewChar:string):string;
  function AdaptStr(AText: string): string;
  function ReplaceInitialChar(AText:string;AOldChar:array of Char;ANewChar:Char): string;
  function ReplaceFinalChar(AText:string;AOldChar:array of Char;ANewChar:Char): string;
  function StrListJoin(AStrList:TStringList):string;
  function Upper(AText:string):string;
  function BitmapFromBase64(const base64: string): TBitmap;
  function Base64FromBitmap(Bitmap: TBitmap): string;
  function RemoveVowelLessStart(AText:string):string;
  function ReplaceBetweenStr(AText:string;AOldChar:array of Char;ANewChar:Char):string;
  function RemoveDuplicateStr(AText:string;AListChar:array of Char):string;
  function RemoveInitialChar(AText:string;AListChar:array of Char): string;
  function ReplaceBetweenVowel(AText:string;AOldChar:array of Char;ANewChar:Char):string;
  function IsVowel(AChar:Char):Boolean;
  function RemoveSpecialCharacters(AText:string):string;

implementation

function ReturnSplitString(AText:string):TStrings;
var
  Values: TStrings;
  LWord, LInput: string;
begin
  Values := TStringList.Create;
  LInput := AText;
  //Values.add('Spliting the text: ');
  for LWord in SplitString(LInput) do
    Values.Add(LWord);
  Result:= Values;
end;

function ReturnGroupString(AText:string):TStrings;
var
  ValSplit, ValGroup: TStrings;
  LWord, LInput: string;
  LGroup: IGrouping<Integer, string>;
begin
  ValSplit := TStringList.Create;
  ValGroup := TStringList.Create;
  LInput := AText;
  //ValGroup.add('Write all words groupped by their length: ');
  for LWord in SplitString(LInput) do
    ValSplit.Add(LWord);
  for LGroup in SplitString(LInput).
    Op.GroupBy<Integer>(function(S: String): Integer begin Exit(Length(S)) end).
    Ordered(function(const L, R: IGrouping<Integer, string>): Integer begin Exit(L.Key - R.Key) end) do
  begin
    ValGroup.Add(Format(' # %d characters: ',[LGroup.Key]));
    for LWord in LGroup do
      ValGroup.Add(LWord);
  end;
  Result := ValGroup;
end;

function SplitString(const AString: string; const ASeparator: Char): ISequence<string>;
begin
  Result := TSplitStringCollection.Create(AString, ASeparator);
end;

{ TSplitStringCollection }

constructor TSplitStringCollection.Create(const AString: string; const ASeparator: Char);
begin
  Create(TRules<string>.Default, AString, ASeparator);
end;

constructor TSplitStringCollection.Create(const ARules: TRules<string>; const AString: string; const ASeparator: Char);
var
  LChar: Char;
begin
  inherited Create(ARules);
  FInputString := AString;
  FSeparator := ASeparator;
  if Length(AString) > 0 then
  begin
    FCount := 1;
    for LChar in AString do
      if LChar = ASeparator then
        Inc(FCount);
  end;
end;

function TSplitStringCollection.Empty: Boolean;
begin
  Result := FCount > 0;
end;

function TSplitStringCollection.GetCount: NativeInt;
begin
  Result := FCount;
end;

function TSplitStringCollection.GetEnumerator: IEnumerator<string>;
begin
  Result := TEnumerator.Create(Self);
end;

{ TSplitStringCollection.TEnumerator }

constructor TSplitStringCollection.TEnumerator.Create(const AOwner: TSplitStringCollection);
begin
  inherited Create(AOwner);
  LPrevIndex := 1;
  LNowIndex := 1;
  FLength := Length(AOwner.FInputString);
end;

function TSplitStringCollection.TEnumerator.TryMoveNext(out ACurrent: string): Boolean;
var
  LOwner: TSplitStringCollection;
begin
  LOwner := TSplitStringCollection(Owner);
  Result := false;

  while LNowIndex <= FLength do
  begin
    if LOwner.FInputString[LNowIndex] = LOwner.FSeparator then
    begin
      ACurrent := System.Copy(LOwner.FInputString, LPrevIndex, (LNowIndex - LPrevIndex));
      LPrevIndex := LNowIndex + 1;
      Result := true;
    end;
    Inc(LNowIndex);
    if Result then
      Exit;
  end;

  if LPrevIndex < LNowIndex then
  begin
    ACurrent := Copy(LOwner.FInputString, LPrevIndex, FLength - LPrevIndex + 1);
    LPrevIndex := LNowIndex + 1;
    Result := true;
  end;
end;

function AdaptStr(AText: string): string;
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

function RemoveAccents(AText: string): string;
var
  NewStr:string;
begin
  Result := EmptyStr;
  NewStr := Trim(Upper(AText));
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

function RemoveDuplicate(AText: string): string;
var
  n:Integer;
  NewStr:string;
begin
  Result := EmptyStr;
  NewStr := Upper(Trim(AText));
  for n := 1 to Pred(Length(AText)) do
  begin
    if NewStr[n] = NewStr[n+1] then
      Delete(NewStr,n,1);
  end;
  Result := NewStr;
end;

function RemoveOfStr(AText: string;
  APattern: array of string): string;
var
  n,p:Integer;
  NewStr:string;
begin
  Result := EmptyStr;
  NewStr := Upper(Trim(AText));
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

function StrReplace(const AText: string;
  AOldChar: array of string; ANewChar: string): string;
var
  n:Integer;
  New:TStringBuilder;
begin
  New := TStringBuilder.Create;
  New.Clear;
  New.Append(Trim(Upper(AText)));
  for n := Low(AOldChar) to High(AOldChar) do
  begin
    New.Replace(AOldChar[n],ANewChar);
  end;
  Result := New.ToString;
end;

function ReplaceInitialChar(AText:string;AOldChar:array of Char;ANewChar:Char): string;
var
  NewStrList,NewStrResult:TStringList;
  NewStr:string;
  n,i:Integer;
begin
  Result := EmptyStr;
  NewStrResult := TStringList.Create;
  NewStrList := TStringList.Create;
  NewStrList.AddStrings(ReturnSplitString(AText));
  for n := 0 to Pred(NewStrList.Count) do
  begin
    NewStr := NewStrList[n];
    for i := Low(AOldChar) to High(AOldChar) do
    begin
      if NewStr[1] = AOldChar[i] then
        NewStr[1] := ANewChar;
    end;
    NewStrResult.Add(NewStr);
  end;
  Result := StrListJoin(NewStrResult);
end;

function ReplaceFinalChar(AText:string;AOldChar:array of Char;ANewChar:Char): string;
var
  NewStrList,NewStrResult:TStringList;
  NewStr:string;
  n,i:Integer;
begin
  Result       := EmptyStr;
  NewStrResult := TStringList.Create;
  NewStrList   := TStringList.Create;
  NewStrList.AddStrings(ReturnSplitString(AText));
  for n := 0 to Pred(NewStrList.Count) do
  begin
    NewStr := NewStrList[n];
    for i := Low(AOldChar) to High(AOldChar) do
    begin
      if NewStr[Length(NewStr)] = AOldChar[i] then
        NewStr[Length(NewStr)] := ANewChar;
    end;
    NewStrResult.Add(NewStr);
  end;
  Result := StrListJoin(NewStrResult);
end;

function StrListJoin(AStrList:TStringList):string;
var
  n:Integer;
  New:TStringBuilder;
begin
  New := TStringBuilder.Create;
  New.Clear;
  for n := 0 to pred(AStrList.Count) do
  begin
    New.Append(Format('%s ',[AStrList[n]]));
  end;
  Result := New.ToString;
end;

function Upper(AText:string):string;
begin
  StringReplace(AText,'á','Á',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'à','À',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'â','Â',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'å','Å',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ã','Ã',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ä','Ä',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'æ','Æ',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'á','Á',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'é','É',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'è','È',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ê','Ê',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ë','Ë',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ð','Ð',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'í','Í',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ì','Ì',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'î','Î',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ï','Ï',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ó','Ó',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ò','Ò',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ô','Ô',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ø','Ø',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'õ','Õ',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ö','Ö',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ú','Ú',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ù','Ù',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'û','Û',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ü','Ü',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ç','Ç',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ñ','Ñ',[rfReplaceAll, rfIgnoreCase]);
  StringReplace(AText,'ý','Ý',[rfReplaceAll, rfIgnoreCase]);
  Result := AnsiUpperCase(AText)
end;

/////////////////////////////////////////////////////////
////// Converter BitMap/Base64 e Base64/BitMap /////////
////////////////////////////////////////////////////////
{ Example use
var
  Bitmap: TBitmap;
  s: string;

begin
  Bitmap := TBitmap.Create;
  Bitmap.SetSize(100,100);
  Bitmap.Canvas.Brush.Color := clRed;
  Bitmap.Canvas.FillRect(Rect(20, 20, 80, 80));
  s := Base64FromBitmap(Bitmap);
  Bitmap.Free;
  Bitmap := BitmapFromBase64(s);
  Bitmap.SaveToFile('C:\desktop\temp.bmp');
end.
}

function Base64FromBitmap(Bitmap: TBitmap): string;
var
  Input: TBytesStream;
  Output: TStringStream;
begin
  Input := TBytesStream.Create;
  try
    Bitmap.SaveToStream(Input);
    Input.Position := 0;
    Output := TStringStream.Create('', TEncoding.ASCII);
    try
      Soap.EncdDecd.EncodeStream(Input, Output);
      Result := Output.DataString;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

function BitmapFromBase64(const base64: string): TBitmap;
var
  Input: TStringStream;
  Output: TBytesStream;
begin
  Input := TStringStream.Create(base64, TEncoding.ASCII);
  try
    Output := TBytesStream.Create;
    try
      Soap.EncdDecd.DecodeStream(Input, Output);
      Output.Position := 0;
      Result := TBitmap.Create;
      try
        Result.LoadFromStream(Output);
      except
        Result.Free;
        raise;
      end;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

/////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

function RemoveVowelLessStart(AText:string):string;
var
  NewStrList,NewStrResult:TStringList;
  NewStr,ParcStr:string;
  n:Integer;
begin
  Result       := EmptyStr;
  NewStrResult := TStringList.Create;
  NewStrList   := TStringList.Create;
  NewStrList.AddStrings(ReturnSplitString(AText));
  for n := 0 to Pred(NewStrList.Count) do
  begin
    NewStr  := NewStrList[n];
    ParcStr := copy(NewStr,2,Length(NewStr));
    ParcStr :=  RemoveOfStr(ParcStr,['A','E','I','O','U']);
    NewStrResult.Add(Format('%s%s',[NewStr[1],ParcStr]));
  end;
  Result    := StrListJoin(NewStrResult);
end;

function ReplaceBetweenStr(AText:string;AOldChar:array of Char;ANewChar:Char):string;
var
  NewStrList,NewStrResult:TStringList;
  NewStr:string;
  n,i,j:Integer;
begin
  Result       := EmptyStr;
  NewStrResult := TStringList.Create;
  NewStrList   := TStringList.Create;
  NewStrList.AddStrings(ReturnSplitString(AText));
  for n := 0 to Pred(NewStrList.Count) do
  begin
    NewStr := NewStrList[n];
    for i := Low(AOldChar) to High(AOldChar) do
    begin
      for j := 2 to Pred(Length(NewStr)) do
      begin
        if NewStr[j] = AOldChar[i] then
          NewStr[j] := ANewChar;
      end;
    end;
    NewStrResult.Add(NewStr);
  end;
  Result := StrListJoin(NewStrResult);
end;

function RemoveDuplicateStr(AText:string;AListChar:array of Char):string;
var
  NewStrList,NewStrResult:TStringList;
  NewStr:string;
  n,i:Integer;
begin
  Result       := EmptyStr;
  NewStrResult := TStringList.Create;
  NewStrList   := TStringList.Create;
  NewStrList.AddStrings(ReturnSplitString(AText));
  for n := 0 to Pred(NewStrList.Count) do
  begin
    NewStr := NewStrList[n];
    for i := Low(AListChar) to High(AListChar) do
    begin
      NewStr := NewStrList[n];
      StrReplace(NewStr,[AListChar[i]+AListChar[i]],AListChar[i]);
    end;
    NewStrResult.Add(NewStr);
  end;
  Result := StrListJoin(NewStrResult);
end;

function RemoveInitialChar(AText:string;AListChar:array of Char): string;
var
  NewStrList,NewStrResult:TStringList;
  NewStr:string;
  n,i:Integer;
begin
  Result := EmptyStr;
  NewStrResult := TStringList.Create;
  NewStrList := TStringList.Create;
  NewStrList.AddStrings(ReturnSplitString(AText));
  for n := 0 to Pred(NewStrList.Count) do
  begin
    NewStr := NewStrList[n];
    for i := Low(AlistChar) to High(AListChar) do
    begin
      if NewStr[1] = AListChar[i] then
        delete(NewStr,1, 1);
    end;
    NewStrResult.Add(NewStr);
  end;
  Result := StrListJoin(NewStrResult);
end;

function ReplaceBetweenVowel(AText:string;AOldChar:array of Char;ANewChar:Char):string;
var
  NewStrList,NewStrResult:TStringList;
  NewStr:string;
  n,i,j:Integer;
  AChar:Char;
begin
  Result       := EmptyStr;
  NewStrResult := TStringList.Create;
  NewStrList   := TStringList.Create;
  NewStrList.AddStrings(ReturnSplitString(AText));
  for n := 0 to Pred(NewStrList.Count) do
  begin
    NewStr := NewStrList[n];
    for i := Low(AOldChar) to High(AOldChar) do
    begin
      for j := 1 to Length(NewStr)do
      begin
        //AChar := NewStr[j];
        if ((IsVowel(NewStr[j-1])) and (IsVowel(NewStr[j+1])) and (AOldChar[i] = NewStr[j])) then
          NewStr[j] := ANewChar;
      end;
    end;
    NewStrResult.Add(NewStr);
  end;
  Result := StrListJoin(NewStrResult);
end;

function IsVowel(AChar:Char):Boolean;
begin
  Result := ((AChar='A')or(AChar='E')or(AChar='I')or(AChar='O')or(AChar='U'));
end;

function RemoveSpecialCharacters(AText:string):string;
const
  xSpecChar: array[1..48] of string = ('<','>','!','@','#','$','%','¨','&','*',
                                     '(',')','_','+','=','{','}','[',']','?',
                                     ';',':',',','|','*','"','~','^','´','`',
                                     '¨','æ','Æ','ø','£','Ø','ƒ','ª','º','¿',
                                     '®','½','¼','ß','µ','þ','ý','Ý');
var
  i : Integer;
begin
   for i:=1 to 48 do
     Result := StringReplace(AText, xSpecChar[i], '', [rfreplaceall]);
end;


end.
