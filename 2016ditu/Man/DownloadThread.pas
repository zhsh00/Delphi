unit DownloadThread;

interface

uses
  Classes, Dialogs, DownloadFrm, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, SysUtils;

type
  TTestThread = class(TThread)
  private
    { Private declarations }
    FRowOffset: Integer;
    FLeftOffset: Integer;
    FRightOffset: Integer;
    FOwnerForm: TDownloadForm;
    FIdHTTP: TIdHTTP;
  protected
    procedure Execute; override;
    procedure DoDownload(url, name: string);
  public
    constructor Create(CreateSuspended: Boolean;
      ownerForm: TDownloadForm; currRowOffset, leftOffset,rightOffset: Integer); overload;
  end;

implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TestThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TestThread }

constructor TTestThread.Create(CreateSuspended: Boolean;
  ownerForm: TDownloadForm; currRowOffset, leftOffset, rightOffset: Integer);
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate := True;//
  FRowOffset := currRowOffset;
  FLeftOffset := leftOffset;
  FRightOffset := rightOffset;
  FOwnerForm := ownerForm;
  FIdHTTP := TIdHTTP.Create(nil);
  with FIdHTTP do
  begin//下面数据是从dfm文件中拷出来的
    //MaxLineAction := maException;//找不到ma...
    ReadTimeout := 0;
    AllowCookies := True;
    ProxyParams.BasicAuthentication := False;
    ProxyParams.ProxyPort := 0;
    Request.Connection := 'Keep-Alive';
    Request.ContentLength := -1;
    Request.ContentRangeEnd := 0;
    Request.ContentRangeStart := 0;
    Request.ContentType := 'text/html';
    Request.Accept := 'text/html, application/xhtml+xml, image/jxr, */*';
    Request.AcceptEncoding := 'gzip, deflate';
    Request.AcceptLanguage := 'zh-Hans-CN,zh-Hans;q=0.5';
    Request.BasicAuthentication := False;
    Request.UserAgent :=
      'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like ' +
      'Gecko';
    HTTPOptions := [hoForceEncodeParams];
  end;
end;

procedure TTestThread.DoDownload(url, name: string);
var
  streamTmp: TMemoryStream;
begin
  if FileExists(name) then Exit;
  streamTmp := TMemoryStream.Create;
  try
    try
      //注意：要设置属性TIdHTTPRequest，不然会报错
      FIdHTTP.Get(url, streamTmp);
    except
      FIdHTTP.DisconnectSocket;
      //ShowMessage('网络出错！');
      //网络的异常，什么都不做，因为到目前我不会
    end;
    streamTmp.SaveToFile(name);
  finally
    streamTmp.Free;
  end;
end;

procedure TTestThread.Execute;
var
  i: Integer;
  filedir, fileName, imageUrl, s:string;
begin
  filedir := FOwnerForm.SaveDir;
  for i := FLeftOffset to FRightOffset do
  begin
    if Terminated or FOwnerForm.MultiThreadStopFlag then Break;

    s := FOwnerForm.CalcImageName(FRowOffset, i);
    fileName := filedir + s;
    imageUrl := FOwnerForm.CalcImageUrl(FRowOffset, i);
    DoDownload(imageUrl,fileName);
  end;
end;

end.
