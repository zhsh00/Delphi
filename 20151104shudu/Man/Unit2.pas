unit Unit2;

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
  //PRow = ^TRow;

  TRow = record
    index: Integer; //记录行对象位于数独方块的第几行
    used: TDigit;
    D: TDigit; //待用数字——未填入该行的数字
    d0: TDigit; //待用数字——不处理占位0
    P: array [0..2] of PGrid;
  end;
  PRow = ^TRow;

  TCol = record
    index: Integer; //记录列对象位于数独方块的第几列
    used: TDigit;
    D: TDigit; //待用数字——未填入该列的数字
    d0: TDigit; //待用数字——不处理占位0
    P: array [0..2] of PGrid;
  end;
  PCol = ^TCol;

  TGrid = record
    iR: Integer; //记录Grid对象位于数独方块的第几行，取0，1，2
    iC: Integer; //记录Grid对象位于数独方块的第几列，取0，1，2
    R: TRect;
    D: TDigit; //待用数字——未填入Grid的数字
    d0: TDigit; //待用数字——不处理占位0
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
    //根据界面输入数据初始化数独矩阵的Grid对象
    procedure InitShudu(shud: PShud);
    //用已经初始化了Grid的数独矩阵初始化行对象
    procedure InitShuduRow(shud: PShud);
    //用已经初始化了Grid的数独矩阵初始化列对象
    procedure InitShuduCol(shud: PShud);
    procedure PrintShudubyGrid(shud: PShud);
    procedure PrintShudubyRow(shud: PShud);
    procedure PrintShudubyCol(shud: PShud);
    procedure FindTheOnlyOneAtCross(shud: PShud);
    procedure FindExistOnOtherRowsAndCols(shud: PShud);
    procedure DobyRow(shud: PShud);
    procedure DobyCol(shud: PShud);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  cDigits: TDigit = (1,2,3,4,5,6,7,8,9);

var
  gShudu: TShud;
  
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
          TRow(shud^.Rs[iRow + 1]).used[iCol + 1]);
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
          TCol(shud^.Cs[iCol + 1]).used[iRow + 1]);
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
      //计算Grid在显示界面的偏移值的基址
      iRow := r * 3 - 1;
      iCol := c * 3 - 1;
      for ri := 1 to 3 do
        for ci := 1 to 3 do
        begin
          //把界面的值写到Grid
          TGrid(shud^.G[r][c]).R[ri][ci] :=
            StrToIntDef(sgInit.cells[iCol + ci, iRow + ri], 0);
        end;

      dTmp := cDigits;
      //在TGrid.D中剔除TGrid.R中已存在的数
      for ri := 1 to 3 do
        for ci := 1 to 3 do
          if TGrid(shud^.G[r][c]).R[ri][ci] <> 0 then
          begin
            //因为dTmp[i]=i，所以下面即可在dTmp中去除Grid中存在的数
            dTmp[TGrid(shud^.G[r][c]).R[ri][ci]] := 0;
          end;
      TGrid(shud^.G[r][c]).d0 := dTmp;
      //在TGrid.D从1开始
      ci := 1;
      for ri := 1 to 9 do
        if dTmp[ri] <> 0 then
        begin
          TGrid(shud^.G[r][c]).D[ci] := dTmp[ri];
          Inc(ci);
        end;
      for ci := ci to 9 do
        TGrid(shud^.G[r][c]).D[ci] := 0; //多余的长度清0
    end;
end;

//很相似的代码，目前我复制一遍吧
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
      //当j=3时表示第1个方格的滴3行，此时r=1，ri=0，为计算统一方便，r应减1，而
      //ri=3，这是因为j=1，2时，r=0/ri=1，2，公式为j=3*r+ri
      if ri = 0 then
      begin
        Dec(r);
        ri := 3;
        //列对象指向其经过的Grid
        TCol(shud^.Cs[i]).P[r] := @TGrid(shud^.G[r][c]);
        //列对象经过的Grid指向该列对象
        //PGrid(TRow(shud^.Cs[i]).P[r])^ 等价于TGrid(shud^.G[r][c])
        //ci表示Grid列对象指针数组PC的第ci个分量
        PGrid(TCol(shud^.Cs[i]).P[r])^.PC[ci] := @TRow(shud^.Cs[i]);
      end;
      //使用Grid对象的值给Col对象赋值
      TCol(shud^.Cs[i]).used[j] := TGrid(shud^.G[r][c]).R[ri][ci];
    end;
    dTmp := cDigits;
    for j := 1 to 9 do
      if TCol(shud^.Cs[i]).used[j] <> 0 then
      begin
        //因为dTmp[i]=i，所以下面即可在dTmp中去除Grid中存在的数
        dTmp[TCol(shud^.Cs[i]).used[j]] := 0;
      end;
    TCol(shud^.Cs[i]).d0 := dTmp;
    //在TCol.D从1开始
    ci := 1;
    for ri := 1 to 9 do
      if dTmp[ri] <> 0 then
      begin
        TCol(shud^.Cs[i]).D[ci] := dTmp[ri];
        Inc(ci);
      end;
    for ci := ci to 9 do
      TCol(shud^.Cs[i]).D[ci] := 0; //多余的长度清0
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
        //行对象指向其经过的Grid
        TRow(shud^.Rs[i]).P[c] := @TGrid(shud^.G[r][c]);
        //行对象经过的Grid指向该行对象
        //PGrid(TRow(shud^.Rs[i]).P[c])^ 等价于TGrid(shud^.G[r][c])
        //ri表示第ri个分量
        PGrid(TRow(shud^.Rs[i]).P[c])^.PR[ri] := @TRow(shud^.Rs[i]);
      end;
      //使用Grid对象的值给Row对象赋值
      TRow(shud^.Rs[i]).used[j] := TGrid(shud^.G[r][c]).R[ri][ci];
    end;
    dTmp := cDigits;
    for j := 1 to 9 do
      if TRow(shud^.Rs[i]).used[j] <> 0 then
      begin
        //因为dTmp[i]=i，所以下面即可在dTmp中去除Grid中存在的数
        dTmp[TRow(shud^.Rs[i]).used[j]] := 0;
      end;
    TRow(shud^.Rs[i]).d0 := dTmp;
    //在TRow.D从1开始
    ci := 1;
    for ri := 1 to 9 do
      if dTmp[ri] <> 0 then
      begin
        TRow(shud^.Rs[i]).D[ci] := dTmp[ri];
        Inc(ci);
      end;
    for ci := ci to 9 do
      TRow(shud^.Rs[i]).D[ci] := 0; //多余的长度清0
  end;
end;

procedure TForm1.btnInitClick(Sender: TObject);
var
  shudu: TShud;
begin
  InitShudu(@shudu);
  InitShuduRow(@shudu);
  InitShuduCol(@shudu);
  gShudu := shudu;
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

procedure TForm1.FindTheOnlyOneAtCross(shud: PShud);
var
  r, c, i, j, iCount, iTmp: Integer;
  ri, ci: Integer;
  dTmp: TDigit;
  p: PGrid;
  pR: PRow;
  pC: PCol;
begin
  for r := 0 to 2 do
    for c := 0 to 2 do
    begin
      p := @(shud^.G[r][c]);
      for ri := 1 to 3 do
        for ci := 1 to 3 do
        begin
          //已经有数了就跳过
          if p.R[ri][ci] <> 0 then Continue;

          pR := @(shud^.Rs[r * 3 + ri]);
          pC := @(shud^.Cs[c * 3 + ci]);
          dTmp := p^.d0;
          for i := 1 to 9 do
            if pR.used[i] <> 0 then
            begin
              //这里因为dTmp[i]=i或0
              if dTmp[pR.used[i]] = pR.used[i] then
                // 在行对象pR^上使用过的数则置为0
                dTmp[pR.used[i]] := 0;
            end;

          for i := 1 to 9 do
            if pC.used[i] <> 0 then
            begin
              //这里因为dTmp[i]=i或0
              if dTmp[pC.used[i]] = pC.used[i] then
                // 在行对象pR^上使用过的数则置为0
                dTmp[pC.used[i]] := 0;
            end;

          iCount := 99;//随便给一个值;
          iTmp := 0;
          for i := 1 to 9 do
            if dTmp[i] <> 0 then
            begin
              Inc(iCount);
              iTmp := dTmp[i];
            end;

          if iCount = 1 then
          begin
            p.R[ri][ci] := iTmp;
            p^.d0[iTmp] := 0;
            pR.d0[iTmp] := 0;
            pC.d0[iTmp] := 0;
          end
          else if iCount = 0 then
            ShowMessage('ERROR:iCount shouldnt be 0!');
        end;
    end;
end;

procedure TForm1.DobyRow(shud: PShud);
begin

end;

procedure TForm1.btnDoClick(Sender: TObject);
var
  i :Integer;
begin
  for i := 1 to 10 do
  begin
    FindExistOnOtherRowsAndCols(@gShudu);
    FindTheOnlyOneAtCross(@gShudu);
  end;
  PrintShudubyGrid(@gShudu);
end;

procedure TForm1.FindExistOnOtherRowsAndCols(shud: PShud);
var
  r, c, i, j, k, index, iCount, iTmp, iExist: Integer;
  ri, ci, rr, cc: Integer;
  dTmp: TDigit;
  p: PGrid;
  pR: PRow;
  pC: PCol;
  bExist, bExistOtherAll: Boolean;
begin
  for r := 0 to 2 do
    for c := 0 to 2 do
    begin
      //取出一个Grid对象
      p := @(shud^.G[r][c]);
      //遍历Grid的每一个格子
      for ri := 1 to 3 do
        for ci := 1 to 3 do
        begin
          //格子已经填了数字则跳过
          if p.R[ri][ci] <> 0 then Continue;
          //遍历Grid对象的未使用数字列表
          for i := 1 to 9 do
          begin
            //这里使用d0列表
            if p^.d0[i] = 0 then Continue;
            //取行和列
            pR := p^.PR[ri];
            pC := p^.PC[ci];
            bExist := False;
            //先判断在格子的交叉行、列是否已经使用了该数字
            for j := 1 to 9 do
            begin
              //数字已经在交叉的行被使用
              if p^.d0[i] = pR^.used[j] then
              begin
                bExist := True;
                Break; //
              end;
              //数字已经在交叉的列上被使用
              if p^.d0[i] = pC^.used[j] then
              begin
                bExist := True;
                Break; //
              end;
            end;
            //数字在交叉行、列是否已经被使用，则继续列表的下一个数字
            if bExist then Continue;

            //再判断数字在Grid对象涉及的其它行、列是否存在
            bExistOtherAll := True;
            //1.行
            bExist := False;
            for k := 1 to 3 do
              if k <> ri then //k=ri，表示格子所在的行，跳过
              begin
                //取行
                pR := p^.PR[k];
                bExist := False;
                //判断数字在该行上是否被使用
                for j := 1 to 9 do
                begin
                  //数字已经该行上使用
                  if p^.d0[i] = pR^.used[j] then
                  begin
                    bExist := True;
                    Break; //
                  end;
                end;
                if not bExist then
                begin
                  bExistOtherAll := False;
                  Break;
                end;
              end;
            //在这些行上没有被使用，则可能被多行使用，跳过
            if not bExistOtherAll then Continue;
            //2.列
            bExist := False;
            for k := 1 to 3 do
              if k <> ci then //k=ci，表示格子所在的列，跳过
              begin
                //取列
                pC := p^.PC[k];
                bExist := False;
                //判断数字在该列上是否被使用
                for j := 1 to 9 do
                begin
                  //数字已经该列上使用
                  if p^.d0[i] = pC^.used[j] then
                  begin
                    bExist := True;
                    Break; //
                  end;
                end;
                if not bExist then
                begin
                  bExistOtherAll := False;
                  Break;
                end;
              end;
            //在这些行。列上都被被使用，则数字只能填入当前的格子
            if bExistOtherAll then
              p.R[ri][ci] := p^.d0[i];
          end;
        end;
    end;
end;

end.
