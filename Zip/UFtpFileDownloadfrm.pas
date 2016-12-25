unit UFtpFileDownloadfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UniCodeStdCtrls, ccuLabel, Mask, ccuMaskEdit,
  ccuCustomComboEdit, ccuDropDownEdit, ccuButtonEdit, ccuGrids,
  ccuDataStringGrid, ExtCtrls, ccuUtils, IniFiles,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdFTP;

type
  TFtpFileDownloadForm = class(TForm)
    dgDetail: TccuDataStringGrid;
    bedtFTP: TccuButtonEdit;
    bedtUser: TccuButtonEdit;
    bedtPassword: TccuButtonEdit;
    bedtLocalPath: TccuButtonEdit;
    bedtPort: TccuButtonEdit;
    bedt6: TccuButtonEdit;
    lblFTP: TccuLabel;
    lblUser: TccuLabel;
    lblPassword: TccuLabel;
    lblLocalPath: TccuLabel;
    lblPort: TccuLabel;
    btnStart: TButton;
    pnlTop: TPanel;
    btnSaveSet: TButton;
    procedure btnStartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveSetClick(Sender: TObject);
  private
    { Private declarations }
    CurrExePath: WideString;
    iniFileName: WideString;
    procedure LoadSet;
    procedure SaveSet;

  public
    { Public declarations }
  end;

var
  FtpFileDownloadForm: TFtpFileDownloadForm;

implementation

{$R *.dfm}

procedure TFtpFileDownloadForm.btnStartClick(Sender: TObject);
var
  Row: Integer;
  FileName, LocalPath, LocalName: string;
  IdFtpDownload: TIdFTP;
begin
  //�����ļ���·��
  LocalPath := GetStdDirectoryW(bedtLocalPath.Text);
  if not DirectoryExists(LocalPath) then
    ForceDirectories(LocalPath);

  for Row := 1 to dgDetail.RowProps.Count - 1 do
  begin
    //�������ϵ��ļ���
    FileName := dgDetail.CellByField2['Path', Row];
    if Trim(FileName) = '' then Continue;
//    FileName := GetStdDirectoryW(FileName);
//    FileName := StringReplace(FileName, '\', '/', [rfReplaceAll]);
//    FileName := StringReplace(FileName, '//', '/', [rfReplaceAll]);
//    FileName := StringReplace(FileName, '//', '/', [rfReplaceAll]);

    //�����ļ�
    IdFtpDownload := TIdFTP.Create(self);
    try
      IdFtpDownload.User := bedtUser.Text;
      IdFtpDownload.Password := bedtPassword.Text;
      IdFtpDownload.Host := bedtFTP.Text;
      IdFtpDownload.Port := StrToIntDef(bedtPort.Text, 21);
      IdFtpDownload.Passive := True;
      if (not IdFtpDownload.Connected) then
        IdFtpDownload.Connect;
      IdFtpDownload.ChangeDirUp;
      IdFtpDownload.ChangeDirUp;
      LocalName := LocalPath + dgDetail.CellByField2['LocalName', Row];

      IdFtpDownload.TransferType := ftbinary; //����ģʽ
      try
        IdFtpDownload.Get(FileName, LocalName, true); //��ʼ����
        IdFtpDownload.Quit;
        dgDetail.CellByField2['Stat', Row] := '�ɹ�';
      except
        dgDetail.CellByField2['Stat', Row] := 'ʧ��';
      end;
    finally
      IdFtpDownload.Free;
    end;
  end;
end;

procedure TFtpFileDownloadForm.LoadSet;
var
  iniFile: TIniFile;
  I, J, K: Integer;
begin
  inifile := TIniFile.Create(CurrExePath + '\' + iniFileName);

  bedtFTP.Text := iniFile.ReadString('CLASSSET', 'bedtFTP', '');
  bedtPort.Text := iniFile.ReadString('CLASSSET', 'bedtPort', '');
  bedtUser.Text := iniFile.ReadString('CLASSSET', 'bedtUser', '');
  bedtPassword.Text := iniFile.ReadString('CLASSSET', 'bedtPassword', '');
  bedtLocalPath.Text := iniFile.ReadString('CLASSSET', 'bedtLocalPath', '');
//  bedtFTP.Text := iniFile.ReadString('CLASSSET', 'bedtFTP', '');
//  bedtFTP.Text := iniFile.ReadString('CLASSSET', 'bedtFTP', '');
//  bedtFTP.Text := iniFile.ReadString('CLASSSET', 'bedtFTP', '');
end;

procedure TFtpFileDownloadForm.SaveSet;
var
  inifile: TIniFile;
  I, J, K: Integer;
begin
  inifile := TIniFile.Create(CurrExePath + '\' + iniFileName);

  iniFile.WriteString('CLASSSET', 'bedtFTP', bedtFTP.Text);
  iniFile.WriteString('CLASSSET', 'bedtPort', bedtPort.Text);
  iniFile.WriteString('CLASSSET', 'bedtUser', bedtUser.Text);
  iniFile.WriteString('CLASSSET', 'bedtPassword', bedtPassword.Text);
  iniFile.WriteString('CLASSSET', 'bedtLocalPath', bedtLocalPath.Text);
end;

procedure TFtpFileDownloadForm.FormShow(Sender: TObject);
begin
  //�õ���ǰ��������Ŀ¼,β����'\'
  CurrExePath := IncludeTrailingBackSlash(ExtractFilePath(Application.ExeName));
  iniFileName := '�ļ�����.ini';
  LoadSet;
end;

procedure TFtpFileDownloadForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SaveSet;
end;

procedure TFtpFileDownloadForm.btnSaveSetClick(Sender: TObject);
begin
  SaveSet;
end;

end.
