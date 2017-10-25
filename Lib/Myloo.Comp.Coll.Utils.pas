unit Myloo.Comp.Coll.Utils;

interface

uses
  Generics.Collections;

type
  TArraySliceForEach<t> = reference to procedure (
                                          const Index: Integer;
                                          const Value: T;
                                          var ABreak: Boolean);
  TArraySlice<t> = record
  private
    FArray: TArray<t>;
    FOffset: Integer;
    FCount: Integer;
    FOriginalLength: Integer;
  private
    function GetRealIndex(const Value: Integer): Integer;
    function GetItem(Index: Integer): T;
    procedure SetItem(Index: Integer; const Value: T);
  public
    ///
    ///  returns low bound
    ///
    function Low: Integer;
    ///
    ///  returns high bound
    ///
    function High: Integer;
    ///
    ///  returns true if the array size has changed since slice was initialized
    ///
    function ArraySizeChanged: Boolean;
    ///
    ///  returns a reference to the MAIN array
    ///
    function GetMainArray: TArray<t>;
    ///
    ///  resturns a NEW array based on slice information
    ///
    function ToArray: TArray<t>;
    ///
    ///  initializes the slice
    ///
    procedure SliceArray(const Value: TArray<t>; const AtIndex, ACount: Integer);
    ///
    ///  loop through all elements of the slice
    ///
    procedure ForEach(Callback: TArraySliceForEach<t>);
    ///
    ///  loop through all elements of main array
    ///
    procedure ForEachAll(Callback: TArraySliceForEach<t>);
  public
    ///
    ///  returns number of elements in array
    ///
    property Count: Integer read FCount;
    ///
    ///  get or set array item
    ///
    property Item[Index: Integer]: T read GetItem write SetItem; default;
  end;

implementation

uses
   SysUtils,Classes;

{ TArraySlice<t> }

function TArraySlice<t>.ArraySizeChanged: Boolean;
begin
  Result := FOriginalLength <> Length(FArray);
end;

procedure TArraySlice<t>.ForEach(Callback: TArraySliceForEach<t>);
var
  Index: Integer;
  LBreak: Boolean;
begin
  LBreak := False;
  for Index := Low to High do begin
    Callback(Index, Item[Index], LBreak);
    if LBreak then
      Break;
  end;
end;

procedure TArraySlice<t>.ForEachAll(Callback: TArraySliceForEach<t>);
var
  Index: Integer;
  LBreak: Boolean;
begin
  LBreak := False;
  for Index := 0 to Length(FArray) -1 do begin
    Callback(Index, FArray[Index], LBreak);
    if LBreak then
      Break;
  end;
end;

function TArraySlice<t>.GetMainArray: TArray<t>;
begin
  Result := FArray;
end;

function TArraySlice<t>.ToArray: TArray<t>;
begin
  Result := Copy(FArray, FOffset, FCount);
end;

function TArraySlice<t>.GetItem(Index: Integer): T;
var
  LIndex: Integer;
begin
  LIndex := GetRealIndex(Index);
  Result := FArray[LIndex];
end;

function TArraySlice<t>.GetRealIndex(const Value: Integer): Integer;
begin
  if (Value < Low) or (Value > High) then
    raise Exception.CreateFmt('TArraySlice: Index(%d) Out Of Bounds!', [Value]);
  Result := FOffset + Value;
end;

function TArraySlice<t>.High: Integer;
begin
  Result := Count -1;
end;

function TArraySlice<t>.Low: Integer;
begin
  Result := 0;
end;

procedure TArraySlice<t>.SetItem(Index: Integer; const Value: T);
var
  LIndex: Integer;
begin
  LIndex := GetRealIndex(Index);
  FArray[LIndex] := Value;
end;

procedure TArraySlice<t>.SliceArray(const Value: TArray<t>; const AtIndex,
  ACount: Integer);
begin
  FArray := Value;
  FCount := ACount;
  FOffset := AtIndex;
  FOriginalLength := Length(Value);
end;

end.
