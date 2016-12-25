unit Utils;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, ImgList{, ccuDataStringGrid,
  UniCodeClasses};

const
  TMyBooleanStringArray: array [Boolean] of String = ('FALSE', 'TRUE');

type
  PSearchRec = ^TSearchRec;

procedure SetStdDirectory(var Dir: String);
function  GetStdDirectory(const Dir: String): String;
procedure FindFiles(APath, AFilter: String; var AList: TList);
//AFilter为'*.xxx'格式;
procedure FindFileNames(APath, AFilter: String; var AList: TStrings);
//得到字符串中的下一部分
function GetNextPart(var str: String; Sep1: char = char(9);
  Sep2: char = ','; Position: integer = 1): String;
//把字符串按某个字符串分隔
procedure DivStrToList(SrcStr, divStr: String; StrList: TStrings;
  bAllowEmpty: Boolean = False);
procedure SetParentPath(var APath: String);
function MyBoolToStr(const ABoolean: Boolean): String;
//根据文件名读取文件最后修改时间
function GetFileTime(const AFile: string): string;

//ProE文件的修订版后缀形如".prt.1"、".prt.2",本方法查找最新修订版
function FindLastFileRevision(APath, AFilter: String; AName: String): string;

implementation

function GetFileTime(const AFile: string): string;
  function CovFileDate(FT: _FILETIME): TDateTime;
  var
    STTmp: _SYSTEMTIME;
    FTTmp: _FILETIME;
  begin
    FileTimeToLocalFileTime(FT, FTTmp);
    FileTimeToSystemTime(FTTmp, STTmp);
    CovFileDate := SystemTimeToDateTime(STTmp);
  end;
const
  Model = 'yyyy-mm-dd hh:mm:ss';
var
  SearchRec: TSearchRec;
begin
  FindFirst(AFile, faAnyFile, SearchRec);
  Result := FormatDateTime(Model,
    CovFileDate(SearchRec.FindData.ftLastWriteTime));
//    CovFileDate(SearchRec.FindData.ftCreationTime));
//    CovFileDate(SearchRec.FindData.ftLastAccessTime));
end;

function MyBoolToStr(const ABoolean: Boolean): String;
begin
  Result := TMyBooleanStringArray[ABoolean];
end;

procedure SetStdDirectory(var Dir: String);
begin
  if Dir[Length(Dir)] <> '\' then
    Dir := Dir + '\'
end;

function GetStdDirectory(const Dir: String): String;
begin
  if Dir[Length(Dir)] <> '\' then
    Result := Dir + '\'
  else
    Result := Dir;
end;

procedure FindFiles(APath, AFilter: String; var AList: TList);
var
  FSearchRec, DsearchRec: TSearchRec;
  Item: PSearchRec;
  FindResult: Integer;
  i: Integer;
  function IsDirNotation(ADirName: string): Boolean;
  begin
    Result := (ADirName = '.') or (ADirName = '..');
  end;
begin
  SetStdDirectory(APath);
  FindResult := FindFirst(APath + AFilter, faAnyFile + faHidden + faSysFile +
                          faReadOnly, FSearchRec);
  try
    while FindResult = 0 do
    begin
      Item := @FSearchRec;
      AList.Add(Item);
      Item := nil;

      FindResult := FindNext(FSearchRec);
    end;

    FindResult := FindFirst(APath + '*.*', faDirectory, DSearchRec);
    while FindResult = 0 do
    begin
      if ((DSearchRec.Attr and faDirectory) = faDirectory) and not
         IsDirNotation(DsearchRec.Name) then
         FindFiles(APath + DSearchRec.Name, '*.*', AList);
      FindResult := FindNext(DsearchRec);
    end;
  finally
      FindClose(FSearchRec);
  end;
end;

procedure FindFileNames(APath, AFilter: String; var AList: TStrings);
var
  FSearchRec, DsearchRec: TSearchRec;
  Item: PSearchRec;
  FindResult: Integer;
  i: Integer;
  function IsDirNotation(ADirName: string): Boolean;
  begin
    Result := (ADirName = '.') or (ADirName = '..');
  end;
begin
  SetStdDirectory(APath);
  FindResult := FindFirst(APath + AFilter, faAnyFile + faHidden + faSysFile +
                          faReadOnly, FSearchRec);
  try
    while FindResult = 0 do
    begin
      AList.Add(APath + FSearchRec.Name);

      FindResult := FindNext(FSearchRec);
    end;

    FindResult := FindFirst(APath + '*.*', faDirectory, DSearchRec);
    while FindResult = 0 do
    begin
      if ((DSearchRec.Attr and faDirectory) = faDirectory) and not
        IsDirNotation(DsearchRec.Name) then
        FindFileNames(APath + DSearchRec.Name, '*.*', AList);
      FindResult := FindNext(DsearchRec);
    end;
  finally
    FindClose(FSearchRec);
    FindClose(DsearchRec);
  end;
end;

//得到字符串中的下一部分
function GetNextPart(var str: String; Sep1: char = char(9);
  Sep2: char = ','; Position: integer = 1): String;
var
  intPos: integer;
begin
  intPos := pos(Sep1, str);
  if (intPos = 0) and (Sep2 <> '') then
    intPos := pos(Sep2, str);
  if intPos > 0 then
  begin
    result := Copy(str, 1, intPos - 1);
    Delete(str, 1, intPos);
  end
  else
  begin
    result := str;
    str := '';
  end;
  if (intPos > 0) and (Position > 1) then
    result := GetNextPart(str, Sep1, Sep2, Position - 1);
end;

//把字符串按某个字符串分隔
procedure DivStrToList(SrcStr, divStr: String; StrList: TStrings;
  bAllowEmpty: Boolean = False);
var
  strTmp: String;
  iPos, iIndex: Integer;
begin
  if Trim(SrcStr) = '' then Exit;
  if copy(srcStr, length(srcStr) - length(divStr) + 1, length(divStr)) <> divStr then
    {if srcStr[length(srcStr)] <> divStr}
    srcStr := srcStr + divStr;
  StrList.Clear;
  iPos := pos(divStr, SrcStr);
  while iPos <> 0 do
  begin
    strTmp := Copy(Srcstr, 1, iPos - 1);
    iIndex := Length(StrTmp);

    //得出字符串和有效宽度
    if (strTmp = '') and (not bAllowEmpty) then
    else
      StrList.Add(strTmp);

    delete(SrcStr, 1, iIndex + length(divStr));
    iPos := pos(divStr, SrcStr);
  end;
end;

procedure SetParentPath(var APath: String);
var
  i: Integer;
begin
  if APath[Length(APath)] = '\' then
    Delete(APath, Length(APath), 1);
  for i := Length(APath) downto 1 do
    if APath[i] = '\' then
    begin
      Delete(APath, i + 1, Length(APath) - 1);
      Exit;
    end;
end;

//ProE文件的修订版后缀形如".prt.1"、".prt.2",本方法查找最新修订版
function FindLastFileRevision(APath, AFilter: String; AName: String): string;
var
  FSearchRec: TSearchRec;
  NameTmp, strTmp, upTmp: string;
  FindResult: Integer;
  Len, LenTmp, Rev, Max: Integer;

  procedure SetStdDirectory(var Dir: String);
  begin
    if Dir[Length(Dir)] <> '\' then
      Dir := Dir + '\'
  end;
begin
  Result := AName;
  Max := 0;
  Len := Length(AName);
  NameTmp := UpperCase(AName);
  SetStdDirectory(APath);
  FindResult := FindFirst(APath + AFilter, faAnyFile + faHidden + faSysFile +
                          faReadOnly, FSearchRec);
  try
    while FindResult = 0 do
    begin
      strTmp := FSearchRec.Name;
      LenTmp := Length(strTmp);
      if LenTmp > Len then
      begin
        upTmp := UpperCase(strTmp);
        Rev := pos(NameTmp, upTmp);//Rev只是临时使用
        if (Rev = 1)then
        begin
          Rev := StrToIntDef(System.Copy(upTmp, Len + 2, LenTmp), 0);
          if Rev > Max then
          begin
            Max := Rev;
            Result := strTmp;
          end;
        end;
      end;
      FindResult := FindNext(FSearchRec);
    end;
  finally
    FindClose(FSearchRec);
  end;
end;

end.
 