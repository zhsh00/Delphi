unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons;

type

  TGrid = array [1..9] of array [1..9] of Integer;
  PGrid = ^TGrid;
  TDigit = array [1..9] of Integer;
  PDigit = ^TDigit;
  //
  PCell = ^TCell;
  TPCellRow = array [1..9] of PCell;
  TPCellRect = array [1..3] of array [1..3] of PCell;
  TPCellGrid = array [1..9] of array [1..9] of PCell;

  TRow = record
    index: Integer; //��¼�ж���λ����������ĵڼ���
    used: TDigit;
    notuse: TDigit; //�������֡���δ������е�����
    notuse0: TDigit; //�������֡���������ռλ0
    cells: TPCellRow;
  end;
  PRow = ^TRow;

  TCol = record
    index: Integer; //��¼�ж���λ����������ĵڼ���
    used: TDigit;
    notuse: TDigit; //�������֡���δ������е�����
    notuse0: TDigit; //�������֡���������ռλ0
    cells: TPCellRow; //cells[1..9]�����α�ʾ��
  end;
  PCol = ^TCol;

  TRect = record
    indexR: Integer; //��¼TRect����λ����������ĵڼ��У�ȡ0��1��2
    indexC: Integer; //��¼TRect����λ����������ĵڼ��У�ȡ0��1��2
    used: TDigit;
    notuse: TDigit; //�������֡���δ������е�����
    notuse0: TDigit; //�������֡���������ռλ0
    cells: TPCellRect;//ע��TRect��cells�Ƕ�ά����
  end;
  PRect = ^TRect;

  TCell = record
    iR: Integer; //��Ԫ����TRect�����������
    iC: Integer; //��Ԫ����TRect�����������
    iR2: Integer; //��Ԫ�������������������
    iC2: Integer; //��Ԫ�������������������
    rect: PRect;
    row: PRow;
    col: PCol;
  end;

  TShudu = class
  public
    Grid: TGrid;
    Rows: array [1..9] of TRow;
    Cols: array [1..9] of TCol;
    Rects: array [0..2] of array [0..2] of TRect;
    //��ʼ���ڲ���ָ���ϵ
    procedure Init;
    //���ݽ����������ݳ�ʼ�����������Grid����
    procedure InitUseStringGrid(sg: TStringGrid);
    //Grid��ʼ������ܵ���
    procedure InitRect();
    //���Ѿ���ʼ����Grid�����������ʼ���ж���
    procedure InitRow();
    //���Ѿ���ʼ����Grid�����������ʼ���ж���
    procedure InitCol();
    procedure PrintToSgByGrid(sg: TStringGrid);
    procedure PrintToSgByRect(sg: TStringGrid);
    procedure PrintToSgByRow(sg: TStringGrid);
    procedure PrintToSgByCol(sg: TStringGrid);
    procedure FindTheOnlyOneAtCross();
    procedure FindExistOnOtherRowsAndCols();
    procedure DobyRow();
    procedure DobyCol();
  end;

  //
  TForm1 = class(TForm)
    sg1: TStringGrid;
    sgR: TStringGrid;
    sgC: TStringGrid;
    btn1: TBitBtn;
    sgInit: TStringGrid;
    btnInit: TBitBtn;
    btnDo: TBitBtn;
    procedure btn1Click(Sender: TObject);
    procedure btnInitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  cDigits: TDigit = (1,2,3,4,5,6,7,8,9);

var
  gShudu: TShudu;


procedure TForm1.btn1Click(Sender: TObject);
begin
  //InitShudu(@shudu);
  //ShowMessage(Format('1=%d,2=%d,3=%d',[SizeOf(TShud),SizeOf(TGrid),SizeOf(TRect)]));
  //PrintShudubyGrid(@shudu);
end;

procedure TForm1.btnInitClick(Sender: TObject);
begin
  gShudu := TShudu.Create;
  gShudu.InitUseStringGrid(sgInit);
  //ShowMessage(Format('1=%d,2=%d,3=%d',[SizeOf(TShud),SizeOf(TGrid),SizeOf(TRect)]));
  gShudu.PrintToSgByGrid(sg1);
  gShudu.PrintToSgByRow(sgR);
  gShudu.PrintToSgByCol(sgC);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //sgInit.Cells[col, row]
  sgInit.Cells[3,0] := '4';
  sgInit.Cells[5,0] := '1';
  sgInit.Cells[6,0] := '3';
  sgInit.Cells[8,0] := '5';

  sgInit.Cells[2,1] := '6';
  sgInit.Cells[4,1] := '3';
  sgInit.Cells[6,1] := '1';
  sgInit.Cells[8,1] := '7';

  sgInit.Cells[1,2] := '5';
  sgInit.Cells[4,2] := '6';
  sgInit.Cells[6,2] := '4';

  sgInit.Cells[3,3] := '7';
  sgInit.Cells[6,3] := '8';
  sgInit.Cells[8,3] := '2';

  sgInit.Cells[1,4] := '6';
  sgInit.Cells[2,4] := '7';
  sgInit.Cells[6,4] := '9';
  sgInit.Cells[7,4] := '1';

  sgInit.Cells[0,5] := '1';
  sgInit.Cells[2,5] := '2';
  sgInit.Cells[5,5] := '8';

  sgInit.Cells[2,6] := '4';
  sgInit.Cells[4,6] := '8';
  sgInit.Cells[7,6] := '7';

  sgInit.Cells[0,7] := '6';
  sgInit.Cells[2,7] := '3';
  sgInit.Cells[4,7] := '7';
  sgInit.Cells[6,7] := '5';

  sgInit.Cells[0,8] := '5';
  sgInit.Cells[2,8] := '8';
  sgInit.Cells[3,8] := '2';
  sgInit.Cells[5,8] := '3';
end;

procedure TForm1.btnDoClick(Sender: TObject);
var
  i :Integer;
begin
  for i := 1 to 10 do
  begin
    //FindExistOnOtherRowsAndCols(@gShudu);
    //FindTheOnlyOneAtCross(@gShudu);
  end;
  //PrintShudubyGrid(@gShudu);
end;



{ TShudu }

procedure TShudu.DobyCol;
begin

end;

procedure TShudu.DobyRow;
begin

end;

procedure TShudu.FindExistOnOtherRowsAndCols;
begin

end;

procedure TShudu.FindTheOnlyOneAtCross;
begin

end;

procedure TShudu.Init;
begin

end;

procedure TShudu.InitCol;
begin

end;

procedure TShudu.InitRect;
begin

end;

procedure TShudu.InitRow;
begin

end;

procedure TShudu.InitUseStringGrid(sg: TStringGrid);
var
  r, c: Integer;
begin
  for r := 0 to 8 do
    for c := 0 to 8 do
    begin
      //�ѽ����ֵд��Grid
      Grid[r + 1][c + 1] := StrToIntDef(sg.cells[c, r], 0);
    end;
end;

procedure TShudu.PrintToSgByCol(sg: TStringGrid);
begin

end;

procedure TShudu.PrintToSgByGrid(sg: TStringGrid);
var
  r, c, iTmp: Integer;
begin
  for r := 0 to 8 do
    for c := 0 to 8 do
    begin
      iTmp := Grid[r + 1][c + 1];
      if iTmp <> 0 then
        sg.Cells[c, r] := IntToStr(iTmp);
    end;
end;

procedure TShudu.PrintToSgByRect(sg: TStringGrid);
begin

end;

procedure TShudu.PrintToSgByRow(sg: TStringGrid);
begin

end;

end.
