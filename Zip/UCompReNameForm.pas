unit UCompReNameForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Menus, ToolWin, StdCtrls, StrUtils;

type
  TCompReNameForm = class(TForm)
    pnlTop: TPanel;
    pnlRight: TPanel;
    lv1: TListView;
    pm1: TPopupMenu;
    pmiAddFiles: TMenuItem;
    grp1: TGroupBox;
    edtOld1: TEdit;
    btn1: TButton;
    grp2: TGroupBox;
    edt2: TEdit;
    btn2: TButton;
    edt3: TEdit;
    lbl1: TLabel;
    edtNew1: TEdit;
    edt5: TEdit;
    chk1: TCheckBox;
    btnAddFiles: TButton;
    btnCommit: TButton;
    OpenDialog1: TOpenDialog;
    procedure btnAddFilesClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btnCommitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CompReNameForm: TCompReNameForm;

implementation

{$R *.dfm}
uses
  Util;
procedure TCompReNameForm.btnAddFilesClick(Sender: TObject);
var
  I: Integer;
begin
  with OpenDialog1 do
    if Execute then
      for I := 0 to Files.Count - 1 do
      begin
        AddAListItem([Files[i]], [], lv1);
      end;
end;

procedure TCompReNameForm.btn1Click(Sender: TObject);
var
  strOldPattern, strNewPattern, strOldName, strNewName: string;
  strTmp, strDir: string;
  I: Integer;
begin
  strOldPattern := edtOld1.Text;
  strNewPattern := edtNew1.Text;
  if strOldPattern = '' then Exit;
  for I := 0 to lv1.Items.Count - 1 do
  begin
    strOldName := lv1.Items[I].Caption;
    strDir := ExtractFileDir(strOldName);
    strOldName := ExtractFileName(strOldName);
    strNewName := StringReplace(strOldName, strOldPattern, strNewPattern,
      [rfIgnoreCase]);
    lv1.Items[I].SubItems.Add(strDir + '\' + strNewName);
  end;
end;

procedure TCompReNameForm.btnCommitClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to lv1.Items.Count - 1 do
  begin
    RenameFile(lv1.Items[I].Caption, lv1.Items[I].SubItems[0]);
  end;
end;

end.
