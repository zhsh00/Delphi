unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Menus, ChildFrm, CheckBinaryDfmFrm,
  DirSearchFrm, ExplorerFrm, Grids, Variables;

type
  PtsList = ^TtsList;
  TtsList = array[0..maxTsSize - 1] of TTabSheet;

  PMenuFormItem = ^TMenuFormItem;
  TMenuFormItem = record
    FTag: integer;
    FRefName: string;
    FCaption: string;
  end;
  PMenuFormList = ^TMenuFormList;
  TMenuFormList = array[0..maxTsSize - 1] of TMenuFormItem;

  TMainForm = class(TForm)
    Menu1: TMainMenu;
    pmiN1: TMenuItem;
    pmiN2: TMenuItem;
    pmiN3: TMenuItem;
    pnlLeft: TPanel;
    spl1: TSplitter;
    pgcRight: TPageControl;
    pmiN4: TMenuItem;
    pmiN5: TMenuItem;
    pmiN6: TMenuItem;
    pmiForm11: TMenuItem;
    pmiForm21: TMenuItem;
    estTreeViewForm1: TMenuItem;
    InheritTestForm1: TMenuItem;
    MessageTestForm1: TMenuItem;
    mniDealExeclNameForm: TMenuItem;
    N1: TMenuItem;
    procedure pmiN3Click(Sender: TObject);
    procedure pmiN4Click(Sender: TObject);
    procedure pmiN5Click(Sender: TObject);
    procedure pmiForm11Click(Sender: TObject);
    procedure pmiForm21Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure estTreeViewForm1Click(Sender: TObject);
    procedure InheritTestForm1Click(Sender: TObject);
    procedure MessageTestForm1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    FtsList: PtsList;
    tsTmp: TTabSheet;
    FMenuFormList: TMenuFormList;
    FNewChildForm: TChildForm;
    procedure setMenuFormList;
    procedure setMainMenuTagbyMenuFormList;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
  uses Unit1, Unit2, testTreeView, InheritTestFrm, UMessageTestFrm,
  ReNameFrm;
{$R *.dfm}


function GetFormClass(const AClassName: string): TFormClass;
begin
  Result := TFormClass(GetClass(AClassName));
end;


procedure TMainForm.pmiN3Click(Sender: TObject);
var
  FormClass: TFormClass;
  i: integer;
  ts: TTabSheet;
begin
  FormClass := GetFormClass(FMenuFormList[TMenuItem(Sender).Tag].FRefName);
  if FormClass <> nil then
  begin
    for i := 0 to pgcright.pagecount - 1 do
      if TTabSheet(pgcright.Pages[i]).Caption =
        FMenuFormList[TMenuItem(Sender).Tag].FCaption then
          exit;

    tsTmp := TTabSheet.create(self);
    tsTmp.PageControl := pgcRight;
    tsTmp.Name := 'ts' + inttostr(pgcright.pagecount);
    tsTmp.Caption := FMenuFormList[TMenuItem(Sender).Tag].FCaption;
    pgcRight.ActivePage := tsTmp;

    if not Assigned(FNewChildForm) then
      FNewChildForm := TChildForm(FormClass).Create(Application, tsTmp);

    FNewChildform.Show;
  end;
{  tsTmp := TTabSheet.create(self);
  tsTmp.PageControl := pgcRight;
  tsTmp.Name := 'ts' + inttostr(pgcright.pagecount);
  pgcRight.ActivePage := tsTmp;

  if not Assigned(FNewChildForm) then
    FNewChildForm := TCheckBinaryDfmForm.Create(Application, tsTmp);

  FNewChildform.Show;
  pgcRight.Height := pgcRight.Height-1;}
end;

procedure TMainForm.pmiN4Click(Sender: TObject);
begin
  if not Assigned(DirSearchForm) then
    DirSearchForm := TDirSearchForm.Create(Application, pgcRight);

  DirSearchForm.Show;
  pgcRight.Height := pgcRight.Height-1;
end;

procedure TMainForm.pmiN5Click(Sender: TObject);
begin
  if not Assigned(ExplorerForm) then
    ExplorerForm := TExplorerForm.Create(Application, pgcRight);

  ExplorerForm.Show;
  pgcRight.Height := pgcRight.Height-1;
end;

procedure TMainForm.pmiForm11Click(Sender: TObject);
begin
  Form1.Show;
end;

procedure TMainForm.pmiForm21Click(Sender: TObject);
begin
  Form2.show;
end;

procedure TMainForm.setMenuFormList;
begin
  //现在写死一些菜单关联
  FMenuFormList[0].FTag := 0;
  FMenuFormList[0].FRefName := 'TCheckBinaryDfmForm';
  FMenuFormList[0].FCaption := 'CheckBinaryDfmForm';
  FMenuFormList[1].FTag := 1;
  FMenuFormList[1].FRefName := 'TDirSearchForm';
  FMenuFormList[1].FCaption := 'DirSearchForm';
  FMenuFormList[2].FTag := 2;
  FMenuFormList[2].FRefName := 'TExplorerForm';
  FMenuFormList[2].FCaption := '资源管理器';
end;

procedure TMainForm.setMainMenuTagbyMenuFormList;
begin
  //现在写死一些菜单关联
  pmiN3.Tag := FMenuFormList[0].FTag;
  pmiN4.Tag := FMenuFormList[1].FTag;
  pmiN5.Tag := FMenuFormList[1].FTag;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  setMenuFormList;
  setMainMenuTagbyMenuFormList;
end;



procedure TMainForm.estTreeViewForm1Click(Sender: TObject);
begin
  testTreeViewForm.show
end;

procedure TMainForm.InheritTestForm1Click(Sender: TObject);
begin
  InheritTestForm := TInheritTestForm.create(self);
  InheritTestForm.show;
end;

procedure TMainForm.MessageTestForm1Click(Sender: TObject);
begin
  UMessageTestForm := TUMessageTestForm.create(self);
  UMessageTestForm.show;
end;

procedure TMainForm.N1Click(Sender: TObject);
begin
  ReNameForm := TReNameForm.create(self);
  ReNameForm.show;
end;

end.
