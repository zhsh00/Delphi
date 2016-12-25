program UploadToFtp;

uses
  Forms,
  UploadToFtpFrm in 'UploadToFtpFrm.pas' {UploadToFtpForm},
  Utils in '..\bpg\Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TUploadToFtpForm, UploadToFtpForm);
  Application.Run;
end.
