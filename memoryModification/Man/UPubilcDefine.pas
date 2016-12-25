unit UPubilcDefine;

interface

uses
  Windows,Messages,SysUtils,ScktComp,Forms,ADODB,syncobjs;

const
  WM_READMEMORY   = WM_USER+100;
  RM_GETADDR     = 1;//-----------------------------------------------------得到地址
  RM_GETPOS     = 2;//-----------------------------------------------------进度位置
  RM_FINISH     = 4;//-----------------------------------------------------完成标志
  RM_MAXPROGRESS   = 8;//-----------------------------------------------------最大进度
  RM_ADDRCOUNT    = 16;//----------------------------------------------------地址总数
  RM_USETIME     = 32;//----------------------------------------------------花费时间
  RM_MEMORYSTARTADDR = 64;//----------------------------------------------------开始地址
  RM_MEMORYENDADDR  = 128;//---------------------------------------------------结束地址
  ReadSize      = 4*1024;//------------------------------------------------读取大小

type
  TByteArray = array[1..$FFFF] of Byte;
  TByteArray1 = array[1..1] of Byte;
  TByteArray2 = array[1..2] of Byte;
  TByteArray4 = array[1..4] of Byte;
  PByte    = ^Byte;
  PWord    = ^Word;
  PLongword  = ^Longword;

  TParameter = record//---------------------------------------------------------查询参数
    Data:DWord;
    DataType:Integer;
    FirstSearch:Boolean;
    ProcessHandle:THandle;
  end;

  TSearchResult = record//------------------------------------------------------查询结果
    Data:Integer;
    DataType:Integer;
    DataAddr:Integer;
  end;

  TProcessInfo = record//-------------------------------------------------------进程信息
    ProcessExe:String;
    ProcessID:Integer;
  end;

  PProcessInfo=^TProcessInfo;
  TMemoryRegion = record
    BaseAddress:Dword;
    MemorySize:Dword;
  end;

var
  PParameter:TParameter;
  PSearchResult:TSearchResult;
  PSearchAgain:Array[0..99] of TSearchResult;
  APPHandle:LongWord;//---------------------------------------------------------主程序句柄

implementation

end.



