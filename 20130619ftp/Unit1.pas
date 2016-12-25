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
本程序是一个ftp  demo程序，我用windows信息服务在本机建立了一个ftp服务，
本机IP：192.168.10.99
用户名：cc
密码：1
}
procedure TForm1.btn1Click(Sender: TObject);
var
  tr : Tstrings;
begin  //连接
  tr := TStringlist.Create;
  IdFTP1.Host := '192.168.1.107'; //FTP服务器地址
  IdFTP1.UserName := '0'; //FTP服务器用户名
  IdFTP1.Password := '4321'; //FTP服务器密码
  IdFTP1.Connect();  //连接到ftp
  edt1.Text := IdFTP1.RetrieveCurrentDir;//得到初始目录
  IdFTP1.ChangeDir('BB'); //进入到client子目录
  //IdFTP1.ChangeDir('..'); //回到上一级目录
  IdFTP1.List(tr); //得到client目录下所有文件列表
  mm1.Lines.Assign(tr);
  tr.Free;
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  tt :TIdFTPListItems;
  t : TIdFTPListItem;
  i : integer;
  tfname : String;
begin  //下载
  lbl1.Caption := IdFTP1.DirectoryListing.Items[0].FileName;
  IdFTP1.TransferType := ftBinary; //指定为二进制文件  或文本文件ftASCII
  for i:=0 to IdFTP1.DirectoryListing.Count-1 do
  begin
    tt := IdFTP1.DirectoryListing; //得到当前目录下文件及目录列表
    t := tt.Items[i]; //得到一个文件相关信息
    lbl1.Caption :=t.Text;  //取出一个文件信息内容
    tfname := t.FileName;
    showmessage(t.OwnerName+'  '+t.GroupName+'  '+t.FileName+'  '+t.LinkedItemName);
    if IdFTP1.DirectoryListing.Items[i].ItemType = ditFile then //如果是文件
    begin
      IdFTP1.Get(tfname,'D:\FtpTest\'+tfname,True,False); //下载到本地，并为覆盖，且支持断点续传
//覆盖又持断点续传会有问题，只能一个为真
    end;
  end;
end;

procedure TForm1.btn3Click(Sender: TObject);
var
  fi : string;
begin  //上传
  if OpenDialog1.Execute then
  begin
    fi := OpenDialog1.FileName;
    IdFTP1.Put('D:\Resourse\delphi\0619ftp\Project1.rar','CC\Project1.txt');//上传，
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
    ftpTransfer: showmessage('文件传送完毕。');
    ftpReady: showmessage('准备传送文件....');
    ftpAborted: showmessage('传送失败');
  end;        }
  //showmessage(AStatusText);
end;

end.
