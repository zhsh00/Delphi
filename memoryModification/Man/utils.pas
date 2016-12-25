unit utils;

interface
uses
    Windows, TypInfo, Variables, SysUtils, Classes;

type
  //�Զ����SysUtil��Ķ����ͻ�ˣ�����
  TByteArray = Variables.TByteArray;



function CountMemoryRegionsAllMemory(MemoryRegions: TMemoryRegions): Integer;

procedure AverageMemoryRegionsToArray(var MemoryRegions: TMemoryRegions;
  var resultArray: TMemoryRegionsArray{TResultArray});
procedure AverageMemoryRegionsToArray2(var MemoryRegions: TMemoryRegions;
  var resultArray: TMemoryRegionsArray);
//��ListArray��8��TList���͵�Ԫ��ƽ��һ��
procedure AverageListArray(data: TResultArray);

function CountResultArray(resultArray: TResultArray):Cardinal;
function CountByteArrayBlocksMemory(resultArray: TResultArray):Cardinal;
function CountFirst(resultArray: TResultArray):Cardinal;
function CountListArray(resultArray: TResultArray):Cardinal;
function JoinListArrayFast(data: TResultArray): TList;

procedure InitMemoLog;
procedure CloseMemoLog;
procedure ClearMemoLog;
procedure ShowLogToMemo(s: string);
implementation
uses
  ReadMemoryFrm;


function CountMemoryRegionsAllMemory(MemoryRegions: TMemoryRegions): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := Low(memoryRegions) to High(memoryRegions) do
    Inc(Result, MemoryRegions[i].MemorySize);
end;

procedure SortMemoryRegions(var MemoryRegions: TMemoryRegions);
var
  i, j, k, high1: Integer;
  max: Cardinal;
begin
  high1 := High(MemoryRegions);
  for i := Low(MemoryRegions) to high1 do
  begin
    max := MemoryRegions[i].MemorySize;
    for j := i + 1 to high1 do
      if max < MemoryRegions[j].MemorySize then
      begin
        max := MemoryRegions[j].MemorySize;
        k := j;
      end;
    if i <> k then
    begin
      MemoryRegions[k].MemorySize := MemoryRegions[i].MemorySize;
      MemoryRegions[i].MemorySize := max;
      max := MemoryRegions[k].BaseAddress;
      MemoryRegions[k].BaseAddress := MemoryRegions[i].BaseAddress;
      MemoryRegions[i].BaseAddress := max;
    end;
  end;
end;

procedure AverageMemoryRegionsToArray(var MemoryRegions: TMemoryRegions;
  var resultArray: TMemoryRegionsArray);
var
  i, j, k, m, jHead, jBackwardHead, len, jBackward: Integer;
  count: Cardinal;
  avr, c1, c2: Integer;
  mr: TMemoryRegions;
  counts: array[0..threadCount - 1] of Integer;
begin
  count := CountMemoryRegionsAllMemory(MemoryRegions);
  //showLogToMemo(Format('count1=%d',[count]));
  avr := count div threadCount + 1 ;// +1Ԥ������
  SortMemoryRegions(MemoryRegions);
  //count := CountMemoryRegionsAllMemory(MemoryRegions);
  //showLogToMemo(Format('count2=%d',[count]));
  j := Low(MemoryRegions);
  jBackward := High(MemoryRegions);
  jHead := j;
  jBackwardHead := jBackward;
  for i := 0 to threadCount - 2 do//��2�����ʣ�µĲ�����ô�鷳�ˣ�������bug
  begin
    count := 0;
    c1 := 0;
    //while count < avr do//������ֻ��Ҫ����������ˣ�j < jBackward�����ܷ���
    while (count < avr) and (j < jBackward) do
    begin
      Inc(count, MemoryRegions[j].MemorySize);
      Inc(j);
      Inc(c1);
    end;
    if c1 > 1 then//��һ��ʹ���avrʱ������
    begin
      Dec(j);//��1
      Dec(count, MemoryRegions[j].MemorySize);
    end;
    c2 := 0;
    while (count < avr) and (j < jBackward) do
    begin
      Inc(count, MemoryRegions[jBackward].MemorySize);
      Dec(jBackward);
      Inc(c2);
    end;
    //Dec(j);//�ټ�1����Ϊ���һ�μ��ϵ��Ѿ�����ȥ��
    //Inc(jBackward);//��1����Ϊ��
    //�������Ҫ����˼��
    len := (j - jHead) + (jBackwardHead - jBackward);
    mr := nil;
    SetLength(mr, len);
    m := 0;
    for k := jHead to j - 1 do//j������δ����
    begin
      mr[m].BaseAddress := MemoryRegions[k].BaseAddress;
      mr[m].MemorySize := MemoryRegions[k].MemorySize;
      Inc(m);
    end;
    for k := jBackward + 1 to jBackwardHead do//jBackward������δ����
    begin
      mr[m].BaseAddress := MemoryRegions[k].BaseAddress;
      mr[m].MemorySize := MemoryRegions[k].MemorySize;
      Inc(m);
    end;
    resultArray[i] := mr;
    jHead := j;
    jBackwardHead := jBackward;
//showLogToMemo(Format('jHead=%d,j=%d,jbackward=%d,jbackwarHead=%d',[jHead,j,jbackward,jbackwardHead]));
  end;

  len := jBackward - j + 1;
  mr := nil;
  SetLength(mr, len);
  m := 0;
  for k := j to jBackward do//j������δ����
  begin
    mr[m].BaseAddress := MemoryRegions[k].BaseAddress;
    mr[m].MemorySize := MemoryRegions[k].MemorySize;
    Inc(m);
  end;
  resultArray[threadCount - 1] := mr;
end;

procedure AverageMemoryRegionsToArray2(var MemoryRegions: TMemoryRegions;
  var resultArray: TMemoryRegionsArray{TResultArray});
var
  i, count, j, k, m, last, this, len: Cardinal;
  avr: Integer;
  //mra: TMemoryRegionsArray;
  //pms: PMemoryRegions;
  tms: TMemoryRegions;
  counts: array[0..threadCount - 1] of Integer;
begin
  count := CountMemoryRegionsAllMemory(MemoryRegions);
  avr := count div threadCount + 1 ;// +1Ԥ������

  count := 0;
  this := High(MemoryRegions);
  last := this;
  j := Low(MemoryRegions);//��������һ��
  for i := threadCount - 1 downto 1 do
  begin
    repeat
      Inc(count, MemoryRegions[this].MemorySize);
      Dec(this);
    until (count > avr) or (this = j);
    //�ڴ������������˵̫���ˣ����Ҫ�����ⲿ����ĸ��˺ö�ö��
    tms := resultArray[i];
    len := last - this;
    SetLength(tms, len);
    len := SizeOf(TMemoryRegion) * len;
    //GetMem(resultArray[i], len);//setLength������GetMem���ٴη�����
    CopyMemory(tms, @MemoryRegions[this + 1], len);
    resultArray[i] := tms;//setLength���ܸı�tms��ֵ(��ַ)
    last := this;
    count := 0;
    if this = 0 then Break;//��֪Ϊʲô�ᷢ���������
  end;
  SetLength(MemoryRegions, this + 1);
  resultArray[0] := MemoryRegions;
end;

//��ListArray��8��TList���͵�Ԫ��ƽ��һ��
procedure AverageListArray(data: TResultArray);
var
  i, count, j, k, m: Cardinal;
  avr: Integer;
  list1, list2: TList;
begin
  count := 0;
  for i := 0 to threadCount - 1 do
    if data[i] <> nil then
      Inc(count, TList(data[i]).Count);

  avr := count div threadCount + 1 ;// +1Ԥ������
  ShowLogToMemo(Format('count%d,avr=%d', [count, avr]));
  for i := 0 to threadCount - 1 do
  begin
    if TList(data[i]) <> nil then
      if TList(data[i]).Count > avr then
      begin
        list1 := TList(data[i]);
        for j := 0 to threadCount - 1 do
        begin
          if data[j] <> nil then
            if TList(data[j]).Count < avr then
            begin
              list2 := TList(data[j]);
              //����Ӧ��ת�Ƶ������������ּӶ���
              m := avr - list2.Count;//laa[j]��ƽ�����ٵ�����������laa[i]��ƽ�����������
              if ((list1.Count - avr) <= m )then
                for k := list1.Count - 1 downto avr do
                begin
                  list2.Add((list1[k]));
                  list1.Delete(k);
                end
              else//laa[j]��ƽ�����ٵ�����������laa[i]��ƽ�����������
                for k := list1.Count - 1 downto list1.Count - 1 - m do
                begin
                  list2.Add((list1[k]));
                  list1.Delete(k);
                end;
            end;
        end;
      end;
  end;
end;

function CountResultArray(resultArray: TResultArray):Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i:= 0 to threadCount - 1 do
    inc(Result, Cardinal(resultArray[i]));
end;

function CountListArray(resultArray: TResultArray):Cardinal;
var
  i: Integer;
begin
  Result := 0;
  for i:= 0 to threadCount - 1 do
    if resultArray[i] <> nil then
      inc(Result, TList(resultArray[i]).Count);
end;

function CountByteArrayBlocksMemory(resultArray: TResultArray):Cardinal;
var
  i, j: Integer;
  babs: TByteArrayBlocks;
begin
  Result := 0;
  for i:= 0 to threadCount - 1 do
  begin
    babs := TByteArrayBlocks(resultArray[i]);
    if babs <> nil then
      for j := Low(babs) to High(babs) do
      try
        inc(Result, babs[j].count);
      except
        ShowLogToMemo(Format(
          'i=%d,j=%d,Low()=%d,High()=%d'
          , [i,j, Low(babs),High(babs)]));
      end;
  end;
end;

function CountFirst(resultArray: TResultArray):Cardinal;
var
  i, j: Integer;
begin
  Result := 0;
  for i:= 0 to threadCount - 1 do
    if(resultArray[i] <> nil) then
      for j := 0 to Tlist(resultArray[i]).Count - 1 do
      inc(Result, PByteArrayBlock(Tlist(resultArray[i])).count);
end;

function JoinListArrayFast(data: TResultArray): TList;
var
  i, j: integer;
  list: TList;
begin
  Result := TList.Create;
  for i := 0 to threadCount - 1 do
    if data[i] <> nil then
    begin
      list := TList(data[i]);
      for j := list.Count - 1 downto 0 do
      begin
        Result.Add(list[j]);
        list.Delete(j);
      end;
      FreeAndNil(list);
    end;
end;

procedure InitMemoLog;
begin
  mmLog := ReadMemoryForm.mmLog;
end;
procedure CloseMemoLog;
begin
  mmLog := nil;
end;
procedure showLogToMemo(s: string);
begin
  mmlog.Lines.Add(s);
end;
procedure ClearMemoLog;
begin
  mmLog.Lines.Clear;
end;

end.
