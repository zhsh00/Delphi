unit InheritTestFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

const
  mySplitter = '--------------';

type
  TInheritTestForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    btn7: TButton;
    btn8: TButton;
    btn9: TButton;
    pnl1: TPanel;
    btn10: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure btn10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TA = class;
  TB = class;
  TC = class;

  TA = class(TObject)
  public
    FA: string;
    FInt: Integer;
    FObject: TObject;
    procedure Proc(AStr: string); virtual;
    function FunIntToStr(AInt: integer): string; virtual;
    procedure callbyProc(AStr: string); virtual;
  end;

  TB = class(TA)
  public
    FB: string;
    FIntB: Integer;
    FObjectB: TObject;
    procedure Proc(AStr: string); override;
    function FunIntToStr(AInt: integer): string; override;
    procedure ProcOnlyB(AStr: string);
    procedure ProcOnlyB2(AStr: string);
    procedure callbyProc(AStr: string); override;
  end;

  TC = class(TB)
  public
    FC: string;
    FIntC: Integer;
    FObjectC: TObject;
    procedure Proc(AStr: string); override;
    function FunIntToStr(AInt: integer): string; override;
    procedure ProcOnlyC(AStr: string);
    procedure callbyProc(AStr: string); override;
  end;
var
  InheritTestForm: TInheritTestForm;
  FA: TA;
  FB: TB;
  FC: TC;
implementation

{$R *.dfm}

{ TA }

procedure TA.callbyProc(AStr: string);
begin
  ShowMessage('A Objtect of ' + Self.ClassName + #13 + 'TA.callbyProc' + #13 +
    mySplitter + #13 + AStr);
end;

function TA.FunIntToStr(AInt: integer): string;
begin
  ShowMessage('A Objtect of ' + Self.ClassName + #13 + 'TA.FunIntToStr' + #13 +
    IntToStr(Aint));
  Result := 'A Objtect of ' + Self.ClassName + #13 + IntToStr(Aint);
end;

procedure TA.Proc(AStr: string);
var
  str: string;
begin
  str := 'A Objtect of ' + Self.ClassName + #13 + 'TA.Proc' + #13 + mySplitter +
    #13 + AStr;
  callbyProc(str);
  //ShowMessage(Self.ClassName + #13 + 'TA.Proc' + #13 + AStr);
end;

{ TB }

procedure TB.callbyProc(AStr: string);
begin
  inherited;
  ShowMessage('A Objtect of ' + Self.ClassName + #13 + 'TB.callbyProc' + #13 +
    mySplitter + #13 + AStr);
end;

function TB.FunIntToStr(AInt: integer): string;// override;
begin
  inherited FunIntToStr(AInt);
  ShowMessage('A Objtect of ' + Self.ClassName + #13 + 'TB.FunIntToStr' + #13 +
    IntToStr(Aint));
  Result := Self.ClassName + #13 + IntToStr(Aint);
end;

procedure TB.Proc(AStr: string);// override;
var
  str: string;
begin
  inherited;
  str := 'A Objtect of ' + Self.ClassName + #13 + 'TB.Proc' + #13 + mySplitter +
    #13 + AStr;
  callbyProc(str);
end;

procedure TB.ProcOnlyB(AStr: string);
begin
  inherited Proc(AStr);
  ShowMessage('A Objtect of ' + Self.ClassName + #13 + 'TB.ProcOnlyB' + #13 +
    AStr);
end;

procedure TB.ProcOnlyB2(AStr: string);
begin
  inherited;
  ShowMessage('A Objtect of ' + Self.ClassName + #13 + 'TB.ProcOnlyB2' + #13 +
    AStr);
end;

{ TC }

procedure TC.callbyProc(AStr: string);
begin
  inherited;

end;

function TC.FunIntToStr(AInt: integer): string;
begin
  ShowMessage('A Objtect of ' + Self.ClassName + #13 + 'TC.FunIntToStr' + #13 +
    IntToStr(Aint));
  Result := Self.ClassName + #13 + IntToStr(Aint);
end;

procedure TC.Proc(AStr: string);
begin
  ShowMessage('A Objtect of ' + Self.ClassName + #13 + 'TC.Proc' + #13 + AStr);
end;

procedure TC.ProcOnlyC(AStr: string);
begin
  inherited;
  ShowMessage('A Objtect of ' + Self.ClassName + #13 + 'TC.ProcOnlyC' + #13 +
    AStr);
end;

procedure TInheritTestForm.FormCreate(Sender: TObject);
begin
  FA := TA.Create;
  FB := TB.Create;
  FC := TC.Create;
end;

procedure TInheritTestForm.FormDestroy(Sender: TObject);
begin
  FA.Free;
  FB.Free;
  FC.Free;
end;

procedure TInheritTestForm.btn1Click(Sender: TObject);
begin
  FA.FunIntToStr(100);
end;

procedure TInheritTestForm.btn2Click(Sender: TObject);
begin
  FA.Proc(TButton(Sender).Caption);
end;

procedure TInheritTestForm.btn3Click(Sender: TObject);
begin
  FB.FunIntToStr(1000);
end;

procedure TInheritTestForm.btn4Click(Sender: TObject);
begin
  FB.Proc(TButton(Sender).Caption);
end;

procedure TInheritTestForm.btn5Click(Sender: TObject);
begin
  FB.ProcOnlyB(TButton(Sender).Caption);
end;

procedure TInheritTestForm.btn6Click(Sender: TObject);
begin
  FC.FunIntToStr(10000);
end;

procedure TInheritTestForm.btn7Click(Sender: TObject);
begin
  FC.Proc(TButton(Sender).Caption);
end;

procedure TInheritTestForm.btn8Click(Sender: TObject);
begin
  FC.ProcOnlyC(TButton(Sender).Caption);
end;

procedure TInheritTestForm.btn9Click(Sender: TObject);
begin
  FB.ProcOnlyB2(TButton(Sender).Caption);
end;

procedure TInheritTestForm.btn10Click(Sender: TObject);
begin
{ Incompatible types: 'TB' and 'TA',˵�����ܸ����ʵ��������ı��� }
//  FB := TA.create;
  FB := TC.Create;  //�����ʵ�����Ը������͵ı���
  FB.FB := '������';
  ShowMessage(TC(FB).FB);//������ȷ,TC.Caeate������ʵ��ת��ΪTC����ʹ��
  ShowMessage(FB.FB); //������ȷ,ֱ��ʹ�ã�����TB���������ֶ�
  TA(FB).FA := '������¶'; //ת��Ϊ����TA����Ҳ�ܳɹ�������ֻ��ʹ��TA���������ֶ�
  ShowMessage(TA(FB).FA);
{ Undeclared indentifier: 'FC' TB���͵ı���,��Ȼָ��TC���͵�ʵ��, ȴ����ʹ�� TC
  ���������ֶ�}
//  FB.FC := 'qiutianyulu';
  TC(FB).FC := 'qiutianyulu'; //����ת����OK������ʹ�������������ֶ�
  ShowMessage(TC(FB).FC);
//  ShowMessage(FB.FC); //FB.FC �����͵ı�������ֱ��ʹ��������ֶ�
  FB.FA := 'ZhuShaolin'; //����̳и�������ԡ��ֶο���ֱ��ʹ��
  ShowMessage(FB.FA);
  FB.FA := 'FB.FA';
  FB.FB := 'FB.FB';
  ShowMessage(FB.FA + ' ' + FB.FB); //ֱ��ʹ��FB����TB������������
  ShowMessage(TA(FB).FA); //ת��ΪTA����TA�����������ԣ���Ҳ�ɲ�ת����
  TC(FB).FC := 'TC(FB).FC';
{ ת��ΪTC���Ͳ����������ԣ�����TC�����������ԣ�����ת�� }
  ShowMessage(TC(FB).FA + ' ' + TC(FB).FB + ' ' + TC(FB).FC);
{ ��������FC δ���� Undeclared indentifier 'FC' }
//  ShowMessage(TC(FB).FA + ' ' + TC(FB).FB + ' ' + FB.FC);

// ����Ϊ�����͵ı������ܸ�ֵΪ������ʵ��(ָ������ʵ��)��
// �����Ը�ֵΪ���ӵ����͵�ʵ��(ָ����ӵ�����ʵ��)
// ����Ϊ�����ͣ�����ָ����ӵ�����ʵ���ı�����
// 1.����ֱ��ֻ�ã�ֻ��ʹ�ñ�������������������
// 2.����ת��Ϊ������ʹ�ã�����ֻ��ʹ�ø���������������
// 3.����ת��Ϊָ��ľ���ʵ����������ʹ�ã�����ʹ�þ������͵��������ԣ������̳�����
// 4.�ɷ�ת��Ϊָ��ľ���ʵ�������͵ĸ��ӵ�����ʹ�ã�
end;

end.
