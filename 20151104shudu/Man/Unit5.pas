unit Unit5;

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

  // TRow��TCol�ṹһ��
  TRow = record
    num: TNumRow; //nums[1..9]�����α�ʾ����
    used: TDigit;
    notuse: TDigit; //�������֡���δ������е�����
    notuse0: TDigit; //�������֡���������ռλ0
  end;
  PRow = ^TRow;

  //ע��TRect��cells�Ƕ�ά����
  //ʹ��һ������,������Ӧ��ϵ��(1,2,3,4,5,6,7,8,9)<=>((1,2,3),(4,5,6),(7,8,9))
  //TRect��TRow��sizeһ���������ݽṹ�ǳ�������
  TRect = record
    num:  TVarPInteger;
    used: TDigit;
    notuse: TDigit; //�������֡���δ������е�����
    notuse0: TDigit; //�������֡���������ռλ0
  end;
  PRect = ^TRect;
  //ֱ�Ӱ�TRect����ú�TRowһ��
  //ʹ��һ�����壬����num�ֶ����Ͳ�ͬ������sizeһ�£�num����������Ӧ��ϵ��
  //(1,2,3,4,5,6,7,8,9)<=>((1,2,3),(4,5,6),(7,8,9))
//  TRect = record
//    case Integer of
//    1: (
//      num:  TNumRect;
//      used: TDigit;
//      notuse: TDigit; //�������֡���δ������е�����
//      notuse0: TDigit; //�������֡���������ռλ0
//      );
//    2: (
//      num2: TNumRow; //nums[1..9]�����α�ʾ����
//      used2: TDigit;
//      notuse2: TDigit; //�������֡���δ������е�����
//      notuse02: TDigit; //�������֡���������ռλ0
//      );
//  end;
//  PRect = ^TRect;

  TShudu = class
  public
    Grid: TGrid;
    Rows: array [1..9] of TRow;
    Cols: array [1..9] of TRow;
    Rects: array [0..2] of array [0..2] of TRect;

    constructor Create();
    //��ʼ���ڲ���ָ���ϵ
    procedure Init;
    //���ݽ����������ݳ�ʼ�����������Grid����
    procedure InitUseStringGrid(sg: TStringGrid);
    //Grid��ʼ������ܵ���
    procedure InitWithNum();
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
    //
    procedure DoByCell;
    procedure RowOnlyCanFillTheCell;
    procedure ColOnlyCanFillTheCell;
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
//1.ÿ�ζ�λ��һ���յĸ���,�Ը�����������Ϊ��׼��ȡ���е�δʹ�������б�
//2.����ÿһ������
//2.1.�����Ѿ��������������С�С����ʹ�õ�����
//2.2.�����ڻ�׼�о����������������Ѿ���ʹ��
//2.2.1.�������Ƿ��пյĸ���
//2.2.1.���������Ƿ��Ѿ�ʹ�ø�����
//2.2.1...
//3.������ֻ������ø���
//4.��3��δʹ���б����޳�����
procedure TShudu.RowOnlyCanFillTheCell;
var
  r, c, ro, co, ri, ci, i, j, k, ri1, ci1, index: Integer;
  currNum: Integer;
  pRectTmp: PRect;
  bExist, bExistOtherAll: Boolean;
  vv: TVarPInteger;
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
      if Grid[r][c] = 0 then // �յĸ���
      begin
        co := c div 3;
        ci := c mod 3;
        if ci = 0 then
        begin
          ci := 3;
          Dec(co);
        end;
        //��������������������С��С�Rect
        //Rows[r].notuse0
        //Cols[c].notuse0
        //pRectTmp := @Rects[ro][co];
        index := 1;
        //�����ж����δʹ���б�
        while(Rows[r].notuse[index] <> 0) do
        begin
          //�ж������Ƿ��Ѿ���������������ʹ��
          bExist := False;
          for i := 1 to 9 do
            // �����Ѿ����б�ʹ��
            if Rows[r].notuse[index] = Cols[c].num[i]^ then
            begin
              bExist := True;
              Break;
            end;
          if bExist then
          begin
            Inc(index);
            Continue;
          end;

          //�ж������Ƿ��Ѿ�����������С����ʹ��
          pRectTmp := @Rects[ro][co];
          for ri1 := 1 to 3 do
          begin
            for ci1 := 1 to 3 do
            begin
              // �����Ѿ���С����ʹ��
              if Rows[r].notuse[index] = pRectTmp.num.VRect[ri1][ci1]^ then
              begin
                bExist := True;
                Break;
              end;
            end;
            //����Ҫ�������ѭ���ȽϷ�
            if bExist then
              Break;
          end;
          if bExist then
          begin
            Inc(index);
            Continue;
          end;

          //��ʼ�ж��Ƿ����������ڻ�׼�о����������������Ѿ���ʹ��
          bExistOtherAll := True;
          for i := 1 to 9 do
          begin
            // �����������в��ٷ���
            if i = c then Continue;
            //��Ȼֻ���ǿյĸ��ӣ��Ѿ������ֵĸ�������
            if Rows[r].num[i]^ <> 0 then Continue;
            //�����ڵ� i ���Ƿ�ʹ��
            bExist := False;
            for j := 1 to 9 do
              if Rows[r].notuse[index] = Cols[i].num[j]^ then
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
          //�����ڻ�׼�о����������������Ѿ���ʹ�ã�������ֻ�����뵱ǰ����
          if bExistOtherAll then
          begin
            Grid[r][c] := Rows[r].notuse[index];

            //���б����޳�����
            currNum := Rows[r].notuse[index];//Ӧ����ǰ...
            //1.��
            Rows[r].notuse0[currNum] := 0;
            i := index;
            repeat
              Rows[r].notuse[i] := Rows[r].notuse[i + 1];
              Inc(i);
            until Rows[r].notuse[i + 1] = 0;
            Rows[r].notuse[i] := 0; //���...
            //2.��
            Cols[c].notuse0[currNum] := 0;
            i := 0;
            bExist := False;
            //�����ֿ���������ӣ������ڸ��������������δʹ���б������
            //�������ٿ���ѭ��һ��
            repeat
              Inc(i); // ��1��ʼ
              //�ҵ�һ�κ󣬺��治���ٱȽ��ˣ�ֻ���ƶ�λ�ü���
              if bExist then
              begin
                Cols[c].notuse[i] := Cols[c].notuse[i + 1];
                Inc(i);
              end
              //����Ƚ��Ƿ����
              else if currNum = Cols[c].notuse[i] then
              begin
                Cols[c].notuse[i] := Cols[c].notuse[i + 1];
                bExist := True;
              end;
            until Cols[c].notuse[i + 1] = 0;
            Cols[c].notuse[i] := 0;
            //1.С����
            pRectTmp.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pRectTmp.notuse[i] <> 0 do
            begin
              //�ҵ�һ�κ󣬺��治���ٱȽ��ˣ�ֻ���ƶ�λ�ü���
              if bExist then
              begin
                pRectTmp.notuse[i] := pRectTmp.notuse[i + 1];
                Inc(i);
              end
              //����Ƚ��Ƿ����
              else if currNum = pRectTmp.notuse[i] then
              begin
                pRectTmp.notuse[i] := pRectTmp.notuse[i + 1];
                bExist := True;
              end;
              //������һ������
              Inc(i);
            end;
            pRectTmp.notuse[i - 1] := 0; //���һ��������0
          end;

          Inc(index);
        end;
      end;
  end;
end;

//�ø����������ж���Ϊ��׼
procedure TShudu.ColOnlyCanFillTheCell;
var
  r, c, ro, co, ri, ci, i, j, k, ri1, ci1, index: Integer;
  currNum: Integer;
  pRectTmp: PRect;
  bExist, bExistOtherAll: Boolean;
  vv: TVarPInteger;
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
      if Grid[r][c] = 0 then // �յĸ���
      begin
        co := c div 3;
        ci := c mod 3;
        if ci = 0 then
        begin
          ci := 3;
          Dec(co);
        end;
        //��������������������С��С�Rect
        //Rows[r].notuse0
        //Cols[c].notuse0
        //pRectTmp := @Rects[ro][co];
        index := 1;
        //�����ж����δʹ���б�
        while(Cols[c].notuse[index] <> 0) do
        begin
          currNum := Cols[c].notuse[index];//��ǰ���Ե�����
          //�ж������Ƿ��Ѿ���������������ʹ��
          bExist := False;
          for i := 1 to 9 do
            // �����Ѿ����б�ʹ��
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

          //�ж������Ƿ��Ѿ�����������С����ʹ��
          pRectTmp := @Rects[ro][co];
          for ri1 := 1 to 3 do
          begin
            for ci1 := 1 to 3 do
            begin
              // �����Ѿ���С����ʹ��
              if currNum = pRectTmp.num.VRect[ri1][ci1]^ then
              begin
                bExist := True;
                Break;
              end;
            end;
            //����Ҫ�������ѭ���ȽϷ�
            if bExist then
              Break;
          end;
          if bExist then
          begin
            Inc(index);
            Continue;
          end;

          //��ʼ�ж��Ƿ����������ڻ�׼�о����������������Ѿ���ʹ��
          bExistOtherAll := True;
          for i := 1 to 9 do
          begin
            // �����������в��ٷ���
            if i = r then Continue;
            //��Ȼֻ���ǿյĸ��ӣ��Ѿ������ֵĸ�������
            if Cols[c].num[i]^ <> 0 then Continue;
            //�����ڵ� i ���Ƿ�ʹ��
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
          //�����ڻ�׼�о����������������Ѿ���ʹ�ã�������ֻ�����뵱ǰ����
          if bExistOtherAll then
          begin
            Grid[r][c] := currNum;

            //��������������б����޳�����
            //1.��
            Cols[c].notuse0[currNum] := 0;
            i := index;
            repeat
              Cols[c].notuse[i] := Cols[c].notuse[i + 1];
              Inc(i);
            until Cols[c].notuse[i + 1] = 0;
            Cols[c].notuse[i] := 0; //���...
            //2.��
            Rows[r].notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while Rows[r].notuse[i] <> 0 do
            begin
              //�ҵ�һ�κ󣬺��治���ٱȽ��ˣ�ֻ���ƶ�λ�ü���
              if bExist then
                Rows[r].notuse[i] := Rows[r].notuse[i + 1]
              //����Ƚ��Ƿ����
              else if currNum = Rows[r].notuse[i] then
              begin
                Rows[r].notuse[i] := Rows[r].notuse[i + 1];
                bExist := True;
              end;
              //������һ������
              Inc(i);
            end;
            Rows[r].notuse[i - 1] := 0;
            //1.С����
            pRectTmp.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pRectTmp.notuse[i] <> 0 do
            begin
              //�ҵ�һ�κ󣬺��治���ٱȽ��ˣ�ֻ���ƶ�λ�ü���
              if bExist then
                pRectTmp.notuse[i] := pRectTmp.notuse[i + 1]
              //����Ƚ��Ƿ����
              else if currNum = pRectTmp.notuse[i] then
              begin
                pRectTmp.notuse[i] := pRectTmp.notuse[i + 1];
                bExist := True;
              end;
              //������һ������
              Inc(i);
            end;
            pRectTmp.notuse[i - 1] := 0; //���һ��������0
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

//1.ÿ�ζ�λ��һ���յĸ���
//2.ȡ����ø����������3�������С��м�����������С����
//3.3������û��ʹ�õ����ֿ�������ø���
procedure TShudu.DoByCell;
var
  r, c, ro, co, ri, ci, i, j: Integer;
  pRectTmp: PRect;
begin
  for j := 1 to 20 do //ѭ��10������
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
      if Grid[r][c] = 0 then // �յĸ���
      begin
        co := c div 3;
        ci := c mod 3;
        if ci = 0 then
        begin
          ci := 3;
          Dec(co);
        end;
        //��������������������С��С�Rect
        //Rows[r].notuse0
        //Cols[c].notuse0
        //pRectTmp := @Rects[ro][co];
        for i := 1 to 9 do
          //��������û��ʹ�õ����֣�������������
          if (Rows[r].notuse0[i] <> 0) and
             (Rows[r].notuse0[i] = Cols[c].notuse0[i]) and
             (Rows[r].notuse0[i] = Rects[ro][co].notuse0[i]) then
          begin
            Grid[r][c] := Rows[r].notuse0[i];
            Rows[r].notuse0[i] := 0;
            Cols[c].notuse0[i] := 0;
            Rects[ro][co].notuse0[i] := 0;
          end;
      end;
  end;
end;

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
      Rects[ro][co].num.VRect[ri][ci] := @Grid[r][c];
    end;
  end;
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

procedure TShudu.InitWithNum;
var
  r, c, iTmp, ro, co: Integer;
  pRectTmp: PRect;
  pARow: PRow;
  vv: TVarPInteger;
begin
  //��
  for r := 1 to 9 do
  begin
    pARow := @Rows[r];
    pARow.notuse0 := cDigits;
    for c := 1 to 9 do
    begin
      iTmp := pARow.num[c]^;
      if iTmp <> 0 then
      begin
        //�����ѱ�ʹ�ã���Ӧ�ô�δʹ���б���ȥ��
        pARow.used[c] := iTmp;
        pARow.notuse0[iTmp] := 0;
      end;
    end;
    iTmp := 1;
    for c := 1 to 9 do
      if pARow.notuse0[c] <> 0 then
      begin
        pARow.notuse[iTmp] := pARow.notuse0[c];
        Inc(iTmp);
      end;
  end;

  //��
  for c := 1 to 9 do
  begin
    pARow := @Cols[c]; //�к��е����ݽṹ��һ����
    pARow.notuse0 := cDigits;
    for r := 1 to 9 do
    begin
      iTmp := pARow.num[r]^;
      if iTmp <> 0 then
      begin
        //�����ѱ�ʹ�ã���Ӧ�ô�δʹ���б���ȥ��
        pARow.used[r] := iTmp;
        pARow.notuse0[iTmp] := 0;
      end;
    end;
    iTmp := 1;
    for r := 1 to 9 do
      if pARow.notuse0[r] <> 0 then
      begin
        pARow.notuse[iTmp] := pARow.notuse0[r];
        Inc(iTmp);
      end;
  end;

  //TRect����
  for ro := 0 to 2 do
    for co := 0 to 2 do
    begin
      //ʹ���и�ʽ
      pARow := @Rects[ro][co];
      //Ҳ����ʹ��ǿ������ת���İɣ�
      pRectTmp := @Rects[ro][co];
      pRectTmp.notuse0 := cDigits;
      for r := 1 to 9 do
      begin
        //ʹ���и�ʽ
        iTmp := pRectTmp.num.VRow[r]^;
        if iTmp <> 0 then
        begin
          //�����ѱ�ʹ�ã���Ӧ�ô�δʹ���б���ȥ��
          pRectTmp.used[r] := iTmp;
          pRectTmp.notuse0[iTmp] := 0;
        end;
      end;
      iTmp := 1;
      for r := 1 to 9 do
        if pRectTmp.notuse0[r] <> 0 then
        begin
          pRectTmp.notuse[iTmp] := pRectTmp.notuse0[r];
          Inc(iTmp);
        end;
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



procedure TShudu.CalcCellByCell;
var
  i: Integer;
begin
  for i := 1 to 30 do
  begin
    RowOnlyCanFillTheCell;
    ColOnlyCanFillTheCell;
  end;
end;

end.
