unit ReNameFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ChildFrm, ComCtrls, StdCtrls, ExtCtrls, ImgList;

type
  TReNameForm = class(TChildForm)
    pnl1: TPanel;
    edtFilter: TEdit;
    btnFind: TButton;
    btnModifyName: TButton;
    btnReName: TButton;
    pnl2: TPanel;
    lv1: TListView;
    edtDirectory: TEdit;
    procedure btnFindClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnModifyNameClick(Sender: TObject);
    procedure btnReNameClick(Sender: TObject);
  private
    { Private declarations }
    FFileName: string;
  public
    { Public declarations }
  end;

var
  ReNameForm: TReNameForm;

implementation

uses
  Util;
{$R *.dfm}

procedure TReNameForm.btnFindClick(Sender: TObject);
begin
  inherited;
  FFileName := '*.xls';
//  RefreshListTitle(['йтр╩йт'], [100], lvDetail);
  lv1.Items.Clear;
  lv1.Clear;
  FindFiles(edtDirectory.Text, edtFilter.Text, lv1);
end;

procedure TReNameForm.FormCreate(Sender: TObject);
begin
  inherited;
  edtDirectory.Text := 'C:\Users\0\Desktop\frm_254_0803';
  edtFilter.Text := '*.xml';
end;

procedure TReNameForm.btnModifyNameClick(Sender: TObject);
var
  i: Integer;
  strTmp, strName: string;
begin
  inherited;
  for i := 0 to lv1.Items.Count - 1 do
    with lv1.Items[i] do
    begin
      strTmp := Caption;
      strName := ExtractFileName(strTmp);
      strTmp := ExtractFilePath(strTmp);
      SetStdDirectory(strTmp);
      System.Delete(strName,1,1);
//      strName := '28' + strName;
      SubItems.Add(strTmp + strName);
    end;
end;

procedure TReNameForm.btnReNameClick(Sender: TObject);
var
  i: Integer;
  oldName, newName: string;
begin
  inherited;
  for i := 0 to lv1.Items.Count - 1 do
    with lv1.Items[i] do
    begin
      oldName := Caption;
      newName := SubItems.Strings[0];
      SysUtils.RenameFile(oldName, newName);
    end;
end;

end.
