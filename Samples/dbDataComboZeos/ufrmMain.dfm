object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 301
  ClientWidth = 754
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
    Left = 48
    Top = 47
    Width = 33
    Height = 13
    Caption = 'Codigo'
  end
  object Label2: TLabel
    Left = 178
    Top = 47
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label3: TLabel
    Left = 50
    Top = 104
    Width = 19
    Height = 13
    Caption = 'CPF'
  end
  object Label4: TLabel
    Left = 178
    Top = 104
    Width = 21
    Height = 13
    Caption = 'CRC'
  end
  object Label5: TLabel
    Left = 50
    Top = 160
    Width = 45
    Height = 13
    Caption = 'Endere'#231'o'
  end
  object Label6: TLabel
    Left = 391
    Top = 160
    Width = 28
    Height = 13
    Caption = 'Bairro'
  end
  object Label7: TLabel
    Left = 48
    Top = 219
    Width = 33
    Height = 13
    Caption = 'Cidade'
  end
  object DBDataComboZeos1: TDBDataComboZeos
    Left = 48
    Top = 234
    Width = 649
    Height = 22
    SearchFieldName = 'NOME'
    SearchFieldNameID = 'CODIGO'
    SearchTableName = 'CIDADE'
    SearchFieldOrder = 'NOME'
    Phonetic = tpNone
    SQLConnection = Conn
    TypeSearch = tpContains
    DataField = 'CIDADE'
    DataSource = dsTeste
  end
  object DBEdit1: TDBEdit
    Left = 48
    Top = 64
    Width = 121
    Height = 21
    DataField = 'CODIGO'
    DataSource = dsTeste
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 178
    Top = 64
    Width = 519
    Height = 21
    DataField = 'NOME'
    DataSource = dsTeste
    TabOrder = 2
  end
  object DBEdit3: TDBEdit
    Left = 48
    Top = 120
    Width = 121
    Height = 21
    DataField = 'CPF'
    DataSource = dsTeste
    TabOrder = 3
  end
  object DBEdit4: TDBEdit
    Left = 178
    Top = 120
    Width = 121
    Height = 21
    DataField = 'CRC'
    DataSource = dsTeste
    TabOrder = 4
  end
  object DBEdit5: TDBEdit
    Left = 48
    Top = 176
    Width = 337
    Height = 21
    DataField = 'ENDERECO'
    DataSource = dsTeste
    TabOrder = 5
  end
  object DBEdit6: TDBEdit
    Left = 391
    Top = 176
    Width = 306
    Height = 21
    DataField = 'BAIRRO'
    DataSource = dsTeste
    TabOrder = 6
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 0
    Width = 754
    Height = 25
    DataSource = dsTeste
    Align = alTop
    Kind = dbnHorizontal
    TabOrder = 7
    ExplicitLeft = 360
    ExplicitTop = 8
    ExplicitWidth = 240
  end
  object Conn: TZConnection
    ControlsCodePage = cCP_UTF16
    Connected = True
    Port = 0
    Database = 'D:\Banco_DSI\Industrial\BANCO.FDB'
    User = 'sysdba'
    Password = 'masterkey'
    Protocol = 'firebirdd-2.5'
    Left = 248
    Top = 256
  end
  object qryTeste: TZQuery
    Connection = Conn
    Active = True
    SQL.Strings = (
      'select * from  CONTABILISTA order by CODIGO')
    Params = <>
    Sequence = seq
    SequenceField = 'CODIGO'
    Left = 328
    Top = 256
    object qryTesteCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryTesteNOME: TWideStringField
      FieldName = 'NOME'
      Size = 255
    end
    object qryTesteCPF: TWideStringField
      FieldName = 'CPF'
      Required = True
      Size = 11
    end
    object qryTesteCNPJ: TWideStringField
      FieldName = 'CNPJ'
      Size = 14
    end
    object qryTesteCRC: TWideStringField
      FieldName = 'CRC'
      Required = True
      Size = 15
    end
    object qryTesteCEP: TWideStringField
      FieldName = 'CEP'
      Size = 8
    end
    object qryTesteENDERECO: TWideStringField
      FieldName = 'ENDERECO'
      Size = 255
    end
    object qryTesteNUMERO: TWideStringField
      FieldName = 'NUMERO'
      Size = 10
    end
    object qryTesteCOMPLEMENTO: TWideStringField
      FieldName = 'COMPLEMENTO'
      Size = 60
    end
    object qryTesteBAIRRO: TWideStringField
      FieldName = 'BAIRRO'
      Size = 255
    end
    object qryTesteTELEFONE: TWideStringField
      FieldName = 'TELEFONE'
      Size = 12
    end
    object qryTesteFAX: TWideStringField
      FieldName = 'FAX'
      Size = 12
    end
    object qryTesteEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Size = 255
    end
    object qryTesteCIDADE: TIntegerField
      FieldName = 'CIDADE'
    end
  end
  object dsTeste: TDataSource
    DataSet = qryTeste
    Left = 480
    Top = 256
  end
  object seq: TZSequence
    Connection = Conn
    SequenceName = 'CONTABILISTA'
    Left = 396
    Top = 257
  end
end
