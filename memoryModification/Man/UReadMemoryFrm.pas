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

//1��CreateToolhelp32Snapshot()����ϵͳ���վ����hSnapShot������������������
//�����Ŀ��վ����
//2��Process32First��Process32Next������ö�ٽ���
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

{=============�ڴ����=========================}
function TReadMemoryForm.StartSearch: Boolean;
var
  ProcHandle:Integer;
begin
  Result:=False;
  ReadMemoryProgress.Position:=0;
  if Not CheckInput then Exit;
  if FileName=TabSheet1.Caption then //-----------------------------------------��������>1��
  begin
    PParameter.FirstSearch:=False;
    PParameter.Data:=StrToInt(EdtSearchData.Text);
  end else
  begin               //-----------------------------------------��һ������
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
//DWORD   dwDesiredAccess, // ϣ����õķ���Ȩ��
//BOOL    bInheritHandle, // ָ���Ƿ�ϣ������õľ�����Լ̳�
//DWORD   dwProcessId // Ҫ���ʵĽ���ID
//);
//�����ڴ��
//------------------------------------------------------------------------------�����ڴ��
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
  //------------------------------------------------------------------------------�ж��ڴ���Ƿ����
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
  //------------------------------------------------------------------------------����ת��
  MemoryRegionsIndex:=j;
  for i:=0 to MemoryRegionsIndex-1 do
  begin
    PMemoryRegion.MemorySize:=NewMemoryRegions.MemorySize;
    PMemoryRegion.BaseAddress:=NewMemoryRegions.BaseAddress;
  end;
  Result:=True;
end;
//1�����ҵ��ڴ��С
//TempStartAddress  := 1*1024*1024;
//TempEndAddress   := 2*1024*1024;
//TempEndAddress   := TempEndAddress*1024;
//2��VirtualQueryEx :��ѯ��ַ�ռ����ڴ��ַ����Ϣ��
//����:
//hProcess  ���̾����
//LpAddress  ��ѯ�ڴ�ĵ�ַ��
//LpBuffer  ָ��MEMORY_BASIC_INFORMATION�ṹ��ָ�룬���ڽ����ڴ���Ϣ��
//DwLength  MEMORY_BASIC_INFORMATION�ṹ�Ĵ�С��
//����ֵ:
//����д��lpBuffer���ֽ��������������sizeof(MEMORY_BASIC_INFORMATION)��ʾʧ�ܡ�
//http://www.vckbase.com/vckbase/function/viewfunc.asp?id=139 �������API����ϸ��Ϣ
{=============================================}
{=============��ʼ����=========================}
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

//------------------------------------------------------------------------------��һ�β�ѯ
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
//------------------------------------------------------------------------------��β�ѯ
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
//http://www.vckbase.com/vckbase/funct ... sp?id=148 �����÷�
//����
//hProcess
//Ŀ����̵ľ�����þ�������Ŀ����̾���PROCESS_VM_READ �ķ���Ȩ�ޡ�
//lpBaseAddress
//��Ŀ������ж�ȡ���ݵ���ʼ��ַ�� �ڶ�ȡ����ǰ��ϵͳ���ȼ���õ�ַ�������Ƿ�ɶ���������ɶ�������������ʧ�ܡ�
//lpBuffer
//�����������ݵĻ�������ַ��
//nSize
//��Ŀ����̶�ȡ���ݵ��ֽ�����
//lpNumberOfBytesRead
//ʵ�ʱ���ȡ���ݴ�С�Ĵ�ŵ�ַ�������ָ��ΪNULL,��ô�����Դ˲�����
//����ֵ
//�������ִ�гɹ�������ֵ���㡣
//�������ִ��ʧ�ܣ�����ֵΪ�㡣���� GetLastError �������Ի�ȡ�ú���ִ�д������Ϣ��
//���Ҫ��ȡһ�������в��ɷ��ʿռ�����ݣ��ú����ͻ�ʧ�ܡ�
//2��
//PByte    = ^Byte;
//PWord    = ^Word;
//PLongword  = ^Longword;
//��������ָ��
//������ڴ����ǣ�AA BB CC DD
//��ô������ʵ���ϣ�PByte (@(Buffer))^   AA
//PWord(@(Buffer))^   BBAA
//PLongword (@(Buffer))^ DDCCBBAA
{=============================================}
{=============�޸��ڴ�=========================}
{=============================================}
procedure TReadMemoryForm.ChangeMemoryClick(Sender: TObject);
var
  LPDW:DWord;
  NewData:Integer;
  PDataType:Integer;
begin
  if Not ElevPrivileges(False) Then
  begin
  DisMessage('��߳���Ȩ��ʧ��');
  Exit;
  end;
  if (EdtAddr.Text='') or (EdtDataType.Text='') or (EdtNewData.Text='') then
  begin
  DisMessage('����������');
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
    DisMessage('�޸ĳɹ�');
    end else
    begin
    DisMessage('�޸�ʧ��');
    end;
  except
    DisMessage('�޸�ʧ��');
  end;
end;
//1��WriteProcessMemory
//��������ͬReadProcessMemory,����hProcess���Ҫ�жԽ��̵�PROCESS_VM_WRITE��PROCESS_VM_OPERATIONȨ��.lpBufferΪҪд��ָ�����̵����ݵ�ָ��.
//2����Ϊ��д�ڴ���ֻ����������޸��ڴ��������޸��ڴ�
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

//MemoryProperty:=GetMemoryProperty(OldFun); {�õ��ڴ�����}
//VirtualProtectEx(DestHandle
//,OldFun
//,8
//,PAGE_READWRITE
//,@GetCurrentProcessId);         {�޸��ڴ�����}
//if Not WriteProcessMemory(DestHandle,
//OldFun,
//@FunJumpCode[FunIndex[FunName]].NewJmpCode,
//8,
//dwSize)then Exit;
//VirtualProtectEx(DestHandle        {�ָ��ڴ�����}
//,OldFun
//,8
//,MemoryProperty
//,@GetCurrentProcessId);


end.

