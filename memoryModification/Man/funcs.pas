unit funcs;

interface
uses
    Windows, TypInfo, Variables, Classes, SysUtils, TlHelp32;


type
  //�Զ����SysUtil��Ķ����ͻ�ˣ�����
  TByteArray = Variables.TByteArray;


//==func==
procedure GetMemoryregions(hProcess:THandle;
  var MemoryRegions: TMemoryRegions);

function CheckBadPtrRegions(memoryRegions: TMemoryRegions): Integer;

//���سɹ���ȡ��������������byte��
function ScanRegions(hProcess: THandle; memoryRegions: TMemoryRegions;
  var byteArrayBlocks: TByteArrayBlocks): Integer;
//���سɹ���ȡ��������������byte��
function ScanRegions2(hProcess: THandle; memoryRegions: TMemoryRegions;
  var list: TList): Integer;
//���سɹ���ȡ��������������byte��
function ScanRegions3(hProcess: THandle; memoryRegions: TMemoryRegions;
  var list: TList): Integer;

function FilterOutNonChange(hProcess: THandle; const list: TList;
  var outList: TList): Integer;

function FindNonChange(hProcess: THandle; var list: TList): Integer;

//flag:0-Ĭ�ϣ�1-ֵ�ĸı���value��Χ��,2-ֵ�ĸı䳬��value,3-ֵ���,4-ֵ��С
function FindChanged(hProcess: THandle; var list: TList;
  flag: Integer = 0; value: Integer = 0): Integer;
  
function FindValue(hProcess: THandle; const list: TList;
  var outList: TList; value: Integer): Integer;
  
//flag:1-���ֽڣ�2-����(2�ֽ�)��4-������(4�ֽ�),3-ֻҪ��ȶ�Ҫ
function FindValueUseMemoryregions(hProcess: THandle;
  const MemoryRegions: TMemoryRegions;
  var outList: TList; flag, value: Integer): Integer;
//�ѷ�������flag:1-���ֽڣ�2-����(2�ֽ�)��3-������(4�ֽ�)
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

//���سɹ���ȡ��������������byte��
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
//  babCapacity := 4;//��ʼ����
//  SetLength(byteArrayBlocks, babCapacity);
//  pByteArrayBlock1 := @byteArrayBlocks[babi];
//  bi := 0;
//  byteCapacity := 4;//��ʼ����
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
//        //�����Ѿ��������ݲſ�ʼ��һ����
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
//          //�������Ŀ����¿�ʼ
//          pByteArrayBlock1 := @byteArrayBlocks[babi];
//          bi := 0;
//          byteCapacity := 4;//��ʼ����
//          ByteArray1 := pByteArrayBlock1.ba;
//          SetLength(ByteArray1, byteCapacity);
//        end;
//      end;
//      Inc(j);
//    end;
//    //repeatѭ�����һ�Σ�������baseҲҪ���ˣ����¿�ʼһ���飡����
//    //�����Ѿ��������ݲſ�ʼ��һ����
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
//      //�������Ŀ����¿�ʼ
//      pByteArrayBlock1 := @byteArrayBlocks[babi];
//      bi := 0;
//      byteCapacity := 4;//��ʼ����
//      ByteArray1 := pByteArrayBlock1.ba;
//      SetLength(ByteArray1, byteCapacity);
//    end;
//  end;
//  //����߼���������������ˣ�length�պþ���babi
//  SetLength(byteArrayBlocks, babi);
//  
//  showLogToMemo(Format(
//    'Low(memoryRegions)=%d,High(memoryRegions)=%d,count=%d',
//    [Low(memoryRegions),High(memoryRegions),Result]));
end;

//���سɹ���ȡ��������������byte��
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
//  byteCapacity := 4;//��ʼ����
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
//        //�����Ѿ��������ݲſ�ʼ��һ����
//        if not isNewByteArray then
//        begin
//          SetLength(ByteArray1, bi);
//          pByteArrayBlock1.count := bi;
//          pByteArrayBlock1.ba := ByteArray1;
//          isNewByteArray := True;
//          list.Add(pByteArrayBlock1);
//          //�������Ŀ����¿�ʼ
//          New(pByteArrayBlock1);
//          bi := 0;
//          byteCapacity := 4;//��ʼ����
//          ByteArray1 := pByteArrayBlock1.ba;
//          SetLength(ByteArray1, byteCapacity);
//        end;
//        Inc(t);
//      end;
//      Inc(j);
//    end;
//    //repeatѭ�����һ�Σ�������baseҲҪ���ˣ����¿�ʼһ���飡����
//    //�����Ѿ��������ݲſ�ʼ��һ����
//    if not isNewByteArray then
//    begin
//      SetLength(ByteArray1, bi);
//      pByteArrayBlock1.count := bi;
//      pByteArrayBlock1.ba := ByteArray1;
//      isNewByteArray := True;
//      list.Add(pByteArrayBlock1);
//      //�������Ŀ����¿�ʼ
//      New(pByteArrayBlock1);
//      bi := 0;
//      byteCapacity := 4;//��ʼ����
//      ByteArray1 := pByteArrayBlock1.ba;
//      SetLength(ByteArray1, byteCapacity);
//    end;
//  end;
//  
//  showLogToMemo(Format(
//    'Low(memoryRegions)=%d,High(memoryRegions)=%d,count=%d,t=%d',
//    [Low(memoryRegions),High(memoryRegions),Result,t]));
end;

//���سɹ���ȡ��������������byte��
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
    end;//�Ѿ���֤��MemorySize����1024�ı���
    //����ȡģ���Ҳ����
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

//��һ�ε�����̫���ˣ��˳�û�б仯��
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
          pii.value := PInteger(@ba[k])^;//Ҫ����ֵ������
          outList.Add(pii);
          Inc(Result);
        end;
      //����߽��3byte�����������֤���û��һ����ȡ�ɹ���
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
        Dispose(pii);//�ͷ�New������ڴ�
      end;
  end;

  showLogToMemo(Format(
    'list.Count=%d',
    [list.Count]));
end;

//flag:0-Ĭ�ϣ�1-ֵ�ĸı���value��Χ��,2-ֵ�ĸı䳬��value,3-ֵ���,4-ֵ��С
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
        Dispose(pii);//�ͷ�New������ڴ�
      end else begin
        case flag of
          0:
            begin
              pii.value := int;// ����ֵ
            end;
          1:
            begin
              change := int - pii.value;
              if (change > value) or (change < minusValue) then
              begin
                list.Delete(i);
                Dispose(pii);//�ͷ�New������ڴ�
              end else pii.value := int;// ����ֵ
            end;
          2:
            begin
              change := int - pii.value;
              if (change < value) and (change > minusValue) then
              begin
                list.Delete(i);
                Dispose(pii);//�ͷ�New������ڴ�
              end else pii.value := int;// ����ֵ
            end;
          3:
            begin
              if int <= pii.value then
              begin
                list.Delete(i);
                Dispose(pii);//�ͷ�New������ڴ�
              end else pii.value := int;// ����ֵ
            end;
          4:
            begin
              if int >= pii.value then
              begin
                list.Delete(i);
                Dispose(pii);//�ͷ�New������ڴ�
              end else pii.value := int;// ����ֵ
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
        pii.value := value;//pii�����ϴζ�ȡ��ֵ��Ҫ����
        outList.Add(pii);//��ֱ�����ã������ͷŵ�ʱ��ҪС��
        Inc(Result);
      end;
  end;

  showLogToMemo(Format(
    'Result=%d',
    [Result]));
end;

//�ѷ�������flag:1-���ֽڣ�2-����(2�ֽ�)��3-������(4�ֽ�)
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
  case flag of//�Ƿ��б�Ҫ��ô���ӣ�ֱ��ʹ��Integer��BufferӦ�ÿ��ԣ�����
    1: pBuffer := @b;
    2: pBuffer := @w;
    4: pBuffer := @int;
  end;
  //��������һ�����ѵ���bug��i��Cardinal���ͣ���High(memoryRegions)=-1������
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
        //���²���
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

//flag:1-���ֽڣ�2-����(2�ֽ�)��4-������(4�ֽ�),3-ֻҪ��ȶ�Ҫ
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
  //��������һ�����ѵ���bug��i��Cardinal���ͣ���High(memoryRegions)=-1������
  if High(memoryRegions) = -1 then Exit;
  for i := Low(memoryRegions) to High(memoryRegions) do
  begin
    j := memoryRegions[i].BaseAddress;
    //�Ѿ���֤memoryRegions[i].MemorySizeһ����1024�ı�����Ŀǰcb=1024
    j2 := j + memoryRegions[i].MemorySize;
    while j < j2 do
    begin
      if ReadProcessMemory(hProcess, Pointer(j), pBuffer,
        cb, numberOfBytesRead) then
      begin
        if flag in [1, 3] then
          for k := 0 to cb -1 do//����Byte��1�ֽڣ�
            if ba[k] = value then
            begin
              New(pii);
              pii.address := j + k;
              pii.value := value;//ֱ����value��ֵ����λ��Ȼ����Ҫ��ֵ��
              outList.Add(pii);
              Inc(Result);
            end;
        if flag in [2, 3] then
          for k := 0 to cb -1 - 1 do//����Word��2�ֽڣ�
            if PWord(@ba[k])^ {PWord(j3 + k)^} = value then
            begin
              New(pii);
              pii.address := j + k;
              pii.value := value;//ֱ����value��ֵ����λ��Ȼ����Ҫ��ֵ��
              outList.Add(pii);
              Inc(Result);
            end;
        if flag in [3, 4] then
          //����������4�ֽڣ�
          //����3λ����1��Integer����,����,�������������FilterOutNonChange
          //��֤
          for k := 0 to cb -1 - 3 do
            //��ע�͵�д���ȣ���һ�ָ����أ�����
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
