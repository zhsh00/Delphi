unit UMessageTestFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

const
  WM_ZHTest = WM_USER + 1000;

type
  TUMessageTestForm = class(TForm)
    btn1: TButton;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure SetButtonCaption(var Msg: TMessage); message WM_ZHTest;
    procedure MySetButtonCaption;
//    procedure MyWhenWMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure MyWMShowWindow(var Message: TWMShowWindow); message WM_SHOWWINDOW;
  public
    { Public declarations }
  end;

var
  UMessageTestForm: TUMessageTestForm;
  UMessageTestFormHandle: THandle;
implementation

{$R *.dfm}

procedure TUMessageTestForm.btn1Click(Sender: TObject);
begin
  SendMessagew(UMessageTestFormHandle, WM_ZHTest, 0, 0);
end;

procedure TUMessageTestForm.FormShow(Sender: TObject);
begin
  UMessageTestFormHandle := Handle;
end;

procedure TUMessageTestForm.MySetButtonCaption;
begin
  btn1.Caption := '朱绍林';
end;

{procedure TUMessageTestForm.MyWhenWMPaint(var Message: TWMPaint);
begin
  ShowMessage(Format('接收到消息%d！', [integer(WM_PAINT)]));
end; }

procedure TUMessageTestForm.MyWMShowWindow(var Message: TWMShowWindow);
begin
  ShowMessage(Format('接收到消息%d！', [integer(WM_SHOWWINDOW)]));
end;

procedure TUMessageTestForm.SetButtonCaption(var Msg: TMessage);
begin
  MySetButtonCaption;
end;

end.
