unit UPubilcDefine;

interface

uses
  Windows,Messages,SysUtils,ScktComp,Forms,ADODB,syncobjs;

const
  WM_READMEMORY   = WM_USER+100;
  RM_GETADDR     = 1;//-----------------------------------------------------�õ���ַ
  RM_GETPOS     = 2;//-----------------------------------------------------����λ��
  RM_FINISH     = 4;//-----------------------------------------------------��ɱ�־
  RM_MAXPROGRESS   = 8;//-----------------------------------------------------������
  RM_ADDRCOUNT    = 16;//----------------------------------------------------��ַ����
  RM_USETIME     = 32;//----------------------------------------------------����ʱ��
  RM_MEMORYSTARTADDR = 64;//----------------------------------------------------��ʼ��ַ
  RM_MEMORYENDADDR  = 128;//---------------------------------------------------������ַ
  ReadSize      = 4*1024;//------------------------------------------------��ȡ��С

type
  TByteArray = array[1..$FFFF] of Byte;
  TByteArray1 = array[1..1] of Byte;
  TByteArray2 = array[1..2] of Byte;
  TByteArray4 = array[1..4] of Byte;
  PByte    = ^Byte;
  PWord    = ^Word;
  PLongword  = ^Longword;

  TParameter = record//---------------------------------------------------------��ѯ����
    Data:DWord;
    DataType:Integer;
    FirstSearch:Boolean;
    ProcessHandle:THandle;
  end;

  TSearchResult = record//------------------------------------------------------��ѯ���
    Data:Integer;
    DataType:Integer;
    DataAddr:Integer;
  end;

  TProcessInfo = record//-------------------------------------------------------������Ϣ
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
  APPHandle:LongWord;//---------------------------------------------------------��������

implementation

end.



