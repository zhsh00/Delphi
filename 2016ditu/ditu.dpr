program ditu;

uses
  Forms,
  DownloadFrm in 'Man\DownloadFrm.pas' {DownloadForm},
  DownloadThread in 'Man\DownloadThread.pas',
  DrawFrm in 'Man\DrawFrm.pas' {DrawForm},
  MainFrm in 'Man\MainFrm.pas' {MainForm},
  ChildFrm in '..\DDGPAINT\ChildFrm.pas' {ChildForm},
  LinkUtil in 'Man\LinkUtil.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
