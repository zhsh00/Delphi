unit ccuUtils;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ccuGrids, ccuDataStringGrid, StdCtrls, unicodeclasses;

type
  PSearchRec = ^TSearchRec;

procedure SetStdDirectoryW(var Dir: WideString);
function  GetStdDirectoryW(const Dir: WideString): WideString;
function MyDgGetFirstEmptyRow(var dg: TccuDataStringGrid): Integer;
procedure FindFilesW(APath, AFilter: WideString; var AList: TList);
procedure FindFileNamesW(APath, AFilter: WideString; var AList: TUniStrings);
//得到字符串中的下一部分
function GetNextPart(var str: String; Sep1: char = char(9);
  Sep2: char = ','; Position: integer = 1): String;

implementation

procedure SetStdDirectoryW(var Dir: WideString);
begin
  if Dir[Length(Dir)] <> '\' then
    Dir := Dir + '\'
end;

function GetStdDirectoryW(const Dir: WideString): WideString;
begin
  if Dir[Length(Dir)] <> '\' then
    Result := Dir + '\'
  else
    Result := Dir;
end;

function MyDgGetFirstEmptyRow(var dg: TccuDataStringGrid): Integer;
var
  IntTmp: Integer;
begin
  IntTmp := dg.GetFirstEmptyRow;
  if IntTmp = -1 then
  begin
    dg.RowCount := dg.RowCount + 1;
    dg.Row := dg.RowCount - 1;
  end else dg.Row := IntTmp;
end;

procedure FindFilesW(APath, AFilter: WideString; var AList: TList);
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
  SetStdDirectoryW(APath);
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
         FindFilesW(APath + DSearchRec.Name, '*.*', AList);
      FindResult := FindNext(DsearchRec);
    end;
  finally
      FindClose(FSearchRec);
  end;
end;

procedure FindFileNamesW(APath, AFilter: WideString; var AList: TUniStrings);
var
  FSearchRec, DsearchRec: TSearchRec;
  Item: PSearchRec;
  FindResult: Integer;
  i: Integer;
  function IsDirNotation(ADirName: WideString): Boolean;
  begin
    Result := (ADirName = '.') or (ADirName = '..');
  end;
begin
  SetStdDirectoryW(APath);
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
        FindFileNamesW(APath + DSearchRec.Name, '*.*', AList);
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

end.
 