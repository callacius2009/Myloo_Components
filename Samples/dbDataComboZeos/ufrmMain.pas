unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBDataComboZeos, ZAbstractConnection,
  ZConnection, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZSequence, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TForm1 = class(TForm)
    DBDataComboZeos1: TDBDataComboZeos;
    Conn: TZConnection;
    qryTeste: TZQuery;
    dsTeste: TDataSource;
    seq: TZSequence;
    qryTesteCODIGO: TIntegerField;
    qryTesteNOME: TWideStringField;
    qryTesteCPF: TWideStringField;
    qryTesteCNPJ: TWideStringField;
    qryTesteCRC: TWideStringField;
    qryTesteCEP: TWideStringField;
    qryTesteENDERECO: TWideStringField;
    qryTesteNUMERO: TWideStringField;
    qryTesteCOMPLEMENTO: TWideStringField;
    qryTesteBAIRRO: TWideStringField;
    qryTesteTELEFONE: TWideStringField;
    qryTesteFAX: TWideStringField;
    qryTesteEMAIL: TWideStringField;
    qryTesteCIDADE: TIntegerField;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
