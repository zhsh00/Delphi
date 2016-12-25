program ClassInfoInAnExe;

uses
  Forms,
  ClassInfoExFrm in 'ClassInfoExFrm.pas' {ClassInfoExForm},
  UnitClassInfoEx in 'UnitClassInfoEx.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TClassInfoExForm, ClassInfoExForm);
  Application.Run;
end.
