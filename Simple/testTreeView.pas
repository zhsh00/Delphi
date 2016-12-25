unit testTreeView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TtestTreeViewForm = class(TForm)
    tv1: TTreeView;
    edt1: TEdit;
    btn1: TButton;
    procedure edt1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tv1AdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  testTreeViewForm: TtestTreeViewForm;

implementation

uses UPointerTestFrm;

{$R *.dfm}

function GetNextPart(var str: string; Sep1: char = char(9);
  Sep2: char = ','; Position: integer = 1): string;
var
  intPos: integer;
begin
  intPos := pos(Sep1, str);
  if (intPos = 0) and (Sep2 <> '') then
    intPos := pos(Sep2, str);
  if intPos > 0 then
  begin
    result := Copy(str, 1, intPos - 1);
    Delete(str, 1, intPos);
  end
  else
  begin
    result := str;
    str := '';
  end;
  if (intPos > 0) and (Position > 1) then
    result := GetNextPart(str, Sep1, Sep2, Position - 1);
end;


procedure TtestTreeViewForm.edt1Change(Sender: TObject);
var
  i: integer;
  IntSearch, IntTmp: integer;
  strTmp: string;
begin
  IntSearch := strtointdef(edt1.text, 0);
  if IntSearch <> 0 then
  begin
    for i := 0 to tv1.Items.Count - 1 do
    begin
      strTmp := tv1.Items.Item[i].Text;
      strTmp := getnextpart(strTmp, ' ');
      IntTmp := strtointdef(strTmp, 0);
      if IntSearch = IntTmp then
      begin
        tv1.Select(tv1.Items.item[i]);
      end;
    end;
  end;
end;

procedure TtestTreeViewForm.FormCreate(Sender: TObject);
begin
  tv1.FullExpand;
end;

procedure TtestTreeViewForm.tv1AdvancedCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
  var PaintImages, DefaultDraw: Boolean);
begin
  if TTreeView(sender).Selected = Node then
    Sender.Canvas.Brush.Color := clblue;
end;

procedure TtestTreeViewForm.btn1Click(Sender: TObject);
begin
  PointerTestForm := TPointerTestForm.Create(Self);
  PointerTestForm.show;
end;

end.
