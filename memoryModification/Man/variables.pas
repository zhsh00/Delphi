unit Variables;

interface

uses
  Classes, Messages, SysUtils, Windows, StdCtrls;

const
  WM_MY_DONE = WM_USER + 100;

  
  blockSize = 1024;
  threadCount = 8;

type
  TWorkKind = (wkFirst, wkSecond, wkThird, wkSimple, wkOther);

  TByteArray = array[0..blockSize] of Byte;
  PByteArray =^TByteArray;
  //TWordArray = array[0..MaxListSize - 1] of Integer;//SysUtils已经定义了
  //PWordArray = ^TWordArray;
  TIntegerArray = array[0..MaxListSize - 1] of Integer;
  PIntegerArray = ^TIntegerArray;

  TMemoryRegion = record
    BaseAddress: Cardinal;
    MemorySize: Integer;
  end;
  PMemoryRegion = ^TMemoryRegion;
  TMemoryRegions = array of TMemoryRegion;
  PMemoryRegions = TMemoryRegions;

  TMemoryRegionsArray = array[0..threadCount - 1] of TMemoryRegions;
  //PMemoryRegionsArray = ^TMemoryRegionsArray;
  TResultArray = array[0..threadCount - 1] of Pointer;
  PResultArray = ^TResultArray;



  TByteArrayBlock = record
    base: Cardinal;
    count: Cardinal;
    ba: TByteArray;
  end;
  PByteArrayBlock = ^TByteArrayBlock;
  TByteArrayBlocks = array of TByteArrayBlock;
  //PContinuousByteBlocks = ^TContinuousByteBlocks;

  TByteItem = record//大小才5字节，好浪费空间
    address: Cardinal;
    value: Byte;
  end;
  PByteItem = ^TByteItem;
  TIntegerItem = record
    address: Cardinal;
    value: Integer;
  end;
  PIntegerItem = ^TIntegerItem;



  TMemoryItem = record
    address: Cardinal;
  case Integer of
    1: (vByte: Byte;);
    2: (vWord: Word;);
    4: (vInteger: Integer;);
  end;
  PMemoryItem = ^TMemoryItem;


var
  mmlog: TMemo;

implementation

end.
