unit Zipfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UniCodeStdCtrls, ccuButton, ExtCtrls, UniExtCtrls,
  ccuPanel, ccuMemo, ComCtrls, UniCodeComCtrls, ccuPageControl,
  ccuSkinProvider, ccuSkinManager, ccuLabel, UniCodeClasses, ccuGrids,
  ccuDataStringGrid, UniDialogs, ccuDialogs, ccuCheckbox, ccuGroupBox,
  ccuSplitter, Mask, ccuMaskEdit, ccuCustomComboEdit, ccuDropDownEdit,
  ccuButtonEdit, ccuUtils;

const
  iniForAllNeededZipFile = 'iniForAllNeededZipFile.txt';
  iniForSrcAndDestDir = 'iniForSrcAndDestDir.ini';
  TMyBooleanStringArray: array [Boolean] of WideString = ('FALSE', 'TRUE');

type
  TMyCharSet = set of Char;
//  TMyBooleanArray = array [Boolean] of WideString;

type
  TZipForm = class(TForm)
    pnlTop: TccuPanel;
    pnlBottom: TccuPanel;
    pgc1: TccuPageControl;
    tsDoZip: TccuTabSheet;
    tsEditFileListName: TccuTabSheet;
    mmEditFileListName: TMemo;
    ccuSkinManager1: TccuSkinManager;
    ccuSkinProvider1: TccuSkinProvider;
    lblZipTo: TccuLabel;
    lblZipToHint: TccuLabel;
    lblBpls: TccuLabel;
    lblBplsDir: TccuLabel;
    lblCurrentBpl: TccuLabel;
    dgDetail: TccuDataStringGrid;
    pnlRight: TccuPanel;
    dlgScanFiles: TccuOpenDialog;
    btnCheckAndZipIt: TccuButton;
    btnZipAndToTheDir: TccuButton;
    ccuGroupBox1: TccuGroupBox;
    btnScanFiles: TccuButton;
    btnSave: TccuButton;
    cbxBakBeforeSave: TccuCheckBox;
    ccuGroupBox2: TccuGroupBox;
    lblLineCount: TccuLabel;
    bedtDirSelect: TccuButtonEdit;
    grpZip: TccuGroupBox;
    btnZipZipIndg: TccuButton;
    btnCompare: TccuButton;
    CheckBox1: TccuCheckBox;
    lbl2: TccuLabel;
    grpOption: TccuGroupBox;
    bedtExt: TccuButtonEdit;
    bedtName: TccuButtonEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure btnZipZipIndgClick(Sender: TObject);
    procedure btnScanFilesClick(Sender: TObject);
    procedure btnCheckAndZipItClick(Sender: TObject);
    procedure btnZipAndToTheDirClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure bedtDirSelectChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure lbl2Click(Sender: TObject);
  private
    { Private declarations }
    //上传文件到FTP页的窗体
    //FUploadToFtpForm: TUploadToFtpForm;
    //重命名页窗体
    //ReNameForm: TReNameForm;
    //重命名页窗体
    //CompReNameForm: TCompReNameForm;
    //下载文件页窗体
    //FtpFileDownloadForm: TFtpFileDownloadForm;

    function ZipZipFile(FileName, ZippedFileName: WideString): boolean;overload;
    function ZipZipFile(FileName: TUniStrings;
      ZippedFileName: WideString): boolean; overload;

    function IsWhiteSpaceLine(ALine: WideString): Boolean;

    function MyBooleanToString(const ABoolean: Boolean): WideString;
    function GetZipNameByFileName(const AFileName: WideString): WideString;
  public
    { Public declarations }
  end;

var
  ZipForm: TZipForm;

implementation

{$R *.dfm}
uses IniFiles, vclzip, vclunzip, CheckFolderFrm;


function CovFileDate(Fd: _FILETIME): TDateTime;
var
  Tct: _SYSTEMTIME;
  Temp: _FILETIME;
begin
  FileTimeToLocalFileTime(Fd, Temp);
  FileTimeToSystemTime(Temp, Tct);
  CovFileDate := SystemTimeToDateTime(Tct);
  //Result := SystemTimeToDateTime(Tct);
end;

function GetFileTime(const AFile: string): string;
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

function TZipForm.GetZipNameByFileName(const AFileName: WideString): WideString;
var
  i: Integer;
  strExt: string;
  lowExt, NameMode: Integer;
begin
  if bedtExt.ItemIndex = 0 then
    strExt := '.zip'
  else
    strExt := '.ZIP';
  for i := Length(AFileName) downto 1 do
    if AFileName[i] = '.' then
    begin
      if bedtName.ItemIndex = 1 then
        Result := UpperCase(Copy(AFileName, 1, i - 1)) + strExt
      else if bedtName.ItemIndex = 2 then
        Result := LowerCase(Copy(AFileName, 1, i - 1)) + strExt
      else
        Result := Copy(AFileName, 1, i - 1) + strExt;
      Exit;
    end;
  Result := AFileName + '_ErrorExtName' +'.ZIP';
end;


{ TMainForm }
procedure TZipForm.FormCreate(Sender: TObject);
var
  CurrExePath: string;
  Line, sTmp: string;
  F: TextFile;
  iniTmp: TIniFile;
  iniFileName: string;
  strList: TStringList;
  bHasValidBplsDir, bHasValidZipToDir: Boolean;
  i: Integer;
begin
  //得到当前程序运行目录,尾部带'\'
  CurrExePath := IncludeTrailingBackSlash(ExtractFilePath(Application.ExeName));

  //lsx
  ccuSkinManager1.SkinDirectory := CurrExePath;
  ccuSkinManager1.SkinName := 'Office2007';
  ccuSkinManager1.ExtendedBorders := False; //设为true的话打开窗口标题会先是一片白的

  //读取需要压缩的包的名字到memo
  if not FileExists(CurrExePath + iniForAllNeededZipFile) then
  begin
    AssignFile(F,CurrExePath + iniForAllNeededZipFile);
    Rewrite(f);
  end
  else
    AssignFile(F,CurrExePath + iniForAllNeededZipFile);

  Reset(F);
  mmEditFileListName.Lines.Clear;
  while not Eof(F) do
  begin
    Readln(F,Line);
    mmEditFileListName.Lines.Add(Line);
  end;
  CloseFile(F);
  lblLineCount.Caption := Format('共有记录 %d 条',
    [mmEditFileListName.Lines.Count]);

  strList := TStringList.Create;
  iniFileName := CurrExePath + iniForSrcAndDestDir;
  iniTmp := TIniFile.Create(iniFileName);
  iniTmp.ReadSection('BplsDir', strList);
  bHasValidBplsDir := False;
  for i := 0 to strList.Count - 1 do
    bedtDirSelect.Items.Add(
      WideString(iniTmp.ReadString('BplsDir',strList[i],'')));
  bHasValidBplsDir := True;
  //sTmp := iniTmp.ReadString('uplowIndex',strList[i],'');
  bedtName.ItemIndex := 1;
  bedtExt.ItemIndex := 0;
  {if strList.Count = 1 then
  begin
    lblBplsDir.Caption:=WideString(iniTmp.ReadString('BplsDir',strList[0],''));
    if lblBplsDir.Caption ='' then
      lblBplsDir.Caption := lblBpls.Caption + '为空，请重新配置！'
    else
      bHasValidBplsDir := True;
  end
  else
  if strList.Count > 1 then
  begin
    lblBplsDir.Caption := lblBpls.Caption + '多于一条，请重新配置！';
  end
  else
    lblBplsDir.Caption := '没有配置[' + lblBpls.Caption + ']请配置[' +
      lblBpls.Caption + ']';}
  //目标路径
  iniTmp.ReadSection('ZipToDir', strList);
  bHasValidZipToDir := False;
  if strList.Count = 1 then
  begin
    lblZipToHint.Caption:=WideString(iniTmp.ReadString('ZipToDir',strList[0],''));
    if lblZipToHint.Caption ='' then
      lblZipToHint.Caption := lblZipTo.Caption + '为空，请重新配置！'
    else
      bHasValidZipToDir := True;
  end
  else
  if strList.Count > 1 then
  begin
    lblZipToHint.Caption := lblZipTo.Caption + '多于一条，请重新配置！';
  end
  else
    lblZipToHint.Caption := '没有配置[' + lblZipTo.Caption + ']请配置[' +
      lblZipTo.Caption + ']';

  lblCurrentBpl.Caption := '';
  btnCompare.Enabled :=  bHasValidBplsDir and bHasValidZipToDir;
  btnZipZipIndg.Enabled :=  bHasValidBplsDir and bHasValidZipToDir;
end;

//压缩文件
function TZipForm.ZipZipFile(FileName: TUniStrings;
  ZippedFileName: WideString): boolean;
var
  Zip: TVCLZip;
begin
  result := True;
  try
    Zip := TVCLZip.Create(nil);
    try
      Zip.FilesList.Assign(FileName);
      Zip.ZipName := ZippedFileName;
      Zip.DestDir := ExtractFileDir(ZippedFileName);
      Zip.DoAll := True;
      Zip.OverwriteMode := Never;
      Zip.Zip;
    finally
      Zip.Free;
    end;
  except
    result := False;
  end;
end;

//压缩文件
function TZipForm.ZipZipFile(FileName, ZippedFileName: WideString): boolean;
var
  Zip: TVCLZip;
begin
  result := True;
  try
    Zip := TVCLZip.Create(nil);
    try
      Zip.FilesList.Add(FileName);
      Zip.ZipName := ZippedFileName;
      Zip.DestDir := ExtractFileDir(ZippedFileName);
      Zip.DoAll := True;
      Zip.OverwriteMode := Never;
      Zip.Zip;
    finally
      Zip.Free;
    end;
  except
    result := False;
  end;
end;

procedure TZipForm.btnCompareClick(Sender: TObject);
var
  i: Integer;
  Line, BplName, BplsDir, strBplPath, ZipName, ZipTo, strZipPath: WideString;
  strErr: string;
  PFileAttr: Pointer;
  bBplExists, bZipExists: Boolean;
begin
  //得到当前程序运行目录,尾部若没有'\'则加上
  BplsDir := IncludeTrailingPathDelimiter(lblBplsDir.Caption);
  ZipTo := IncludeTrailingPathDelimiter(lblZipToHint.Caption);
  dgDetail.Lock;
  try
    dgDetail.ClearStringGrid(2);
    dgDetail.rowcount := mmEditFileListName.Lines.Count + 1;
    //清空过滤属性
    for i := 1 to dgDetail.Columns.count - 1 do
    begin
      dgDetail.Columns[i].FilterList.Clear;
      dgDetail.Columns[i].ShowFilter := False;
    end;

    for i := 0 to mmEditFileListName.Lines.Count - 1 do
    try
      Line := mmEditFileListName.Lines[i];
      if IsWhiteSpaceLine(Line) then
        Continue;

      BplName := Line;
      if Line[Length(Line)] = ',' then //若行尾有',',则去掉它
        BplName := Copy(Line, 1, Length(Line) - 1);

      strBplPath := BplsDir + BplName;
      dgDetail.CellByField2['BplName', i + 1] := BplName;
      if FileExists(strBplPath) then
      begin
        dgDetail.CellByField2['BplTime', i + 1] := GetFileTime(strBplPath);
        dgDetail.CellByField2['BplPath', i + 1] := strBplPath;
        bBplExists := True;
      end
      else
      begin
        bBplExists := False;
        dgDetail.RowProps[i + 1].RowColor := clBlue;
        dgDetail.CellByField2['ShouldZipInfo', i+ 1] :=
          WideFormat('Bpl文件(%s)没有找到%s', [BplName, #13]);
      end;
      dgDetail.CellByField2['BplExists', i+ 1] := MyBooleanToString(bBplExists);

      ZipName :=UpperCase(Copy(Line, 1, AnsiPos('.', Line))) + 'ZIP';
      strZipPath := ZipTo + ZipName;
      dgDetail.CellByField2['ZipPath', i + 1] := strZipPath;
      if FileExists(strZipPath) then
      begin
        dgDetail.CellByField2['ZipName', i + 1] := ZipName;
        dgDetail.CellByField2['ZipTime', i + 1] := GetFileTime(strZipPath);
        bZipExists := True;
      end
      else
      begin
        bZipExists := False;
      end;
      dgDetail.CellByField2['ZipExists', i+ 1] := MyBooleanToString(bZipExists);

      //判断Bpl是否需要压缩
      if bBplExists and (not bZipExists) then
      begin
        dgDetail.CellByField2['ShouldBeZip', i + 1] := MyBooleanToString(True);
        dgDetail.CellByField2['ShouldZipInfo', i+ 1] := '是';
      end
      else
      if bBplExists and bZipExists
        and (CompareStr(dgDetail.CellByField2['BplTime', i + 1],
          dgDetail.CellByField2['ZipTime', i + 1]) > 0) then
      begin
        dgDetail.CellByField2['ShouldBeZip', i + 1] := MyBooleanToString(True);
        dgDetail.CellByField2['ShouldZipInfo', i+ 1] := '是';
      end
      else
      begin
        dgDetail.CellByField2['ShouldBeZip', i + 1] := MyBooleanToString(False);
        dgDetail.CellByField2['ShouldZipInfo', i+ 1] := '否';
      end;
    finally

    end;
    // 设置显示过滤
    for i := 1 to dgDetail.Columns.count - 1 do
      dgDetail.Columns[i].ShowFilter := True;
      
    dgDetail.ClearAllRowChangeFlg;
  finally
    dgDetail.UnLock;
  end;
end;

procedure TZipForm.btnZipZipIndgClick(Sender: TObject);
var
  i: Integer;
  MyFalseString: WideString;
begin
  MyFalseString := MyBooleanToString(False);
  for i := 1 to dgDetail.RowCount - 1 do
  begin
    //使用CheckBox模式,则跳过没有勾选的行
    if CheckBox1.Checked and not dgDetail.RowProps[i].Checked then
      Continue;
    dgDetail.Row := i;
    if SameText(dgDetail.CellByField['ShouldBeZip'], MyFalseString) then
      Continue;

    lblCurrentBpl.Caption := Format('当前正在压缩         %s',
      [dgDetail.CellByField['BplName']]);
    ZipZipFile(dgDetail.CellByField['BplPath'], dgDetail.CellByField['ZipPath']);
  end;
  lblCurrentBpl.Caption := '文件压缩完成';
end;

function TZipForm.IsWhiteSpaceLine(ALine: WideString): Boolean;
const
  myWhiteSpaceChar: TMyCharSet = [Char(' '), #13, #10];
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Length(ALine) - 1 do
  if not (Char(ALine[i]) in myWhiteSpaceChar) then
  begin
    Result := False;
    Exit;
  end;
end;

function TZipForm.MyBooleanToString(const ABoolean: Boolean): WideString;
begin
  Result := TMyBooleanStringArray[ABoolean];
end;

procedure TZipForm.btnScanFilesClick(Sender: TObject);
var
  i: Integer;
begin
  dlgScanFiles.Options := [ofAllowMultiSelect];
  if dlgScanFiles.Execute then
  begin
    mmEditFileListName.Lines.Clear;
    for i := 0 to dlgScanFiles.Files.Count -1 do
    begin
      mmEditFileListName.Lines.Add(
        ExtractFileName(dlgScanFiles.Files.Strings[i]) + ',');
    end;
    lblLineCount.Caption := Format('共有记录 %d 条',
      [mmEditFileListName.Lines.Count]);
  end;
end;

procedure TZipForm.btnCheckAndZipItClick(Sender: TObject);
var
  i: Integer;
  FileName, ZipName: WideString;
begin
  dlgScanFiles.InitialDir := lblBplsDir.Caption;
  dlgScanFiles.Options := [ofAllowMultiSelect];
//  dlgScanFiles.Filter := 'bpl;exe';
//  dlgScanFiles.DefaultExt := 'bpl';
  if dlgScanFiles.Execute then
  begin
    for i := 0 to dlgScanFiles.Files.Count -1 do
    begin
      FileName := dlgScanFiles.Files.Strings[i]; // 若文件带有中文，则压缩内文件有问题
      ZipName := GetZipNameByFileName(FileName);
      ZipZipFile(FileName, ZipName);
    end;
    ShowMessage('压缩完毕！');
  end;
end;

procedure TZipForm.btnZipAndToTheDirClick(Sender: TObject);
var
  i: Integer;
  FileName, ZipName: WideString;
begin
  dlgScanFiles.Options := [ofAllowMultiSelect];
  dlgScanFiles.InitialDir := lblBplsDir.Caption;
  if dlgScanFiles.Execute then
  begin
    for i := 0 to dlgScanFiles.Files.Count -1 do
    begin
      FileName := dlgScanFiles.Files.Strings[i]; // 若文件带有中文，则压缩内文件有问题
      ZipName := IncludeTrailingPathDelimiter(lblZipToHint.Caption) + //得到当前程序运行目录,尾部若没有'\'则加上
        GetZipNameByFileName(ExtractFileName(FileName));

      ZipZipFile(FileName, ZipName);
    end;
    ShowMessage('压缩完毕！');
  end;
end;

procedure TZipForm.btnSaveClick(Sender: TObject);
var
  CurrExePath: string;
begin
  //得到当前程序运行目录,尾部带'\'
  CurrExePath := IncludeTrailingBackSlash(ExtractFilePath(Application.ExeName));
  if cbxBakBeforeSave.Checked
    and FileExists(CurrExePath + iniForAllNeededZipFile) then
      RenameFile(CurrExePath + iniForAllNeededZipFile,
        CurrExePath + iniForAllNeededZipFile + '.bak.txt');

  mmEditFileListName.Lines.SaveToFile(CurrExePath + iniForAllNeededZipFile);
end;

procedure TZipForm.bedtDirSelectChange(Sender: TObject);
begin
  lblBplsDir.Caption := bedtDirSelect.Text;
  //ShowMessage(bedtDirSelect.Text);
end;

procedure TZipForm.FormShow(Sender: TObject);
begin
  bedtDirSelect.ItemIndex := 0;
end;

procedure TZipForm.btn1Click(Sender: TObject);
begin
//shp1.Brush.Color := clFuchsia;
end;

procedure TZipForm.CheckBox1Click(Sender: TObject);
begin
  dgDetail.CheckBoxes := CheckBox1.Checked;
end;

procedure TZipForm.lbl2Click(Sender: TObject);
begin
//  with AboutBoxDialog1 do
//    begin
//      ProductName := 'Zip';
//      Copyright := 'Copyright ? zhshll';
//      Comments := '11';
//
//      if execute then
//      begin
//
//      end;
//    end;
end;

end.


