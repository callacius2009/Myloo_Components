object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 300
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
  object Label1: TLabel
    Left = 160
    Top = 35
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label2: TLabel
    Left = 29
    Top = 77
    Width = 19
    Height = 13
    Caption = 'CPF'
  end
  object Label3: TLabel
    Left = 29
    Top = 35
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object Label4: TLabel
    Left = 160
    Top = 77
    Width = 21
    Height = 13
    Caption = 'CRC'
  end
  object Label6: TLabel
    Left = 30
    Top = 117
    Width = 45
    Height = 13
    Caption = 'Endere'#231'o'
  end
  object Label7: TLabel
    Left = 29
    Top = 154
    Width = 33
    Height = 13
    Caption = 'Cidade'
  end
  object Label5: TLabel
    Left = 368
    Top = 117
    Width = 28
    Height = 13
    Caption = 'Bairro'
  end
  object DBEdit1: TDBEdit
    Left = 29
    Top = 51
    Width = 121
    Height = 21
    DataField = 'CODIGO'
    DataSource = dsTeste
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 160
    Top = 51
    Width = 433
    Height = 21
    DataField = 'NOME'
    DataSource = dsTeste
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 29
    Top = 91
    Width = 121
    Height = 21
    DataField = 'CPF'
    DataSource = dsTeste
    TabOrder = 2
  end
  object DBEdit4: TDBEdit
    Left = 160
    Top = 91
    Width = 121
    Height = 21
    DataField = 'CRC'
    DataSource = dsTeste
    TabOrder = 3
  end
  object DBEdit5: TDBEdit
    Left = 29
    Top = 131
    Width = 324
    Height = 21
    DataField = 'ENDERECO'
    DataSource = dsTeste
    TabOrder = 4
  end
  object DBEdit6: TDBEdit
    Left = 368
    Top = 131
    Width = 225
    Height = 21
    DataField = 'BAIRRO'
    DataSource = dsTeste
    TabOrder = 5
  end
  object DBDataComboDBX1: TDBDataComboDBX
    Left = 29
    Top = 168
    Width = 564
    Height = 22
    SearchFieldName = 'NOME'
    SearchFieldNameID = 'CODIGO'
    SearchTableName = 'CIDADE'
    SearchFieldOrder = 'NOME'
    Phonetic = tpNone
    SQLConnection = SQLConnection1
    TypeSearch = tpContains
    DataField = 'CIDADE'
    DataSource = dsTeste
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 0
    Width = 635
    Height = 25
    DataSource = dsTeste
    Align = alTop
    Kind = dbnHorizontal
    TabOrder = 7
    ExplicitLeft = 280
    ExplicitTop = 24
    ExplicitWidth = 240
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'Firebird'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxfb.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXFirebird'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver160.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=16.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFire' +
        'birdDriver160.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandF' +
        'actory,Borland.Data.DbxFirebirdDriver,Version=16.0.0.0,Culture=n' +
        'eutral,PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverINTERBASE'
      'LibraryName=dbxfb.dll'
      'LibraryNameOsx=libsqlfb.dylib'
      'VendorLib=fbclient.dll'
      'VendorLibWin64=fbclient.dll'
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird'
      'Database=D:\Banco_DSI\Industrial\BANCO.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Role=RoleName'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'SQLDialect=3'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'TrimChar=False'
      'BlobSize=-1'
      'ErrorResourceFile='
      'RoleName=RoleName'
      'ServerCharSet='
      'Trim Char=False')
    VendorLib = 'fbclient.dll'
    Connected = True
    Left = 182
    Top = 244
  end
  object qryTeste: TSQLQuery
    Active = True
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from CONTABILISTA')
    SQLConnection = SQLConnection1
    Left = 272
    Top = 243
    object qryTesteCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryTesteNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 255
    end
    object qryTesteCPF: TStringField
      FieldName = 'CPF'
      Required = True
      Size = 11
    end
    object qryTesteCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 14
    end
    object qryTesteCRC: TStringField
      FieldName = 'CRC'
      Required = True
      Size = 15
    end
    object qryTesteCEP: TStringField
      FieldName = 'CEP'
      FixedChar = True
      Size = 8
    end
    object qryTesteENDERECO: TStringField
      FieldName = 'ENDERECO'
      Required = True
      Size = 255
    end
    object qryTesteNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 10
    end
    object qryTesteCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 60
    end
    object qryTesteBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Required = True
      Size = 255
    end
    object qryTesteTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 12
    end
    object qryTesteFAX: TStringField
      FieldName = 'FAX'
      Size = 12
    end
    object qryTesteEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 255
    end
    object qryTesteCIDADE: TIntegerField
      FieldName = 'CIDADE'
      Required = True
    end
  end
  object dspTeste: TDataSetProvider
    DataSet = qryTeste
    Left = 368
    Top = 244
  end
  object cdsTeste: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTeste'
    Left = 464
    Top = 248
  end
  object dsTeste: TDataSource
    DataSet = cdsTeste
    Left = 544
    Top = 248
  end
end
