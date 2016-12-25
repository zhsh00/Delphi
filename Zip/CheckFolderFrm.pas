unit CheckFolderFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UniDialogs, ccuDialogs, StdCtrls, UniCodeStdCtrls, ccuLabel,
  Mask, ccuMaskEdit, ccuCustomComboEdit, ccuDropDownEdit, ccuButtonEdit;

type
  TCheckFolderForm = class(TForm)
    bedt1: TccuButtonEdit;
    bedt2: TccuButtonEdit;
    lbl1: TccuLabel;
    dlg1: TccuOpenDialog;
    procedure bedt1ButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  Form1: TForm1;
// Typ=1,OpenDialog;2,输入文件夹名字
function ShowCheckFolderForm(Typ: Integer; InitDir: WideString = ''): Boolean;

implementation

{$R *.dfm}

function ShowCheckFolderForm(Typ: Integer; InitDir: WideString = ''): Boolean;
begin
  with TCheckFolderForm.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TCheckFolderForm.bedt1ButtonClick(Sender: TObject);
begin
  with dlg1 do
    if Execute then
    begin

    end;
end;

end.
