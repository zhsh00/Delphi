unit UReadMemoryFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, PsAPI, TlHelp32;

type
  TReadMemoryForm = class(TForm)
    stat1: TStatusBar;
    ReadMemoryProgress: TProgressBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  TReadMemory = class
  public
    function GetProcessInfo: TList;
  end;
var
  ReadMemoryForm: TReadMemoryForm;

implementation

{$R *.dfm}
uses
  UPubilcDefine;

//1：CreateToolhelp32Snapshot()创建系统快照句柄（hSnapShot是我们声明用来保存
//创建的快照句柄）
//2：Process32First、Process32Next是用来枚举进程
function TReadMemory.GetProcessInfo: TList;
var
  ProcessInfoList : TList;
  ProcessInfo     : PProcessInfo;
  hSnapShot       : THandle;
  mProcessEntry32 : TProcessEntry32;
  bFound          : Boolean;
begin
  ProcessInfoList := TList.Create;
  ProcessInfoList.Clear;
  hSnapShot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  mProcessEntry32.dwSize := Sizeof(mProcessEntry32);
  bFound := Process32First(hSnapShot, mProcessEntry32);
  while bFound do
  begin
    New(ProcessInfo);
    ProcessInfo.ProcessExe := mProcessEntry32.szExeFile;
    ProcessInfo.ProcessId := mProcessEntry32.th32ProcessID;
    ProcessInfoList.Add(ProcessInfo);
    bFound := Process32Next(hSnapShot, mProcessEntry32);
  end;
  Result := ProcessInfoList;
end;

{=============内存查找=========================}
function TReadMemoryForm.StartSearch: Boolean;
var
  ProcHandle:Integer;
begin
  Result:=False;
  ReadMemoryProgress.Position:=0;
  if Not CheckInput then Exit;
  if FileName=TabSheet1.Caption then //-----------------------------------------搜索次数>1次
  begin
    PParameter.FirstSearch:=False;
    PParameter.Data:=StrToInt(EdtSearchData.Text);
  end else
  begin               //-----------------------------------------第一次搜索
    PParameter.FirstSearch:=True;
    if PParameter.ProcessHandle>0 then
    CloseHandle(PParameter.ProcessHandle);
    ProcHandle:=OpenProcess(PROCESS_ALL_ACCESS,false,StrToInt(EdtProcID.Text));
    if ProcHandle>0 then
    begin
      PParameter.Data:=StrToInt(EdtSearchData.Text);
      Case DataType.ItemIndex of
        0:PParameter.DataType:=1;
        1:PParameter.DataType:=2;
        2:PParameter.DataType:=4;
      end;
    end else Exit;
    FileName:=TabSheet1.Caption;
    PParameter.ProcessHandle:=ProcHandle;
  end;
  SearchButton.Enabled:=False;
  ToolSearchMemory.Enabled:=False;
  MemoryAddrList.Clear;
  PReadMemory.StartSearch;
  Result:=True;
end;
//1: HANDLE OpenProcess(
//DWORD   dwDesiredAccess, // 希望获得的访问权限
//BOOL    bInheritHandle, // 指明是否希望所获得的句柄可以继承
//DWORD   dwProcessId // 要访问的进程ID
//);
//分析内存块
//------------------------------------------------------------------------------分析内存块
function TReadMemoryThread.GetMemoryRegion: Boolean;
var
  TempStartAddress : DWord;
  TempEndAddress  : DWord;
  I,J,k      : Integer;
  NewMemoryRegions : array [0..40000] of TmemoryRegion;
begin
  Result:=False;
  MemoryRegionsIndex := 0;
  TempStartAddress  := 1*1024*1024;
  TempEndAddress   := 2*1024*1024;
  TempEndAddress   := TempEndAddress*1024;
  While (VirtualQueryEx(PParameter.ProcessHandle, pointer(TempStartAddress),
    MBI, sizeof(MBI))>0) and (TempStartAddress<TempEndAddress) do
  begin
    if (MBI.State=MEM_COMMIT)  then
    begin
      if (MBI.Protect=PAGE_READWRITE) or
         (MBI.Protect=PAGE_WRITECOPY) or
         (MBI.Protect=PAGE_EXECUTE_READWRITE) or
         (MBI.Protect=PAGE_EXECUTE_WRITECOPY) then
      begin
        PMemoryRegion[MemoryRegionsIndex].BaseAddress:=Dword(MBI.BaseAddress);
        PMemoryRegion[MemoryRegionsIndex].MemorySize:=MBI.RegionSize;
        Inc(MemoryRegionsIndex);
      end;
    end;
    TempStartAddress:=Dword(MBI.BaseAddress)+MBI.RegionSize;
  end;
  if MemoryRegionsIndex=0 then Exit;
  //------------------------------------------------------------------------------判断内存块是否过大
  J:=0;
  for i:=0 to MemoryRegionsIndex-1 do
  begin
    if PMemoryRegion.MemorySize>$FFFF then
    begin
      for K:=0 to PMemoryRegion.MemorySize div $FFFF do
      begin
        if K=PMemoryRegion.MemorySize div $FFFF+1 then
        begin
        NewMemoryRegions[j].BaseAddress:=PMemoryRegion.BaseAddress+K*$FFFF;
        NewMemoryRegions[j].MemorySize:=PMemoryRegion.MemorySize Mod $FFFF;
        end else
        begin
        NewMemoryRegions[j].BaseAddress:=PMemoryRegion.BaseAddress+K*$FFFF;
        NewMemoryRegions[j].MemorySize:=$FFFF;
        end;
        Inc(J);
      end;
    end else
    begin
      NewMemoryRegions[j].BaseAddress:=PMemoryRegion.BaseAddress;
      NewMemoryRegions[j].MemorySize:=PMemoryRegion.MemorySize;
      Inc(J);
    end;
  end;
  //------------------------------------------------------------------------------数据转换
  MemoryRegionsIndex:=j;
  for i:=0 to MemoryRegionsIndex-1 do
  begin
    PMemoryRegion.MemorySize:=NewMemoryRegions.MemorySize;
    PMemoryRegion.BaseAddress:=NewMemoryRegions.BaseAddress;
  end;
  Result:=True;
end;
//1：查找的内存大小
//TempStartAddress  := 1*1024*1024;
//TempEndAddress   := 2*1024*1024;
//TempEndAddress   := TempEndAddress*1024;
//2：VirtualQueryEx :查询地址空间中内存地址的信息。
//参数:
//hProcess  进程句柄。
//LpAddress  查询内存的地址。
//LpBuffer  指向MEMORY_BASIC_INFORMATION结构的指针，用于接收内存信息。
//DwLength  MEMORY_BASIC_INFORMATION结构的大小。
//返回值:
//函数写入lpBuffer的字节数，如果不等于sizeof(MEMORY_BASIC_INFORMATION)表示失败。
//http://www.vckbase.com/vckbase/function/viewfunc.asp?id=139 讲了这个API的详细信息
{=============================================}
{=============开始查找=========================}
{=============================================}
procedure TReadMemoryThread.Execute;
var
  //StopAddr,StartAddr:Dword;
  BeginTime,EndTime:String;
  I:Integer;
begin
  inherited;
  while Not Terminated do
  begin
    AddrCount    := 0;
    if PParameter.FirstSearch then
    begin
      if Not GetMemoryRegion then Exit;
      GetMaxMemoryRange;
      GetMinMemoryRange;
      SendMessage(APPHandle,WM_READMEMORY,RM_MAXPROGRESS,MemoryRegionsIndex);
      BeginTime:=FloatToStr(CPUTimeCounterQPC);
      for I:=0 to MemoryRegionsIndex-1 do
      begin
      FirstCheckMemory(PMemoryRegion.BaseAddress,PMemoryRegion.MemorySize);
      end;
      EndTime:=FloatToStr(CPUTimeCounterQPC);
      SendMessage(APPHandle,
      WM_READMEMORY,
      RM_USETIME,
      StrToInt(Copy(EndTime,1,Pos('.',EndTime)-1))-StrToInt(Copy(BeginTime,1,Pos('.',BeginTime)-1)));
      SendMessage(APPHandle,WM_READMEMORY,RM_ADDRCOUNT,AddrCount);
      SendMessage(APPHandle,WM_READMEMORY,RM_FINISH,RM_FINISH);
    end else
    begin
      SendMessage(APPHandle,WM_READMEMORY,RM_MAXPROGRESS,100);
      BeginTime:=FloatToStr(CPUTimeCounterQPC);
      for i:=0 to High(PSearchAgain) do
      begin
      SecondCheckMemory(PSearchAgain.DataAddr);
      end;
      EndTime:=FloatToStr(CPUTimeCounterQPC);
      SendMessage(APPHandle,
      WM_READMEMORY,
      RM_USETIME,
      StrToInt(Copy(EndTime,1,Pos('.',EndTime)-1))-StrToInt(Copy(BeginTime,1,Pos('.',BeginTime)-1)));
      SendMessage(APPHandle,WM_READMEMORY,RM_ADDRCOUNT,AddrCount);
      SendMessage(APPHandle,WM_READMEMORY,RM_FINISH,RM_FINISH);
    end;
    Suspend;
  end;
end;

//------------------------------------------------------------------------------第一次查询
function TReadMemoryThread.FirstCheckMemory(Addr:Integer;ReadCount:Integer): Boolean;
var
  i:Integer;
  Buffer:TByteArray;
  LPDW:DWORD;
begin
  //Result:=False;
  SendMessage(APPHandle,WM_READMEMORY,RM_GETPOS,RM_GETPOS);
  //ZeroMemory(@Buffer,Sizeof(Buffer));
  //SetLength(Buffer,ReadCount);
  if ReadProcessMemory(PParameter.processhandle,pointer(Addr),pointer(@(buffer)),ReadCount,Lpdw) then
  begin
    if Lpdw>0 then
    begin
      I:=1;
      While I<=Lpdw do
      begin
        case PParameter.DataType of
        1:
        begin
          if PByte(@(Buffer))^=PParameter.Data then
          begin
            PSearchResult.Data:=PParameter.Data;
            PSearchResult.DataAddr:=Addr+i-1;
            PSearchResult.DataType:=PParameter.DataType;
            if AddrCount<=99 then
            begin
            PSearchAgain[AddrCount].Data:=PParameter.Data;
            PSearchAgain[AddrCount].DataType:=PParameter.DataType;
            PSearchAgain[AddrCount].DataAddr:=Addr+i-1;
            end;
            Inc(AddrCount);
            SendMessage(APPHandle,WM_READMEMORY,RM_GETADDR,RM_GETADDR);
          end;
        end;
        2:
        begin
          if PWord(@(Buffer))^=PParameter.Data then
          begin
            PSearchResult.Data:=PParameter.Data;
            PSearchResult.DataAddr:=Addr+i-1;
            PSearchResult.DataType:=PParameter.DataType;
            if AddrCount<=99 then
            begin
            PSearchAgain[AddrCount].Data:=PParameter.Data;
            PSearchAgain[AddrCount].DataType:=PParameter.DataType;
            PSearchAgain[AddrCount].DataAddr:=Addr+i-1;
            end;
            Inc(AddrCount);
            SendMessage(APPHandle,WM_READMEMORY,RM_GETADDR,RM_GETADDR);
          end;
        end;
        4:
        begin
          if PLongword(@(Buffer))^=PParameter.Data then
          begin
            PSearchResult.Data:=PParameter.Data;
            PSearchResult.DataAddr:=Addr+i-1;
            PSearchResult.DataType:=PParameter.DataType;
            if AddrCount<=99 then
            begin
            PSearchAgain[AddrCount].Data:=PParameter.Data;
            PSearchAgain[AddrCount].DataType:=PParameter.DataType;
            PSearchAgain[AddrCount].DataAddr:=Addr+i-1;
            end;
            Inc(AddrCount);
            SendMessage(APPHandle,WM_READMEMORY,RM_GETADDR,RM_GETADDR);
          end;
        end;
        end;
        Inc(I);
      end;
    end;
  end;
  Result:=True;
end;
//------------------------------------------------------------------------------多次查询
function TReadMemoryThread.SecondCheckMemory(Addr:Integer): Boolean;
var
Buffer:TByteArray1;
Lpdw:DWord;
begin
  SendMessage(APPHandle,WM_READMEMORY,RM_GETPOS,RM_GETPOS);
  if ReadProcessMemory(PParameter.processhandle,
  pointer(Addr),
  pointer(@(buffer[1])),
  PParameter.DataType,Lpdw) then
  begin
    Case PParameter.DataType of
      1:
      begin
        if PByte(@(Buffer))^=PParameter.Data then
        begin
        PSearchResult.Data:=PParameter.Data;
        PSearchResult.DataAddr:=Addr;
        PSearchResult.DataType:=PParameter.DataType;
        Inc(AddrCount);
        SendMessage(APPHandle,WM_READMEMORY,RM_GETADDR,RM_GETADDR);
        end;
      end;
      2:
      begin
        if PWord(@(Buffer))^=PParameter.Data then
        begin
        PSearchResult.Data:=PParameter.Data;
        PSearchResult.DataAddr:=Addr;
        PSearchResult.DataType:=PParameter.DataType;
        Inc(AddrCount);
        SendMessage(APPHandle,WM_READMEMORY,RM_GETADDR,RM_GETADDR);
        end;
      end;
      4:
      begin
        if PLongword(@(Buffer))^=PParameter.Data then
        begin
        PSearchResult.Data:=PParameter.Data;
        PSearchResult.DataAddr:=Addr;
        PSearchResult.DataType:=PParameter.DataType;
        Inc(AddrCount);
        SendMessage(APPHandle,WM_READMEMORY,RM_GETADDR,RM_GETADDR);
        end;
      end;
    end;
  end;
  Result:=True;
end;
//1: ReadProcessMemory
//http://www.vckbase.com/vckbase/funct ... sp?id=148 具体用法
//参数
//hProcess
//目标进程的句柄，该句柄必须对目标进程具有PROCESS_VM_READ 的访问权限。
//lpBaseAddress
//从目标进程中读取数据的起始地址。 在读取数据前，系统将先检验该地址的数据是否可读，如果不可读，函数将调用失败。
//lpBuffer
//用来接收数据的缓存区地址。
//nSize
//从目标进程读取数据的字节数。
//lpNumberOfBytesRead
//实际被读取数据大小的存放地址。如果被指定为NULL,那么将忽略此参数。
//返回值
//如果函数执行成功，返回值非零。
//如果函数执行失败，返回值为零。调用 GetLastError 函数可以获取该函数执行错误的信息。
//如果要读取一个进程中不可访问空间的数据，该函数就会失败。
//2：
//PByte    = ^Byte;
//PWord    = ^Word;
//PLongword  = ^Longword;
//数据类型指针
//如果在内存中是：AA BB CC DD
//那么读出来实际上：PByte (@(Buffer))^   AA
//PWord(@(Buffer))^   BBAA
//PLongword (@(Buffer))^ DDCCBBAA
{=============================================}
{=============修改内存=========================}
{=============================================}
procedure TReadMemoryForm.ChangeMemoryClick(Sender: TObject);
var
  LPDW:DWord;
  NewData:Integer;
  PDataType:Integer;
begin
  if Not ElevPrivileges(False) Then
  begin
  DisMessage('提高程序权限失败');
  Exit;
  end;
  if (EdtAddr.Text='') or (EdtDataType.Text='') or (EdtNewData.Text='') then
  begin
  DisMessage('请输入数据');
  Exit;
  end;
  case EdtDataType.ItemIndex of
    0:
    begin
    PDataType:=1;
    end;
    1:
    begin
    PDataType:=2;
    end;
    2:
    begin
    PDataType:=4;
    end;
  end;
  try
    NewData:=StrToInt(EdtNewData.Text);
    if WriteProcessMemory(PParameter.ProcessHandle,
    pointer(strtoint('$'+EdtAddr.Text)),
    @NewData,
    PDataType,
    LPDW) then
    begin
    DisMessage('修改成功');
    end else
    begin
    DisMessage('修改失败');
    end;
  except
    DisMessage('修改失败');
  end;
end;
//1：WriteProcessMemory
//参数含义同ReadProcessMemory,其中hProcess句柄要有对进程的PROCESS_VM_WRITE和PROCESS_VM_OPERATION权限.lpBuffer为要写到指定进程的数据的指针.
//2：因为有写内存是只读的你可以修改内存属性来修改内存
function TBaseHOOK.GetMemoryProperty(Addr:Pointer): DWord;
var
lpBuffer: TMemoryBasicInformation;
begin
  Result:=0;
  if VirtualQueryEx(DestHandle,Addr,lpBuffer,sizeof(lpBuffer))>0 then
  begin
    if lpBuffer.State=MEM_COMMIT then
    begin
    Result:=lpBuffer.Protect;
    end;
  end;
end;

//MemoryProperty:=GetMemoryProperty(OldFun); {得到内存属性}
//VirtualProtectEx(DestHandle
//,OldFun
//,8
//,PAGE_READWRITE
//,@GetCurrentProcessId);         {修改内存属性}
//if Not WriteProcessMemory(DestHandle,
//OldFun,
//@FunJumpCode[FunIndex[FunName]].NewJmpCode,
//8,
//dwSize)then Exit;
//VirtualProtectEx(DestHandle        {恢复内存属性}
//,OldFun
//,8
//,MemoryProperty
//,@GetCurrentProcessId);


end.

