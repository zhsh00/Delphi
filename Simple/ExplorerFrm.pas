unit ExplorerFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ChildFrm, StdCtrls, FileCtrl, ComCtrls, ExtCtrls, ImgList;

type
  TExplorerForm = class(TChildForm)
    pnlLeft: TPanel;
    pnlRight: TPanel;
    spl1: TSplitter;
    pnlTop: TPanel;
    lvDetail: TListView;
    drvcbb1: TDriveComboBox;
    procedure drvcbb1Change(Sender: TObject);
  private
    { Private declarations }
    drvChar: Char;  // 存储当前选择的卷
    FFileName: string;
    // 得到标准目录，即若字符串末尾不是'\'，则在末尾加'\'
    function GetStdDirectory(Dir: string): string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AParent: TWinControl); override;

    procedure FindFiles(APath, AFileName: string);
    procedure RefreshListTitle(Titles: array of string;
      Widths: array of integer; LV: TListView; IsClearItems: Boolean = True;
      LastAutoSize: Boolean = True);

    function AddAListItem({intImgIndex: integer;}
      Values: array of string; SubImgIndexs: array of integer;
      {intStaIndex: integer; }LV: TListView; Data: Pointer = nil;
      InsertIndex: integer = -1): TListItem;
  end;

var
  ExplorerForm: TExplorerForm;

implementation

{$R *.dfm}

procedure TExplorerForm.drvcbb1Change(Sender: TObject);
begin
  //inherited;
  drvChar := drvcbb1.Drive;
  FFileName := '*.xls';
  RefreshListTitle(['试一试'], [100], lvDetail);
  FindFiles({drvChar + }'D:\AA\', FFileName);
end;

function TExplorerForm.GetStdDirectory(Dir: string): string;
begin
  if Dir[Length(Dir)] <> '\' then
    Result := Dir + '\'
  else
    Result := Dir;
end;

procedure TExplorerForm.FindFiles(APath, AFileName: string);
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
      AddAListItem([LowerCase(APath + FSearchRec.Name)],[],lvDetail);
      wn := widestring(FSearchRec.Name);
      showmessage(inttostr(Length(FSearchRec.Name))+#13#10+inttostr(length(wn)));
      for i:=1 to Length(FSearchRec.Name) do
      begin
        ch := FSearchRec.Name[i];
        wh := WideChar(wn[i]);
        showmessage(FSearchRec.Name[i]+#13#10+inttostr(ord(FSearchRec.Name[i]))
          +#13#10+ch+#13#10+wh);
      end;
      FindResult := FindNext(FSearchRec);
    end;

    FindResult := FindFirst(APath + '*.*', faDirectory, DSearchRec);
    while FindResult = 0 do
    begin
      if ((DSearchRec.Attr and faDirectory) = faDirectory) and not
         IsDirNotation(DsearchRec.Name) then
         FindFiles(APath + DSearchRec.Name, FFileName);
      FindResult := FindNext(DsearchRec);
    end;
    finally
      FindClose(FSearchRec);
    end;
end;

procedure TExplorerForm.RefreshListTitle(Titles: array of string;
  Widths: array of integer; LV: TListView; IsClearItems: Boolean;
  LastAutoSize: Boolean);
var
  i: integer;
  TmpObj: TObject;
begin
  try
  LV.Hide;
  //注释后，检入文件会先显示 listview后面的grid，再显示listview的
  // 注释这两句后,打开历史版本出现'stream read error'
  LockWindowUpdate(LV.handle);
  SendMessagew(LV.Handle, WM_SETREDRAW, integer(false), 0);
  with LV do
  begin

    //先清空标题
    LV.Columns.Clear;
    for i := Low(Titles) to High(Titles) do
      with LV.Columns.Add do
      begin
        Caption := Titles[i];
        Width := Widths[i];
      //对于‘大小’项，需要右对齐
      //  if Titles[i] = LoadStr(sListSize) then
      //    Alignment := taRightJustify;
        if LastAutosize and (i = High(Titles)) then
          AutoSize := True;
      end;

    //如果需要清空内容，则清空
    if IsClearItems then
    begin
      Hide;
      LV.items.Clear;
      Show;
    end;

    //将宽度增加1是为了当最后一行需要自动增长时，强制列表刷新自己
    //Perform(WM_SIZE,0,0);
    if LastAutosize then
      Width := Width + 1;
      //Perform(WM_SIZE,0,0);
  end;
  SendMessagew(LV.Handle, WM_SETREDRAW, integer(true), 0);
  LockWindowUpdate(0);
  finally
    LV.Show;
  end;
end;

function TExplorerForm.AddAListItem({intImgIndex: integer;}
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

constructor TExplorerForm.Create(AOwner: TComponent; AParent: TWinControl);
begin
  inherited;
  //drvcbb1.Drive := 'D';
end;

end.
