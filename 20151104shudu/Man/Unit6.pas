unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons;

type

  TGrid = array [1..9] of array [1..9] of Integer;
  PGrid = ^TGrid;
  TDigit = array [1..9] of Integer;
  PDigit = ^TDigit;
  TNumRow = array [1..9] of PInteger;
  PNumRow = ^TNumRow;
  TNumRect = array [1..3] of array [1..3] of PInteger;
  PNumRect = ^TNumRect;

  TVarPInteger = record
    case Integer of
      1: (VRow: TNumRow);
      2: (VRect: TNumRect);
  end;

  // TRow和TCol结构一样
  TRow = record
    num: TNumRow; //nums[1..9]，依次表示各行
    used: TDigit;
    notuse: TDigit; //待用数字——未填入该行的数字
    notuse0: TDigit; //待用数字——不处理占位0
  end;
  PRow = ^TRow;

  //注意TRect的cells是二维数组
  //而且 TNumRow 和 TNumRect 的size一样大，可以强制类型转换
  //索引对应关系：(1,2,3,4,5,6,7,8,9)<=>((1,2,3),(4,5,6),(7,8,9))
  //TRect和TRow的size一样大，且数据结构非常相似了
  TRect = record
    num:  TNumRect;
    used: TDigit;
    notuse: TDigit; //待用数字——未填入该列的数字
    notuse0: TDigit; //待用数字——不处理占位0
  end;
  PRect = ^TRect;

  TRectRow = array [1..9] of TRow;
  TRectRect = array [0..2] of array [0..2] of TRect;
  TVarRect = record
    case Integer of
      1: (VRow: TRectRow);
      2: (VRect: TRectRect);
  end;
  
  TShudu = class
  public
    Grid: TGrid;
    Rows: array [1..9] of TRow;
    Cols: array [1..9] of TRow;
    Rects: TVarRect;//变体

    constructor Create();
    //初始化内部的指针关系
    procedure Init;
    //根据界面输入数据初始化数独矩阵的Grid对象
    procedure InitUseStringGrid(sg: TStringGrid);
    //Grid初始化后才能调用
    procedure InitWithNum();
    procedure PrintToSgByGrid(sg: TStringGrid);
    procedure PrintToSgByRect(sg: TStringGrid);
    procedure PrintToSgByRow(sg: TStringGrid);
    procedure PrintToSgByCol(sg: TStringGrid);
    //
    procedure DoByCell;
    procedure RowOnlyCanFillTheCell;
    procedure ColOnlyCanFillTheCell;
    procedure RectOnlyCanFillTheCell;
    procedure CalcCellByCell;
  end;

  //
  TForm1 = class(TForm)
    sgOut: TStringGrid;
    sgR: TStringGrid;
    sgC: TStringGrid;
    btn1: TBitBtn;
    sgInit: TStringGrid;
    btnInit: TBitBtn;
    btnClear: TBitBtn;
    procedure btn1Click(Sender: TObject);
    procedure btnInitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
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
  gShudu.InitWithNum;
  //gShudu.DoByCell;
  gShudu.CalcCellByCell;
  //ShowMessage(Format('1=%d,2=%d,3=%d',[SizeOf(TShud),SizeOf(TGrid),SizeOf(TRect)]));
  //ShowMessage(Format('1=%d,2=%d,3=%d',[SizeOf(TVarPInteger),SizeOf(TNumRow),SizeOf(TNumRect)]));
  gShudu.PrintToSgByGrid(sgOut);
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

procedure TForm1.btnClearClick(Sender: TObject);
var
  r, c: Integer;
begin
  for r := 0 to 8 do
    for c := 0 to 8 do
    begin
      //把界面的值写到Grid
      sgInit.cells[c, r] := '';
    end;
end;



{ TShudu }
//1.每次定位到一个空的格子,以格子所处的行为基准，取出行的未使用数字列表
//2.遍历每一个数字
//2.1.数字已经被格子所处的列、小矩阵使用的跳过
//2.2.数字在基准行经过的其它所有列已经被使用
//2.2.1.其它列是否有空的格子
//2.2.1.其它列列是否已经使用该数字
//2.2.1...
//3.则数组只能填入该格子
//4.从3个未使用列表中剔除数字
procedure TShudu.RowOnlyCanFillTheCell;
var
  r, c, ro, co, ri, ci, i, j, index: Integer;
  currNum: Integer;
  pARow: PRow;
  bExist, bExistOtherAll: Boolean;
begin
  for r := 1 to 9 do
  begin
    ro := r div 3;
    ri := r mod 3;
    if ri = 0 then
    begin
      //ri := 3;
      Dec(ro);
    end;
    for c := 1 to 9 do
      if Grid[r][c] = 0 then // 空的格子
      begin
        co := c div 3;
        ci := c mod 3;
        if ci = 0 then
        begin
          //ci := 3;
          Dec(co);
        end;
        //格子相关联的三个对象，行、列、Rect
        index := 1;
        //遍历行对象的未使用列表
        while(Rows[r].notuse[index] <> 0) do
        begin
          currNum := Rows[r].notuse[index];
          //判断数字是否已经被格子所处的列使用
          bExist := False;
          for i := 1 to 9 do
            // 数字已经在列被使用
            if currNum = Cols[c].num[i]^ then
            begin
              bExist := True;
              Break;
            end;
          if bExist then
          begin
            Inc(index);
            Continue;
          end;

          //判断数字是否已经被格子所处小矩阵使用，强制 类型转换为TRow
          pARow := @Rects.VRect[ro][co];
          for i := 1 to 9 do
            // 数字已经在小矩阵被使用
            if currNum = pARow.num[i]^ then
            begin
              bExist := True;
              Break;
            end;
          if bExist then
          begin
            Inc(index);
            Continue;
          end;

          //开始判断是否发生：数字在基准行经过的其它所有列已经被使用
          bExistOtherAll := True;
          for i := 1 to 9 do
          begin
            // 格子所处的列不再分析
            if i = c then Continue;
            //当然只考虑空的格子，已经有数字的格子跳过
            if Rows[r].num[i]^ <> 0 then Continue;
            //数字在第 i 列是否被使用
            bExist := False;
            for j := 1 to 9 do
              if currNum = Cols[i].num[j]^ then
              begin
                bExist := True;
                Break;
              end;
            if not bExist then
            begin
              bExistOtherAll := False;
              Break;
            end;
          end;
          //数字在基准行经过的其它所有列已经被使用，则数字只能填入当前格子
          if bExistOtherAll then
          begin
            Grid[r][c] := currNum;

            //从列表中剔除数字
            //1.行
            pARow := @Rows[r];
            pARow.notuse0[currNum] := 0;
            i := index;
            repeat
              pARow.notuse[i] := pARow.notuse[i + 1];
              Inc(i);
            until pARow.notuse[i + 1] = 0;
            pARow.notuse[i] := 0; //这个...
            //2.列
            pARow := @Cols[c];
            pARow.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pARow.notuse[i] <> 0 do
            begin
              //找到一次后，后面不用再比较了，只需移动位置即可
              if bExist then
                pARow.notuse[i] := pARow.notuse[i + 1]
              //否则比较是否相等
              else if currNum = pARow.notuse[i] then
              begin
                pARow.notuse[i] := pARow.notuse[i + 1];
                bExist := True;
              end;
              //继续下一个数字
              Inc(i);
            end;
            pARow.notuse[i - 1] := 0;
            //1.小矩阵，使用PRow类型指向TRect记录
            pARow := @Rects.VRect[ro][co];
            pARow.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pARow.notuse[i] <> 0 do
            begin
              //找到一次后，后面不用再比较了，只需移动位置即可
              if bExist then
                pARow.notuse[i] := pARow.notuse[i + 1]
              //否则比较是否相等
              else if currNum = pARow.notuse[i] then
              begin
                pARow.notuse[i] := pARow.notuse[i + 1];
                bExist := True;
              end;
              //继续下一个数字
              Inc(i);
            end;
            pARow.notuse[i - 1] := 0; //最后一个还得清0
          end;

          Inc(index);
        end;
      end;
  end;
end;

//用格子所处的列对象为基准
procedure TShudu.ColOnlyCanFillTheCell;
var
  r, c, ro, co, ri, ci, i, j, index: Integer;
  currNum: Integer;
  pARow: PRow;
  bExist, bExistOtherAll: Boolean;
begin
  for r := 1 to 9 do
  begin
    ro := r div 3;
    ri := r mod 3;
    if ri = 0 then
    begin
      //ri := 3;
      Dec(ro);
    end;
    for c := 1 to 9 do
      if Grid[r][c] = 0 then // 空的格子
      begin
        co := c div 3;
        ci := c mod 3;
        if ci = 0 then
        begin
          //ci := 3;
          Dec(co);
        end;
        //格子相关联的三个对象，行、列、Rect
        //Rows[r].notuse0
        //Cols[c].notuse0
        //pRectTmp := @Rects[ro][co];
        index := 1;
        //遍历列对象的未使用列表
        while(Cols[c].notuse[index] <> 0) do
        begin
          currNum := Cols[c].notuse[index];//当前尝试的数字
          //判断数字是否已经被格子所处的行使用
          bExist := False;
          for i := 1 to 9 do
            // 数字已经在行被使用
            if currNum = Rows[r].num[i]^ then
            begin
              bExist := True;
              Break;
            end;
          if bExist then
          begin
            Inc(index);
            Continue;
          end;

          //判断数字是否已经被格子所处小矩阵使用，强制 类型转换为TRow
          pARow := @Rects.VRect[ro][co];
          for i := 1 to 9 do
            // 数字已经在小矩阵被使用
            if currNum = pARow.num[i]^ then
            begin
              bExist := True;
              Break;
            end;
          if bExist then
          begin
            Inc(index);
            Continue;
          end;

          //开始判断是否发生：数字在基准列经过的其它所有行已经被使用
          bExistOtherAll := True;
          for i := 1 to 9 do
          begin
            // 格子所处的行不再分析
            if i = r then Continue;
            //当然只考虑空的格子，已经有数字的格子跳过
            if Cols[c].num[i]^ <> 0 then Continue;
            //数字在第 i 行是否被使用
            bExist := False;
            for j := 1 to 9 do
              if currNum = Rows[i].num[j]^ then
              begin
                bExist := True;
                Break;
              end;
            if not bExist then
            begin
              bExistOtherAll := False;
              Break;
            end;
          end;
          //数字在基准列经过的其它所有行已经被使用，则数字只能填入当前格子
          if bExistOtherAll then
          begin
            Grid[r][c] := currNum;

            //从三个相关联的列表中剔除数字
            //1.列
            pARow := @Cols[c];
            pARow.notuse0[currNum] := 0;
            i := index;
            repeat
              pARow.notuse[i] := pARow.notuse[i + 1];
              Inc(i);
            until pARow.notuse[i + 1] = 0;
            pARow.notuse[i] := 0; //这个...
            //2.行
            pARow := @Rows[r];
            pARow.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pARow.notuse[i] <> 0 do
            begin
              //找到一次后，后面不用再比较了，只需移动位置即可
              if bExist then
                pARow.notuse[i] := pARow.notuse[i + 1]
              //否则比较是否相等
              else if currNum = pARow.notuse[i] then
              begin
                pARow.notuse[i] := pARow.notuse[i + 1];
                bExist := True;
              end;
              //继续下一个数字
              Inc(i);
            end;
            pARow.notuse[i - 1] := 0;
            //1.小矩阵
            pARow := @Rects.VRect[ro][co];
            pARow.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pARow.notuse[i] <> 0 do
            begin
              //找到一次后，后面不用再比较了，只需移动位置即可
              if bExist then
                pARow.notuse[i] := pARow.notuse[i + 1]
              //否则比较是否相等
              else if currNum = pARow.notuse[i] then
              begin
                pARow.notuse[i] := pARow.notuse[i + 1];
                bExist := True;
              end;
              //继续下一个数字
              Inc(i);
            end;
            pARow.notuse[i - 1] := 0; //最后一个还得清0
          end;

          Inc(index);
        end;
      end;
  end;
end;

procedure TShudu.RectOnlyCanFillTheCell;
var
  r, c, ro, co, ri, ci, i, j, index: Integer;
  currNum: Integer;
  pARow: PRow;
  bExist, bExistOtherAll, bHasEmptyCell: Boolean;
begin
  for r := 1 to 9 do
  begin
    ro := r div 3;
    ri := r mod 3;
    if ri = 0 then
    begin
      //ri := 3;
      Dec(ro);
    end;
    for c := 1 to 9 do
      if Grid[r][c] = 0 then // 空的格子
      begin
        co := c div 3;
        ci := c mod 3;
        if ci = 0 then
        begin
          //ci := 3;
          Dec(co);
        end;
        //格子相关联的三个对象，行、列、Rect
        index := 1;
        //遍历Rect对象的未使用列表
        while(Rects.VRect[ro][co].notuse[index] <> 0) do
        begin
          currNum := Rects.VRect[ro][co].notuse[index];//当前尝试的数字
          //判断数字是否已经被格子所处的行使用
          bExist := False;
          for i := 1 to 9 do
            // 数字已经在行被使用
            if currNum = Rows[r].num[i]^ then
            begin
              bExist := True;
              Break;
            end;
          if bExist then
          begin
            Inc(index);
            Continue;
          end;

          //判断数字是否已经被格子所处的列使用
          bExist := False;
          for i := 1 to 9 do
            // 数字已经在列被使用
            if currNum = Cols[c].num[i]^ then
            begin
              bExist := True;
              Break;
            end;
          if bExist then
          begin
            Inc(index);
            Continue;
          end;

          //开始判断是否发生：数字在Rect覆盖的其它所有行、列已经被使用
          bExistOtherAll := True;
          //1.行
          for i := ro * 3 + 1 to ro * 3 + 3 do
          begin
            //格子所处的行不再分析
            if i = r then Continue;
            //判断是否尚有空的格子
            bHasEmptyCell := False;
            for j := co * 3 + 1 to co * 3 + 3 do
              if Grid[i][j] = 0 then //也可以用Rows[i].num[j]^
              begin
                bHasEmptyCell := True;
                Break;
              end;
            if not bHasEmptyCell then Continue; //没有空格子就跳过
            //数字在第 i 行是否被使用
            bExist := False;
            for j := 1 to 9 do
              if currNum = Rows[i].num[j]^ then
              begin
                bExist := True;
                Break;
              end;
            if not bExist then
            begin
              bExistOtherAll := False;
              Break;
            end;
          end;
          //1.列
          for i := co * 3 + 1 to co * 3 + 3 do
          begin
            //格子所处的列不再分析
            if i = c then Continue;
            //判断是否尚有空的格子
            bHasEmptyCell := False;
            for j := ro * 3 + 1 to ro * 3 + 3 do
              if Grid[j][i] = 0 then //也可以用Cols[i].num[j]^
              begin
                bHasEmptyCell := True;
                Break;
              end;
            if not bHasEmptyCell then Continue; //没有空格子就跳过
            //数字在第 i 行是否被使用
            bExist := False;
            for j := 1 to 9 do
              if currNum = Cols[i].num[j]^ then
              begin
                bExist := True;
                Break;
              end;
            if not bExist then
            begin
              bExistOtherAll := False;
              Break;
            end;
          end;

          //数字在基准列经过的其它所有行已经被使用，则数字只能填入当前格子
          if bExistOtherAll then
          begin
            Grid[r][c] := currNum;

            //从三个相关联的列表中剔除数字
            //1.行
            pARow := @Rows[r];
            pARow.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pARow.notuse[i] <> 0 do
            begin
              //找到一次后，后面不用再比较了，只需移动位置即可
              if bExist then
                pARow.notuse[i] := pARow.notuse[i + 1]
              //否则比较是否相等
              else if currNum = pARow.notuse[i] then
              begin
                pARow.notuse[i] := pARow.notuse[i + 1];
                bExist := True;
              end;
              //继续下一个数字
              Inc(i);
            end;
            pARow.notuse[i - 1] := 0;
            //2.列
            pARow := @Cols[c];
            pARow.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pARow.notuse[i] <> 0 do
            begin
              //找到一次后，后面不用再比较了，只需移动位置即可
              if bExist then
                pARow.notuse[i] := pARow.notuse[i + 1]
              //否则比较是否相等
              else if currNum = pARow.notuse[i] then
              begin
                pARow.notuse[i] := pARow.notuse[i + 1];
                bExist := True;
              end;
              //继续下一个数字
              Inc(i);
            end;
            pARow.notuse[i - 1] := 0;
            //3.小矩阵
            pARow := @Rects.VRect[ro][co];
            pARow.notuse0[currNum] := 0;
            i := index;
            repeat
              pARow.notuse[i] := pARow.notuse[i + 1];
              Inc(i);
            until pARow.notuse[i + 1] = 0;
            pARow.notuse[i] := 0;
          end;

          Inc(index);
        end;
      end;
  end;
end;

constructor TShudu.Create;
begin
  inherited;
  Init;
end;

//1.每次定位到一个空的格子
//2.取出与该格子相关联的3个对象，行、列及格子所处的小矩阵
//3.3个对象都没有使用的数字可以填入该格子
procedure TShudu.DoByCell;
var
  r, c, ro, co, ri, ci, i, j: Integer;
begin
  for j := 1 to 20 do //循环10次试下
  for r := 1 to 9 do
  begin
    ro := r div 3;
    ri := r mod 3;
    if ri = 0 then
    begin
      //ri := 3;
      Dec(ro);
    end;
    for c := 1 to 9 do
      if Grid[r][c] = 0 then // 空的格子
      begin
        co := c div 3;
        ci := c mod 3;
        if ci = 0 then
        begin
          //ci := 3;
          Dec(co);
        end;
        //格子相关联的三个对象，行、列、Rect
        //Rows[r].notuse0
        //Cols[c].notuse0
        //pRectTmp := @Rects[ro][co];
        for i := 1 to 9 do
          //三个对象都没有使用的数字，则可以填到格子里
          if (Rows[r].notuse0[i] <> 0) and
             (Rows[r].notuse0[i] = Cols[c].notuse0[i]) and
             (Rows[r].notuse0[i] = Rects.VRect[ro][co].notuse0[i]) then
          begin
            Grid[r][c] := Rows[r].notuse0[i];
            Rows[r].notuse0[i] := 0;
            Cols[c].notuse0[i] := 0;
            Rects.VRect[ro][co].notuse0[i] := 0;
          end;
      end;
  end;
end;

procedure TShudu.Init;
var
  r, c, ro, co, ri, ci: Integer;
begin
  for r := 1 to 9 do
  begin
    ro := r div 3;
    ri := r mod 3;
    if ri = 0 then
    begin
      ri := 3;
      Dec(ro);
    end;
    for c := 1 to 9 do
    begin
      Rows[r].num[c] := @Grid[r][c];

      Cols[c].num[r] := @Grid[r][c];

      co := c div 3;
      ci := c mod 3;
      if ci = 0 then
      begin
        ci := 3;
        Dec(co);
      end;
      //Rects.VRow和Rects.VRect的映射关系
      //(1,2,3,4,5,6,7,8,9)<=>((1,2,3),(4,5,6),(7,8,9))
      Rects.VRect[ro][co].num[ri][ci] := @Grid[r][c];
    end;
  end;
end;

procedure TShudu.InitUseStringGrid(sg: TStringGrid);
var
  r, c: Integer;
begin
  for r := 0 to 8 do
    for c := 0 to 8 do
    begin
      //把界面的值写到Grid
      Grid[r + 1][c + 1] := StrToIntDef(sg.cells[c, r], 0);
    end;
end;

procedure TShudu.InitWithNum;
  procedure  InitARow(row: PRow);
  var //若注释回报错，被嵌套过程不能使用外层过程的局部变量
    i, j, iTmp: Integer;
  begin
    row.notuse0 := cDigits;
    for i := 1 to 9 do
    begin
      iTmp := row.num[i]^;
      if iTmp <> 0 then
      begin
        //数字已被使用，则应该从未使用列表中去掉
        row.used[i] := iTmp;
        row.notuse0[iTmp] := 0;
      end;
    end;
    j := 1;
    for i := 1 to 9 do
      if row.notuse0[i] <> 0 then
      begin
        row.notuse[j] := row.notuse0[i];
        Inc(j);
      end;
  end;
var
  r, c: Integer;
begin
  //行
  for r := 1 to 9 do
    InitARow(@Rows[r]);
  //列
  for c := 1 to 9 do
    InitARow(@Cols[c]);
  //小矩阵
  for r := 1 to 9 do
    InitARow(@Rects.VRow[r]);
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

procedure TShudu.CalcCellByCell;
var
  i: Integer;
begin
  for i := 1 to 30 do
  begin
    RowOnlyCanFillTheCell;
    ColOnlyCanFillTheCell;
    RectOnlyCanFillTheCell
  end;
end;



end.
