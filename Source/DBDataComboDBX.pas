{******************************************************************************}
{ Projeto: Componente DBDataComboDBX                                           }
{ Componente de seleção em um dataCombo usando um TSQLQuery e TSQLConnection   }
{ da Paleta de componentes do DBExpress                                        }
{ Direitos Autorais Reservados (c) 2017 Daniel Costa                           }
{                                                                              }
{                                                                              }

{ Colaboradores nesse arquivo:                                                 }

{  Você pode obter a última versão desse arquivo na pagina do Projeto Myloo    }
{ Componentes localizado em                                                    }


{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }

{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }

{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }

{ Daniel Eliton Costa  -  callacius@gmail.com  -  www.conectivalink.com.br     }
{                                                                              }
{******************************************************************************}
unit DBDataComboDBX;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  System.Variants,
  Vcl.StdCtrls,
  Vcl.Controls,
  Vcl.Buttons,
  Data.DB,
  Vcl.DBGrids,
  Vcl.Dialogs,
  Vcl.Graphics,
  Vcl.DBCtrls,
  Vcl.ComCtrls,
  IdBaseComponent,
  IdIntercept,
  {DBXFirebird,}
  Data.SqlExpr,
  Datasnap.DBClient,
  Generics.Collections,
  StrUtils,
  Myloo.Phonetic.BuscaBR,
  Myloo.Phonetic.Soundex,
  Myloo.Phonetic.Metaphone,
  Myloo.Strings.Utils;

type
  TTypeSearch = (tpContains, tpStarting, tpFinally, tpExactly);

  TPhoneticMatching = (tpNone, tpBuscaBr, tpMetaphoneBr, tpSoundexBr);

  TNotifyEvent = procedure(Sender: TObject) of object;

  TData = class
  private
    FKey     : Integer;
    FName    : string;
    FPhonetic: string;
  public
    property Key:Integer      read FKey      write FKey;
    property Name:string      read FName     write FName;
    property Phonetic:string  read FPhonetic write FPhonetic;
  end;

  TDBDataComboDBX = class(TWinControl)
  private
    FOnChange          : TNotifyEvent;
    FOnSelect          : TNotifyEvent;
    FFieldName         : string;
    FFieldNameID       : string;
    FTableName         : string;
    FFieldOrder        : string;
    FPhonetic          : TPhoneticMatching;
    FSQLConnection     : TSQLConnection;
    FKeyValue          : Integer;
    FPhoneticValue     : string;
    FTypeSearch        : TTypeSearch;
    FDataLink          : TFieldDataLink;
    { Sub-componentes utilizados dentro do componente }
    Edit               : TEdit;
    Btn                : TSpeedButton;
    ListFull           : TDictionary<Integer,TData>;
    List               : TDictionary<Integer,TData>;
    ListView           : TListBox;
    Query              : TSQLQuery;

    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure UpdateData(Sender: TObject);
    procedure Change;
    procedure CMExit(var Message: TWMNoParams); message CM_EXIT;

    procedure SBClick(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListViewExit(Sender: TObject);
    procedure ListViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListViewDblClick(Sender: TObject);
    procedure CreateListFull;
    procedure Search(AText:string);
    procedure SetSQLConnection(Value: TSQLConnection);
    procedure SetCharCase(Value: TEditCharCase);
    procedure SetText(Value: String);
    procedure SetFieldName(Value: String);
    procedure SetFieldNameID(Value: String);
    procedure SetTableName(Value: String);
    procedure SetKeyValue(const Value: Integer);
    function GetCharCase: TEditCharCase;
    function GetText: String;
    function ToPhonetic(AValue: string): string;
    function SearchByKey(AValue: Integer):TData;
    function CompareText(AText, ASubText:string):Boolean;
    function GetData(AValue: Integer): TData;
    procedure SetTypeSearch(const Value: TTypeSearch);
  protected
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override; { Utilizado para posicionar os sub-componentes}
    procedure Resize; override;
    procedure Clear;
    procedure ClearAndReload;
    property KeyValue:Integer              read FKeyValue      write SetKeyValue;
    property PhoneticValue:string          read FPhoneticValue write FPhoneticValue;
  published
    property CharCase: TEditCharCase       read GetCharCase    write SetCharCase   default ecNormal;
    property Text: string                  read GetText        write SetText;
    property SearchFieldName: string       read FFieldName     write SetFieldName;
    property SearchFieldNameID: string     read FFieldNameID   write SetFieldNameID;
    property SearchTableName: string       read FTableName     write SetTableName;
    property SearchFieldOrder:string       read FFieldOrder    write FFieldOrder;
    property Phonetic: TPhoneticMatching   read FPhonetic      write FPhonetic;
    property SQLConnection: TSQLConnection read FSQLConnection write SetSQLConnection;
    property TypeSearch:TTypeSearch        read FTypeSearch    write SetTypeSearch;
    property OnChange: TNotifyEvent        read FOnChange      write FOnChange;
    property onSelect: TNotifyEvent        read FOnSelect      write FOnSelect;
    property DataField: string             read GetDataField   write SetDataField;
    property DataSource: TDataSource       read GetDataSource  write SetDataSource;
  end;

  resourceString
    ASql ='select %s,%s from %s order by %s';

implementation

{$R MylooComponentes.RES}

{ TDBDataComboDBX }

constructor TDBDataComboDBX.Create(AOwner: TComponent);
var
  Img:TStringBuilder;
  Bitmap: TBitmap;
begin
  inherited Create(AOwner);
  Img := TStringBuilder.Create;
  Img.Append('Qk02AwAAAAAAADYAAAAoAAAAEAAAABAAAAABABgAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAAA');
  Img.Append('/////////////////////////////////Pz8+Pj49PT08PDw5ubm4+Pj8PDw/Pz8////////');
  Img.Append('/////////////////////////Pz8+Pj49PT08PDw3d3dd3d33Nzc/Pz8////////////////');
  Img.Append('////////////////////////////9vb2e3t7WlpaZ2dn////////////////////////////');
  Img.Append('////////////////+Pj4e3t7WlpaVlZW2NjY////////////////////////////////////');
  Img.Append('////9fX1eXl5WlpaVVVV2NjY////////////////////9PT0y8vLvLy8wsLC3Nzc8/Pzra2tWlpaT09P2dnZ');
  Img.Append('////////////////////3t7ep6enyMjI29vb3d3dzMzMqqqqk5OTg4OD3d3d////////////');
  Img.Append('////////7e3tubm54uLi7e3t8fHx9fX1+fn54uLip6en5ubm////////////////////////');
  Img.Append('v7+/6Ojo7+/v5eXl6+vr8PDw8/Pz+Pj4xMTE2dnZ////////////////////////oaGh9/f3');
  Img.Append('/f399vb25+fn6enp7u7u8vLy19fXvb29////////////////////////nJyc8/Pz+Pj4/Pz8');
  Img.Append('/Pz87Ozs5eXl7Ozs1tbWu7u7////////////////////////rKys4eHh8fHx9vb2+vr6/f398');
  Img.Append('/Pz5eXlycnJ0dHR////////////////////////1tbWv7+/6urq7+/v9PT0+fn5/Pz88vLyubm59vb2');
  Img.Append('////////////////////////////w8PDwsLC4ODg7e3t7+/v39/fsrKy4uLi////////////');
  Img.Append('/////////////////////v7+2tratbW1oqKioKCgtbW16enp////////////////////////');
  Img.Append('/////////////////////////v7+////////////////////////////////////////');
  Bitmap                 := BitmapFromBase64(Img.ToString);
  Edit                   := TEdit.Create(Self);
  Edit.Parent            := Self;
  Edit.OnKeyDown         := EditKeyDown;
  Btn                    := TSpeedButton.Create(Self);
  Btn.Parent             := Self;
  Btn.Glyph              := Bitmap;
  Btn.OnClick            := SBClick;
  ListFull               := TDictionary<Integer,TData>.Create;
  List                   := TDictionary<Integer,TData>.Create;
  ListView               := TListBox.Create(Self);
  ListView.Visible       := False;
  ListView.MultiSelect   := False;
  ListView.OnExit        := ListViewExit;
  ListView.OnKeyDown     := ListViewKeyDown;
  ListView.OnDblClick    := ListViewDblClick;
  FDataLink              := TFieldDataLink.Create;
  FDataLink.Control      := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnUpdateData := UpdateData;
  BringToFront;
end;

procedure TDBDataComboDBX.CreateListFull;
var
  i:Integer;
  Data:TData;
begin
  i := 0;
  Query := TSQLQuery.Create(Self);
  with  Query do
  begin
    Close;
    SQLConnection := Self.SQLConnection;
    SQL.Text      := Format(ASql,[SearchFieldNameID,SearchFieldName,SearchTableName,SearchFieldOrder]);
    Open;
    First;
  end;
  while not Query.Eof do
  begin
    Data          := TData.Create;
    Data.Key      := Query.Fields[0].AsInteger;
    Data.Name     := Query.Fields[1].AsString;
    Data.Phonetic := ToPhonetic(Data.Name);
    ListFull.Add(i,Data);
    List.Add(Data.Key,Data);
    inc(i);
    Query.Next;
  end;
end;

procedure TDBDataComboDBX.Search(AText:string);
var
  i:Integer;
  Data:TData;
begin
  { Propriedade do Campo }
  ListView.Parent      := Self.Parent;
  ListView.SetBounds(Self.Left,Self.Top+Self.Height,141,132);
  ListView.Visible     := True;
  ListView.ClientWidth := 0;
  if ListView.Left+ListView.Width > Self.Parent.ClientWidth then
    ListView.Width := ListView.Width - ((ListView.Left+ListView.Width) -  Self.Parent.ClientWidth);
  if Self.Width > ListView.Width then
  begin
    ListView.Width := ListView.Width + (Self.Width - ListView.Width);
    ListView.ClientWidth := ListView.ClientWidth + (Self.Width - ListView.Width);
  end;
  ListView.SetFocus;
  ListView.Clear;
  { Fazer a Busca}
  Data := TData.Create;
  for i := 0 to Pred(ListFull.Count) do
  begin
    Data := GetData(i);
    if (Trim(Edit.Text) <> '') then
    begin
      if CompareText(Data.Name,AText) then
        ListView.AddItem(Data.Name,Data);
    end
    else
      ListView.AddItem(Data.Name,Data);
  end;
end;

procedure TDBDataComboDBX.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_Return then
    Btn.Click;
end;

function TDBDataComboDBX.GetCharCase: TEditCharCase;
begin
  Result := Edit.CharCase;
end;

function TDBDataComboDBX.GetText: String;
begin
  Result := Edit.Text;
end;

procedure TDBDataComboDBX.ListViewDblClick(Sender: TObject);
var
  Data:TData;
begin
  Data := TData(ListView.Items.Objects[ListView.ItemIndex]);
  KeyValue := Data.Key;
  //Edit.SetFocus;
  if Assigned(FOnSelect) then { Executa o evento Selecionado caso o programador o tenha criado }
    FOnSelect(Self);
  FDataLink.Field.AsVariant := KeyValue;
  Edit.SetFocus;
end;

procedure TDBDataComboDBX.ListViewExit(Sender: TObject);
begin
  ListView.Visible := False;
end;

procedure TDBDataComboDBX.ListViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Return then { Enter - confirma o valor selecionado }
    ListViewDblClick(ListView)
  else if Key = vk_Escape then { Esc - manda o foco para o Edit }
    Edit.SetFocus;
end;

procedure TDBDataComboDBX.Resize;
begin
  inherited;
  if csDesigning in ComponentState then
    Self.Height := 22; // Trava a altura do componente
  if Assigned(Btn) then
  begin
    Btn.Left    := Self.Width-21;
    Edit.Width  := Btn.Left-2;
  end;
end;

procedure TDBDataComboDBX.SBClick(Sender: TObject);
begin
  Search(Edit.Text);
end;

procedure TDBDataComboDBX.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  Edit.SetBounds(1,1,Self.Width-23,21);
  Btn.SetBounds(Self.Width-21,2,19,19);
end;

procedure TDBDataComboDBX.SetCharCase(Value: TEditCharCase);
begin
  if Edit.CharCase <> Value then
    Edit.CharCase := Value;
end;

procedure TDBDataComboDBX.SetSQLConnection(Value: TSQLConnection);
begin
  if Value <> FSQLConnection then
  begin
    FSQLConnection := Value;
  end;
  if ((FFieldName <> '') and (FFieldNameID <> '') and (FTableName <> '')and (FFieldOrder <> '')) then
    CreateListFull;
end;

procedure TDBDataComboDBX.SetFieldName(Value: String);
begin
  if (FFieldName <> Value) then
    FFieldName := Value;
end;

procedure TDBDataComboDBX.SetFieldNameID(Value: String);
begin
  if (FFieldNameID <> Value) then
    FFieldNameID := Value;
end;

procedure TDBDataComboDBX.SetKeyValue(const Value: Integer);
begin
  if ((FKeyValue <> Value) and (FSQLConnection <> nil)) then
  begin
    FKeyValue := Value;
  end;

  if ((Value > 0) and (FSQLConnection <> nil)) then
    SetText(SearchByKey(Value).Name);
end;

procedure TDBDataComboDBX.SetTableName(Value: String);
begin
  if (FTableName <> Value) then
    FTableName := Value;
end;

procedure TDBDataComboDBX.SetText(Value: String);
begin
  if Value <> Edit.Text then
    Edit.Text := Value;
end;

procedure TDBDataComboDBX.SetTypeSearch(const Value: TTypeSearch);
begin
  FTypeSearch := Value;
end;

function TDBDataComboDBX.ToPhonetic(AValue:string):string;
begin
  Result := EmptyStr;
  case Phonetic of
    tpNone:        Result := AValue ;
    tpBuscaBr:     Result := TBuscaBR.PhoneticMatching(AValue);
    tpMetaphoneBr: Result := TMetaphoneBr.PhoneticMatching(AValue);
    tpSoundexBr:   Result := TSoundexBr.PhoneticMatching(AValue);
  end;
end;

function TDBDataComboDBX.SearchByKey(AValue: Integer):TData;
begin
  Result := nil;
  List.TryGetValue(Avalue, Result);
end;

function TDBDataComboDBX.CompareText(AText, ASubText:string):Boolean;
begin
  case TypeSearch of
    tpStarting:
    begin
      if (Phonetic = tpNone) then
        Result := AnsiStartsText(ASubText,AText)
      else
        Result := AnsiStartsText(ToPhonetic(ASubText),ToPhonetic(AText));
    end;
    tpContains:
    begin
      if (Phonetic = tpNone) then
        Result := AnsiContainsText(AText,ASubText)
      else
        Result := AnsiContainsText(ToPhonetic(AText),ToPhonetic(ASubText));
    end;
    tpFinally:
    begin
      if (Phonetic = tpNone) then
        Result := AnsiEndsText(ASubText,AText)
      else
        Result := AnsiEndsText(ToPhonetic(ASubText),ToPhonetic(AText));
    end;
    tpExactly:
    begin
      Result := False;
      if (Phonetic = tpNone) then
      begin
        if AnsiCompareText(AText,ASubText) = 0 then
          Result := True;
      end
      else
      begin
        if AnsiCompareText(ToPhonetic(AText),ToPhonetic(ASubText)) = 0 then
          Result := True;
      end;
    end;
  end;
end;

function TDBDataComboDBX.GetData(AValue:Integer):TData;
begin
  Result := nil;
  ListFull.TryGetValue(Avalue, Result);
end;


function TDBDataComboDBX.GetDataField : string;
begin
  Result := FDataLink.FieldName;
end;

function TDBDataComboDBX.GetDataSource : TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBDataComboDBX.SetDataField(const Value : string);
begin
  FDataLink.FieldName := Value;
end;

procedure TDBDataComboDBX.SetDataSource(Value : TDataSource);
begin
  FDataLink.DataSource := Value;
end;

//procedure TDBDataCombo.DataChange(Sender : TObject);
//begin
//  if (FDataLink.Field = nil) or (VarIsNull(FDataLink.Field.asVariant)) then
//    Text := ''
//  else
//    Text := FDataLink.Field.asVariant;
//end;

procedure TDBDataComboDBX.UpdateData(Sender : TObject);
begin
  FDataLink.Field.AsInteger := KeyValue;
end;

procedure TDBDataComboDBX.CMExit(var Message : TWMNoParams);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TDBDataComboDBX.MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
var
  MyMouseDown : TMouseEvent;
begin
  if not FDataLink.ReadOnly and FDataLink.Edit then
    inherited MouseDown(Button, Shift, X, Y)
  else
  begin
    MyMouseDown := OnMouseDown;
    if Assigned(MyMouseDown) then MyMouseDown(Self, Button, Shift, X, Y);
  end;
end;

procedure TDBDataComboDBX.KeyDown(var Key : Word; Shift : TShiftState);
var
  MyKeyDown : TKeyEvent;
begin
  if not FDataLink.ReadOnly and FDataLink.Edit then
    inherited KeyDown(Key, Shift)
  else
  begin
    MyKeyDown := OnKeyDown;
    if Assigned(MyKeyDown) then MyKeyDown(Self, Key, Shift);
  end;
end;

procedure TDBDataComboDBX.DataChange(Sender: TObject);
begin
  if (FDataLink.Field = nil) then
    SetKeyValue(0)
  else
    SetKeyValue(FDataLink.Field.AsInteger);
  if ((DataSource.State = dsInsert) and (FDataLink.Field.AsInteger <= 0)) then
    Clear;
end;

procedure TDBDataComboDBX.Change;
begin
  FDataLink.Edit;
  inherited Changed;
  FDataLink.Modified;
end;

destructor TDBDataComboDBX.Destroy;
begin
  FDataLink.OnDataChange := nil;
  FDataLink.Free;
  inherited Destroy;
end;

procedure TDBDataComboDBX.Clear;
begin
  Edit.Clear;
  SetKeyValue(-1);
  PhoneticValue := '';
  Text := '';
end;

procedure TDBDataComboDBX.ClearAndReload;
begin
  Edit.Clear;
  SetKeyValue(-1);
  PhoneticValue := '';
  Text := '';
  ListFull.Clear;
  List.Clear;
  ListView.Clear;
  CreateListFull;
end;

end.

