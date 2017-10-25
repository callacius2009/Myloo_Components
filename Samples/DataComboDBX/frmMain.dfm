object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 647
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DataCombo: TDataComboEx
    Left = 136
    Top = 96
    Width = 345
    Height = 22
    CharCase = ecUpperCase
    SearchFieldName = 'LAN_DESCRICAO'
    SearchFieldNameID = 'LAN_CODIGO'
    SearchTableName = 'CLASSIF_LANCAMENTOS'
    SearchFieldOrder = 'LAN_DESCRICAO'
    Phonetic = tpNone
    SQLConnection = SQLConnection1
    TypeSearch = tpContains
  end
  object Button1: TButton
    Left = 512
    Top = 96
    Width = 75
    Height = 25
    Caption = 'ok'
    TabOrder = 1
    OnClick = Button1Click
  end
  object DataComboEx1: TDataComboEx
    Left = 136
    Top = 144
    Width = 345
    Height = 22
    CharCase = ecNormal
    SearchFieldName = 'NOME'
    SearchFieldNameID = 'CODIGO'
    SearchTableName = 'PESSOA'
    SearchFieldOrder = 'CODIGO'
    Phonetic = tpNone
    SQLConnection = SQLConnection1
    TypeSearch = tpExactly
  end
  object DataComboEx2: TDataComboEx
    Left = 136
    Top = 192
    Width = 345
    Height = 22
    CharCase = ecNormal
    SearchFieldName = 'NOME'
    SearchFieldNameID = 'CODIGO'
    SearchTableName = 'CIDADE'
    SearchFieldOrder = 'CODIGO'
    Phonetic = tpNone
    SQLConnection = SQLConnection1
    TypeSearch = tpStarting
  end
  object DataComboEx3: TDataComboEx
    Left = 136
    Top = 240
    Width = 345
    Height = 22
    CharCase = ecNormal
    SearchFieldName = 'DESCRICAO'
    SearchFieldNameID = 'CODIGO'
    SearchTableName = 'CONDICAO'
    SearchFieldOrder = 'CODIGO'
    Phonetic = tpNone
    SQLConnection = SQLConnection1
    TypeSearch = tpStarting
  end
  object DataComboEx4: TDataComboEx
    Left = 136
    Top = 288
    Width = 345
    Height = 22
    CharCase = ecNormal
    SearchFieldName = 'DESCRICAO'
    SearchFieldNameID = 'CODIGO'
    SearchTableName = 'DESCRICAOFISCAL'
    SearchFieldOrder = 'CODIGO'
    Phonetic = tpNone
    SQLConnection = SQLConnection1
    TypeSearch = tpStarting
  end
  object DataComboEx5: TDataComboEx
    Left = 136
    Top = 336
    Width = 345
    Height = 22
    CharCase = ecNormal
    SearchFieldName = 'REFERENCIA'
    SearchFieldNameID = 'CODIGO'
    SearchTableName = 'PRODUTO'
    SearchFieldOrder = 'CODIGO'
    Phonetic = tpNone
    SQLConnection = SQLConnection1
    TypeSearch = tpStarting
  end
  object DataComboEx6: TDataComboEx
    Left = 136
    Top = 384
    Width = 345
    Height = 22
    CharCase = ecNormal
    SearchFieldName = 'NUMEROPEDIDO'
    SearchFieldNameID = 'CODIGO'
    SearchTableName = 'TITULO'
    SearchFieldOrder = 'CODIGO'
    Phonetic = tpNone
    SQLConnection = SQLConnection1
    TypeSearch = tpStarting
  end
  object DataComboEx7: TDataComboEx
    Left = 136
    Top = 432
    Width = 345
    Height = 22
    CharCase = ecNormal
    SearchFieldName = 'DESCRICAO'
    SearchFieldNameID = 'CODIGO'
    SearchTableName = 'UNIDADEMEDIDA'
    SearchFieldOrder = 'CODIGO'
    Phonetic = tpNone
    SQLConnection = SQLConnection1
    TypeSearch = tpStarting
  end
  object DataComboEx8: TDataComboEx
    Left = 136
    Top = 480
    Width = 345
    Height = 22
    CharCase = ecNormal
    SearchFieldName = 'TITULO'
    SearchFieldNameID = 'CODIGO'
    SearchTableName = 'NUMERO'
    SearchFieldOrder = 'CODIGO'
    Phonetic = tpNone
    SQLConnection = SQLConnection1
    TypeSearch = tpStarting
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'Firebird'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxfb.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=D:\Banco_DSI\Industrial\BANCO.FDB'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    VendorLib = 'fbclient.dll'
    Connected = True
    Left = 512
    Top = 8
  end
end
