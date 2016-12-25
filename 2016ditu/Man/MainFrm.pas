unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    pgc: TPageControl;
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    procedure CreateForm(className: string);
    function IsTabExists(name: string): boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
  LinkUtil, DownloadFrm, DrawFrm;

{$R *.dfm}

function TMainForm.IsTabExists(name: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to pgc.PageCount -1 do
    //这里两个string可以直接使用=，不错不错，这是为什么呢？什么情况下可以呢？
    if (pgc.Pages[i].Name = name) then
    begin
      Result := True;
      pgc.ActivePageIndex := i;
      Exit;
    end;
end;

procedure TMainForm.CreateForm(className: string);
var
  tabTmp: TTabSheet;
  formTmp: TForm;
  formClass: TFormClass;
  tabName: string;
begin
  tabName := Copy(className, 2, Length(className));
  if IsTabExists(tabName) then Exit;
  tabTmp := TTabSheet.Create(pgc);
  tabTmp.Parent := pgc;
  tabTmp.PageControl := pgc;
  tabTmp.Name := Format('%s',[tabName]);
  //设置为当前页，找了好久
  pgc.ActivePage := tabTmp;
  //LoadLibrary('D:\Delphi\2016ditu\package\ditu.exe');
  //1.需要注册类，才能使用GetClass()方法；
  //2.要想能调试进内核代码，需要在搜索路径加上内核代码的路径；
  formClass := TFormClass(GetClass(className));
  formTmp := formClass.Create(Application);
  formTmp.BorderStyle := bsNone;
  formTmp.Parent := tabTmp;
  formTmp.Align := alClient;
  formTmp.Show;
end;

procedure TMainForm.N2Click(Sender: TObject);
begin
  CreateForm('TDownloadForm');
end;

procedure TMainForm.N3Click(Sender: TObject);
begin
  CreateForm('TDrawForm');
end;

end.
