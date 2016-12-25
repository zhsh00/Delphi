unit funcs;

interface
uses
    Windows, TypInfo, Variables, Classes, SysUtils, TlHelp32;


type
  //自定义和SysUtil里的定义冲突了，悲剧
  TByteArray = Variables.TByteArray;


//==func==
procedure GetMemoryregions(hProcess:THandle;
  var MemoryRegions: TMemoryRegions);

function CheckBadPtrRegions(memoryRegions: TMemoryRegions): Integer;

//返回成功读取的条数，这里是byte数
function ScanRegions(hProcess: THandle; memoryRegions: TMemoryRegions;
  var byteArrayBlocks: TByteArrayBlocks): Integer;
//返回成功读取的条数，这里是byte数
function ScanRegions2(hProcess: THandle; memoryRegions: TMemoryRegions;
  var list: TList): Integer;
//返回成功读取的条数，这里是byte数
function ScanRegions3(hProcess: THandle; memoryRegions: TMemoryRegions;
  var list: TList): Integer;

function FilterOutNonChange(hProcess: THandle; const list: TList;
  var outList: TList): Integer;

function FindNonChange(hProcess: THandle; var list: TList): Integer;

//flag:0-默认，1-值的改变在value范围内,2-值的改变超过value,3-值变大,4-值变小
function FindChanged(hProcess: THandle; var list: TList;
  flag: Integer = 0; value: Integer = 0): Integer;
  
function FindValue(hProcess: THandle; const list: TList;
  var outList: TList; value: Integer): Integer;
  
//flag:1-查字节，2-查字(2字节)，4-查整数(4字节),3-只要相等都要
function FindValueUseMemoryregions(hProcess: THandle;
  const MemoryRegions: TMemoryRegions;
  var outList: TList; flag, value: Integer): Integer;
//已废弃！！flag:1-查字节，2-查字(2字节)，3-查整数(4字节)
function FindValueUseMemoryregions2(hProcess: THandle;
  const MemoryRegions: TMemoryRegions;
  var outList: TList; flag, value: Integer): Integer;
implementation
uses
  utils;

procedure GetMemoryregions(hProcess:THandle;
  var MemoryRegions: TMemoryRegions);
var
  address: Cardinal;
  mbi: TMemoryBasicInformation;
  stop: Cardinal;
  len: Cardinal;
begin
  SetLength(MemoryRegions, 0);
  address := 0;
{$IFDEF CPUX64}
  stop := $7FFFFFFFFFFFFFFF
{$ELSE}
  stop := $7FFFFFFF;
{$ENDIF}
  while (address < stop) and (VirtualQueryEx(hProcess, Pointer(address),
    mbi, SizeOf(mbi)) <> 0) and ((address + mbi.RegionSize) > address) do
  begin
    if (mbi.state = MEM_COMMIT)// and
      //(((mbi.Protect and PAGE_EXECUTE_READ) = PAGE_EXECUTE_READ) or
      //((mbi.Protect and PAGE_READWRITE) = PAGE_READWRITE) or
      //((mbi.Protect and PAGE_EXECUTE_READWRITE) = PAGE_EXECUTE_READWRITE))
      then
    begin
      len := Length(MemoryRegions);
      SetLength(MemoryRegions, len + 1);
      MemoryRegions[len].BaseAddress := Cardinal(mbi.BaseAddress);
      MemoryRegions[len].MemorySize := mbi.RegionSize;
    end;
    inc(address, mbi.RegionSize);
  end;
end;


function CheckBadPtrRegions(memoryRegions: TMemoryRegions): Integer;
var
  i, k: Integer;
  j: Cardinal;
  pTest: Pointer;
  cb: Cardinal;
begin
  Result := 0;
  k := 0;
  cb := SizeOf(Integer);
  for i := Low(memoryRegions) to High(memoryRegions) do
  begin
    for j := memoryRegions[i].BaseAddress to
      memoryRegions[i].BaseAddress + memoryRegions[i].MemorySize - 1 do
      if IsBadReadPtr(Pointer(j), cb) then
        Inc(k) else Inc(Result);
  end;
  showLogToMemo(Format(
    'Low(memoryRegions)=%d,High(memoryRegions)=%d,count=%d,bad=%d',
    [Low(memoryRegions),High(memoryRegions),Result, k]));
end;

//返回成功读取的条数，这里是byte数
function ScanRegions(hProcess: THandle; memoryRegions: TMemoryRegions;
  var byteArrayBlocks: TByteArrayBlocks): Integer;
var
  i: Integer;
  j, j2, numberOfBytesRead: Cardinal;
  pb: PByte;
  b: Byte;
  cb: Cardinal;
  ByteArray1: TByteArray;
  pByteArrayBlock1: PByteArrayBlock;
  isNewByteArray: Boolean;
  bi, byteCapacity: Integer;
  babi, babCapacity: Integer;
begin
//  Result := 0;
//  cb := SizeOf(Byte);
//  pb := @b;
//  babi := 0;
//  babCapacity := 4;//初始容量
//  SetLength(byteArrayBlocks, babCapacity);
//  pByteArrayBlock1 := @byteArrayBlocks[babi];
//  bi := 0;
//  byteCapacity := 4;//初始容量
//  ByteArray1 := pByteArrayBlock1.ba;
//  SetLength(ByteArray1, byteCapacity);
//  isNewByteArray := True;
//  for i := Low(memoryRegions) to High(memoryRegions) do
//  begin
//    j := memoryRegions[i].BaseAddress;
//    j2 := memoryRegions[i].BaseAddress + memoryRegions[i].MemorySize;
//    while j < j2 do
//    begin
//      if ReadProcessMemory(hProcess, Pointer(j), pb, cb, numberOfBytesRead) then
//      begin
//        if isNewByteArray then
//        begin
//          pByteArrayBlock1.base := j;
//          isNewByteArray := False;
//        end;
//        if bi = byteCapacity then
//        begin
//          byteCapacity := byteCapacity div 2 + byteCapacity;
//          SetLength(ByteArray1, byteCapacity);
//        end;
//        ByteArray1[bi] := b;
//        Inc(bi);
//        Inc(Result);
//      end else begin
//        //本块已经有了数据才开始下一个块
//        if not isNewByteArray then
//        begin
//          SetLength(ByteArray1, bi);
//          pByteArrayBlock1.count := bi;
//          pByteArrayBlock1.ba := ByteArray1;
//          isNewByteArray := True;
//          Inc(babi);
//          if babi = babCapacity then
//          begin
//            babCapacity := babCapacity div 2 + babCapacity;
//            SetLength(byteArrayBlocks, babCapacity);
//          end;
//          //不连续的块重新开始
//          pByteArrayBlock1 := @byteArrayBlocks[babi];
//          bi := 0;
//          byteCapacity := 4;//初始容量
//          ByteArray1 := pByteArrayBlock1.ba;
//          SetLength(ByteArray1, byteCapacity);
//        end;
//      end;
//      Inc(j);
//    end;
//    //repeat循环完成一次，理论上base也要变了，重新开始一个块！！！
//    //本块已经有了数据才开始下一个块
//    if not isNewByteArray then
//    begin
//      SetLength(ByteArray1, bi);
//      pByteArrayBlock1.count := bi;
//      pByteArrayBlock1.ba := ByteArray1;
//      isNewByteArray := True;
//      Inc(babi);
//      if babi = babCapacity then
//      begin
//        babCapacity := babCapacity div 2 + babCapacity;
//        SetLength(byteArrayBlocks, babCapacity);
//      end;
//      //不连续的块重新开始
//      pByteArrayBlock1 := @byteArrayBlocks[babi];
//      bi := 0;
//      byteCapacity := 4;//初始容量
//      ByteArray1 := pByteArrayBlock1.ba;
//      SetLength(ByteArray1, byteCapacity);
//    end;
//  end;
//  //这个逻辑，理解起来绕死了，length刚好就是babi
//  SetLength(byteArrayBlocks, babi);
//  
//  showLogToMemo(Format(
//    'Low(memoryRegions)=%d,High(memoryRegions)=%d,count=%d',
//    [Low(memoryRegions),High(memoryRegions),Result]));
end;

//返回成功读取的条数，这里是byte数
function ScanRegions2(hProcess: THandle; memoryRegions: TMemoryRegions;
  var list: TList): Integer;
var
  i, t: Integer;
  j, j2, numberOfBytesRead: Cardinal;
  pb: PByte;
  b: Byte;
  cb: Cardinal;
  ByteArray1: TByteArray;
  pByteArrayBlock1: PByteArrayBlock;
  isNewByteArray: Boolean;
  bi, byteCapacity: Integer;
  //babi, babCapacity: Integer;
begin
//  Result := 0;
//  cb := SizeOf(Byte);
//  pb := @b;
//  bi := 0;
//  byteCapacity := 4;//初始容量
//  New(pByteArrayBlock1);
//  ByteArray1 := pByteArrayBlock1.ba;
//  SetLength(ByteArray1, byteCapacity);
//  isNewByteArray := True;
//  for i := Low(memoryRegions) to High(memoryRegions) do
//  begin
//    j := memoryRegions[i].BaseAddress;
//    j2 := memoryRegions[i].BaseAddress + memoryRegions[i].MemorySize;
//    while (j < j2) do
//    begin
//      if ReadProcessMemory(hProcess, Pointer(j), pb, cb, numberOfBytesRead) then
//      begin
//        if isNewByteArray then
//        begin
//          pByteArrayBlock1.base := j;
//          isNewByteArray := False;
//        end;
//        if bi = byteCapacity then
//        begin
//          byteCapacity := byteCapacity div 2 + byteCapacity;
//          SetLength(ByteArray1, byteCapacity);
//        end;
//        ByteArray1[bi] := b;
//        Inc(bi);
//        Inc(Result);
//      end else begin
//        //本块已经有了数据才开始下一个块
//        if not isNewByteArray then
//        begin
//          SetLength(ByteArray1, bi);
//          pByteArrayBlock1.count := bi;
//          pByteArrayBlock1.ba := ByteArray1;
//          isNewByteArray := True;
//          list.Add(pByteArrayBlock1);
//          //不连续的块重新开始
//          New(pByteArrayBlock1);
//          bi := 0;
//          byteCapacity := 4;//初始容量
//          ByteArray1 := pByteArrayBlock1.ba;
//          SetLength(ByteArray1, byteCapacity);
//        end;
//        Inc(t);
//      end;
//      Inc(j);
//    end;
//    //repeat循环完成一次，理论上base也要变了，重新开始一个块！！！
//    //本块已经有了数据才开始下一个块
//    if not isNewByteArray then
//    begin
//      SetLength(ByteArray1, bi);
//      pByteArrayBlock1.count := bi;
//      pByteArrayBlock1.ba := ByteArray1;
//      isNewByteArray := True;
//      list.Add(pByteArrayBlock1);
//      //不连续的块重新开始
//      New(pByteArrayBlock1);
//      bi := 0;
//      byteCapacity := 4;//初始容量
//      ByteArray1 := pByteArrayBlock1.ba;
//      SetLength(ByteArray1, byteCapacity);
//    end;
//  end;
//  
//  showLogToMemo(Format(
//    'Low(memoryRegions)=%d,High(memoryRegions)=%d,count=%d,t=%d',
//    [Low(memoryRegions),High(memoryRegions),Result,t]));
end;

//返回成功读取的条数，这里是byte数
function ScanRegions3(hProcess: THandle; memoryRegions: TMemoryRegions;
  var list: TList): Integer;
var
  i, t, tt, ttt: Integer;
  j, j2, numberOfBytesRead: Cardinal;
  cb, cb1024: Cardinal;
  ByteArray1: TByteArray;
  pByteArrayBlock1: PByteArrayBlock;
  iMod: Integer;
begin
  Result := 0;
  t := 0;
  tt := 0;
  ttt := 0;
  cb1024 := 1024;
  New(pByteArrayBlock1);
  for i := Low(memoryRegions) to High(memoryRegions) do
  begin
    j := memoryRegions[i].BaseAddress;
    j2 := memoryRegions[i].BaseAddress + memoryRegions[i].MemorySize;
    while (j < j2) do
    begin
      if ReadProcessMemory(hProcess, Pointer(j), Pointer(@pByteArrayBlock1.ba),
        cb1024, numberOfBytesRead) then
      begin
        pByteArrayBlock1.base := j;
        pByteArrayBlock1.count := cb1024;

        list.Add(pByteArrayBlock1);
        New(pByteArrayBlock1);
        Inc(Result);
        Inc(ttt, cb1024);
      end else begin
        Inc(t);
      end;
      Inc(j, cb1024);
    end;//已经验证过MemorySize总是1024的倍数
    //正数取模结果也是正
    iMod := memoryRegions[i].MemorySize mod cb1024;
    if iMod > 0 then
    begin
      Inc(tt);
    end;
  end;
  
  showLogToMemo(Format(
    'Low(memoryRegions)=%d,High()=%d,count=%d,t=%d,tt=%d,ttt=%d',
    [Low(memoryRegions),High(memoryRegions),Result,t,tt,ttt]));
end;

//第一次的数据太多了，滤除没有变化的
function FilterOutNonChange(hProcess: THandle; const list: TList;
  var outList: TList): Integer;
var
  i, j, k, cb, t: Cardinal;
  numberOfBytesRead: Cardinal;
  address: pointer;
  pii: PIntegerItem;
  ba: TByteArray;
  p: Pointer;
  bab: PByteArrayBlock;
  pi: PInteger;
begin
  Result := 0;
  t := 0;
  if list.Count <= 0 then Exit;
  p := @ba;
  for i := 0 to list.Count - 1 do
  begin
    bab := PByteArrayBlock(list[i]);
    j := bab.base;
    cb := bab.count;
    Inc(t, cb);
    address := Pointer(j);
    if ReadProcessMemory(hProcess, address, p, cb, numberOfBytesRead) then
    begin
      for k := 0 to cb - 4 do
        if PInteger(@bab.ba[k])^ <> PInteger(@ba[k])^ then
        begin
          New(pii);
          pii.address := j + k;
          pii.value := PInteger(@ba[k])^;//要把新值存下来
          outList.Add(pii);
          Inc(Result);
        end;
      //处理边界的3byte！！！输出验证结果没有一个读取成功的
      cb := 4;
      for k := j + cb - 3 to j + cb - 1 do
        if ReadProcessMemory(hProcess, Pointer(k), pi, cb, numberOfBytesRead) then
        begin
          New(pii);
          pii.address := k;
          pii.value := pi^;
          outList.Add(pii);
          //Inc(Result);
        end;
    end;
  end;
  showLogToMemo(Format(
    'list.Count=%d,t=%d,Result=%d',
    [list.Count,t,Result]));
end;

function FindNonChange(hProcess: THandle; var list: TList): Integer;
var
  i, cb: Cardinal;
  numberOfBytesRead: Cardinal;
  address: pointer;
  pii: PIntegerItem;
  pi: PInteger;
  int: Integer;
begin
  Result := 0;
  if list.Count <= 0 then Exit;
  cb := 4;//SizeOf(Integer);
  pi := @int;
  for i := list.Count - 1 downto 0 do
  begin
    pii := PIntegerItem(list[i]);
    address := Pointer(pii.address);
    if ReadProcessMemory(hProcess, address, pi, cb, numberOfBytesRead) then
      if pii.value <> int then
      begin
        list.Delete(i);
        Dispose(pii);//释放New分配的内存
      end;
  end;

  showLogToMemo(Format(
    'list.Count=%d',
    [list.Count]));
end;

//flag:0-默认，1-值的改变在value范围内,2-值的改变超过value,3-值变大,4-值变小
function FindChanged(hProcess: THandle; var list: TList;
  flag, value: Integer): Integer;
var
  i, cb: Cardinal;
  numberOfBytesRead: Cardinal;
  address: pointer;
  pii: PIntegerItem;
  pi: PInteger;
  int, minusValue, change: Integer;
begin
  Result := 0;
  if list.Count <= 0 then Exit;
  cb := 4;//SizeOf(Integer);
  pi := @int;
  minusValue := -1 * Abs(value);
  for i := list.Count - 1 downto 0 do
  begin
    pii := PIntegerItem(list[i]);
    address := Pointer(pii.address);
    if ReadProcessMemory(hProcess, address, pi, cb, numberOfBytesRead) then
      if pii.value = int then
      begin
        list.Delete(i);
        Dispose(pii);//释放New分配的内存
      end else begin
        case flag of
          0:
            begin
              pii.value := int;// 赋新值
            end;
          1:
            begin
              change := int - pii.value;
              if (change > value) or (change < minusValue) then
              begin
                list.Delete(i);
                Dispose(pii);//释放New分配的内存
              end else pii.value := int;// 赋新值
            end;
          2:
            begin
              change := int - pii.value;
              if (change < value) and (change > minusValue) then
              begin
                list.Delete(i);
                Dispose(pii);//释放New分配的内存
              end else pii.value := int;// 赋新值
            end;
          3:
            begin
              if int <= pii.value then
              begin
                list.Delete(i);
                Dispose(pii);//释放New分配的内存
              end else pii.value := int;// 赋新值
            end;
          4:
            begin
              if int >= pii.value then
              begin
                list.Delete(i);
                Dispose(pii);//释放New分配的内存
              end else pii.value := int;// 赋新值
            end;
        end;
      end;
  end;

  showLogToMemo(Format(
    'list.Count=%d',
    [list.Count]));
end;

function FindValue(hProcess: THandle; const list: TList;
  var outList: TList; value: Integer): Integer;
var
  i, cb: Cardinal;
  numberOfBytesRead: Cardinal;
  address: pointer;
  pii, piiNew: PIntegerItem;
  pi: PInteger;
  int: Integer;
begin
  Result := 0;
  if list.Count <= 0 then Exit;
  cb := 4;//SizeOf(Integer);
  pi := @int;
  for i := list.Count - 1 downto 0 do
  begin
    pii := PIntegerItem(list[i]);
    address := Pointer(pii.address);
    if ReadProcessMemory(hProcess, address, pi, cb, numberOfBytesRead) then
      if int = value then
      begin
        pii.value := value;//pii里是上次读取的值，要更新
        outList.Add(pii);//这直接引用，后面释放的时候要小心
        Inc(Result);
      end;
  end;

  showLogToMemo(Format(
    'Result=%d',
    [Result]));
end;

//已废弃！！flag:1-查字节，2-查字(2字节)，3-查整数(4字节)
function FindValueUseMemoryregions2(hProcess: THandle;
  const MemoryRegions: TMemoryRegions;
  var outList: TList; flag, value: Integer): Integer;
var
  i, j, j2, cb: Cardinal;
  numberOfBytesRead: Cardinal;
  address, pBuffer : Pointer;
  b: Byte;
  w: Word;
  int: Integer;
  pii: PIntegerItem;
  //pmi: PMemoryItem;
begin
  Result := 0;
  cb := flag;
  case flag of//是否有必要这么复杂，直接使用Integer做Buffer应该可以？？？
    1: pBuffer := @b;
    2: pBuffer := @w;
    4: pBuffer := @int;
  end;
  //擦，遇到一个超难调的bug，i是Cardinal类型，而High(memoryRegions)=-1。。。
  if High(memoryRegions) = -1 then Exit;
  for i := Low(memoryRegions) to High(memoryRegions) do
  begin
    j2 := memoryRegions[i].BaseAddress + memoryRegions[i].MemorySize;
    for j := memoryRegions[i].BaseAddress to j2 - 1 do
      if ReadProcessMemory(hProcess, Pointer(j), pBuffer,
        cb, numberOfBytesRead) then
      begin
        case flag of
          1: if value <> b then Continue;
          2: if value <> w then Continue;
          4: if value <> int then Continue;
        end;
        New(pii);
        pii.address := j;
        pii.value := value;
        //以下不必
//        case flag of
//          1: PMemoryItem(pii).vByte := b;
//          2: PMemoryItem(pii).vWord := w;
//          4: PMemoryItem(pii).vInteger := int;
//        end;
        outList.Add(pii);
        Inc(Result);
      end;
  end;
  showLogToMemo(Format(
    'Low(memoryRegions)=%d,High(memoryRegions)=%d,count=%d',
    [Low(memoryRegions), High(memoryRegions), Result]));
end;

//flag:1-查字节，2-查字(2字节)，4-查整数(4字节),3-只要相等都要
function FindValueUseMemoryregions(hProcess: THandle;
  const MemoryRegions: TMemoryRegions;
  var outList: TList; flag, value: Integer): Integer;
var
  i, j, j2, cb: Cardinal;
  j3: Cardinal;
  numberOfBytesRead: Cardinal;
  address, pBuffer : Pointer;
  ba: TByteArray;
  k: Integer;
  pii: PIntegerItem;
begin
  Result := 0;
  cb := blockSize;
  pBuffer := @ba;
  j3 := Cardinal(@ba);
  //擦，遇到一个超难调的bug，i是Cardinal类型，而High(memoryRegions)=-1。。。
  if High(memoryRegions) = -1 then Exit;
  for i := Low(memoryRegions) to High(memoryRegions) do
  begin
    j := memoryRegions[i].BaseAddress;
    //已经验证memoryRegions[i].MemorySize一定是1024的倍数，目前cb=1024
    j2 := j + memoryRegions[i].MemorySize;
    while j < j2 do
    begin
      if ReadProcessMemory(hProcess, Pointer(j), pBuffer,
        cb, numberOfBytesRead) then
      begin
        if flag in [1, 3] then
          for k := 0 to cb -1 do//查找Byte（1字节）
            if ba[k] = value then
            begin
              New(pii);
              pii.address := j + k;
              pii.value := value;//直接用value赋值，低位自然就是要的值了
              outList.Add(pii);
              Inc(Result);
            end;
        if flag in [2, 3] then
          for k := 0 to cb -1 - 1 do//查找Word（2字节）
            if PWord(@ba[k])^ {PWord(j3 + k)^} = value then
            begin
              New(pii);
              pii.address := j + k;
              pii.value := value;//直接用value赋值，低位自然就是要的值了
              outList.Add(pii);
              Inc(Result);
            end;
        if flag in [3, 4] then
          //查找整数（4字节）
          //最后的3位不够1个Integer长度,舍弃,这个合理性已在FilterOutNonChange
          //验证
          for k := 0 to cb -1 - 3 do
            //和注释的写法比，哪一种更快呢？？？
            if PInteger(@ba[k])^ {PInteger(j3 + k)^} = value then
            begin
              New(pii);
              pii.address := j + k;
              pii.value := value;
              outList.Add(pii);
              Inc(Result);
            end;
      end;
      Inc(j, cb);
    end;
  end;
  showLogToMemo(Format(
    'Low(memoryRegions)=%d,High(memoryRegions)=%d,count=%d',
    [Low(memoryRegions), High(memoryRegions), Result]));
end;

//initialization
//  mmlog := ReadMemoryForm.mmLog;
//finalization
//  mmlog := nil;
end.
