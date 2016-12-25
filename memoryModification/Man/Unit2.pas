unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Tlhelp32, ComCtrls;

type
  pint=^integer;
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    ListView1: TListView;
    Button3: TButton;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    edtSelectedAddres: TEdit;
    Button2: TButton;
    Edit3: TEdit;
    Button4: TButton;
    Label6: TLabel;
    Label7: TLabel;
    edtNewValue: TEdit;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Button5: TButton;
    Label1: TLabel;
    sb1: TStatusBar;
    pnl1: TPanel;
    pnl2: TPanel;
    lv2: TListView;
    edt1: TEdit;
    edt2: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure edtNewValueKeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Button5Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure showList;
  end;

const bufferSize=1024;
var
  Form1: TForm1;
  pc,gBakCount:integer;//相符地址数组尾指针,//多次查找时做前者备份
  gFound:array[0..65535] of pointer;//相符地址数组
  gBak :array[0..65535] of pointer;//多次查找时做上述备份
  gFoundCount: Integer;
  isFirst:boolean; //是否第一次查找？
  sysinfo:SYSTEM_INFO;
  hProc:dword;
implementation

{$R *.dfm}

procedure GetProc();
var
  sProc:PROCESSENTRY32;
  hSnap:dword;
  ok:bool;
begin
  Form1.ListView1.Clear;
  sProc.dwSize:=SizeOf(sProc);
  hSnap:=CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS,0);
  ok:=Process32First(hSnap,sProc);
  While ok do
    begin
      With Form1.ListView1.Items.Add do
        begin
          Caption:=sProc.szExeFile;
          SubItems.Add(IntToHex(sproc.th32ProcessID,0));
        end;
      ok:=Process32Next(hSnap,sProc);
    end;
  CloseHandle(hSnap);
  if Form1.ListView1.Items.Count<>0 then
    Form1.ListView1.Items.Item[0].Selected:=true;
end;

//在4k内存中查找符合指定数值的内存单元地址，返回值说明读入内存块是否成功
function FindMemBlock(PH: Thandle; add: pointer; v: integer): boolean;
var                  //进程句柄，起始地址，需要查找的数值
  i, t: integer;//计数器
  buffer: array[1..bufferSize] of byte;//用来装4KB的内存块
  ok: boolean;//装入内存块是否成功
  LPDW: DWORD;
begin
  ok := ReadProcessMemory(PH, add, pointer(@(buffer[1])), bufferSize, Lpdw);
  if ok then //读取成功 ^_^
  begin
    for i := 0 to bufferSize do
    begin
      t := (PInteger(@(buffer[i])))^;
      if t = v then//找到
      begin
        Inc(gFoundCount);
        gFound[gFoundCount] := Pointer(Cardinal(add) + i);//保存地址
      end;
    end;
    result := true;
  end
  else //读取失败 :(
  begin
    Result := false;
  end;
end;

//将V写到指定进程指定位置，返回值代表写入是否成功
function writeMemory(PH:Thandle;Add:pointer;V:integer):boolean;
var
  ok:boolean;
  LPDW:DWORD;
begin
  ok:=WriteProcessMemory(PH,Add,pointer(@V),4,LPDW);
  if ok then Result:=True
  else Result:=False;
end;
//取得指定进程指定位置处数值
function getAddressV(PH:Thandle; Add:pointer; var V:integer):boolean;
var
  ok:boolean;
  LPDW:DWORD;
begin
  ok:=readProcessMemory(PH,add,pointer(@V),4,LPDW);
  if ok then Result:=True
  else Result:=False;
end;

procedure showlist();
var
  i:Integer;
begin
  Form1.ListBox1.Clear;
  for i:=1 to gFoundCount do
  begin
    Form1.ListBox1.Items.Add(IntTohex(DWORD(gFound[i]),8));
  end;
  if Form1.ListBox1.Count<>0 then
    begin
      form1.Label1.Caption:=inttostr(form1.listbox1.Count);
      Form1.ListBox1.Selected[0]:=true;
      Form1.edtSelectedAddres.Text:='0x'+Form1.Listbox1.Items.Strings[0];
    end
  else
    begin
      form1.Label1.Caption:='';
      Form1.edtSelectedAddres.Text:='';
    end;
end;

procedure TForm1.Button1Click(Sender:TObject);
var
  i, test, v: integer;
  j, e: Dword;
  pointerTmp: Pointer;
  numberOfBytesRead: Cardinal;
  c1,c2: Integer;
begin
   //只是简单考虑非法输入啊！！请不要输入太大的数值！！！
  if edit1.Text='' then
  begin
    showmessage('不可为空！');
    exit;
  end;
  if edit3.Text='' then exit;
    hProc:=OpenProcess(PROCESS_ALL_ACCESS,false,strtoint(edit3.text));

//  GetSystemInfo(sysinfo);

  V:=StrToInt(Edit1.Text);
  if isFirst then //是第一次查找
  begin
    gFoundCount := 0;
    isFirst := false;
//查找从4M至2G的地址空间
    j:=4*1024*1024;
    e:=2*1024*1024;
    e:=e*1024;
//    j:=dword(sysinfo.lpMinimumApplicationAddress);
//    e:=dword(sysinfo.lpMaximumApplicationAddress);
    while j < e do
    begin
      if FindMemBlock(hProc, pointer(j), V) then
      begin
        sb1.SimpleText := '读入成功';
        Inc(c1);
      end
      else
      begin
        sb1.SimpleText := '读入失败';
        Inc(c2);
      end;
      j := j + bufferSize;  //下一个4KB
    end;
    edt1.Text := IntToStr(c1);
    edt2.Text := IntToStr(c2);
  end
  else   //第n次查找
  begin
   //先备份
    gBakCount := gFoundCount;
    for i:=1 to gBakCount do
    begin
      gBak[i]:=gFound[i];
    end;
    //再比较
    gFoundCount := 0;
    for i := 1 to gBakCount do
      if GetAddressV(hProc, gBak[i], test) then //读取成功
      begin
        if test = v then //相符
        begin
          Inc(gFoundCount);
          gFound[gFoundCount] := gBak[i];
        end;
      end;
    if gFoundCount = 0 then //等于0可能数据有错误保留上一次状态，以备重来
    begin
      gFoundCount := gBakCount;
      //似乎并不需要交换，fFound完好没损！！！
//      pointerTmp := gFound;
//      gFound := gBak;
//      gBak := pointerTmp;
    end;
  end;
  showlist();//显示地址列表到listBox1中
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     //只是简单考虑非法输入啊！！请不要输入太大的数值！！！
  if edtNewValue.Text='' then
  begin
    showmessage('不可为空！');
    exit;
  end;
  if edtSelectedAddres.text='' then exit;
      if MessageDlg('真的修改？',MtWarning,MbOKCancel,0)=MrCancel then exit;
  if WriteMemory(hProc,pointer(strtoint(edtSelectedAddres.text)),strtoint(edtNewValue.Text))
  then  sb1.SimpleText:='修改成功！'
  else  sb1.SimpleText:='修改失败！';
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if (key>'9')or(key<'0') then key:=#0;
end;
procedure TForm1.edtNewValueKeyPress(Sender: TObject; var Key: Char);
begin
  if (key>'9')or(key<'0') then key:=#0;
end;
procedure TForm1.FormCreate(Sender:TObject);
begin
isFirst:=true;
GetProc;
end;
procedure TForm1.Button4Click(Sender: TObject);
begin
  isFirst:=true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  GetProc;
end;

procedure TForm1.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  Edit3.Text:='0x'+Item.SubItems.Strings[0];
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  edtSelectedAddres.Text:='0x'+Listbox1.Items.Strings[listbox1.itemindex];
end;

function CustomSortProc(Item1, Item2: TListItem; ParamSort: Integer):
Integer; stdcall;
begin
  if ParamSort = 0 then
    Result := StrComp(PAnsiChar(Item1.Caption), PAnsiChar(Item2.Caption))
  else
    Result := StrComp(PAnsiChar(Item1.SubItems[ParamSort - 1]),
      PAnsiChar(Item2.SubItems[ParamSort - 1]));
end;

procedure TForm1.ListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  ListView1.CustomSort(@CustomSortProc, Column.index);
end;

procedure TForm1.showList;
var
  i:Integer;
begin
  lv2.Clear;
  for i := 1 to gFoundCount do
  begin
    with lv2.Items.Add do
    begin
      Caption := IntTohex(DWORD(gFound[i]),8);
    end;
  end;
  if lv2.Items.Count <> 0 then
    begin
      Label1.Caption := inttostr(lv2.Items.Count);
      lv2.Items[0].Selected := True;
      edtSelectedAddres.Text := '0x' +lv2.Items[0].Caption;
    end
  else
  begin
    Label1.Caption:='';
    edtSelectedAddres.Text:='';
  end;
  sb1.SimpleText := '';
end;

end.
