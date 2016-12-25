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
{ Incompatible types: 'TB' and 'TA',说明不能父类的实例给子类的变量 }
//  FB := TA.create;
  FB := TC.Create;  //子类的实例可以给父类型的变量
  FB.FB := '朱绍林';
  ShowMessage(TC(FB).FB);//返回正确,TC.Caeate创建的实例转换为TC类型使用
  ShowMessage(FB.FB); //返回正确,直接使用，引用TB类声明的字段
  TA(FB).FA := '秋天雨露'; //转换为父类TA类型也能成功，但是只能使用TA类声明的字段
  ShowMessage(TA(FB).FA);
{ Undeclared indentifier: 'FC' TB类型的变量,虽然指向TC类型的实例, 却不能使用 TC
  类声明的字段}
//  FB.FC := 'qiutianyulu';
  TC(FB).FC := 'qiutianyulu'; //类型转换后OK，可以使用子类声明的字段
  ShowMessage(TC(FB).FC);
//  ShowMessage(FB.FC); //FB.FC 父类型的变量不能直接使用子类的字段
  FB.FA := 'ZhuShaolin'; //子类继承父类的属性、字段可以直接使用
  ShowMessage(FB.FA);
  FB.FA := 'FB.FA';
  FB.FB := 'FB.FB';
  ShowMessage(FB.FA + ' ' + FB.FB); //直接使用FB操作TB类声明的属性
  ShowMessage(TA(FB).FA); //转换为TA操作TA类声明的属性，！也可不转换！
  TC(FB).FC := 'TC(FB).FC';
{ 转换为TC类型操作所有属性，操作TC类声明的属性，必须转换 }
  ShowMessage(TC(FB).FA + ' ' + TC(FB).FB + ' ' + TC(FB).FC);
{ 否则提升FC 未声明 Undeclared indentifier 'FC' }
//  ShowMessage(TC(FB).FA + ' ' + TC(FB).FB + ' ' + FB.FC);

// 声明为子类型的变量不能赋值为父类型实例(指向父类型实例)，
// 但可以赋值为更子的类型的实例(指向更子的类型实例)
// 声明为子类型，但是指向更子的类型实例的变量：
// 1.可以直接只用，只能使用本层子类型声明的属性
// 2.可以转换为父类型使用，但是只能使用父类型声明的属性
// 3.可以转换为指向的具体实例的类类型使用，可以使用具体类型的所有属性，包括继承属性
// 4.可否转换为指向的具体实例的类型的更子的类型使用？
end;

end.
