unit threads;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFrm, ComCtrls, ToolWin, StdCtrls, TlHelp32, Variables;


type
  TFirstThread = class(TThread)
    FMainThread: THandle;
    FProcess: THandle;
    FResultArray: PResultArray;
    FResultIndex: Integer;
    FMemoryRegions: TMemoryRegions;
  private

  public
    //searchFlag:1-查找改变值,2-查找不变值
    constructor Create(hProcess, mainThread: THandle;
      resultArray: PResultArray; resultIndex: Integer;
      memoryRegions: TMemoryRegions
      ); overload;
    procedure execute; override;
  end;

  TSecondThread = class(TThread)
    FMainThread: THandle;
    FProcess: THandle;
    FResultArray: PResultArray;
    FResultIndex: Integer;
    FList: TList;
  private

  public
    constructor Create(hProcess, mainThread: THandle;
      resultArray: PResultArray; resultIndex: Integer;
      list: TList
      ); overload;
    procedure execute; override;
  end;

  TThirdThread = class(TThread)
    FMainThread: THandle;
    FProcess: THandle;
    FList: TList;
    FSearchFlag,
    FRange: Integer;
  private

  public
    //searchFlag:1-查找改变值,2-查找不变值
    constructor Create(hProcess, mainThread: THandle; list: TList;
      searchFlag, range: Integer); overload;
    procedure execute; override;
  end;

  TReadIntegerThread = class(TThread)
    FMainThread: THandle;
    FProcess: THandle;
    FI1,
    FI2: Cardinal;
    FFlag,
    FValue: Integer;
    //FLa: PListArray;
    FLaIndex: Integer;
  private

  public

    procedure execute; override;
  end;


  TCheckBadPtrThread = class(TThread)
    FMainThread: THandle;
    FProcess: THandle;
    FResultArray: PResultArray;
    FResultIndex: Integer;
    FMemoryRegions: TMemoryRegions;
  private

  public
    constructor Create(hProcess, mainThread: THandle;
      resultArray: PResultArray; resultIndex: Integer;
      memoryRegions: TMemoryRegions
      ); overload;
    procedure execute; override;
  end;


  TWorkThread = class(TThread)
    FMainThread: THandle;
    FProcess: THandle;
    FResultArray: PResultArray;
    FResultIndex: Integer;
    FWorkKind: TWorkKind;
    FMemoryRegions: TMemoryRegions;
    FList: TList;
    FValueSize,
    FValue: Integer;
  private

  public
    constructor Create(hProcess, mainThread: THandle;
      resultArray: PResultArray; resultIndex: Integer;
      workKind: TWorkKind;//不同的参数在execute里调用相应的方法
      memoryRegions: TMemoryRegions = nil;
      list: TList = nil;
      valueSize: Integer = 0; value: Integer = 0
      ); overload;
    procedure execute; override;
  end;


implementation

{ TFirstThird }
uses
  funcs;



constructor TFirstThread.Create(hProcess, mainThread: THandle;
  resultArray: PResultArray; resultIndex: Integer;
  memoryRegions: TMemoryRegions
  );
begin
  inherited Create(True);
  FProcess := hProcess;
  FMainThread := mainThread;
  FResultArray := resultArray;
  FResultIndex := resultIndex;
  FMemoryRegions := memoryRegions
end;

procedure TFirstThread.execute;
var
  byteArrayBlocks: TByteArrayBlocks;
  list: TList;
begin
  inherited;
  //ScanRegions(FProcess, FMemoryRegions, byteArrayBlocks);
  list := TList.Create;
  ScanRegions3(FProcess, FMemoryRegions, list);
  //
  FResultArray[FResultIndex] := Pointer(list{byteArrayBlocks});
  SendMessage(FMainThread, WM_MY_DONE, 1, 0);
end;


{ TSecondThread }

constructor TSecondThread.Create(hProcess, mainThread: THandle;
  resultArray: PResultArray; resultIndex: Integer;
  list: TList
  );
begin
  inherited Create(True);
  FProcess := hProcess;
  FMainThread := mainThread;
  FResultArray := resultArray;
  FResultIndex := resultIndex;
  FList := list
end;

procedure TSecondThread.execute;
var
  outList: TList;
begin
  inherited;
  outList := TList.Create;
  FilterOutNonChange(FProcess, FList, outList);
  FResultArray[FResultIndex] := Pointer(outList);
  SendMessage(FMainThread, WM_MY_DONE, 2, 0);
end;


{ TThirdThread }

constructor TThirdThread.Create(hProcess, mainThread: THandle; list: TList;
  searchFlag, range: Integer);
begin
  inherited Create(True);
  FProcess := hProcess;
  FMainThread := mainThread;
  FList := list;
  FSearchFlag := searchFlag;
  FRange := Abs(range);
end;

procedure TThirdThread.execute;
begin
  inherited;

  SendMessage(FMainThread, WM_MY_DONE, 2, 0);
end;


{ TReadIntegerThread }


procedure TReadIntegerThread.execute;
begin
  inherited;
  SendMessage(FMainThread, WM_MY_DONE, 1, 0);
end;

{ TCheckBadPtrThread }

constructor TCheckBadPtrThread.Create(hProcess, mainThread: THandle;
  resultArray: PResultArray; resultIndex: Integer;
  memoryRegions: TMemoryRegions
  );
begin
  inherited Create(True);
  FProcess := hProcess;
  FMainThread := mainThread;
  FResultArray := resultArray;
  FResultIndex := resultIndex;
  FMemoryRegions := memoryRegions
end;

procedure TCheckBadPtrThread.execute;
var
  i, count: Integer;
  j: Cardinal;
begin
  inherited;
  i := CheckBadPtrRegions(FMemoryRegions);
  //后面获取值的时候要把pointer转成cardinal，这并不是一个指针
  FResultArray[FResultIndex] := Pointer(i);
  SendMessage(FMainThread, WM_MY_DONE, 7, 0);
end;

{ TWorkThread }

constructor TWorkThread.Create(hProcess, mainThread: THandle;
  resultArray: PResultArray; resultIndex: Integer;
  workKind: TWorkKind;//不同的参数在execute里调用相应的方法
  memoryRegions: TMemoryRegions; list: TList;
  valueSize:Integer; value: Integer);
begin
  inherited Create(True);
  FProcess := hProcess;
  FMainThread := mainThread;
  FResultArray := resultArray;
  FResultIndex := resultIndex;
  FWorkKind := workKind;
  FMemoryRegions := memoryRegions;
  FList := list;
  FValueSize := valueSize;
  FValue := value;
end;

procedure TWorkThread.execute;
var
  list: TList;
begin
  inherited;
  case FWorkKind of//不同的参数在execute里调用相应的方法
    wkSimple:
      begin
        list := TList.Create;
        FindValueUseMemoryregions(FProcess, FMemoryRegions, list, FValueSize, FValue);
        FResultArray[FResultIndex] := Pointer(list);
        SendMessage(FMainThread, WM_MY_DONE, 11, 0);
      end;
  end;
end;

end.
 