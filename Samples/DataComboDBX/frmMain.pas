unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataComboEx, Data.DBXFirebird, Data.DB,
  Data.SqlExpr, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    DataCombo: TDataComboEx;
    Button1: TButton;
    DataComboEx1: TDataComboEx;
    DataComboEx2: TDataComboEx;
    DataComboEx3: TDataComboEx;
    DataComboEx4: TDataComboEx;
    DataComboEx5: TDataComboEx;
    DataComboEx6: TDataComboEx;
    DataComboEx7: TDataComboEx;
    DataComboEx8: TDataComboEx;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage(IntToStr(DataCombo.KeyValue));
end;

end.
