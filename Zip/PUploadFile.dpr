program PUploadFile;

uses
  Forms,
  UploadFileFrm in '..\20130619ftp\UploadFileFrm.pas' {UploadFileForm},
  ZipClas in 'ZipClas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TUploadFileForm, UploadFileForm);
  Application.Run;
end.
