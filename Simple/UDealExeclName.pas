unit UDealExeclName;
//ϵͳ����ʶ���û��ļ�������һ����ֵ��ַ�����������ո�widechar=160
//���Ŀո��Ӣ�Ŀո�һ��32
//ȫ�ǿո�12288

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UniDialogs, ccuDialogs, Mask, ccuMaskEdit,
  ccuCustomComboEdit, ccuDropDownEdit, ccuButtonEdit;

type
  TDealExeclNameForm = class(TForm)
    dlg1: TccuOpenDialog;
    btn1: TButton;
    bedt1: TccuButtonEdit;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DealExeclNameForm: TDealExeclNameForm;

implementation

{$R *.dfm}

procedure TDealExeclNameForm.btn1Click(Sender: TObject);
var
  strTmp, strTmp2: widestring;
  i, j: Integer;
  wh: WideChar;
begin
  with dlg1 do
  if execute then
  try
    for i := 0 to Files.Count - 1 do
    begin
      strTmp := Files[i];
//      strTmp2 := wideExtractFileName(Files[i]);
      for j := 30 to Length(strTmp) do
      begin
        wh := strtmp[j];
        wideShowMessage(
          'M'+widestring(wh)+'M'+inttostr(Ord(wh))+#13#10);
      end;
    end;
  finally
  end;
end;

procedure TDealExeclNameForm.btn2Click(Sender: TObject);
var
  strTmp, strTmp2: widestring;
  i, j: Integer;
  wh: WideChar;
begin
  for j := 0 to Length(bedt1.Text) do
  begin
    wh := bedt1.Text[j];
    wideShowMessage(
      'M'+widestring(wh)+'M'+inttostr(Ord(wh))+#13#10);
  end;
end;

end.
