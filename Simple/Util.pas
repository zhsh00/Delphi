unit Util;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ChildFrm, ComCtrls, StdCtrls, ExtCtrls, ImgList;

function GetStdDirectory(Dir: string): string;
procedure SetStdDirectory(var Dir: string);

procedure FindFiles(APath, AFileName: string; LV: TListView);

function AddAListItem({intImgIndex: integer;}
  Values: array of string; SubImgIndexs: array of integer;
  {intStaIndex: integer; }LV: TListView; Data: Pointer = nil;
  InsertIndex: integer = -1): TListItem;
implementation

function GetStdDirectory(Dir: string): string;
begin
  if Dir[Length(Dir)] <> '\' then
    Result := Dir + '\'
  else
    Result := Dir;
end;

procedure SetStdDirectory(var Dir: string);
begin
  if Dir[Length(Dir)] <> '\' then
    Dir := Dir + '\'
end;

procedure FindFiles(APath, AFileName: string; LV: TListView);
var
  FSearchRec, DsearchRec: TSearchRec;
  FindResult: Integer;
  i: Integer;
  ch: Char;
  wn: WideString;
  wh: WideChar;
  function IsDirNotation(ADirName: string): Boolean;
  begin
    Result := (ADirName = '.') or (ADirName = '..');
  end;
begin
  APath := GetStdDirectory(APath);
  FindResult := FindFirst(APath + AFileName, faAnyFile + faHidden + faSysFile +
                          faReadOnly, FSearchRec);
  try
    while FindResult = 0 do
    begin
      //lvDetail.Columns[0].Caption := LowerCase(APath + FSearchRec.Name);
      AddAListItem([LowerCase(APath + FSearchRec.Name)],[],LV);
{      wn := widestring(FSearchRec.Name);
      showmessage(inttostr(Length(FSearchRec.Name))+#13#10+inttostr(length(wn)));
      for i:=1 to Length(FSearchRec.Name) do
      begin
        ch := FSearchRec.Name[i];
        wh := WideChar(wn[i]);
        showmessage(FSearchRec.Name[i]+#13#10+inttostr(ord(FSearchRec.Name[i]))
          +#13#10+ch+#13#10+wh);
      end;}
      FindResult := FindNext(FSearchRec);
    end;

    FindResult := FindFirst(APath + '*.*', faDirectory, DSearchRec);
    while FindResult = 0 do
    begin
      if ((DSearchRec.Attr and faDirectory) = faDirectory) and not
         IsDirNotation(DsearchRec.Name) then
         FindFiles(APath + DSearchRec.Name, '*.*', LV);
      FindResult := FindNext(DsearchRec);
    end;
    finally
      FindClose(FSearchRec);
    end;
end;

function AddAListItem({intImgIndex: integer;}
  Values: array of string; SubImgIndexs: array of integer;
  {intStaIndex: integer; }LV: TListView; Data: Pointer = nil;
  InsertIndex: integer = -1): TListItem;
var
  i: integer;
  bHasSubImg: Boolean;
begin

  if High(SubImgIndexs) = -1 then
    bHasSubImg := False
  else
    bHasSubImg := True;

  if InsertIndex = -1 then
    result := TListItem(LV.items.Add)
  else
    result := TListItem(LV.items.Insert(InsertIndex));
  with result do
  begin
    Caption := Values[Low(Values)];
    //ImageIndex := intImgIndex;
    //StateIndex := intStaIndex;
    for i := Low(Values) + 1 to High(Values) do
    begin
      SubItems.Add(Values[i]);
      if bHasSubImg then
        SubItemImages[i - 1] := SubImgIndexs[i - 1];
    end;
  end;
  Result.Data := Data;
end;

end.
 