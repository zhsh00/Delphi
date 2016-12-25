program Project1;

uses
  Forms,
  UPubilcDefine in 'man\UPubilcDefine.pas',
  UReadMemoryFrm in 'Man\UReadMemoryFrm.pas' {ReadMemoryForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TReadMemoryForm, ReadMemoryForm);
  Application.Run;
end.
