unit CheckBinaryDfmFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ChildFrm, StdCtrls;

type
  TCheckBinaryDfmForm = class(TChildForm)
    mm1: TMemo;
    dlgOpen1: TOpenDialog;
    edt1: TEdit;
    lblFolder: TLabel;
    btnCheck: TButton;
    btnTextTest: TButton;
    btnReadDfm: TButton;
    procedure btnCheckClick(Sender: TObject);
    procedure btnTextTestClick(Sender: TObject);
    procedure btnReadDfmClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CheckBinaryDfmForm: TCheckBinaryDfmForm;

implementation

{$R *.dfm}

procedure TCheckBinaryDfmForm.btnCheckClick(Sender: TObject);
var
  StrFolder: string;
begin
  inherited;
  if edt1.Text <> '' then
  begin

  end;
end;

procedure TCheckBinaryDfmForm.btnTextTestClick(Sender: TObject);
var
  MyTextFile: TextFile;
  S: string;
  i: Integer;
begin
  AssignFile(MyTextFile, 'MyTextFile.txt');
  Rewrite(MyTextFile);
  try
    for i := 1 to 5 do
    begin
      S := 'This is Line $ ';
      Writeln(MyTextFile, S, i);
    end;
  finally
    CloseFile(MyTextFile);
  end;
end;

procedure TCheckBinaryDfmForm.btnReadDfmClick(Sender: TObject);
var
  UnTypeFile: File;
  Buffer: array[0..128] of Byte;
  NumRecsRead: Integer;
begin
  //inherited;
  AssignFile(UnTypeFile, edt1.Text);
  Reset(UnTypeFile);
  try
    BlockRead(UnTypeFile, Buffer, 1, NumRecsRead);
    if Buffer[0] = 255 then
      mm1.Lines.Add('FF');
    if Buffer[1] = 10 then
      mm1.Lines.Add('A0');
    if Buffer[2] = 0 then
      mm1.Lines.Add('00');
  finally
    CloseFile(UnTypeFile);
  end;
end;

end.
