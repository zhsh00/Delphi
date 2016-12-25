unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    btnShowAForm: TButton;
    btn1: TButton;
    procedure btnShowAFormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses Unit2;
{$R *.dfm}

procedure TForm1.btnShowAFormClick(Sender: TObject);
var
  Form: TForm;
begin
  Form := TForm.Create(self);
  try
    if form.showmodal = mrOK then
      showmessage('OK');
  finally
    Form.Free;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  FForm := TForm2.Create(Application.MainForm);
  FForm.show;
end;

end.
