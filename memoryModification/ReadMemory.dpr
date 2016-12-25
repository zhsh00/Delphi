program ReadMemory;

uses
  Forms,
  ReadMemoryFrm in 'man\ReadMemoryFrm.pas' {ReadMemoryForm},
  funcs in 'man\funcs.pas',
  threads in 'man\threads.pas',
  Variables in 'man\Variables.pas',
  utils in 'man\utils.pas',
  BaseFrm in 'Man\BaseFrm.pas' {BaseForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TReadMemoryForm, ReadMemoryForm);
  Application.CreateForm(TBaseForm, BaseForm);
  Application.Run;
end.
