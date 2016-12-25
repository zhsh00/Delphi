program Zip;

uses
  ExceptionLog,
  Forms,
  Mainfrm in 'Mainfrm.pas' {MainForm},
  CheckFolderFrm in 'CheckFolderFrm.pas' {CheckFolderForm},
  UFtpFileDownloadfrm in 'UFtpFileDownloadfrm.pas' {FtpFileDownloadForm},
  UCompReNameForm in 'UCompReNameForm.pas' {CompReNameForm},
  ReNameFrm in '..\Simple\ReNameFrm.pas',
  ChildFrm in '..\Simple\ChildFrm.pas' {ChildForm},
  UploadToFtpFrm in '..\20130619ftp\UploadToFtpFrm.pas' {UploadToFtpForm},
  ccuUtils in '..\PUBLIC\ccuUtils.pas',
  Utils in '..\PUBLIC\Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TChildForm, ChildForm);
  Application.CreateForm(TUploadToFtpForm, UploadToFtpForm);
  Application.Run;
end.
