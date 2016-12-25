unit ClassInfoExFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TClassInfoExForm = class(TForm)
    btn1: TButton;
    mm1: TMemo;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClassInfoExForm: TClassInfoExForm;

implementation

{$R *.dfm}

uses
  UnitClassInfoEx, TypInfo;

procedure TClassInfoExForm.btn1Click(Sender: TObject);
var
  p: PTypeInfos;
begin
  p := GetAllClassInfos_FromSystemModuleList
end;

end.
