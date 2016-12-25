unit ReadMemoryFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFrm, ComCtrls, ToolWin, StdCtrls, Variables, ExtCtrls,
  Menus;

type
  TReadMemoryForm = class(TBaseForm)
    btnFindValue: TToolButton;
    mmLog: TMemo;
    btnCheckPtr: TToolButton;
    pnlRight: TPanel;
    pnlLog: TPanel;
    btnFirst: TToolButton;
    btn3: TToolButton;
    btnFilterOutNonChange: TToolButton;
    btnFindNonChange: TToolButton;
    btnFindChanged: TToolButton;
    pnlMiddle: TPanel;
    btnSimpleFind: TToolButton;
    lbledtFindValue: TLabeledEdit;
    lvFindResult: TListView;
    lbledtNewValue: TLabeledEdit;
    lbledtAddress: TLabeledEdit;
    btnDoModify: TButton;
    lbledtProcess: TLabeledEdit;
    pgc1: TPageControl;
    tsLog: TTabSheet;
    tsResult: TTabSheet;
    stat1: TStatusBar;
    btnClearMemoLog: TButton;
    pnlResult: TPanel;
    stat2: TStatusBar;
    btnPromote: TButton;
    btnReRead: TButton;
    edtReRead: TEdit;
    btnBackupAddresses: TButton;
    btnBatchRead: TButton;
    ts1: TTabSheet;
    mm1: TMemo;
    btnBatchWrite: TButton;
    lbledtAAAA: TLabeledEdit;
    pm1: TPopupMenu;
    mniNewSession: TMenuItem;
    procedure btnFindValueClick(Sender: TObject);
    procedure btnCheckPtrClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btnFilterOutNonChangeClick(Sender: TObject);
    procedure btnFindNonChangeClick(Sender: TObject);
    procedure btnFindChangedClick(Sender: TObject);
    procedure btnSimpleFindClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvFindResultDblClick(Sender: TObject);
    procedure btnDoModifyClick(Sender: TObject);
    procedure lvProcessesDblClick(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btnClearMemoLogClick(Sender: TObject);
    procedure btnPromoteClick(Sender: TObject);
    procedure btnReReadClick(Sender: TObject);
    procedure btnBackupAddressesClick(Sender: TObject);
    procedure btnBatchReadClick(Sender: TObject);
    procedure btnBatchWriteClick(Sender: TObject);
    procedure mniNewSessionClick(Sender: TObject);
  private
    FTimes: Integer;//记录一次会话内查找的次数
    function ShowMemoryRegions(memoryRegions: TMemoryRegions): Cardinal;
    function readyResultArray: Integer;
    function GetWillFindValue: Integer;
    procedure ShowLookupResult(list: TList; lv: TListView);
    function GetNewValue: Integer;
    function ShowMemoryRegionsArray(
      MemoryRegionsArray: TMemoryRegionsArray): Cardinal;
    function GetValueFrom(lbledt: TLabeledEdit): Integer;
    procedure ShowLookupTimes;
    procedure NewSession;
  protected
    procedure GetSearchProcessHandle(var hProcess: THandle); override;
  public
    { Public declarations }
    procedure WndProc(var Msg: TMessage); override;
  end;

var
  ReadMemoryForm: TReadMemoryForm;

implementation

{$R *.dfm}
uses
  funcs, threads, utils;

var
  oddArray: TResultArray;
  evenArray: TResultArray;
  msgCount, msgCountShould: Integer;
  resultArray: TResultArray;
  g_isSameSession: Boolean;
  g_useSingleThread: Boolean;
  g_singleThreadsList: TList;//单线程模式的list
  g_singleThreadsResultList: TList;//单线程模式的返回list
  g_NeedPromoteResult: Boolean;

procedure TReadMemoryForm.btnCheckPtrClick(Sender: TObject);
var
  hProcess: THandle;
  MemoryRegions: TMemoryRegions;
  i, count: Integer;
  pTest: Pointer;
  cb, j: Cardinal;
  MemoryRegionsArray: TMemoryRegionsArray;
begin
  inherited;
  GetSearchProcessHandle(hProcess);
  GetMemoryregions(hProcess, MemoryRegions);
  if Length(MemoryRegions) <= 8 then Exit;
  ShowLogToMemo(Format('count--%d', [CountMemoryRegionsAllMemory(MemoryRegions)]));
  AverageMemoryRegionsToArray(MemoryRegions, MemoryRegionsArray);
  count := 0;
  for i := 0 to threadCount - 1 do
  begin
    mmLog.Lines.Add(IntToStr(i) + '--' +
      IntToStr(High(TMemoryRegions(MemoryRegionsArray[i]))));
    Inc(count, CountMemoryRegionsAllMemory(TMemoryRegions(MemoryRegionsArray[i])));
  end;
  ShowLogToMemo(Format('avr--count--%d', [count]));
  ZeroMemory(@oddArray, SizeOf(TResultArray));
  for i := 0 to threadCount - 1 do
    with TCheckBadPtrThread.Create(hProcess, Handle,
      @oddArray, i,
      TMemoryRegions(MemoryRegionsArray[i])) do
        Resume;
end;

procedure TReadMemoryForm.WndProc(var Msg: TMessage);
var
  count: Cardinal;
  i: Integer;
  list: TList;
begin
  inherited;
  if Msg.Msg = WM_MY_DONE then
  begin
    Inc(msgCount);
    case Msg.WParam of
      1:
      begin
        count := CountFirst{CountByteArrayBlocksMemory}(oddArray);
        mmLog.Lines.Add(IntToStr(msgCount) + '---' + IntToStr(count));
      end;
      2:
      begin
        count := CountListArray(evenArray);
        mmLog.Lines.Add(IntToStr(msgCount) + '---' + IntToStr(count));
      end;
      11: //simpleFind
        if msgCountShould = msgCount then //妈的有线程挂了，这里不好搞，又必须查
        begin
          //count := CountListArray(oddArray);
          g_useSingleThread := True;
          FreeAndNil(g_singleThreadsList);
          g_singleThreadsList := JoinListArrayFast(oddArray);
          ShowLookupResult(g_singleThreadsList, lvFindResult);
        end;
    end;
  end;
end;

procedure TReadMemoryForm.ShowLookupResult(list: TList; lv: TListView);
var
  i: Integer;
begin
  lv.Items.Clear;
  if list.Count <= 5000 then//找到的结果太多的话不展示了
  begin
    for i := 0 to list.Count -1 do
      with lv.Items.Add do
      begin
        Caption := IntToHex(PIntegerItem(list[i]).address, 0);
        SubItems.Add(IntToStr(PIntegerItem(list[i]).value));
      end;
    pgc1.TabIndex := 0;
    stat2.Panels[1].Text := Format('%ds records has found',[list.Count]);
  end else
    ShowLogToMemo(Format('%ds records,and it''s too much!',[list.Count]));
  ShowLookupTimes;
end;

procedure TReadMemoryForm.FormCreate(Sender: TObject);
begin
  inherited;
  InitMemoLog;
end;

procedure TReadMemoryForm.btnFirstClick(Sender: TObject);
var
  hProcess: THandle;
  MemoryRegions: TMemoryRegions;
  i: Integer;
  pTest: Pointer;
  cb, j: Cardinal;
  MemoryRegionsArray: TMemoryRegionsArray;
begin
  inherited;
  GetSearchProcessHandle(hProcess);
  GetMemoryregions(hProcess, MemoryRegions);
  if Length(MemoryRegions) <= 8 then Exit;
  ShowLogToMemo(Format('count--%d', [CountMemoryRegionsAllMemory(MemoryRegions)]));
  AverageMemoryRegionsToArray(MemoryRegions, MemoryRegionsArray);
  for i := 0 to threadCount - 1 do
    mmLog.Lines.Add(IntToStr(i) + '--' +
      IntToStr(High(TMemoryRegions(MemoryRegionsArray[i]))));
  ZeroMemory(@oddArray, SizeOf(TResultArray));
  for i := 0 to threadCount - 1 do
    with TFirstThread.Create(hProcess, Handle,
      @oddArray, i,
      TMemoryRegions(MemoryRegionsArray[i])) do
        Resume;
end;

procedure TReadMemoryForm.btn3Click(Sender: TObject);
var
  hProcess: THandle;
  MemoryRegions: TMemoryRegions;
  MemoryRegionsArray: TMemoryRegionsArray;
  i: Integer;
begin
  inherited;
  GetSearchProcessHandle(hProcess);
  GetMemoryregions(hProcess, MemoryRegions);
  ShowLogToMemo(Format('count--%d', [CountMemoryRegionsAllMemory(MemoryRegions)]));
  AverageMemoryRegionsToArray2(MemoryRegions, MemoryRegionsArray);
  //ShowLogToMemo(Format('count--%d', [CountMemoryRegionsAllMemory(MemoryRegions)]));
  for i := 0 to threadCount - 1 do
    mmLog.Lines.Add(IntToStr(i) + '--' +
      IntToStr(High(TMemoryRegions(MemoryRegionsArray[i]))));

  ShowMemoryRegionsArray(MemoryRegionsArray);
end;

function TReadMemoryForm.ShowMemoryRegions(
  memoryRegions: TMemoryRegions): Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i := Low(memoryRegions) to High(memoryRegions) do
  begin
    //if MemoryRegions[i].MemorySize mod 1024 <> 0 then
    ShowLogToMemo(Format('BaseAddress=%d,MemorySize=%d',
      [memoryRegions[i].BaseAddress, MemoryRegions[i].MemorySize]));
    Inc(Result, MemoryRegions[i].MemorySize);
    //Inc(Result);
  end;
  ShowLogToMemo(Format('count=====%d',
    [Result]));
end;

function TReadMemoryForm.ShowMemoryRegionsArray(
  memoryRegionsArray: TMemoryRegionsArray):
  Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to threadCount - 1 do
  begin
    Inc(Result, showMemoryRegions(memoryRegionsArray[i]));
  end;
  ShowLogToMemo(Format('总计=====%d',
    [Result]));
end;

procedure TReadMemoryForm.btnFilterOutNonChangeClick(Sender: TObject);
var
  hProcess: THandle;
  i: Integer;
  list: TList;
begin
  inherited;
  GetSearchProcessHandle(hProcess);
  //list := TList.Create;
  //SearchChanged(hProcess, resultArray[0], list);
  ZeroMemory(@evenArray, SizeOf(TResultArray));
  for i := 0 to threadCount - 1 do
    with TSecondThread.Create(hProcess, Handle,
      @evenArray, i,
      TList(oddArray[i])) do
        Resume;
end;

procedure TReadMemoryForm.btnFindNonChangeClick(Sender: TObject);
var
  hProcess: THandle;
  i: Integer;
begin
  inherited;
  GetSearchProcessHandle(hProcess);
  ZeroMemory(@oddArray, SizeOf(TResultArray));
  ShowLogToMemo(Format('count--%d', [CountListArray(evenArray)]));
  AverageListArray(evenArray);
  ShowLogToMemo(Format('count--%d', [CountListArray(evenArray)]));
  for i := 0 to threadCount - 1 do
    FindNonChange(hProcess, TList(evenArray[i]));
//    with TThirdThread.Create(hProcess, Handle,
//      @oddArray, i,
//      TList(evenArray[i])) do
//        Resume;
end;

procedure TReadMemoryForm.btnFindChangedClick(Sender: TObject);
var
  hProcess: THandle;
  i: Integer;
begin
  inherited;
  GetSearchProcessHandle(hProcess);
  for i := 0 to threadCount - 1 do
    FindChanged(hProcess, TList(evenArray[i]));
end;

procedure TReadMemoryForm.btnFindValueClick(Sender: TObject);
var
  hProcess: THandle;
  i, v: Integer;
begin
  inherited;
  GetSearchProcessHandle(hProcess);
  ZeroMemory(@oddArray, SizeOf(TResultArray));
  v := GetWillFindValue;
  readyResultArray;
  for i := 0 to threadCount - 1 do
    FindValue(hProcess, TList(evenArray[i]), TList(resultArray[i]), v);
end;

function TReadMemoryForm.GetWillFindValue: Integer;
begin
  Result := GetValueFrom(lbledtFindValue);
end;

function TReadMemoryForm.GetNewValue: Integer;
begin
  Result := GetValueFrom(lbledtNewValue);
end;

function TReadMemoryForm.GetValueFrom(lbledt: TLabeledEdit): Integer;
var
  s: string;
  i, len: Integer;
begin
  Result := 0;
  if Trim(lbledt.Text) = '' then
    ShowLogToMemo(lbledt.Name + ' 为空值，请输入值！')
  else Result := StrToInt(lbledt.Text);
//  s := lbledt.Text;
//  Result := 0;
//  len := Length(s);
//  if len > 4 then
//  len :=4;
//  for i := 1 to len do
//  begin
//    Result := Result * 256 + Byte(s[i]);
//  end;
end;

procedure TReadMemoryForm.NewSession;
begin
  FTimes := 0;
  g_useSingleThread := False;
  ShowLookupTimes;
end;

function TReadMemoryForm.readyResultArray: Integer;
var
  i: Integer;
begin
  for i := 0 to threadCount - 1 do
    resultArray[i] := Pointer(TList.Create);
end;

procedure TReadMemoryForm.btnSimpleFindClick(Sender: TObject);
var
  hProcess: THandle;
  MemoryRegions: TMemoryRegions;
  i: Integer;
  MemoryRegionsArray: TMemoryRegionsArray;
  value: Integer;
begin
  inherited;
  value := GetWillFindValue;
  GetSearchProcessHandle(hProcess);
  if FTimes = 0 then//新开始的会话总是使用多线程模式
    g_useSingleThread := False;
  Inc(FTimes);
  msgCount := 0;
  if g_useSingleThread then
  begin
    FreeAndNil(g_singleThreadsResultList);
    g_singleThreadsResultList := TList.Create;
    FindValue(hProcess, g_singleThreadsList, g_singleThreadsResultList, value);
    ShowLookupResult(g_singleThreadsResultList, lvFindResult);
    g_NeedPromoteResult := True;
    ShowLookupTimes;
  end else begin
    GetMemoryregions(hProcess, MemoryRegions);
    ZeroMemory(@oddArray, SizeOf(TResultArray));
    if Length(MemoryRegions) <= 8 then
    begin
      //只创建一个单线程去处理
      with TWorkThread.Create(hProcess, Handle,
        @oddArray, i, wkSimple,
        MemoryRegions, nil
        ,4, value) do
          Resume;
      msgCountShould := 1;
    end else begin
      ShowLogToMemo(Format('count--%d', [CountMemoryRegionsAllMemory(MemoryRegions)]));
      AverageMemoryRegionsToArray(MemoryRegions, MemoryRegionsArray);
      for i := 0 to threadCount - 1 do
        mmLog.Lines.Add(IntToStr(i) + '--' +
          IntToStr(High(TMemoryRegions(MemoryRegionsArray[i]))));

      for i := 0 to threadCount - 1 do
        with TWorkThread.Create(hProcess, Handle,
          @oddArray, i, wkSimple,
          TMemoryRegions(MemoryRegionsArray[i]), nil
          ,4, value) do
            Resume;

      msgCountShould := threadCount;
    end;
    //显示查找结果要在WndProc去做
  end;
end;

procedure TReadMemoryForm.FormShow(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  Width := 900;
  for i := 0 to ControlCount - 1 do
  begin
    if Controls[i].ClassType = TLabeledEdit then
      TLabeledEdit(Controls[i]).EditLabel.Width :=
        TLabeledEdit(Controls[i]).Width
  end;
  lvProcessesDblClick(lvProcesses);
end;

procedure TReadMemoryForm.lvFindResultDblClick(Sender: TObject);
begin
  inherited;
  lbledtAddress.Text := '0x' + lvFindResult.Selected.Caption;
end;

procedure TReadMemoryForm.btnDoModifyClick(Sender: TObject);
var
  j, cb, numberOfBytesWrite: Cardinal;
  newValue: Integer;
  ok: LongBool;
  pi: PInteger;
  hProcess: THandle;
  str: string;
begin
  inherited;
  GetSearchProcessHandle(hProcess);
  j := StrToInt64(lbledtAddress.Text);
  newValue := GetNewValue;
  pi := @newValue;//我擦居然会报访问违例，难道pi^通常只能做所谓的右值？
  cb := 4;
  ok := WriteProcessMemory(hProcess, Pointer(j), pi, cb, numberOfBytesWrite);
  if ok then
  begin
    str := 'Write OK!';
    if cb = numberOfBytesWrite then
      str := str + 'Write 4 byte'
    else str := str + Format('But %d Bytes.', [numberOfBytesWrite]);
  end else str := Format('Write Error!Code:%d', [GetLastError]);
  ShowLogToMemo(str);
end;

procedure TReadMemoryForm.btnReReadClick(Sender: TObject);
var
  j, cb, numberOfBytesRead: Cardinal;
  value: Integer;
  ok: LongBool;
  pi: PInteger;
  hProcess: THandle;
  str: string;
begin
  inherited;
  GetSearchProcessHandle(hProcess);
  j := StrToInt64(lbledtAddress.Text);

  pi := @value;
  cb := 4;
  ok := ReadProcessMemory(hProcess, Pointer(j), pi, cb, numberOfBytesRead);
  if ok then
  begin
    str := 'ReRead OK!';
    if cb = numberOfBytesRead then
      str := str + Format('@'+ IntToHex(j,0)+',4 bytes:%d',[value])
    else str := str + Format('But %d Bytes.', [numberOfBytesRead]);
    edtReRead.Text := IntToStr(value);
  end else str := Format('ReRead Error!Code:%d', [GetLastError]);
  ShowLogToMemo(str);
end;

procedure TReadMemoryForm.lvProcessesDblClick(Sender: TObject);
begin
  inherited;
  lbledtProcess.Text := '0x' + lvProcesses.Selected.SubItems[0];
end;

procedure TReadMemoryForm.GetSearchProcessHandle(var hProcess: THandle);
var
  i: Cardinal;
begin
  i := StrToInt(lbledtProcess.Text);
  hProcess := OpenProcess(PROCESS_ALL_ACCESS, false, i);
end;

procedure TReadMemoryForm.btn4Click(Sender: TObject);
begin
  inherited;
  mmLog.Visible := not mmLog.Visible;
end;

procedure TReadMemoryForm.btnClearMemoLogClick(Sender: TObject);
begin
  inherited;
  mmLog.Lines.Clear;
end;

procedure TReadMemoryForm.ShowLookupTimes;
begin
  stat1.Panels[0].Text :=
  Format('第 %d 次查找完毕', [FTimes]);
end;

procedure TReadMemoryForm.btnPromoteClick(Sender: TObject);
begin
  inherited;
  if g_NeedPromoteResult then
  begin
    FreeAndNil(g_singleThreadsList);
    g_singleThreadsList := g_singleThreadsResultList;
    g_singleThreadsResultList := nil;
  end;
  g_NeedPromoteResult := False;
end;



procedure TReadMemoryForm.btnBackupAddressesClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  mm1.Lines.Add('----');
  for i := 0 to lvFindResult.Items.Count - 1 do
  begin
    mm1.Lines.Add(lvFindResult.Items[i].Caption);
  end;
  mm1.Lines.Add('++++');
end;

procedure TReadMemoryForm.btnBatchReadClick(Sender: TObject);
var
  j, cb, numberOfBytesRead: Cardinal;
  i, value: Integer;
  ok: LongBool;
  pi: PInteger;
  hProcess: THandle;
  str: string;
begin
  inherited;
  GetSearchProcessHandle(hProcess);
  pi := @value;
  cb := 4;
  for i := 0 to mm1.Lines.Count - 1 do
  begin
    j := StrToInt64('0x' + mm1.Lines[i]);
    ok := ReadProcessMemory(hProcess, Pointer(j), pi, cb, numberOfBytesRead);
    if ok then
    begin
      str := 'ReRead OK!';
      if cb = numberOfBytesRead then
        str := str + Format('@'+ IntToHex(j,0)+',4 bytes:%d',[value])
      else str := str + Format('But %d Bytes.', [numberOfBytesRead]);
    end else str := Format('ReRead Error!Code:%d', [GetLastError]);
    ShowLogToMemo(str);
  end;
end;

procedure TReadMemoryForm.btnBatchWriteClick(Sender: TObject);
var
  j, cb, numberOfBytesWrite: Cardinal;
  i, value: Integer;
  ok: LongBool;
  pi: PInteger;
  hProcess: THandle;
  str: string;
begin
  inherited;
  GetSearchProcessHandle(hProcess);
  value := GetValueFrom(lbledtAAAA);
  pi := @value;
  cb := 4;
  for i := 0 to mm1.Lines.Count - 1 do
  begin
    j := StrToInt64('0x' + mm1.Lines[i]);
    ok := WriteProcessMemory(hProcess, Pointer(j), pi, cb, numberOfBytesWrite);
    if ok then
    begin
      str := 'Write OK!';
      if cb = numberOfBytesWrite then
        str := str + 'Write 4 byte'
      else str := str + Format('But %d Bytes.', [numberOfBytesWrite]);
    end else str := Format('Write Error!Code:%d', [GetLastError]);
    ShowLogToMemo(str);
  end;
end;

procedure TReadMemoryForm.mniNewSessionClick(Sender: TObject);
begin
  inherited;
  NewSession;
end;

end.
