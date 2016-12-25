unit DrawFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ChildFrm, FileCtrl;

type
  TDrawForm = class(TChildForm)
    btnDraw1png: TButton;
    btnDraw1Row: TButton;
    pnl1: TPanel;
    pnl2: TPanel;
    btn3: TButton;
    ScrollBox1: TScrollBox;
    btnSave: TButton;
    img: TImage;
    pnl3: TPanel;
    imgSave: TImage;
    stbMain: TStatusBar;
    btnDraw1Col: TButton;
    btnDraw: TButton;
    pnl5: TPanel;
    gb2: TGroupBox;
    gb1: TGroupBox;
    lbledtRight: TLabeledEdit;
    lbledtBottom: TLabeledEdit;
    lbledtLeft: TLabeledEdit;
    lbledtTop: TLabeledEdit;
    procedure btnDraw1pngClick(Sender: TObject);
    procedure btnDraw1RowClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure imgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnDraw1ColClick(Sender: TObject);
    procedure btnDrawClick(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
    left: Integer;
    right: Integer;
    top: Integer;
    bottom: Integer;

    procedure CheckCount;
  public
    { Public declarations }
  end;

var
  DrawForm: TDrawForm;

implementation
uses
  pngimage, jpeg;
{$R *.dfm}

procedure TDrawForm.btnDraw1pngClick(Sender: TObject);
var
  pngTmp: TPNGObject;
  d,src: TRect;
begin
  pngTmp := TPNGObject.Create;
  pngTmp.LoadFromFile('C:\Users\hasee\Desktop\ditu\01\001.jpg');
  //imgTmp.LoadFromFile('C:\Users\hasee\Desktop\ditu\r001\001.jpg');
  d.Left := 0;
  d.Top := 0;
  d.Right := 256;
  d.Bottom := 256;
  src := d;

  img.Canvas.Draw(0, 0, pngTmp);
  pngTmp.Free;
end;

procedure TDrawForm.btnDraw1RowClick(Sender: TObject);
var
  s, fileName: string;
  pngTmp: TPNGObject;
  d,src: TRect;
  i: Integer;
begin
  pngTmp := TPNGObject.Create;
  d.Left := 0;
  d.Top := 0;
  d.Right := 256;
  d.Bottom := 256;
  src := d;
  for i := top to bottom do
  begin
    s := Format('001%.3d',[i]);
    fileName := 'C:\Users\hasee\Desktop\ditu\01\' + s + '.png';
    pngTmp.LoadFromFile(fileName);

    img.Canvas.Draw((i - 1) * 256, 0, pngTmp);
    img.Canvas.TextOut(i * 256, 258, s);
  end;
  pngTmp.Free;
end;

procedure TDrawForm.imgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  stbMain.Panels[1].Text := Format('X: %d, Y: %D', [X, Y]);
end;

procedure TDrawForm.btnDraw1ColClick(Sender: TObject);
var
  s, fileName: string;
  pngTmp: TPNGObject;
  d,src: TRect;
  i: Integer;
begin
  pngTmp := TPNGObject.Create;
  d.Left := 0;
  d.Top := 0;
  d.Right := 256;
  d.Bottom := 256;
  src := d;
  for i := left to right do
  begin
    s := Format('%.3d001',[i]);
    fileName := 'C:\Users\hasee\Desktop\ditu\01\' + s + '.png';
    pngTmp.LoadFromFile(fileName);

    img.Canvas.Draw(0, (i - 1) * 256, pngTmp);
    img.Canvas.TextOut(258, i * 256, s);
  end;
  pngTmp.Free;
end;

procedure TDrawForm.btnSaveClick(Sender: TObject);
var
  d,src: TRect;
begin
  CheckCount;
  d.Left := 0;
  d.Top := 0;
  d.Right := 256 * (right - left + 1);
  d.Bottom := 256 * (bottom - top + 1);
  src := d;
  imgSave.Width := d.Right;
  imgSave.Height := d.Bottom;
  imgSave.Canvas.CopyRect(d, img.Canvas, src);
  imgSave.Picture.SaveToFile('C:\Users\hasee\Desktop\ditu\t5h.bmp');
end;

procedure TDrawForm.btnDrawClick(Sender: TObject);
var
  s, fileName: string;
  pngTmp: TPNGObject;
  row, col: Integer;
  i, j: Integer;
begin
  Self.btn3Click(nil);
  CheckCount;
  //设置Image大小
  i := 256 * (right - left + 1);
  j := 256 * (bottom - top + 1);
  pnl2.Width := i + 10;
  pnl2.Height := j + 10;
  img.Width := i;
  img.Height := j;
  pngTmp := TPNGObject.Create;
  for col := left to right do
    for row := top to bottom do
    begin
      s := Format('%.3d%.3d',[row, col]);
      fileName := 'C:\Users\hasee\Desktop\ditu\01\' + s + '.png';
      //如果文件不存则不画，在Image上留下一个空白，便于查询，也不会报错
      if not FileExists(fileName) then Continue;
      pngTmp.LoadFromFile(fileName);
      img.Canvas.Draw((col - left) * 256, (row - top) * 256, pngTmp);
    end;
  pngTmp.Free;
end;

procedure TDrawForm.btn3Click(Sender: TObject);
begin
  inherited;
  left := StrToIntDef(lbledtLeft.Text, 0);
  right := StrToIntDef(lbledtRight.Text, 0);
  top := StrToIntDef(lbledtTop.Text, 0);
  bottom := StrToIntDef(lbledtBottom.Text, 0);
end;

procedure TDrawForm.CheckCount;
begin
  if ((right -left + 1)= 0) or ((bottom - top + 1) = 0) then
  raise Exception.Create('行、列范围值不能为0！');;
end;

end.
