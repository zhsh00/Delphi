unit Unit44;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    edt1: TEdit;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    edt2: TEdit;
    edt3: TEdit;
    btn5: TButton;
    edt4: TEdit;
    edt5: TEdit;
    procedure btn1Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  int: Integer;
  str: string;
implementation

{$R *.dfm}

procedure TForm4.btn1Click(Sender: TObject);
begin
  int := StrToIntDef(edt1.Text, 0);
  //VirtualQueryEx()
end;

procedure TForm4.btn4Click(Sender: TObject);
begin
  edt4.Text := edt1.Text;
end;

procedure TForm4.btn2Click(Sender: TObject);
begin
  str := edt2.Text;
end;

procedure TForm4.btn3Click(Sender: TObject);
begin
  edt3.Text := str;
end;

procedure TForm4.btn5Click(Sender: TObject);
begin
  edt5.Text := IntToStr(int);
end;

end.
