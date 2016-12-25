program PZip;

uses
  ExceptionLog,
  Forms,
  ccuUtils in '..\PUBLIC\ccuUtils.pas',
  Zipfrm in 'ZipFrm.pas' {ZipForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TZipForm, ZipForm);
  Application.Run;
end.
