unit UploadToFtpFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ccuGrids, StdCtrls, ccuCheckbox,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdFTP, Menus,
  ccuDataStringGrid;

type
  TUploadToFtpForm = class(TForm)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    spl1: TSplitter;
    btnSaveSet: TButton;
    btnLoadSet: TButton;
    OpenDialog1: TOpenDialog;
    btnAddZip: TButton;
    edtFilter: TEdit;
    lblFilter: TLabel;
    lblPath: TLabel;
    edtPath: TEdit;
    btnUpload: TButton;
    btnSaveEnable: TButton;
    pmdgOprerate: TPopupMenu;
    pmiDelOneRow: TMenuItem;
    pmiRestorebgColor: TMenuItem;
    edtFind: TEdit;
    btnFind: TButton;
    pnlZip: TPanel;
    pnlFtp: TPanel;
    dgZip: TccuDataStringGrid;
    dgFtp: TccuDataStringGrid;
    cbxFtp: TccuCheckBox;
    cbxZip: TccuCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveSetClick(Sender: TObject);
    procedure btnLoadSetClick(Sender: TObject);
    procedure cbxZipClick(Sender: TObject);
    procedure cbxFtpClick(Sender: TObject);
    procedure btnAddZipClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure btnSaveEnableClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pmiDelOneRowClick(Sender: TObject);
    procedure pmiRestorebgColorClick(Sender: TObject);
  private
    { Private declarations }
    CurrExePath: WideString;
    iniFileName: WideString;
    procedure DoInit;
  public
    { Public declarations }
  end;

var
  UploadToFtpForm: TUploadToFtpForm;

implementation
uses
  IniFiles, Utils;
{$R *.dfm}

procedure TUploadToFtpForm.DoInit;
begin
  pnlFtp.Height := spl1.Parent.Height div 2;
  pnlFtp.Align := alBottom;
  spl1.Align := alBottom;
end;

procedure TUploadToFtpForm.FormCreate(Sender: TObject);
begin
  //得到当前程序运行目录,尾部带'\'
  CurrExePath := IncludeTrailingBackSlash(ExtractFilePath(Application.ExeName));
  iniFileName := '上传文件到FTP.ini';
  DoInit;
end;

procedure TUploadToFtpForm.btnSaveSetClick(Sender: TObject);
var
  inifile: TIniFile;
  I, J, K: Integer;
  strFieldName: WideString;
begin
  inifile := TIniFile.Create(CurrExePath + '\' + iniFileName);

  for I := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TccuDataStringGrid then
    begin
      iniFile.WriteString(TccuDataStringGrid(Components[i]).Name, 'RowCount',
        IntToStr(TccuDataStringGrid(Components[i]).RowCount));

      for J := 1 to TccuDataStringGrid(Components[i]).RowCount - 1 do
        iniFile.WriteString(TccuDataStringGrid(Components[i]).Name, 'RowChecked' + inttostr(J),
          MyBoolToStr(TccuDataStringGrid(Components[i]).RowProps[J].Checked));

      for J := 2 to TccuDataStringGrid(Components[i]).Columns.Count - 1 do
      begin
        strFieldName := TccuDataStringGrid(Components[i]).Columns[J].FieldName;
        iniFile.WriteString(TccuDataStringGrid(Components[i]).Name, strFieldName,
          IntToStr(TccuDataStringGrid(Components[i]).Columns[J].Width));

        for K := 1 to TccuDataStringGrid(Components[i]).RowCount - 1 do
          iniFile.WriteString(TccuDataStringGrid(Components[i]).Name, strFieldName + '#' + IntToStr(K),
            TccuDataStringGrid(Components[i]).Cells[J, K]);
      end;
    end
    else if Components[i] is TEdit then
    begin
      iniFile.WriteString('CLASSSET', TEdit(Components[i]).Name, TEdit(Components[i]).Text);
    end;
  end;
end;

procedure TUploadToFtpForm.btnLoadSetClick(Sender: TObject);
var
  iniFile: TIniFile;
  I, J, K: Integer;
  strFieldName: WideString;
begin
  inifile := TIniFile.Create(CurrExePath + '\' + iniFileName);
  dgZip.ClearStringGrid(2);
  dgFtp.ClearStringGrid(2);
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TccuDataStringGrid then
      begin
        TccuDataStringGrid(Components[i]).RowCount := strToIntDef(iniFile.ReadString
          (TccuDataStringGrid(Components[i]).Name, 'RowCount', ''), 2);

        for J := 1 to TccuDataStringGrid(Components[i]).RowCount - 1 do
          if sameText(iniFile.ReadString(TccuDataStringGrid(Components[i]).Name,
            'RowChecked' + inttostr(J), ''), 'true') then
            TccuDataStringGrid(Components[i]).RowProps[J].Checked := True
          else
            TccuDataStringGrid(Components[i]).RowProps[J].Checked := False;

        for J := 0 to TccuDataStringGrid(Components[i]).Columns.Count - 1 do
        begin
          strFieldName := TccuDataStringGrid(Components[i]).Columns[J].FieldName;
          if strFieldName = '' then Continue;

          TccuDataStringGrid(Components[i]).Columns[j].Width :=
            StrToIntDef(iniFile.ReadString(TccuDataStringGrid(Components[i]).Name,
            strFieldName, ''), 50);

          for K := 1 to TccuDataStringGrid(Components[i]).RowCount - 1 do
            TccuDataStringGrid(Components[i]).Cells[J, K] :=
              iniFile.ReadString(TccuDataStringGrid(Components[i]).Name,
              strFieldName + '#' + IntToStr(K), '')
        end;
        // 设置显示过滤
{       with TDataStringGrid(Components[i]) do
          begin
            for J := 1 to Columns.count - 1 do
              Columns[J].ShowFilter := True;

            ClearAllRowChangeFlg;
          end;}
      end
    else if Components[i] is TEdit then
    begin
      TEdit(Components[i]).Text := iniFile.ReadString('CLASSSET', TEdit(Components[i]).Name, '')
    end;

  dgZip.ClearAllRowChangeFlg;
  dgFtp.ClearAllRowChangeFlg;
end;

procedure TUploadToFtpForm.cbxZipClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to dgZip.RowProps.Count - 1 do
    dgZip.RowProps[I].Checked := cbxZip.Checked;
end;

procedure TUploadToFtpForm.cbxFtpClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to dgFtp.RowProps.Count - 1 do
    dgFtp.RowProps[I].Checked := cbxFtp.Checked;
end;

procedure TUploadToFtpForm.btnAddZipClick(Sender: TObject);
var
  I, J, col, IntTmp:Integer;
  BExists: Boolean;
  strFile, LastFileTime: string;
begin
  OpenDialog1.InitialDir := GetStdDirectory(edtPath.Text);
  OpenDialog1.Filter := edtFilter.Text;
  with OpenDialog1 do
    if Execute then
    begin
      for I := 0 to Files.Count - 1 do
      begin
        strFile := Files[I];
        //查找dgZip中是否已经存在同名的ZIP文件
        IntTmp := -1;
        BExists := False;
        for J := 1 to dgZip.RowProps.Count - 1 do
          if SameText(dgZip.CellByField2['ZipName', J],
            ExtractFileName(strFile)) then
          begin
            IntTmp := J;
            BExists := True;
            break;
          end;

        if IntTmp <> -1 then //如果找到同名的ZIP文件
          dgZip.Row := IntTmp
        else // 如果没有同名的ZIP文件,则查找第一个空行
          begin
            IntTmp := dgZip.GetFirstEmptyRow;
            if IntTmp <> -1 then  //如果有空行
              dgZip.Row := IntTmp
            else //如果没有空行,则新增一行
              begin
                dgZip.RowCount := dgZip.RowCount + 1;
                dgZip.Row := dgZip.RowCount - 1;
              end;
          end;
        dgZip.RowProps[dgZip.Row].Checked := True;
        if BExists then
          if SameText(dgZip.CellByTitle['文件时间'], GetFileTime(strFile)) then
          begin
            dgZip.CellNote[dgZip.GetFieldIndex('ZipName'), dgZip.Row] :=
              '本地文件比起上一次没有更改过，不必上传。';
            dgZip.RowProps[dgZip.Row].RowColor := clBlue;
            dgZip.RowProps[dgZip.Row].Checked := False;
          end;
        dgZip.CellByTitle['名称'] := ExtractFileName(strFile);
        dgZip.CellByTitle['文件时间'] := GetFileTime(strFile);
        dgZip.CellByTitle['本地路径'] := strFile;
      end;
    end;
end;

procedure TUploadToFtpForm.btnUploadClick(Sender: TObject);
var
  RowZip, RowFtp: Integer;
  FromFile, ToFile, BakFile: string;
  IdFTPUpload, IdFtpDownload: TIdFTP;
begin
  //备份文件的路径包含按时间命名的文件夹
  for RowFtp := 1 to dgFtp.RowProps.Count - 1 do
    dgFtp.CellByField2['timepath', RowFtp] :=
      FormatDateTime('yyyymmdd_hh_nn_ss', now) +
      format('%.2d',[RowFtp]);

  for RowZip := 1 to dgZip.RowProps.Count - 1 do
  begin
    if not dgZip.RowProps[RowZip].Checked then Continue;
    dgZip.Row := RowZip;

    for RowFtp := 1 to dgFtp.RowProps.count - 1 do
    begin
      if dgFtp.RowProps[RowFtp].Checked
        and SameText(dgFtp.CellByField2['IsFTP', RowFtp],'FTP') then
      begin
        //服务器上的文件名
        ToFile := GetStdDirectory(dgFtp.CellByField2['Path', RowFtp])
          + UpperCase(dgZip.CellByField['ZipName']);
        ToFile := StringReplace(ToFile, '\', '/', [rfReplaceAll]);
        ToFile := StringReplace(ToFile, '//', '/', [rfReplaceAll]);
        ToFile := StringReplace(ToFile, '//', '/', [rfReplaceAll]);

        //备份文件
        IdFtpDownload := TIdFTP.Create(self);
        try
          IdFtpDownload.User := dgFtp.CellByField2['User', RowFtp];
          IdFtpDownload.Password := dgFtp.CellByField2['Password', RowFtp];
          IdFtpDownload.Host := dgFtp.CellByField2['Host', RowFtp];
          IdFtpDownload.Port := StrToIntDef(dgFtp.CellByField2['Port', RowFtp], 21);
          IdFtpDownload.Passive := True;
          if (not IdFtpDownload.Connected) then
            IdFtpDownload.Connect;
          //备份文件名
          BakFile := GetStdDirectory(GetStdDirectory(dgFtp.CellByField2['BakPath', RowFtp])
            + dgFtp.CellByField2['TimePath', RowFtp])
            + dgZip.CellByField['ZipName'];
          if not DirectoryExists(extractfiledir(BakFile)) then
            ForceDirectories(ExtractFileDir(BakFile));

          IdFtpDownload.TransferType := ftbinary; //下载模式
          try
            IdFtpDownload.Get(ToFile, BakFile, true); //开始下载
          except
            on E: Exception do
            begin
              ShowMessage(E.Message);
            end;
          end;
          IdFtpDownload.Quit;
        finally
          IdFtpDownload.Free;
        end;

        // 上传文件
        IdFTPUpload := TIdFTP.Create(Self);
        try
          IdFTPUpload.User := dgFtp.CellByField2['User', RowFtp];
          IdFTPUpload.Password := dgFtp.CellByField2['Password', RowFtp];
          IdFTPUpload.Host := dgFtp.CellByField2['Host', RowFtp];
          IdFTPUpload.Port := StrToIntDef(dgFtp.CellByField2['Port', RowFtp], 21);
          IdFTPUpload.Passive := True;
          if (not IdFTPUpload.Connected) then
            IdFTPUpload.Connect;
          FromFile := dgZip.CellByField['Path'];

          try
            IdFTPUpload.Put(FromFile, ToFile);
            dgZip.CellByField['UpStat'] := '成功';
          //dgZip.ValueByField['UpStat'] := '1';
          except
            on E: Exception do
            begin
              dgZip.CellByField['UpStat'] := '失败';
            //dgZip.ValueByField['UpStat'] := '2';
              ShowMessage(E.Message);
            end;
          end;
        finally
          IdFTPUpload.Free;
        end;
      end;
    end;
  end;
end;

procedure TUploadToFtpForm.btnSaveEnableClick(Sender: TObject);
begin
  with TButton(Sender) do
    if Tag = 1 then
    begin
      btnSaveSet.Enabled := True;
      Tag := 2;
      Caption := '禁用保存按钮';
    end
    else
    begin
      btnSaveSet.Enabled := False;
      Tag := 1;
      Caption := '启用保存按钮';
    end;
end;

procedure TUploadToFtpForm.FormResize(Sender: TObject);
begin
  if pnlZip.Height < 150 then
    pnlFtp.Height := spl1.Parent.Height div 2;
end;

procedure TUploadToFtpForm.pmiDelOneRowClick(Sender: TObject);
var
  dg: TccuDataStringGrid;
begin
  if pmdgOprerate.PopupComponent is TccuDataStringGrid then
  begin
    dg := TccuDataStringGrid(pmdgOprerate.PopupComponent);
    dg.DeleteRow(dg.Row);
  end;
end;

procedure TUploadToFtpForm.pmiRestorebgColorClick(Sender: TObject);
var
  dg: TccuDataStringGrid;
  I: Integer;
begin
  if pmdgOprerate.PopupComponent is TccuDataStringGrid then
  begin
    dg := TccuDataStringGrid(pmdgOprerate.PopupComponent);
    for I := 1 to dg.RowProps.Count - 1 do
      dg.RowProps[I].RowColor := clWindow;
  end;
end;

end.
