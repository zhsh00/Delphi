unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons;

type

  TRect = array [1..3] of array [1..3] of Integer;
  PRect = ^TRect;
  TDigit = array [1..9] of Integer;
  PDigit = ^TDigit;

  PGrid = ^TGrid;

  TRow = record
    index: Integer; //��¼�ж���λ����������ĵڼ���
    R: TDigit;
    D: TDigit; //�������֡���δ������е�����
    P: array [0..2] of PGrid;
  end;
  PRow = ^TRow;

  TCol = record
    index: Integer; //��¼�ж���λ����������ĵڼ���
    C: TDigit;
    D: TDigit; //�������֡���δ������е�����
    P: array [0..2] of PGrid;
  end;
  PCol = ^TCol;

  TGrid = record
    iR: Integer; //��¼Grid����λ����������ĵڼ��У�ȡ0��1��2
    iC: Integer; //��¼Grid����λ����������ĵڼ��У�ȡ0��1��2
    R: TRect;
    D: TDigit; //�������֡���δ����Grid������
    PR: array [1..3] of PRow;
    PC: array [1..3] of PCol;
  end;

  TShud = record
    G: array [0..2] of array [0..2] of TGrid;
    Rs: array [1..9] of TRow;
    Cs: array [1..9] of TCol;
  end;
  PShud =^TShud;

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
    //���ݽ����������ݳ�ʼ�����������Grid����
    procedure InitShudu(shud: PShud);
    //���Ѿ���ʼ����Grid�����������ʼ���ж���
    procedure InitShuduRow(shud: PShud);
    //���Ѿ���ʼ����Grid�����������ʼ���ж���
    procedure InitShuduCol(shud: PShud);
    procedure PrintShudubyGrid(shud: PShud);
    procedure PrintShudubyRow(shud: PShud);
    procedure PrintShudubyCol(shud: PShud);
    procedure DobyGrid(shud: PShud);
    procedure DobyRow(shud: PShud);
    procedure DobyCol(shud: PShud);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  cDigits: TDigit = (1,2,3,4,5,6,7,8,9);

procedure FillGird();
begin

end;

procedure TForm1.PrintShudubyGrid(shud: PShud);
var
  iRow, iCol, ro, co, ri, ci: Integer;
begin
  for iRow := 0 to 8 do
    for iCol := 0 to 8 do
      begin
        ro := iRow div 3;
        co := iCol div 3;
        ri := iRow mod 3 + 1;
        ci := iCol mod 3 + 1;
        if ri = 0 then
        begin
          Dec(ro);
          ri := 3;
        end;
        if ci = 0 then
        begin
          Dec(co);
          ci := 3;
        end;
        sg1.Cells[iCol, iRow] := IntToStr(
          TGrid(shud^.G[ro][co]).R[ri][ci]);
      end;
end;

procedure TForm1.PrintShudubyRow(shud: PShud);
var
  iRow, iCol: Integer;
begin
  for iRow := 0 to 8 do
    for iCol := 0 to 8 do
      begin
        sgR.Cells[iCol, iRow] := IntToStr(
          TRow(shud^.Rs[iRow + 1]).R[iCol + 1]);
      end;
end;

procedure TForm1.PrintShudubyCol(shud: PShud);
var
  iRow, iCol: Integer;
begin
  for iRow := 0 to 8 do
    for iCol := 0 to 8 do
      begin
        sgC.Cells[iCol, iRow] := IntToStr(
          TCol(shud^.Cs[iCol + 1]).C[iRow + 1]);
      end;
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  shudu: TShud;
begin
  InitShudu(@shudu);
  ShowMessage(Format('1=%d,2=%d,3=%d',[SizeOf(TShud),SizeOf(TGrid),SizeOf(TRect)]));
  PrintShudubyGrid(@shudu);
end;

procedure TForm1.InitShudu(shud: PShud);
var
  r, c, iRow, iCol: Integer;
  ri, ci: Integer;
  dTmp: TDigit;
begin
  for r := 0 to 2 do
    for c := 0 to 2 do
    begin
      TGrid(shud^.G[r][c]).iR := r;
      TGrid(shud^.G[r][c]).iC := c;
      //����Grid����ʾ�����ƫ��ֵ�Ļ�ַ
      iRow := r * 3 - 1;
      iCol := c * 3 - 1;
      for ri := 1 to 3 do
        for ci := 1 to 3 do
        begin
          //�ѽ����ֵд��Grid
          TGrid(shud^.G[r][c]).R[ri][ci] :=
            StrToIntDef(sgInit.cells[iCol + ci, iRow + ri], 0);
        end;

      dTmp := cDigits;
      //��TGrid.D���޳�TGrid.R���Ѵ��ڵ���
      for ri := 1 to 3 do
        for ci := 1 to 3 do
          if TGrid(shud^.G[r][c]).R[ri][ci] <> 0 then
          begin
            //��ΪdTmp[i]=i���������漴����dTmp��ȥ��Grid�д��ڵ���
            dTmp[TGrid(shud^.G[r][c]).R[ri][ci]] := 0;
          end;
      //��TGrid.D��1��ʼ
      ci := 1;
      for ri := 1 to 9 do
        if dTmp[ri] <> 0 then
        begin
          TGrid(shud^.G[r][c]).D[ci] := dTmp[ri];
          Inc(ci);
        end;
      for ci := ci to 9 do
        TGrid(shud^.G[r][c]).D[ci] := 0; //����ĳ�����0
    end;
end;

//�����ƵĴ��룬Ŀǰ�Ҹ���һ���
procedure TForm1.InitShuduCol(shud: PShud);
var
  r, c, i, j: Integer;
  ri, ci: Integer;
  dTmp: TDigit;
begin
  for i := 1 to 9 do
  begin
    TCol(shud^.Cs[i]).index := i;
    c := i div 3;
    ci := i mod 3;
    if ci = 0 then
    begin
      Dec(c);
      ci := 3;
    end;

    for j := 1 to 9 do
    begin
      r := j div 3;
      ri := j mod 3;
      //��j=3ʱ��ʾ��1������ĵ�3�У���ʱr=1��ri=0��Ϊ����ͳһ���㣬rӦ��1����
      //ri=3��������Ϊj=1��2ʱ��r=0/ri=1��2����ʽΪj=3*r+ri
      if ri = 0 then
      begin
        Dec(r);
        ri := 3;
        //�ж���ָ���侭����Grid
        TCol(shud^.Cs[i]).P[r] := @TGrid(shud^.G[r][c]);
        //�ж��󾭹���Gridָ����ж���
        //PGrid(TRow(shud^.Cs[i]).P[r])^ �ȼ���TGrid(shud^.G[r][c])
        //ci��ʾGrid�ж���ָ������PC�ĵ�ci������
        PGrid(TCol(shud^.Cs[i]).P[r])^.PC[ci] := @TRow(shud^.Cs[i]);
      end;
      //ʹ��Grid�����ֵ��Col����ֵ
      TCol(shud^.Cs[i]).C[j] := TGrid(shud^.G[r][c]).R[ri][ci];
    end;
    dTmp := cDigits;
    for j := 1 to 9 do
      if TCol(shud^.Cs[i]).C[j] <> 0 then
      begin
        //��ΪdTmp[i]=i���������漴����dTmp��ȥ��Grid�д��ڵ���
        dTmp[TCol(shud^.Cs[i]).C[j]] := 0;
      end;

    //��TCol.D��1��ʼ
    ci := 1;
    for ri := 1 to 9 do
      if dTmp[ri] <> 0 then
      begin
        TCol(shud^.Cs[i]).D[ci] := dTmp[ri];
        Inc(ci);
      end;
    for ci := ci to 9 do
      TCol(shud^.Cs[i]).D[ci] := 0; //����ĳ�����0
  end;
end;

procedure TForm1.InitShuduRow(shud: PShud);
var
  r, c, i, j: Integer;
  ri, ci: Integer;
  dTmp: TDigit;
begin
  for i := 1 to 9 do
  begin
    TRow(shud^.Rs[i]).index := i;
    r := i div 3;
    ri := i mod 3;
    if ri = 0 then
    begin
      Dec(r);
      ri := 3;
    end;

    for j := 1 to 9 do
    begin
      c := j div 3;
      ci := j mod 3;
      if ci = 0 then
      begin
        Dec(c);
        ci := 3;
        //�ж���ָ���侭����Grid
        TRow(shud^.Rs[i]).P[c] := @TGrid(shud^.G[r][c]);
        //�ж��󾭹���Gridָ����ж���
        //PGrid(TRow(shud^.Rs[i]).P[c])^ �ȼ���TGrid(shud^.G[r][c])
        //ri��ʾ��ri������
        PGrid(TRow(shud^.Rs[i]).P[c])^.PR[ri] := @TRow(shud^.Rs[i]);
      end;
      //ʹ��Grid�����ֵ��Row����ֵ
      TRow(shud^.Rs[i]).R[j] := TGrid(shud^.G[r][c]).R[ri][ci];
    end;
    dTmp := cDigits;
    for j := 1 to 9 do
      if TRow(shud^.Rs[i]).R[j] <> 0 then
      begin
        //��ΪdTmp[i]=i���������漴����dTmp��ȥ��Grid�д��ڵ���
        dTmp[TRow(shud^.Rs[i]).R[j]] := 0;
      end;

    //��TRow.D��1��ʼ
    ci := 1;
    for ri := 1 to 9 do
      if dTmp[ri] <> 0 then
      begin
        TRow(shud^.Rs[i]).D[ci] := dTmp[ri];
        Inc(ci);
      end;
    for ci := ci to 9 do
      TRow(shud^.Rs[i]).D[ci] := 0; //����ĳ�����0
  end;
end;

procedure TForm1.btnInitClick(Sender: TObject);
var
  shudu: TShud;
begin
  InitShudu(@shudu);
  InitShuduRow(@shudu);
  InitShuduCol(@shudu);
  //ShowMessage(Format('1=%d,2=%d,3=%d',[SizeOf(TShud),SizeOf(TGrid),SizeOf(TRect)]));
  PrintShudubyGrid(@shudu);
  PrintShudubyRow(@shudu);
  PrintShudubyCol(@shudu);
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



procedure TForm1.DobyCol(shud: PShud);
begin

end;

procedure TForm1.DobyGrid(shud: PShud);
var
  r, c, i, j, index: Integer;
  ri, ci: Integer;
  dTmp: TDigit;
  p: PGrid;
  pRow: PRow;
  pCol: PCol;
begin
  for r := 0 to 2 do
    for c := 0 to 2 do
    begin
      p^ := shud^.G[r][c];
      for i := 1 to 9 do
      begin
        if p.D[i] = 0 then Continue;
        p.PR[].R[]
      end;
      for ri := 1 to 3 do
      begin
        index := 1;
        while (p.D[index] <> 0) do
        begin
          for i := 0 to 9 do
          begin
            //������ͬ���������޷��ڴ�������
            if p.D[index] = p.PR[ri].R[i] then
          end;
          Inc(index);
        end;
      end;
    end;
end;

procedure TForm1.DobyRow(shud: PShud);
begin

end;

procedure TForm1.btnDoClick(Sender: TObject);
begin
//
end;

end.
