unit UnitClassInfoEx;

interface
uses
{$IFDEF VER230} // XE2
{$DEFINE HAS_UNITSCOPE}
{$ENDIF}
{$IFDEF VER240} // XE3
{$DEFINE HAS_UNITSCOPE}
{$ENDIF}
{$IFDEF VER250} // XE4
{$DEFINE HAS_UNITSCOPE}
{$ENDIF}
{$IFDEF HAS_UNITSCOPE}
  WinAPI.Windows, System.TypInfo;
{$ELSE}
  Windows, TypInfo;
{$ENDIF}

type
  PTypeInfos = array of PTypeInfo;
  TModules = array of HModule;
{$IFNDEF CPUX64}
  // Delphi 早期版本NativeInt计算起来会有内部错误
  NativeUInt = Cardinal;
  NativeInt = Integer;
{$ENDIF}
  // 获取一个指定模块中的类信息
function GetAllClassInfos_FromModule(AModule: HModule): PTypeInfos;
// 从system的Modulelist里面枚举模块,获取模块中类信息
function GetAllClassInfos_FromSystemModuleList(): PTypeInfos;
function GetProcessModules(): TModules;


implementation

const
  MinClassTypeInfoSize = SizeOf(TTypeKind) + 2 { name } + SizeOf(Tclass) +
    SizeOf(PPTypeInfo) + SizeOf(smallint) + 2 { unitname };

type
  TMemoryRegion = record
    BaseAddress: NativeInt;
    MemorySize: NativeInt;
  end;
  TMemoryRegions = array of TMemoryRegion;

function EnumProcessModules(hProcess: THandle; lphModule: PDWORD; cb: DWORD;
  var lpcbNeeded: DWORD): BOOL; stdcall; external 'psapi.dll';

function GetProcessModules(): TModules;
var
  cb: DWORD;
  ret: BOOL;
begin
  if EnumProcessModules(GetCurrentProcess, nil, 0, cb) then
  begin
    SetLength(Result, cb div SizeOf(HModule));
    if not EnumProcessModules(GetCurrentProcess, @Result[0], cb, cb) then
      Result := nil;
  end;
end;

function IsValidityMemoryBlock(MemoryRegions: TMemoryRegions;
  address, Size: NativeUInt): Boolean;
var
  MemoryRegion: TMemoryRegion;
  i: Integer;
  mbi: TMemoryBasicInformation;
begin
  {
    if VirtualQueryEx(GetCurrentProcess, Pointer(address), mbi, SizeOf(mbi)) <> 0
    then
    begin
    GetTickCount;
    end;
  }
  Result := False;
  //for MemoryRegion in MemoryRegions do
  for i := low(MemoryRegions) to High(MemoryRegions) do
  begin
    MemoryRegion := MemoryRegions[i];
    if (address >= MemoryRegion.BaseAddress) and
      ((address + Size) <= (MemoryRegion.BaseAddress + MemoryRegion.MemorySize))
    then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure GetExecutableMemoryregions(var MemoryRegions: TMemoryRegions);
var
  address: NativeUInt;
  mbi: memory_basic_information;
  processhandle: THandle;
  stop: NativeUInt;
begin
  processhandle := GetCurrentProcess;
  SetLength(MemoryRegions, 0);
  address := 0;
{$IFDEF CPUX64}
  stop := $7FFFFFFFFFFFFFFF
{$ELSE}
  stop := $7FFFFFFF;
{$ENDIF}
  while (address < stop) and (VirtualQueryEx(processhandle, Pointer(address),
    mbi, SizeOf(mbi)) <> 0) and ((address + mbi.RegionSize) > address) do
  begin
    if (mbi.state = MEM_COMMIT) and
      (((mbi.Protect and PAGE_EXECUTE_READ) = PAGE_EXECUTE_READ) or
      ((mbi.Protect and PAGE_READWRITE) = PAGE_READWRITE) or
      ((mbi.Protect and PAGE_EXECUTE_READWRITE) = PAGE_EXECUTE_READWRITE)) then
    begin
      // executable
      SetLength(MemoryRegions, Length(MemoryRegions) + 1);
      MemoryRegions[Length(MemoryRegions) - 1].BaseAddress :=
        NativeUInt(mbi.BaseAddress);
      MemoryRegions[Length(MemoryRegions) - 1].MemorySize := mbi.RegionSize;
    end;
    inc(address, mbi.RegionSize);
  end;
end;

procedure GetExecutableMemoryRegionsInRang(address, stop: NativeUInt;
  var MemoryRegions: TMemoryRegions);
var
  mbi: memory_basic_information;
  processhandle: THandle;
begin
  processhandle := GetCurrentProcess;
  SetLength(MemoryRegions, 0);
  while (address < stop) and (VirtualQueryEx(processhandle, Pointer(address),
    mbi, SizeOf(mbi)) <> 0) and ((address + mbi.RegionSize) > address) do
  begin
    if (mbi.state = MEM_COMMIT) and
      (((mbi.Protect and PAGE_EXECUTE_READ) = PAGE_EXECUTE_READ) or
      ((mbi.Protect and PAGE_READWRITE) = PAGE_READWRITE) or
      ((mbi.Protect and PAGE_EXECUTE_READWRITE) = PAGE_EXECUTE_READWRITE)) then
    begin
      // executable
      SetLength(MemoryRegions, Length(MemoryRegions) + 1);
      MemoryRegions[Length(MemoryRegions) - 1].BaseAddress :=
        NativeUInt(mbi.BaseAddress);
      MemoryRegions[Length(MemoryRegions) - 1].MemorySize := mbi.RegionSize;
    end;
    inc(address, mbi.RegionSize);
  end;
end;

function IsValidityClassInfo(ProcessMemoryRegions: TMemoryRegions; p: PAnsiChar;
  var RealResult: PTypeInfos): Boolean; forward;

function IsValidityString(p: PAnsiChar; Length: Byte): Boolean;
var
  i: Integer;
begin
  {
    我假定Delphi的ClassName都是英文.中文的话实际上会被UTF8编码.
    另外这个也不包含编译器编译时产生临时类的类名.
    临时类名为了不和程序员手写的类重名一般都有@#$之类的
  }
  Result := True;
  if p^ in ['a' .. 'z', 'A' .. 'Z', '_'] then
  begin
    for i := 0 to Length - 1 do
    begin { 类名有时会有. ,比如内嵌类,UnitName也会有.泛型类名会有<> }
      if not(p[i] in ['a' .. 'z', '<', '>', 'A' .. 'Z', '_', '.', '0' .. '9'])
      then
      begin
        Result := False;
        Exit;
      end;
    end;
  end
  else
    Result := False;
end;

function FindTypeInfo(const RealResult: PTypeInfos; p: Pointer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Low(RealResult) to High(RealResult) do
    if RealResult[i] = p then
    begin
      Result := True;
      Break;
    end;
end;

procedure AddTypeInfo(var RealResult: PTypeInfos; p: PTypeInfo);
begin
  //if FindTypeInfo(RealResult, p) then
  if p^.Name = 'TForm1.TTT' then
  begin
    GetTickCount;
    //Exit;
  end;
  SetLength(RealResult, Length(RealResult) + 1);
  RealResult[Length(RealResult) - 1] := p;
end;

function IsValidityClassData(ProcessMemoryRegions: TMemoryRegions; p: PAnsiChar;
  var RealResult: PTypeInfos): Boolean;
var
  td: PTypeData;
  parentInfo: PPTypeInfo;
  parentFinded : Boolean;
begin
  Result := False;
  td := PTypeData(p);
  parentInfo := td.parentInfo;
  if not IsValidityString(@td.UnitName[1], Byte(td.UnitName[0])) then
    Exit;
  if GetTypeData(TypeInfo(TObject)) = td then
  begin
    Result := True;
    Exit;
  end;
  if not IsValidityMemoryBlock(ProcessMemoryRegions, NativeUInt(parentInfo),
    SizeOf(Pointer)) then
    Exit;
  if not IsValidityMemoryBlock(ProcessMemoryRegions, NativeUInt(parentInfo^),
    MinClassTypeInfoSize) then
    Exit;
  { 遍历ParentInfo,直到找到TObject为止 }
  parentFinded := FindTypeInfo(RealResult, parentInfo^);
  if parentFinded
    or IsValidityClassInfo(ProcessMemoryRegions, PAnsiChar(parentInfo^),
    RealResult) then
  begin
    Result := True;
    if not parentFinded then
      AddTypeInfo(RealResult, ParentInfo^);
    Exit;
  end;
end;

function IsValidityClassInfo(ProcessMemoryRegions: TMemoryRegions; p: PAnsiChar;
  var RealResult: PTypeInfos): Boolean;
var
  classNamelen: Byte;
  classname: ansistring;
begin
  Result := False;
  if not IsValidityMemoryBlock(ProcessMemoryRegions, NativeUInt(p),
    MinClassTypeInfoSize) then
    Exit;
  if IsBadReadPtr(p, MinClassTypeInfoSize) then
    Exit;
  if ord(p^) = ord(tkClass) then // ord(tkClass) = 7
  begin
    inc(p);
    classNamelen := ord(p^);
    SetLength(classname, classNamelen);
    Move((p + 1)^, PAnsiChar(classname)^, classNamelen);
    if (classNamelen in [1 .. $FE]) then { Shortstring第一个字节是长度,最多254个 }
    begin
      inc(p);
      if IsValidityString(PAnsiChar(p), classNamelen) then
      begin
        // OutputDebugStringA(PAnsiChar(classname));
        inc(p, classNamelen);
        if IsValidityClassData(ProcessMemoryRegions, p, RealResult) then
        begin
          Result := True;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure GetRegionClassInfos(ProcessMemoryRegions: TMemoryRegions;
  const MemoryRegion: TMemoryRegion; var RealResult: PTypeInfos);
var
  p: PAnsiChar;
  MaxAddr: NativeInt;
begin
  p := PAnsiChar(MemoryRegion.BaseAddress);
  MaxAddr := MemoryRegion.BaseAddress + MemoryRegion.MemorySize -
    MinClassTypeInfoSize;
  while NativeInt(p) < MaxAddr do
  begin
    if IsValidityClassInfo(ProcessMemoryRegions, p, RealResult) then
    begin
      AddTypeInfo(RealResult, PTypeInfo(p));
      // OutputDebugStringA(PAnsiChar('classname = ' + PTypeInfo(p).Name));
      inc(p, MinClassTypeInfoSize);
    end
    else
      inc(p);
  end;
end;

function _GetAllClassInfos_FromModule(ProcessMemoryRegions: TMemoryRegions;
  AModule: HModule): PTypeInfos;
var
  MemoryRegions: TMemoryRegions;
  i: Integer;
  addr, stop: NativeUInt;
  dos: PImageDosHeader;
  nt: PImageNtHeaders;
begin
  Result := nil;
  // SetLength(Result, 1);
  // Result[0] := TypeInfo(TObject);
  //
  MemoryRegions := nil;
  addr := AModule;
  dos := PImageDosHeader(addr);
  nt := PImageNtHeaders(addr + dos^._lfanew);
  GetExecutableMemoryRegionsInRang(addr, addr + nt.OptionalHeader.SizeOfImage,
    MemoryRegions);
  for i := Low(MemoryRegions) to High(MemoryRegions) do
  begin
    GetRegionClassInfos(ProcessMemoryRegions, MemoryRegions[i], Result);
    // OutputDebugString(PChar(format('(%d;%d)',[MemoryRegions[i].BaseAddress,MemoryRegions[i].MemorySize])));
  end;
end;

function GetAllClassInfos_FromModule(AModule: HModule): PTypeInfos;
var
  ProcessMemoryRegions: TMemoryRegions;
begin
  GetExecutableMemoryregions(ProcessMemoryRegions);
  Result := _GetAllClassInfos_FromModule(ProcessMemoryRegions, AModule);
end;

function GetAllClassInfos_FromSystemModuleList(): PTypeInfos;
var
  ProcessMemoryRegions: TMemoryRegions;
  lm: PLibModule;
  moduleTypeInfos: PTypeInfos;
  i: Integer;
  oldLen: Integer;
  s: string;
begin
  Result := nil;
  //SetLength(Result, 1);
  //Result[0] := TypeInfo(TObject);
  //
  lm := LibModuleList;
  GetExecutableMemoryregions(ProcessMemoryRegions);
  while True do
  begin
    SetLength(s, MAX_PATH);
    GetModuleFileName(lm.Instance, PChar(s), Length(s));
    OutputDebugString(PChar(s));
    moduleTypeInfos := _GetAllClassInfos_FromModule(ProcessMemoryRegions,
      lm.Instance);
    oldLen := Length(Result);
    SetLength(Result, oldLen + Length(moduleTypeInfos));
    for i := Low(moduleTypeInfos) to High(moduleTypeInfos) do
      Result[oldLen + i] := moduleTypeInfos[i];
    if lm.Next = nil then
      Break;
    lm := lm.Next;
  end;
end;

end.
