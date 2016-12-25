program test01;

uses
  Forms,
  testTreeView in 'testTreeView.pas' {testTreeViewForm},
  UPointerTestFrm in 'UPointerTestFrm.pas' {PointerTestForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TtestTreeViewForm, testTreeViewForm);
  Application.CreateForm(TPointerTestForm, PointerTestForm);
  Application.Run;
end.
