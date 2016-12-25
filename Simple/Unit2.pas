unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    btn1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FForm: TForm2;

function Form2: TForm2;

implementation

{$R *.dfm}

function Form2: TForm2;
begin
  if( FForm = Nil ) then
    FForm := TForm2.Create(Application.MainForm);
  result := FForm;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
  FForm := nil;
end;

procedure TForm2.btn1Click(Sender: TObject);
var
  Form: TForm;
begin
  FForm := TForm2.Create(Application.MainForm);
  FForm.show;
end;

initialization
  FForm := nil;
end.
