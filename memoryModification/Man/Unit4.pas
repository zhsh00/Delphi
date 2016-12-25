unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFrm, ComCtrls, ToolWin, StdCtrls, TlHelp32;

const
  blockSize = 1024;
  arraySize = 1024 * 200;//200M!!!
  cutCount = 8;

type
  TBlock = array [0..blockSize - 1] of Byte;
  TBlockArray = array [0..arraySize - 1] of TBlock;
  PBlock = ^TBlock;
  PBlockArray = ^TBlockArray;
  TBlockIndex = array [0..arraySize - 1] of Cardinal;
  TSeqRange = 0..cutCount - 1;

  TBaseForm4 = class(TBaseForm)
    btn1: TToolButton;
    edt1: TEdit;
    edt2: TEdit;
    btnCCCC: TToolButton;
    btnReset: TToolButton;
    mmLog: TMemo;
    btnCheck: TToolButton;
    procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnCCCCClick(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
  private
    FTimes: Cardinal;

    { Private declarations }
  public
    { Public declarations }
    function ReadMemBlockFirst(hProcess: Thandle): boolean;
    function ReadMemBlockSecond(hProcess: Thandle;
      seq: Cardinal): boolean;
  end;

  TReadThread = class(TThread)
    FProcess: THandle;
    Fseq : TSeqRange;
  private
    function ReadMemBlockSecond: boolean;
  public
    constructor Create(hProcess: Thandle; seq: TSeqRange); overload;
    procedure execute; override;
  end;

var
  BaseForm4: TBaseForm4;

implementation

{$R *.dfm}

var
  blocks: TBlockArray;
  blockIndex: TBlockIndex;
  lists: array[0..cutCount - 1] of TList;
  blockCount: Cardinal;

function TBaseForm4.ReadMemBlockFirst(hProcess: Thandle):Boolean;
var                                  //进程句柄
  j, k, successCount, failedCount: Cardinal;
  ok: boolean;
  numberOfBytesRead: Cardinal;
  address: pointer;
begin
  //查找从4M至2G的地址空间
  j := 4*1024*1024;
  k := 2*1024*1024;
  k := k * 1024;
  successCount := 0;
  failedCount := 0;
  while j < k do
  begin
    address := Pointer(j);
    ok := ReadProcessMemory(hProcess, address, Pointer(@(blocks[successCount][0])),
      blockSize, numberOfBytesRead);
    if ok then
    begin
      blockIndex[successCount] := j;
      inc(successCount);
    end
    else inc(failedCount);
    Inc (j, 1024);
  end;
  blockCount := successCount;
  edt1.text := IntToStr(successCount);
  edt2.text := IntToStr(failedCount)
end;

function TBaseForm4.ReadMemBlockSecond(hProcess: Thandle; seq: Cardinal): boolean;
  function min(i1, i2: Cardinal): Cardinal;
  begin
    if (i1 < i2) then Result := i1 else Result := i2;
  end;
var
  i, j, k, i1, i2: Cardinal;
  ok: boolean;
  numberOfBytesRead: Cardinal;
  address: pointer;
  block: TBlock;
  diffByteCount: Cardinal;
  list: TList;
begin
  diffByteCount := 0;
  list := lists[seq];
  if list = nil then
  begin
    list := TList.Create;
    lists[seq] := list; //不懂为什么要放回去lists才有值。
  end;
  i1 := (blockCount div cutCount) * seq;
  if (seq = cutCount - 1) then //最后一段
    i2 := blockCount
  else
    i2 := (blockCount div cutCount) * (seq + 1) - 1;
  for i := i1 to i2 do
  begin
    //读新数据
    j := blockIndex[i];
    address := Pointer(j);
    ok := ReadProcessMemory(hProcess, address, Pointer(@block), blockSize,
      numberOfBytesRead);
    //比较block
    if ok then
    begin
      for k := 0 to blockSize - 1 do
      begin
        if (blocks[i][k] <> block[k]) then
        begin
          list.Add(Pointer(j + k));
          Inc(diffByteCount);
        end;
      end;
    end;
  end;
  //edt1.text := IntToStr(diffCount);
  edt2.text := IntToStr(diffByteCount);
  Result := True;
end;

procedure TBaseForm4.btn1Click(Sender: TObject);
var
  strID: string;
  intID: Cardinal;
  hProcess: THandle;
begin
  //inherited;
  strID := lvProcesses.Selected.SubItems[0];
  intID := StrToInt('0x' + strID);// HexToInt(strID);

  hProcess := OpenProcess(PROCESS_ALL_ACCESS, false, intID);
  ReadMemBlockFirst(hProcess);
end;

procedure TBaseForm4.FormShow(Sender: TObject);
begin
  inherited;
  FTimes := 0;
end;

procedure TBaseForm4.btnResetClick(Sender: TObject);
begin
  inherited;
  FTimes := 0;
  blockCount := 0;//重来
end;

procedure TBaseForm4.btnCCCCClick(Sender: TObject);
var
  strID: string;
  intID: Cardinal;
  hProcess: THandle;
  seq: TSeqRange;
  tt: TThread;
begin
  //inherited;
  strID := lvProcesses.Selected.SubItems[0];
  intID := StrToInt('0x' + strID);// HexToInt(strID);
  hProcess := OpenProcess(PROCESS_ALL_ACCESS, false, intID);

  Inc(FTimes);
  mmLog.Clear;
  if FTimes = 1 then
    ReadMemBlockFirst(hProcess)
  else if FTimes = 2 then begin
    for seq := 0 to cutCount - 1 do
    begin
      ReadMemBlockSecond(hProcess, seq);
      //tt := TReadThread.Create(hProcess, seq);
      //  tt.Resume;
    end;
  end;
end;


{ TReadThread }

function TReadThread.ReadMemBlockSecond: boolean;
var
  i, j, k, i1, i2: Cardinal;
  ok: boolean;
  numberOfBytesRead: Cardinal;
  address: pointer;
  block: TBlock;
  diffByteCount: Cardinal;
  list: TList;
begin
  diffByteCount := 0;
  list := lists[FSeq];
  if list = nil then
    list := TList.Create;
  i1 := (blockCount div cutCount) * FSeq;
  if (FSeq = cutCount - 1) then //最后一段
    i2 := blockCount
  else
    i2 := (blockCount div cutCount) * (FSeq + 1) - 1;
  for i := i1 to i2 do
  begin
    //读新数据
    j := blockIndex[i];
    address := Pointer(j);
    ok := ReadProcessMemory(FProcess, address, Pointer(@block), blockSize,
      numberOfBytesRead);
    //比较block
    if ok then
    begin
      for k := 0 to blockSize - 1 do
      begin
        if (blocks[i][k] <> block[k]) then
        begin
          list.Add(Pointer(j + k));
          Inc(diffByteCount);
        end;
      end;
    end;
  end;
  Result := True;
end;

constructor TReadThread.Create(hProcess: Thandle; seq: TSeqRange);
begin
  inherited Create(True);
  FProcess := hProcess;
  Fseq := seq;
end;

procedure TReadThread.execute;
begin
  inherited;
  BaseForm4.ReadMemBlockSecond(FProcess, Fseq);
  //BaseForm4.mmLog.Lines.Add('Thread: ' + IntToStr(FSeq) +' has done.'
  //   + 'diffBytes: ' + IntToStr(lists[FSeq].Count));
end;

procedure TBaseForm4.btnCheckClick(Sender: TObject);
var
  i: TSeqRange;
begin
  inherited;
  BaseForm4.mmLog.Lines.Add('-------------');
  for i := 0 to cutCount - 1 do
  begin
    if lists[i] <> nil then
      BaseForm4.mmLog.Lines.Add('seq: ' + IntToStr(i) + ',count:' +
        IntToStr(lists[i].Count));
  end;
end;

end.
