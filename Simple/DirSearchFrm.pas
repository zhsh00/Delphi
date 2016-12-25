unit DirSearchFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ChildFrm, StdCtrls, Grids, Outline, DirOutln, FileCtrl, ImgList;

type
  TDirSearchForm = class(TChildForm)
    drvcbb1: TDriveComboBox;
    ListBox1: TListBox;
    dirol1: TDirectoryOutline;
    lblFileMask: TLabel;
    edtFileMask: TEdit;
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
    procedure drvcbb1Change(Sender: TObject);
  private
    { Private declarations }
    FFileName: string;
    function GetDirectoryName(Dir: string): string;
    procedure FindFiles(Apath: string);
  public
    { Public declarations }
  end;

var
  DirSearchForm: TDirSearchForm;

implementation

{$R *.dfm}

procedure TDirSearchForm.btn1Click(Sender: TObject);
begin
  //inherited;
  Screen.Cursor := crHourGlass;
  try
    ListBox1.Items.Clear;
    FFileName := edtFileMask.Text;
    FindFiles(dirol1.Directory);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDirSearchForm.drvcbb1Change(Sender: TObject);
begin
  //inherited;
  dirol1.Drive := drvcbb1.Drive;
end;

procedure TDirSearchForm.FindFiles(Apath: string);
var
  FSearchRec, DsearchRec: TSearchRec;
  FindResult: Integer;

  function IsDirNotation(ADirName: string): Boolean;
  begin
    Result := (ADirName = '.') or (ADirName = '..');
  end;

begin
  Apath := GetDirectoryName(Apath);
  FindResult := FindFirst(Apath + FFileName, faAnyFile + faHidden + faSysFile +
                          faReadOnly, FSearchRec);
  try
    while FindResult = 0 do
    begin
      ListBox1.Items.Add(LowerCase(Apath + FSearchRec.Name));
      FindResult := FindNext(FSearchRec);
    end;
    FindResult := FindFirst(Apath + '*.*', faDirectory, DSearchRec);

    while FindResult = 0 do
    begin
      if ((DSearchRec.Attr and faDirectory) = faDirectory) and not
         IsDirNotation(DsearchRec.Name) then
         FindFiles(Apath + DSearchRec.Name);
      FindResult := FindNext(DsearchRec);
    end;
    finally
      FindClose(FSearchRec);
    end;
end;

function TDirSearchForm.GetDirectoryName(Dir: string): string;
begin
  if Dir[Length(Dir)] <> '\' then
    Result := Dir + '\'
  else
    Result := Dir;
end;

end.
