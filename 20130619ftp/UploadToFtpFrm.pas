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
  //�õ���ǰ��������Ŀ¼,β����'\'
  CurrExePath := IncludeTrailingBackSlash(ExtractFilePath(Application.ExeName));
  iniFileName := '�ϴ��ļ���FTP.ini';
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
        // ������ʾ����
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
        //����dgZip���Ƿ��Ѿ�����ͬ����ZIP�ļ�
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

        if IntTmp <> -1 then //����ҵ�ͬ����ZIP�ļ�
          dgZip.Row := IntTmp
        else // ���û��ͬ����ZIP�ļ�,����ҵ�һ������
          begin
            IntTmp := dgZip.GetFirstEmptyRow;
            if IntTmp <> -1 then  //����п���
              dgZip.Row := IntTmp
            else //���û�п���,������һ��
              begin
                dgZip.RowCount := dgZip.RowCount + 1;
                dgZip.Row := dgZip.RowCount - 1;
              end;
          end;
        dgZip.RowProps[dgZip.Row].Checked := True;
        if BExists then
          if SameText(dgZip.CellByTitle['�ļ�ʱ��'], GetFileTime(strFile)) then
          begin
            dgZip.CellNote[dgZip.GetFieldIndex('ZipName'), dgZip.Row] :=
              '�����ļ�������һ��û�и��Ĺ��������ϴ���';
            dgZip.RowProps[dgZip.Row].RowColor := clBlue;
            dgZip.RowProps[dgZip.Row].Checked := False;
          end;
        dgZip.CellByTitle['����'] := ExtractFileName(strFile);
        dgZip.CellByTitle['�ļ�ʱ��'] := GetFileTime(strFile);
        dgZip.CellByTitle['����·��'] := strFile;
      end;
    end;
end;

procedure TUploadToFtpForm.btnUploadClick(Sender: TObject);
var
  RowZip, RowFtp: Integer;
  FromFile, ToFile, BakFile: string;
  IdFTPUpload, IdFtpDownload: TIdFTP;
begin
  //�����ļ���·��������ʱ���������ļ���
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
        //�������ϵ��ļ���
        ToFile := GetStdDirectory(dgFtp.CellByField2['Path', RowFtp])
          + UpperCase(dgZip.CellByField['ZipName']);
        ToFile := StringReplace(ToFile, '\', '/', [rfReplaceAll]);
        ToFile := StringReplace(ToFile, '//', '/', [rfReplaceAll]);
        ToFile := StringReplace(ToFile, '//', '/', [rfReplaceAll]);

        //�����ļ�
        IdFtpDownload := TIdFTP.Create(self);
        try
          IdFtpDownload.User := dgFtp.CellByField2['User', RowFtp];
          IdFtpDownload.Password := dgFtp.CellByField2['Password', RowFtp];
          IdFtpDownload.Host := dgFtp.CellByField2['Host', RowFtp];
          IdFtpDownload.Port := StrToIntDef(dgFtp.CellByField2['Port', RowFtp], 21);
          IdFtpDownload.Passive := True;
          if (not IdFtpDownload.Connected) then
            IdFtpDownload.Connect;
          //�����ļ���
          BakFile := GetStdDirectory(GetStdDirectory(dgFtp.CellByField2['BakPath', RowFtp])
            + dgFtp.CellByField2['TimePath', RowFtp])
            + dgZip.CellByField['ZipName'];
          if not DirectoryExists(extractfiledir(BakFile)) then
            ForceDirectories(ExtractFileDir(BakFile));

          IdFtpDownload.TransferType := ftbinary; //����ģʽ
          try
            IdFtpDownload.Get(ToFile, BakFile, true); //��ʼ����
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

        // �ϴ��ļ�
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
            dgZip.CellByField['UpStat'] := '�ɹ�';
          //dgZip.ValueByField['UpStat'] := '1';
          except
            on E: Exception do
            begin
              dgZip.CellByField['UpStat'] := 'ʧ��';
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
      Caption := '���ñ��水ť';
    end
    else
    begin
      btnSaveSet.Enabled := False;
      Tag := 1;
      Caption := '���ñ��水ť';
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
