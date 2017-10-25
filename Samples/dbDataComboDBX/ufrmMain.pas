unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXFirebird, Data.FMTBcd,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, DBDataComboDBX, Data.DB,
  Datasnap.DBClient, Datasnap.Provider, Data.SqlExpr, Vcl.Mask;

type
  TForm1 = class(TForm)
    DBEdit1: TDBEdit;
    SQLConnection1: TSQLConnection;
    qryTeste: TSQLQuery;
    dspTeste: TDataSetProvider;
    cdsTeste: TClientDataSet;
    dsTeste: TDataSource;
    qryTesteCODIGO: TIntegerField;
    qryTesteNOME: TStringField;
    qryTesteCPF: TStringField;
    qryTesteCNPJ: TStringField;
    qryTesteCRC: TStringField;
    qryTesteCEP: TStringField;
    qryTesteENDERECO: TStringField;
    qryTesteNUMERO: TStringField;
    qryTesteCOMPLEMENTO: TStringField;
    qryTesteBAIRRO: TStringField;
    qryTesteTELEFONE: TStringField;
    qryTesteFAX: TStringField;
    qryTesteEMAIL: TStringField;
    qryTesteCIDADE: TIntegerField;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBDataComboDBX1: TDBDataComboDBX;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
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
