unit BaseFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, ExtCtrls;

type
  TBaseForm = class(TForm)
    tb1: TToolBar;
    lvProcesses: TListView;
    btnRefreshProcess: TToolButton;
    pnlLeft: TPanel;
    pnlLeftBottom: TPanel;
    procedure lvProcessesColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormShow(Sender: TObject);
    procedure btnRefreshProcessClick(Sender: TObject);
  private
  protected
    procedure GetProc;
    procedure GetSearchProcessHandle(var hProcess: THandle); virtual;
  public
    { Public declarations }
  end;

var
  BaseForm: TBaseForm;

implementation

{$R *.dfm}
uses
  TlHelp32;
  
procedure TBaseForm.GetProc();
var
  pe32: PROCESSENTRY32;
  hSnap: THandle;
  ok: bool;
begin
  lvProcesses.Clear;
  pe32.dwSize := SizeOf(pe32);
  hSnap := CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  //if hSnap = -1 then
  //  raise EToolHelpError().Create('CreateToolHelp32Snapshot failed');
  ok := Process32First(hSnap,pe32);
  While ok do
    begin
      With lvProcesses.Items.Add do
        begin
          Caption := pe32.szExeFile;
          SubItems.Add(IntToHex(pe32.th32ProcessID, 0));
          SubItems.Add(IntToHex(pe32.th32ParentProcessID, 0));
          SubItems.Add(IntToStr(pe32.cntThreads));
        end;
      ok := Process32Next(hSnap,pe32);
    end;
  CloseHandle(hSnap);
  if lvProcesses.Items.Count <> 0 then
    lvProcesses.Items.Item[0].Selected := true;
end;


function CustomSortProc(Item1, Item2: TListItem; ParamSort: Integer):
Integer; stdcall;
begin
  if ParamSort = 0 then
    Result := StrComp(PAnsiChar(Item1.Caption), PAnsiChar(Item2.Caption))
  else
    Result := StrComp(PAnsiChar(Item1.SubItems[ParamSort - 1]),
      PAnsiChar(Item2.SubItems[ParamSort - 1]));
end;

procedure TBaseForm.lvProcessesColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  lvProcesses.CustomSort(@CustomSortProc, Column.index);
end;

procedure TBaseForm.FormShow(Sender: TObject);
begin
  btnRefreshProcessClick(nil);
end;

procedure TBaseForm.btnRefreshProcessClick(Sender: TObject);
begin
  GetProc;
  lvProcessesColumnClick(lvProcesses, lvProcesses.Column[0]);
  if lvProcesses.Items.Count <> 0 then
    lvProcesses.Items.Item[0].Selected := true;
end;

procedure TBaseForm.GetSearchProcessHandle(var hProcess: THandle);
var
  strID: string;
  intID: Cardinal;
begin
  strID := lvProcesses.Selected.SubItems[0];
  intID := StrToInt('0x' + strID);// HexToInt(strID);
  hProcess := OpenProcess(PROCESS_ALL_ACCESS, false, intID);
end;

end.


