unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

const
  kt = 'kt';
  rd = 'rd';
  jd = 'jd';
  mz = 'mz';
type
  sbSubBranch = (kt, rd, jd , mz);

  TForm3 = class(TForm)
    btn1: TButton;
    lvdetail: TListView;
    btnTestCase: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btnTestCaseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//function GetSubBranch: Integer; overload;
function GetSubBranch(ASubBranch: String): Integer;// overload;

var
  Form3: TForm3;

implementation

{$R *.dfm}

function GetSubBranch(ASubBranch: String): Integer;
const
  ISubBranch: array[sbSubBranch] of Integer = (1, 2, 3, 4);
begin
  result := ISubBranch[ASubBranch];
end;

function AddAListItem({intImgIndex: integer;}
  Values: array of string; SubImgIndexs: array of integer;
  {intStaIndex: integer; }LV: TListView; Data: Pointer = nil;
  InsertIndex: integer = -1): TListItem;
var                                                             :
  i: integer;
  bHasSubImg: Boolean;
begin

  if High(SubImgIndexs) = -1 then
    bHasSubImg := False
  else
    bHasSubImg := True;

  if InsertIndex = -1 then
    result := TListItem(LV.items.Add)
  else
    result := TListItem(LV.items.Insert(InsertIndex));
  with result do
  begin
    Caption := Values[Low(Values)];
    //ImageIndex := intImgIndex;
    //StateIndex := intStaIndex;
    for i := Low(Values) + 1 to High(Values) do
    begin
      SubItems.Add(Values[i]);
      if bHasSubImg then
        SubItemImages[i - 1] := SubImgIndexs[i - 1];
    end;
  end;
  Result.Data := Data;
end;

procedure TForm3.btn1Click(Sender: TObject);
var
  FSearchRec, DsearchRec: TSearchRec;
  FindResult: Integer;
begin
  FindResult := FindFirst('D:\AA\BB\',faAnyFile,FSearchRec);
  try
    while FindResult = 0 do
    begin
      AddAListItem([LowerCase('D:\AA\' + FSearchRec.Name)],[],lvDetail);
      FindResult := FindNext(FSearchRec);
    end;
    finally
      FindClose(FSearchRec);
    end;
end;

procedure TForm3.btnTestCaseClick(Sender: TObject);
var
  I: Integer;
begin
  I := 2;
  case I of
  1:
    ShowMessage('1');
  2:
    ShowMessage('2');
  3:
    ShowMessage('3');
  else ShowMessage('else');
  end;
end;

end.
