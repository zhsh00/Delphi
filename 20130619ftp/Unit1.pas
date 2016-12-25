unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdFTP;

type
  TForm1 = class(TForm)
    IdFTP1: TIdFTP;
    btn1: TButton;
    mm1: TMemo;
    edt1: TEdit;
    btn2: TButton;
    lbl1: TLabel;
    btn3: TButton;
    OpenDialog1: TOpenDialog;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure IdFTP1Status(axSender: TObject; const axStatus: TIdStatus;
      const asStatusText: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses IdFTPList, IdFTPCommon;
{$R *.dfm}
{
��������һ��ftp  demo��������windows��Ϣ�����ڱ���������һ��ftp����
����IP��192.168.10.99
�û�����cc
���룺1
}
procedure TForm1.btn1Click(Sender: TObject);
var
  tr : Tstrings;
begin  //����
  tr := TStringlist.Create;
  IdFTP1.Host := '192.168.1.107'; //FTP��������ַ
  IdFTP1.UserName := '0'; //FTP�������û���
  IdFTP1.Password := '4321'; //FTP����������
  IdFTP1.Connect();  //���ӵ�ftp
  edt1.Text := IdFTP1.RetrieveCurrentDir;//�õ���ʼĿ¼
  IdFTP1.ChangeDir('BB'); //���뵽client��Ŀ¼
  //IdFTP1.ChangeDir('..'); //�ص���һ��Ŀ¼
  IdFTP1.List(tr); //�õ�clientĿ¼�������ļ��б�
  mm1.Lines.Assign(tr);
  tr.Free;
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  tt :TIdFTPListItems;
  t : TIdFTPListItem;
  i : integer;
  tfname : String;
begin  //����
  lbl1.Caption := IdFTP1.DirectoryListing.Items[0].FileName;
  IdFTP1.TransferType := ftBinary; //ָ��Ϊ�������ļ�  ���ı��ļ�ftASCII
  for i:=0 to IdFTP1.DirectoryListing.Count-1 do
  begin
    tt := IdFTP1.DirectoryListing; //�õ���ǰĿ¼���ļ���Ŀ¼�б�
    t := tt.Items[i]; //�õ�һ���ļ������Ϣ
    lbl1.Caption :=t.Text;  //ȡ��һ���ļ���Ϣ����
    tfname := t.FileName;
    showmessage(t.OwnerName+'  '+t.GroupName+'  '+t.FileName+'  '+t.LinkedItemName);
    if IdFTP1.DirectoryListing.Items[i].ItemType = ditFile then //������ļ�
    begin
      IdFTP1.Get(tfname,'D:\FtpTest\'+tfname,True,False); //���ص����أ���Ϊ���ǣ���֧�ֶϵ�����
//�����ֳֶϵ������������⣬ֻ��һ��Ϊ��
    end;
  end;
end;

procedure TForm1.btn3Click(Sender: TObject);
var
  fi : string;
begin  //�ϴ�
  if OpenDialog1.Execute then
  begin
    fi := OpenDialog1.FileName;
    IdFTP1.Put('D:\Resourse\delphi\0619ftp\Project1.rar','CC\Project1.txt');//�ϴ���
  end;
end;

procedure TForm1.IdFTP1Status(axSender: TObject; const axStatus: TIdStatus;
  const asStatusText: String);
begin
  {case  AStatus of
    hsResolving  : showmessage('hsResolving');
    hsConnecting: showmessage('hsConnecting');
    hsConnected: showmessage('hsConnected');
    hsDisconnecting: showmessage('hsDisconnecting');
    hsDisconnected: showmessage('hsDisconnected');
    hsStatusText: showmessage('hsStatusText');  
    ftpTransfer: showmessage('�ļ�������ϡ�');
    ftpReady: showmessage('׼�������ļ�....');
    ftpAborted: showmessage('����ʧ��');
  end;        }
  //showmessage(AStatusText);
end;

end.
