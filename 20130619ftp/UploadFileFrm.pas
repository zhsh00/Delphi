unit UploadFileFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdFTP,
  ZipClas;

type
  TUploadFileForm = class(TForm)
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  UploadFileForm: TUploadFileForm;
//function DoUploadFile(FromFile, ToFile, BakFile: string; fsi: TFtpServerInfo): Boolean;
implementation

{$R *.dfm}


//
function DoUploadFile(FromFile, ToFile, BakFile: string; fsi: TFtpServerInfo): Boolean;
var
  //RowZip, RowFtp: Integer;
  //FromFile, ToFile, BakFile: string;
  IdFTPUpload, IdFtpDownload: TIdFTP;
begin
  //备份文件
  IdFtpDownload := TIdFTP.Create(nil);
  try
    IdFtpDownload.User := fsi.User;
    IdFtpDownload.Password := fsi.Password;
    IdFtpDownload.Host := fsi.Host;
    IdFtpDownload.Port := fsi.Port;
    IdFtpDownload.Passive := True;
    if (not IdFtpDownload.Connected) then
      IdFtpDownload.Connect;

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
  IdFTPUpload := TIdFTP.Create(nil);
  try
    IdFTPUpload.User := fsi.User;
    IdFTPUpload.Password := fsi.Password;
    IdFTPUpload.Host := fsi.Host;
    IdFTPUpload.Port := fsi.Port;
    IdFTPUpload.Passive := True;
    if (not IdFTPUpload.Connected) then
      IdFTPUpload.Connect;
    //FromFile := dgZip.CellByField['Path'];

    try
      IdFTPUpload.Put(FromFile, ToFile);
      //dgZip.CellByField['UpStat'] := '成功';
    //dgZip.ValueByField['UpStat'] := '1';
    except
      on E: Exception do
      begin
        //dgZip.CellByField['UpStat'] := '失败';
      //dgZip.ValueByField['UpStat'] := '2';
        ShowMessage(E.Message);
      end;
    end;
  finally
    IdFTPUpload.Free;
  end;
  Result := True;
end;

procedure TUploadFileForm.btn1Click(Sender: TObject);
var
  FromPath, ToPath, BakPath: string;
  fsi: TFtpServerInfo;
begin
  fsi := TFtpServerInfo.Create;
  fsi.User := 'root';//edt1.text;
  fsi.Password := 'Gztw@20168yy';//edt2.text;
  fsi.Host := '121.40.92.236';//edt3.text;
  fsi.Port := 22;

  FromPath := 'C:\Users\hasee\Desktop\CCART.zip';
  ToPath := '/app/bms/www/Bak';
  BakPath := 'C:\Users\hasee\Desktop\bak\CCART.zip';

  DoUploadFile(FromPath, ToPath, BakPath, fsi);
end;

end.
