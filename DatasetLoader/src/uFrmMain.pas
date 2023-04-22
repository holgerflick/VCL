unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, advmultibuttonedit,
  Vcl.WinXPanels, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.Text,
  FireDAC.Stan.StorageJSON, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.DApt, FireDAC.Comp.BatchMove.SQL;

type
  TForm1 = class(TForm)
    StackPanel1: TStackPanel;
    altop: TLabel;
    txtPOI: TAdvMultiButtonEdit;
    txtSchools: TAdvMultiButtonEdit;
    Label1: TLabel;
    Move: TFDBatchMove;
    Reader: TFDBatchMoveTextReader;
    DBConnection: TFDConnection;
    Writer: TFDBatchMoveSQLWriter;
    txtDatabaseFilename: TAdvMultiButtonEdit;
    Label2: TLabel;
    btImport: TButton;
    btClose: TButton;
    procedure txtPOIClickCustom(Sender: TObject; ButtonIndex: Integer);
    procedure txtPOIClickFind(Sender: TObject);
    procedure txtSchoolsClickCustom(Sender: TObject; ButtonIndex: Integer);
    procedure txtSchoolsClickFind(Sender: TObject);
    procedure btImportClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure txtDatabaseFilenameClickCustom(Sender: TObject; ButtonIndex: Integer);
  private
    { Private declarations }
    procedure LocateFile( ATitle: String; Sender: TObject );
    procedure OpenWeb( AURL: String );

    procedure ImportData;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses ShellAPI;

const
  ROOT_URL = 'http://leegisopendata2-leegis.opendata.arcgis.com/datasets/';


procedure TForm1.btCloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TForm1.btImportClick(Sender: TObject);
var
  LContinue: Boolean;

begin
  LContinue := FileExists( txtPOI.Text ) AND
    FileExists(txtSchools.Text ) AND
    ( not txtDatabaseFilename.Text.IsEmpty );

  if LContinue then
  begin
    ImportData;
    MessageDlg( Format( 'Data has been successfully imported into %s.', [
      txtDatabaseFilename.Text ] ), mtInformation, [mbOK], 0 );
  end
  else
  begin
    MessageDlg('Please specify both spreadsheet files and enter the filename of the database to be created.',
      mtError, [mbOK], 0);
  end;
end;

procedure TForm1.ImportData;
begin
  DBConnection.Close;

  DBConnection.Params.Database := txtDatabaseFilename.Text;

  DeleteFile( DBConnection.Params.Database );

  Reader.FileName := txtPOI.Text;

  Writer.TableName := 'POI';

  Move.GuessFormat;
  Move.Execute;

  Reader.FileName := txtSchools.Text;
  Writer.TableName := 'Schools';

  Move.GuessFormat;
  Move.Execute;
end;

procedure TForm1.LocateFile(ATitle: String; Sender: TObject);
var
  LDlg: TFileOpenDialog;
  LItem: TFileTypeItem;

begin
  LDlg := TFileOpenDialog.Create(nil);
  try
    LDlg.Title := 'Locate spreadsheet file with ' + ATitle;
    LDlg.Options := [fdoPathMustExist, fdoFileMustExist];
    LItem := LDlg.FileTypes.Add;

    LItem.DisplayName := 'Spreadsheet (*.csv)';
    LItem.FileMask := '*.csv';

    if LDlg.Execute then
    begin
      (Sender as TAdvMultiButtonEdit).Text := LDlg.FileName;
    end;

  finally
    LDlg.Free;
  end;
end;

procedure TForm1.OpenWeb(AURL: String);
begin
  ShellExecute( self.Handle, 'open', pChar( AUrl ), '', '', SW_SHOWNORMAL );
end;

procedure TForm1.txtDatabaseFilenameClickCustom(Sender: TObject; ButtonIndex: Integer);
var
  LDlg: TFileOpenDialog;
  LItem: TFileTypeItem;

begin
  LDlg := TFileOpenDialog.Create(nil);
  try
    LDlg.Title := 'Specify database filename';
    LDlg.Options := [fdoPathMustExist, fdoOverWritePrompt];
    LItem := LDlg.FileTypes.Add;

    LItem.DisplayName := 'SQlite database (*.sqlite)';
    LItem.FileMask := '*.sqlite';

    LDlg.DefaultExtension := 'sqlite';

    if LDlg.Execute then
    begin
      (Sender as TAdvMultiButtonEdit).Text := LDlg.FileName;
    end;

  finally
    LDlg.Free;
  end;
end;

procedure TForm1.txtPOIClickCustom(Sender: TObject; ButtonIndex: Integer);
begin
  LocateFile( 'Points of Interest', Sender );
end;

procedure TForm1.txtPOIClickFind(Sender: TObject);
begin
  OpenWeb( ROOT_URL + 'points-of-interest' );
end;

procedure TForm1.txtSchoolsClickCustom(Sender: TObject; ButtonIndex: Integer);
begin
  LocateFile( 'School Data', Sender );
end;

procedure TForm1.txtSchoolsClickFind(Sender: TObject);
begin
  OpenWeb( ROOT_URL + 'schools' );
end;

end.
