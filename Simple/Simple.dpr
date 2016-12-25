program Simple;

uses
  ExceptionLog,
  Forms,
  MainFrm in 'MainFrm.pas' {MainForm},
  ChildFrm in 'ChildFrm.pas' {ChildForm},
  NewChildFrm in 'NewChildFrm.pas' {NewChildForm},
  CheckBinaryDfmFrm in 'CheckBinaryDfmFrm.pas' {CheckBinaryDfmForm},
  DirSearchFrm in 'DirSearchFrm.pas' {DirSearchForm},
  ExplorerFrm in 'ExplorerFrm.pas' {ExplorerForm},
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Variables in 'Variables.pas',
  testTreeView in 'testTreeView.pas' {testTreeViewForm},
  InheritTestFrm in 'InheritTestFrm.pas' {InheritTestForm},
  UMessageTestFrm in 'UMessageTestFrm.pas' {UMessageTestForm},
  ReNameFrm in 'ReNameFrm.pas' {ReNameForm},
  Util in 'Util.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TtestTreeViewForm, testTreeViewForm);
  Application.CreateForm(TReNameForm, ReNameForm);
  Application.Run;
end.
