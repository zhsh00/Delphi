unit UPointerTestFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  PPZH = ^PZH;
  PZH = ^TZH;
  TZH = record
    Name: string;
    Age: Byte;
    Like: string;
  end;

  TPointerTestForm = class(TForm)
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
    n1, n2, n3: string;
    FPointerTest1: Pointer;
  public
    { Public declarations }
    FList: TList;
    FList2: TList;
  end;

var
  PointerTestForm: TPointerTestForm;

implementation

{$R *.dfm}

procedure TPointerTestForm.btn1Click(Sender: TObject);
var
  i: Integer;
  strMsg, strAdd: string;
  mPointer: Pointer;
begin
  strMsg := '';
  strAdd := '';
  for i := 0 to FList.Count - 1 do
  begin
    strMsg := strMsg + string(FList[i]^) + #13;
    strAdd := strAdd + IntToStr(Cardinal(FList[i])) + #13;
  end;
  ShowMessage(strMsg);
  ShowMessage(strAdd);
end;

procedure TPointerTestForm.FormCreate(Sender: TObject);
begin
  FList := TList.Create;
  FList2 := TList.Create;
  n1 := 'ZhuShaolin';
  n2 := '������';
  n3 := 'ס����';
  FList.Add(@n1);
  FList.Add(@n2);
  FList.Add(@n3);
  FList2.Add(Self);
end;

procedure TPointerTestForm.FormDestroy(Sender: TObject);
begin
  FList.Destroy;
  FList2.Destroy;
end;

procedure TPointerTestForm.btn2Click(Sender: TObject);
begin
  FPointerTest1 := FList2[0];
  ShowMessage(TObject(FPointerTest1).classname);
end;

procedure TPointerTestForm.btn3Click(Sender: TObject);
var
  ZH: PZH;
  mPZH: PPZH;
begin
  ZH := New(PZH); // Delphi�����ڴ棬ͬ�����GetMen,AllocMen
  ZH.Name := '������';
  ZH.Age := 25;
  ZH.Like := 'Ů��';
  ShowMessage(zh.Name + #13 + zh.Like + #13 + IntToStr(zh.Age));
  mPZH := @ZH;
  mpzh^.Name := 'ס����';
  mpzh^.Age := 18;
  mpzh^.Like := '��Ů';
  //ShowMessage(mpzh^.Name + #13 + mpzh^.Like + #13 + IntToStr(mpzh^.Age));
  ShowMessage(zh.Name + #13 + zh.Like + #13 + IntToStr(zh.Age));
  mpzh^.Name := '��������';
  mpzh^.Age := 11;
  mpzh^.Like := 'day day up';
  ZH :=mpzh^;
  ShowMessage(zh.Name + #13 + zh.Like + #13 + IntToStr(zh.Age));
  Dispose(ZH);  // Delphi�ͷ��ڴ棬ͬ�����FreeMen,AllocMen?
end;

end.
