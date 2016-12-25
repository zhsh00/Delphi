unit Mainfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UniCodeStdCtrls, ccuButton, ExtCtrls, UniExtCtrls,
  ccuPanel, ccuMemo, ComCtrls, UniCodeComCtrls, ccuPageControl,
  ccuSkinProvider, ccuSkinManager, ccuLabel, UniCodeClasses, ccuGrids,
  ccuDataStringGrid, UniDialogs, ccuDialogs, ccuCheckbox, ccuGroupBox,
  ccuSplitter, Mask, ccuMaskEdit, ccuCustomComboEdit, ccuDropDownEdit,
  ccuButtonEdit, ccuUtils
  ,UploadToFtpFrm, ReNameFrm, UFtpFileDownloadfrm, UCompReNameForm;

const
  iniForAllNeededZipFile = 'iniForAllNeededZipFile.txt';
  iniForSrcAndDestDir = 'iniForSrcAndDestDir.ini';
  TMyBooleanStringArray: array [Boolean] of WideString = ('FALSE', 'TRUE');

type
  TMyCharSet = set of Char;
//  TMyBooleanArray = array [Boolean] of WideString;

type
  TMainForm = class(TForm)
    pnlTop: TccuPanel;
    pnlBottom: TccuPanel;
    pnlLeft: TccuPanel;
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
    tsFTPFileDownload: TccuTabSheet;
    tsUploadToFtp: TccuTabSheet;
    tsReName: TccuTabSheet;
    bedtDirSelect: TccuButtonEdit;
    grp1: TccuGroupBox;
    btnZipZipIndg: TccuButton;
    btnCompare: TccuButton;
    CheckBox1: TccuCheckBox;
    lbl1: TccuLabel;
    lbl2: TccuLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure btnZipZipIndgClick(Sender: TObject);
    procedure btnScanFilesClick(Sender: TObject);
    procedure btnCheckAndZipItClick(Sender: TObject);
    procedure btnZipAndToTheDirClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure pgc1Change(Sender: TObject);
    procedure bedtDirSelectChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure lbl2Click(Sender: TObject);
  private
    { Private declarations }
    //�ϴ��ļ���FTPҳ�Ĵ���
    FUploadToFtpForm: TUploadToFtpForm;
    //������ҳ����
    ReNameForm: TReNameForm;
    //������ҳ����
    CompReNameForm: TCompReNameForm;
    //�����ļ�ҳ����
    FtpFileDownloadForm: TFtpFileDownloadForm;

    function ZipZipFile(FileName, ZippedFileName: WideString): boolean;overload;
    function ZipZipFile(FileName: TUniStrings;
      ZippedFileName: WideString): boolean; overload;

    function IsWhiteSpaceLine(ALine: WideString): Boolean;

    function MyBooleanToString(const ABoolean: Boolean): WideString;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

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

function GetZipNameByFileName(const AFileName: WideString): WideString;
var
  i: Integer;
begin
  for i := Length(AFileName) downto 1 do
    if AFileName[i] = '.' then
    begin
      Result := UpperCase(Copy(AFileName, 1, i - 1)) + '.ZIP';
      Exit;
    end;
  Result := AFileName + '_ErrorExtName' +'.ZIP';
end;


{ TMainForm }
procedure TMainForm.FormCreate(Sender: TObject);
var
  CurrExePath: string;
  Line: string;
  F: TextFile;
  iniTmp: TIniFile;
  iniFileName: string;
  strList: TStringList;
  bHasValidBplsDir, bHasValidZipToDir: Boolean;
  i: Integer;
begin
  //�õ���ǰ��������Ŀ¼,β����'\'
  CurrExePath := IncludeTrailingBackSlash(ExtractFilePath(Application.ExeName));

  //lsx
  ccuSkinManager1.SkinDirectory := CurrExePath;
  ccuSkinManager1.SkinName := 'Office2007';
  ccuSkinManager1.ExtendedBorders := False; //��Ϊtrue�Ļ��򿪴��ڱ��������һƬ�׵�

  //��ȡ��Ҫѹ���İ������ֵ�memo
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
  lblLineCount.Caption := Format('���м�¼ %d ��',
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
  {if strList.Count = 1 then
  begin
    lblBplsDir.Caption:=WideString(iniTmp.ReadString('BplsDir',strList[0],''));
    if lblBplsDir.Caption ='' then
      lblBplsDir.Caption := lblBpls.Caption + 'Ϊ�գ����������ã�'
    else
      bHasValidBplsDir := True;
  end
  else
  if strList.Count > 1 then
  begin
    lblBplsDir.Caption := lblBpls.Caption + '����һ�������������ã�';
  end
  else
    lblBplsDir.Caption := 'û������[' + lblBpls.Caption + ']������[' +
      lblBpls.Caption + ']';}
  //Ŀ��·��
  iniTmp.ReadSection('ZipToDir', strList);
  bHasValidZipToDir := False;
  if strList.Count = 1 then
  begin
    lblZipToHint.Caption:=WideString(iniTmp.ReadString('ZipToDir',strList[0],''));
    if lblZipToHint.Caption ='' then
      lblZipToHint.Caption := lblZipTo.Caption + 'Ϊ�գ����������ã�'
    else
      bHasValidZipToDir := True;
  end
  else
  if strList.Count > 1 then
  begin
    lblZipToHint.Caption := lblZipTo.Caption + '����һ�������������ã�';
  end
  else
    lblZipToHint.Caption := 'û������[' + lblZipTo.Caption + ']������[' +
      lblZipTo.Caption + ']';

  lblCurrentBpl.Caption := '';
  btnCompare.Enabled :=  bHasValidBplsDir and bHasValidZipToDir;
  btnZipZipIndg.Enabled :=  bHasValidBplsDir and bHasValidZipToDir;
end;

//ѹ���ļ�
function TMainForm.ZipZipFile(FileName: TUniStrings;
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

//ѹ���ļ�
function TMainForm.ZipZipFile(FileName, ZippedFileName: WideString): boolean;
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

procedure TMainForm.btnCompareClick(Sender: TObject);
var
  i: Integer;
  Line, BplName, BplsDir, strBplPath, ZipName, ZipTo, strZipPath: WideString;
  strErr: string;
  PFileAttr: Pointer;
  bBplExists, bZipExists: Boolean;
begin
  //�õ���ǰ��������Ŀ¼,β����û��'\'�����
  BplsDir := IncludeTrailingPathDelimiter(lblBplsDir.Caption);
  ZipTo := IncludeTrailingPathDelimiter(lblZipToHint.Caption);
  dgDetail.Lock;
  try
    dgDetail.ClearStringGrid(2);
    dgDetail.rowcount := mmEditFileListName.Lines.Count + 1;
    //��չ�������
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
      if Line[Length(Line)] = ',' then //����β��',',��ȥ����
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
          WideFormat('Bpl�ļ�(%s)û���ҵ�%s', [BplName, #13]);
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

      //�ж�Bpl�Ƿ���Ҫѹ��
      if bBplExists and (not bZipExists) then
      begin
        dgDetail.CellByField2['ShouldBeZip', i + 1] := MyBooleanToString(True);
        dgDetail.CellByField2['ShouldZipInfo', i+ 1] := '��';
      end
      else
      if bBplExists and bZipExists
        and (CompareStr(dgDetail.CellByField2['BplTime', i + 1],
          dgDetail.CellByField2['ZipTime', i + 1]) > 0) then
      begin
        dgDetail.CellByField2['ShouldBeZip', i + 1] := MyBooleanToString(True);
        dgDetail.CellByField2['ShouldZipInfo', i+ 1] := '��';
      end
      else
      begin
        dgDetail.CellByField2['ShouldBeZip', i + 1] := MyBooleanToString(False);
        dgDetail.CellByField2['ShouldZipInfo', i+ 1] := '��';
      end;
    finally

    end;
    // ������ʾ����
    for i := 1 to dgDetail.Columns.count - 1 do
      dgDetail.Columns[i].ShowFilter := True;
      
    dgDetail.ClearAllRowChangeFlg;
  finally
    dgDetail.UnLock;
  end;
end;

procedure TMainForm.btnZipZipIndgClick(Sender: TObject);
var
  i: Integer;
  MyFalseString: WideString;
begin
  MyFalseString := MyBooleanToString(False);
  for i := 1 to dgDetail.RowCount - 1 do
  begin
    //ʹ��CheckBoxģʽ,������û�й�ѡ����
    if CheckBox1.Checked and not dgDetail.RowProps[i].Checked then
      Continue;
    dgDetail.Row := i;
    if SameText(dgDetail.CellByField['ShouldBeZip'], MyFalseString) then
      Continue;

    lblCurrentBpl.Caption := Format('��ǰ����ѹ��         %s',
      [dgDetail.CellByField['BplName']]);
    ZipZipFile(dgDetail.CellByField['BplPath'], dgDetail.CellByField['ZipPath']);
  end;
  lblCurrentBpl.Caption := '�ļ�ѹ�����';
end;

function TMainForm.IsWhiteSpaceLine(ALine: WideString): Boolean;
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

function TMainForm.MyBooleanToString(const ABoolean: Boolean): WideString;
begin
  Result := TMyBooleanStringArray[ABoolean];
end;

procedure TMainForm.btnScanFilesClick(Sender: TObject);
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
    lblLineCount.Caption := Format('���м�¼ %d ��',
      [mmEditFileListName.Lines.Count]);
  end;
end;

procedure TMainForm.btnCheckAndZipItClick(Sender: TObject);
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
      FileName := dlgScanFiles.Files.Strings[i]; // ���ļ��������ģ���ѹ�����ļ�������
      ZipName := GetZipNameByFileName(FileName);
      ZipZipFile(FileName, ZipName);
    end;
    ShowMessage('ѹ����ϣ�');
  end;
end;

procedure TMainForm.btnZipAndToTheDirClick(Sender: TObject);
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
      FileName := dlgScanFiles.Files.Strings[i]; // ���ļ��������ģ���ѹ�����ļ�������
      ZipName := IncludeTrailingPathDelimiter(lblZipToHint.Caption) + //�õ���ǰ��������Ŀ¼,β����û��'\'�����
        GetZipNameByFileName(ExtractFileName(FileName));
      ZipZipFile(FileName, ZipName);
    end;
    ShowMessage('ѹ����ϣ�');
  end;
end;

procedure TMainForm.btnSaveClick(Sender: TObject);
var
  CurrExePath: string;
begin
  //�õ���ǰ��������Ŀ¼,β����'\'
  CurrExePath := IncludeTrailingBackSlash(ExtractFilePath(Application.ExeName));
  if cbxBakBeforeSave.Checked
    and FileExists(CurrExePath + iniForAllNeededZipFile) then
      RenameFile(CurrExePath + iniForAllNeededZipFile,
        CurrExePath + iniForAllNeededZipFile + '.bak.txt');

  mmEditFileListName.Lines.SaveToFile(CurrExePath + iniForAllNeededZipFile);
end;

procedure TMainForm.pgc1Change(Sender: TObject);
begin
  inherited;
  if (pgc1.ActivePage = tsUploadToFtp) and (FUploadToFtpForm = nil) then
  begin
    FUploadToFtpForm := TUploadToFtpForm.Create(Self);
    with FUploadToFtpForm do
      begin
        BorderStyle := bsNone;
        Parent := tsUploadToFtp;
        Align := alClient;
        Show;
      end;
  end else if (pgc1.ActivePage = tsReName) and (CompReNameForm = nil) then
  begin
  //ReNameForm := TReNameForm.Create(Self);
    CompReNameForm := TCompReNameForm.Create(Self);
    with CompReNameForm do
      begin
        BorderStyle := bsNone;
        Parent := tsReName;
        Align := alClient;
        Show;
      end;
  end else if (pgc1.ActivePage = tsFTPFileDownload) and (ReNameForm = nil) then
  begin
    FtpFileDownloadForm := TFtpFileDownloadForm.Create(Self);
    with FtpFileDownloadForm do
      begin
        BorderStyle := bsNone;
        Parent := tsFTPFileDownload;
        Align := alClient;
        Show;
      end;
  end;
end;

procedure TMainForm.bedtDirSelectChange(Sender: TObject);
begin
  lblBplsDir.Caption := bedtDirSelect.Text;
  //ShowMessage(bedtDirSelect.Text);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  bedtDirSelect.ItemIndex := 0;
end;

procedure TMainForm.btn1Click(Sender: TObject);
begin
//shp1.Brush.Color := clFuchsia;
end;

procedure TMainForm.CheckBox1Click(Sender: TObject);
begin
  dgDetail.CheckBoxes := CheckBox1.Checked;
end;

procedure TMainForm.lbl2Click(Sender: TObject);
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


