unit DownloadFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, ChildFrm, FileCtrl, ComCtrls;

type
  TDownloadForm = class(TChildForm)
    pnl1: TPanel;
    pnl2: TPanel;
    gb1: TGroupBox;
    gb3: TGroupBox;
    btnDown: TButton;
    btnTest: TButton;
    IdHTTP1: TIdHTTP;
    btnTest2: TButton;
    lbledtSaveDir: TLabeledEdit;
    btnDownByMultiThread: TButton;
    cbbLi: TComboBox;
    cbbRange: TComboBox;
    gb2: TGroupBox;
    lbl1: TLabel;
    lbledtColBase: TLabeledEdit;
    lbledtLeftOffset: TLabeledEdit;
    lbledtRightOffset: TLabeledEdit;
    lbledtRowBase: TLabeledEdit;
    lbledtTopOffset: TLabeledEdit;
    lbledtBottomOffset: TLabeledEdit;
    lbledtS1: TLabeledEdit;
    mmS4: TMemo;
    btnSelectDir: TButton;
    btnStopDownload: TButton;
    procedure btnDownClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnTest2Click(Sender: TObject);
    procedure btnDownByMultiThreadClick(Sender: TObject);
    procedure cbbTypeChange(Sender: TObject);
    procedure cbbLiChange(Sender: TObject);
    procedure cbbRangeChange(Sender: TObject);
    procedure btnSelectDirClick(Sender: TObject);
    procedure btnStopDownloadClick(Sender: TObject);
  private
    { Private declarations }
    FColBase: Integer;
    FRowBase: Integer;
    FLeftOffset: Integer;
    FRightOffset: Integer;
    FTopOffset: Integer;
    FBottomOffset: Integer;
    FColCount: Integer;
    FRowCount: Integer;
    FCircleCount: Integer;
    FCommonCount: Integer;
    FS1: string;
    //FS2: string;
    //FS3: string;
    FS4: string;
    //
    FSaveDir: string;
    FMultiThreadStopFlag: Boolean;
    FData:TList;
    procedure GetSomeInfo;
  public
    { Public declarations }
    property ColBase: Integer read FColBase;
    property RowBase: Integer read FRowBase;
    property LeftOffset: Integer read FLeftOffset;
    property RightOffset: Integer read FRightOffset;
    property TopOffset: Integer read FTopOffset;
    property BottomOffset: Integer read FBottomOffset;
    property ColCount: Integer read FColCount;
    property RowCount: Integer read FRowCount;
    property CircleCount: Integer read FCircleCount;
    property CommonCount: Integer read FCommonCount;
    property S1: string read FS1;
    property S4: string read FS4;
    property SaveDir: string read FSaveDir;
    property MultiThreadStopFlag: Boolean read FMultiThreadStopFlag;

    function CalcImageName(row, col: Integer): string;
    function CalcImageUrl(row, col: Integer): string;
    procedure DownloadByIdHttpGet(url, name: string);
  end;

var
  DownloadForm: TDownloadForm;

implementation
uses
  UrlMon, DownloadThread;

{$R *.dfm}

var
  intVarCount: Integer = 111;
{ TDownloadForm }

function TDownloadForm.CalcImageName(row, col: Integer): string;
begin
  //i:=row-FRowCount div 2;
  //j:=col-FColCount div 2;
  Result := Format('%.3d%.3d.png', [row, col]);
  //Result := Format('%.3d%.3d.png', [row, col]);
end;

function TDownloadForm.CalcImageUrl(row, col: Integer): string;
var
  s2, s3: string;
begin
  s2 := Format('2i%d',[FColBase + col]);
  s3 := Format('3i%d', [FRowBase + row]);
  Result := FS1 + s2 + '!' + s3 + FS4;
end;

//把界面的数据设置到Form类的属性，所有业务逻辑方法不直接使用界面数据，特别是
//多线程下载时
procedure TDownloadForm.GetSomeInfo;
begin
  //目前观测到的文件命名情况，左小又大，上小下大
  FColBase := StrToIntDef(lbledtColBase.Text,0);
  FRowBase := StrToIntDef(lbledtRowBase.Text,0);
  FLeftOffset := -1 * StrToIntDef(lbledtLeftOffset.Text,0);
  FRightOffset := StrToIntDef(lbledtRightOffset.Text,0);
  FTopOffset := -1 * StrToIntDef(lbledtTopOffset.Text,0);
  FBottomOffset := StrToIntDef(lbledtBottomOffset.Text,0);

  FS1 := lbledtS1.Text;
  FS4 := mmS4.Text;
  //
  FSaveDir := lbledtSaveDir.Text;
end;

  //文件下载
function DownloadFile(source, dest: string): Boolean;
begin
  Result := True;
  if FileExists(dest) then Exit;
  try
    Result := UrlDownloadToFile(nil, PChar(source), PChar(dest), 0, nil) = 0;
  except
    Result := False;
  end;
end;


procedure TDownloadForm.btnTestClick(Sender: TObject);
var
  filedir, imageUrl:string;
begin
  imageUrl :='http://download.pingan.com.cn/bank/client.zip';
  filedir := 'C:\Users\0\Desktop\ditu\01\client.zip';
  if  DownloadFile(imageUrl,filedir) then
    showMessage('文件下载成功')
  else
    showMessage('文件下载失败');
end;

procedure TDownloadForm.btnTest2Click(Sender: TObject);
var
  fileDir, imageUrl:string;
  myStream: TMemoryStream;
begin
  myStream := TMemoryStream.Create;
  imageUrl :='http://ditu.google.cn/maps/vt?pb=!1m5!1m4!1i14!2i12855!3i6862!4i256!2m3!1e4!2st!3i132!2m3!1e0!2sr!3i335000000!3m9!2szh-CN!3sCN!5e18!12m1!1e63!12m3!1e37!2m1!1ssmartmaps!4e0';
  fileDir := 'C:\Users\hasee\Desktop\ditu\01\001001.png';
  if FileExists(fileDir) then Exit;
  try
    //注意：要设置属性TIdHTTPRequest，不然会报错
    idhttp1.Get(imageUrl, myStream);
    myStream.SaveToFile(fileDir);
    showMessage('文件下载成功');
  except
    ShowMessage('网络出错！');
    myStream.Free;
  end;
end;

procedure TDownloadForm.btnDownClick(Sender: TObject);
var
  filedir, fileName, imageUrl, s:string;
  iRow, iCol: Integer;
begin
  filedir := 'C:\Users\0\Desktop\ditu\01\';
  //imageUrl :='http://download.pingan.com.cn/bank/client.zip';
  for iRow := 0 to FRowCount - 1 do
    for iCol :=0 to FColCount - 1 do
    begin
      s := CalcImageName(iRow + 1, iCol + 1);
      fileName := filedir + s;
      imageUrl := CalcImageUrl(iRow, iCol);
      DownloadByIdHttpGet(imageUrl,fileName);
//      if  DownloadFile(imageUrl,filedir) then
//        showMessage('文件下载成功')
//      else
//        showMessage('文件下载失败');
    end;
  //iRow := 0;
  //iCol := 0;
end;

procedure TDownloadForm.DownloadByIdHttpGet(url, name: string);
var
  streamTmp: TMemoryStream;
begin
  if FileExists(name) then Exit;
  streamTmp := TMemoryStream.Create;
  try
    //注意：要设置属性TIdHTTPRequest，不然会报错
    idhttp1.Get(url, streamTmp);
    streamTmp.SaveToFile(name);
  except
    ShowMessage('网络出错！');
    streamTmp.Free;
  end;
end;

//使用多线程下载
procedure TDownloadForm.btnDownByMultiThreadClick(Sender: TObject);
var
  offset: Integer;
  threadTmp: TTestThread;
begin
  FMultiThreadStopFlag := False;
  for offset := TopOffset to BottomOffset do
  begin
    threadTmp := TTestThread.Create(True, Self, offset, LeftOffset, RightOffset);
    threadTmp.Resume;
  end;
end;

procedure TDownloadForm.cbbTypeChange(Sender: TObject);
begin
  inherited;
  GetSomeInfo;
end;

procedure TDownloadForm.cbbLiChange(Sender: TObject);
begin
  inherited;
  if(cbbRange.ItemIndex = -1)then
  begin
    ShowMessage('请先选择地名');
    Exit;
  end;
  if(cbbLi.Text='li7') then
  begin
    //各个地名选择默认的参考点
    if(cbbRange.Text = '中国')then
    begin
      lbledtColBase.Text := '101';
      lbledtRowBase.Text := '52';
    end else if(cbbRange.Text = '云南')then
    begin

    end;
    lbledtLeftOffset.Text := '0';
    lbledtRightOffset.Text := '0';
    lbledtTopOffset.Text := '0';
    lbledtBottomOffset.Text := '0';
    //li参数
    lbledtS1.Text := 'http://ditu.google.cn/maps/vt?pb=!1m5!1m4!1i7!';
    mmS4.Text :='!4i256!2m3!1e4!2st!3i359!2m3!1e0!2sr!3i359029342!3m9!2szh-CN!3sCN!5e18!12m1!1e63!12m3!1e37!2m1!1ssmartmaps!4e0';
    //
    //lbledtSaveDir.Text := 'C:\Users\hasee\Desktop\ditu\01\';
  end else if(cbbLi.Text='li8')then
  begin
    //各个地名选择默认的参考点
    if(cbbRange.Text = '中国')then
    begin
      lbledtColBase.Text := '202';
      lbledtRowBase.Text := '105';
      lbledtLeftOffset.Text := '23';
      lbledtRightOffset.Text := '22';
      lbledtTopOffset.Text := '23';
      lbledtBottomOffset.Text := '22';
    end else if(cbbRange.Text = '云南')then
    begin

    end;

    //li参数
    lbledtS1.Text := 'http://ditu.google.cn/maps/vt?pb=!1m5!1m4!1i8!';
    mmS4.Text :='!4i256!2m3!1e4!2st!3i359!2m3!1e0!2sr!3i359028705!3m9!2szh-CN!3sCN!5e18!12m1!1e63!12m3!1e37!2m1!1ssmartmaps!4e0';
  end else if(cbbLi.Text='li9')then
  begin
    //各个地名选择默认的参考点
    if(cbbRange.Text = '中国')then
    begin
      lbledtColBase.Text := '404';
      lbledtRowBase.Text := '214';
      lbledtLeftOffset.Text := '50';
      lbledtRightOffset.Text := '50';
      lbledtTopOffset.Text := '50';
      lbledtBottomOffset.Text := '50';
    end;
    //li参数
    lbledtS1.Text := 'http://ditu.google.cn/maps/vt?pb=!1m5!1m4!1i9!';
    mmS4.Text :='!4i256!2m3!1e4!2st!3i132!2m3!1e0!2sr!3i335000000!3m9!2szh-CN!3sCN!5e18!12m1!1e63!12m3!1e37!2m1!1ssmartmaps!4e010';
  end else if (cbbLi.Text='li10')then
  begin
    //各个地名选择默认的参考点
    if(cbbRange.Text = '中国')then
    begin
      lbledtColBase.Text := '808';
      lbledtRowBase.Text := '420';
      lbledtLeftOffset.Text := '92';
      lbledtRightOffset.Text := '88';
      lbledtTopOffset.Text := '92';
      lbledtBottomOffset.Text := '88';
    end;
    //li参数
    lbledtS1.Text := 'http://ditu.google.cn/maps/vt?pb=!1m5!1m4!1i10!';
    mmS4.Text :='!4i256!2m3!1e4!2st!3i132!2m3!1e0!2sr!3i335000000!3m9!2szh-CN!3sCN!5e18!12m1!1e63!12m3!1e37!2m1!1ssmartmaps!4e0';
  end else if (cbbLi.Text='li11')then
  begin

  end else if (cbbLi.Text='li12')then
  begin
    //各个地名选择默认的参考点
    if(cbbRange.Text = '云南')then
    begin
      lbledtColBase.Text := '3206';
      lbledtRowBase.Text := '1754';
      lbledtLeftOffset.Text := '50';
      lbledtRightOffset.Text := '50';
      lbledtTopOffset.Text := '50';
      lbledtBottomOffset.Text := '50';
    end;
    //li参数
    lbledtS1.Text := 'http://ditu.google.cn/maps/vt?pb=!1m5!1m4!1i12!';
    mmS4.Text :='!4i256!2m3!1e4!2st!3i132!2m3!1e0!2sr!3i335000000!3m9!2szh-CN!3sCN!5e18!12m1!1e63!12m3!1e37!2m1!1ssmartmaps!4e0';
  end else if (cbbLi.Text='li14') then
  begin
    //各个地名选择默认的参考点
    if(cbbRange.Text = '昭通')then
    begin
      lbledtColBase.Text := '12929';
      lbledtRowBase.Text := '6886';
      lbledtLeftOffset.Text := '55';
      lbledtRightOffset.Text := '55';
      lbledtTopOffset.Text := '55';
      lbledtBottomOffset.Text := '55';
    end else if(cbbRange.Text = '云南')then
    begin

    end;
    //li参数
    lbledtS1.Text := 'http://ditu.google.cn/maps/vt?pb=!1m5!1m4!1i14!';
    mmS4.Text :='!4i256!2m3!1e4!2st!3i132!2m3!1e0!2sr!3i335000000!3m9!2szh-CN!3sCN!5e18!12m1!1e63!12m3!1e37!2m1!1ssmartmaps!4e0';
  end else if (cbbLi.Text='li15') then
  begin
    //各个地名选择默认的参考点
    if(cbbRange.Text = '昭通')then
    begin
      lbledtColBase.Text := '25824';
      lbledtRowBase.Text := '13795';
      lbledtLeftOffset.Text := '30';
      lbledtRightOffset.Text := '30';
      lbledtTopOffset.Text := '30';
      lbledtBottomOffset.Text := '30';
    end else if(cbbRange.Text = '彝良')then
    begin
      lbledtColBase.Text := '25854';
      lbledtRowBase.Text := '13766';
      lbledtLeftOffset.Text := '35';
      lbledtRightOffset.Text := '35';
      lbledtTopOffset.Text := '35';
      lbledtBottomOffset.Text := '35';
    end else if(cbbRange.Text = '云南')then
    begin

    end;

    //li参数
    lbledtS1.Text := 'http://ditu.google.cn/maps/vt?pb=!1m5!1m4!1i15!';
    mmS4.Text :='!4i256!2m3!1e4!2st!3i132!2m3!1e0!2sr!3i335000000!3m9!2szh-CN!3sCN!5e18!12m1!1e63!12m3!1e37!2m1!1ssmartmaps!4e0';
  end;
  GetSomeInfo;
end;

//参考点
procedure TDownloadForm.cbbRangeChange(Sender: TObject);
begin
  inherited;
  if(cbbLi.Text='中国')then
  begin
  end else if(cbbLi.Text='云南')then
  begin
  end else if(cbbLi.Text='昭通')then
  begin
  end else if(cbbLi.Text='彝良')then
  begin

  end;
end;

procedure TDownloadForm.btnSelectDirClick(Sender: TObject);
begin
  inherited;

//  if dlgOpen1.Execute then
//  begin
//    ShowMessage(dlgOpen1.FileName);
//  end;
end;

procedure TDownloadForm.btnStopDownloadClick(Sender: TObject);
begin
  inherited;
  FMultiThreadStopFlag := True;
end;

end.



