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

  // TRow��TCol�ṹһ��
  TRow = record
    num: TNumRow; //nums[1..9]�����α�ʾ����
    used: TDigit;
    notuse: TDigit; //�������֡���δ������е�����
    notuse0: TDigit; //�������֡���������ռλ0
  end;
  PRow = ^TRow;

  //ע��TRect��cells�Ƕ�ά����
  //���� TNumRow �� TNumRect ��sizeһ���󣬿���ǿ������ת��
  //������Ӧ��ϵ��(1,2,3,4,5,6,7,8,9)<=>((1,2,3),(4,5,6),(7,8,9))
  //TRect��TRow��sizeһ���������ݽṹ�ǳ�������
  TRect = record
    num:  TNumRect;
    used: TDigit;
    notuse: TDigit; //�������֡���δ������е�����
    notuse0: TDigit; //�������֡���������ռλ0
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
    Rects: TVarRect;//����

    constructor Create();
    //��ʼ���ڲ���ָ���ϵ
    procedure Init;
    //���ݽ����������ݳ�ʼ�����������Grid����
    procedure InitUseStringGrid(sg: TStringGrid);
    //Grid��ʼ������ܵ���
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
      //�ѽ����ֵд��Grid
      sgInit.cells[c, r] := '';
    end;
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
      if Grid[r][c] = 0 then // �յĸ���
      begin
        co := c div 3;
        ci := c mod 3;
        if ci = 0 then
        begin
          //ci := 3;
          Dec(co);
        end;
        //��������������������С��С�Rect
        index := 1;
        //�����ж����δʹ���б�
        while(Rows[r].notuse[index] <> 0) do
        begin
          currNum := Rows[r].notuse[index];
          //�ж������Ƿ��Ѿ���������������ʹ��
          bExist := False;
          for i := 1 to 9 do
            // �����Ѿ����б�ʹ��
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

          //�ж������Ƿ��Ѿ�����������С����ʹ�ã�ǿ�� ����ת��ΪTRow
          pARow := @Rects.VRect[ro][co];
          for i := 1 to 9 do
            // �����Ѿ���С����ʹ��
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
          //�����ڻ�׼�о����������������Ѿ���ʹ�ã�������ֻ�����뵱ǰ����
          if bExistOtherAll then
          begin
            Grid[r][c] := currNum;

            //���б����޳�����
            //1.��
            pARow := @Rows[r];
            pARow.notuse0[currNum] := 0;
            i := index;
            repeat
              pARow.notuse[i] := pARow.notuse[i + 1];
              Inc(i);
            until pARow.notuse[i + 1] = 0;
            pARow.notuse[i] := 0; //���...
            //2.��
            pARow := @Cols[c];
            pARow.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pARow.notuse[i] <> 0 do
            begin
              //�ҵ�һ�κ󣬺��治���ٱȽ��ˣ�ֻ���ƶ�λ�ü���
              if bExist then
                pARow.notuse[i] := pARow.notuse[i + 1]
              //����Ƚ��Ƿ����
              else if currNum = pARow.notuse[i] then
              begin
                pARow.notuse[i] := pARow.notuse[i + 1];
                bExist := True;
              end;
              //������һ������
              Inc(i);
            end;
            pARow.notuse[i - 1] := 0;
            //1.С����ʹ��PRow����ָ��TRect��¼
            pARow := @Rects.VRect[ro][co];
            pARow.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pARow.notuse[i] <> 0 do
            begin
              //�ҵ�һ�κ󣬺��治���ٱȽ��ˣ�ֻ���ƶ�λ�ü���
              if bExist then
                pARow.notuse[i] := pARow.notuse[i + 1]
              //����Ƚ��Ƿ����
              else if currNum = pARow.notuse[i] then
              begin
                pARow.notuse[i] := pARow.notuse[i + 1];
                bExist := True;
              end;
              //������һ������
              Inc(i);
            end;
            pARow.notuse[i - 1] := 0; //���һ��������0
          end;

          Inc(index);
        end;
      end;
  end;
end;

//�ø����������ж���Ϊ��׼
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
      if Grid[r][c] = 0 then // �յĸ���
      begin
        co := c div 3;
        ci := c mod 3;
        if ci = 0 then
        begin
          //ci := 3;
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

          //�ж������Ƿ��Ѿ�����������С����ʹ�ã�ǿ�� ����ת��ΪTRow
          pARow := @Rects.VRect[ro][co];
          for i := 1 to 9 do
            // �����Ѿ���С����ʹ��
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
            pARow := @Cols[c];
            pARow.notuse0[currNum] := 0;
            i := index;
            repeat
              pARow.notuse[i] := pARow.notuse[i + 1];
              Inc(i);
            until pARow.notuse[i + 1] = 0;
            pARow.notuse[i] := 0; //���...
            //2.��
            pARow := @Rows[r];
            pARow.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pARow.notuse[i] <> 0 do
            begin
              //�ҵ�һ�κ󣬺��治���ٱȽ��ˣ�ֻ���ƶ�λ�ü���
              if bExist then
                pARow.notuse[i] := pARow.notuse[i + 1]
              //����Ƚ��Ƿ����
              else if currNum = pARow.notuse[i] then
              begin
                pARow.notuse[i] := pARow.notuse[i + 1];
                bExist := True;
              end;
              //������һ������
              Inc(i);
            end;
            pARow.notuse[i - 1] := 0;
            //1.С����
            pARow := @Rects.VRect[ro][co];
            pARow.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pARow.notuse[i] <> 0 do
            begin
              //�ҵ�һ�κ󣬺��治���ٱȽ��ˣ�ֻ���ƶ�λ�ü���
              if bExist then
                pARow.notuse[i] := pARow.notuse[i + 1]
              //����Ƚ��Ƿ����
              else if currNum = pARow.notuse[i] then
              begin
                pARow.notuse[i] := pARow.notuse[i + 1];
                bExist := True;
              end;
              //������һ������
              Inc(i);
            end;
            pARow.notuse[i - 1] := 0; //���һ��������0
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
      if Grid[r][c] = 0 then // �յĸ���
      begin
        co := c div 3;
        ci := c mod 3;
        if ci = 0 then
        begin
          //ci := 3;
          Dec(co);
        end;
        //��������������������С��С�Rect
        index := 1;
        //����Rect�����δʹ���б�
        while(Rects.VRect[ro][co].notuse[index] <> 0) do
        begin
          currNum := Rects.VRect[ro][co].notuse[index];//��ǰ���Ե�����
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

          //�ж������Ƿ��Ѿ���������������ʹ��
          bExist := False;
          for i := 1 to 9 do
            // �����Ѿ����б�ʹ��
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

          //��ʼ�ж��Ƿ�����������Rect���ǵ����������С����Ѿ���ʹ��
          bExistOtherAll := True;
          //1.��
          for i := ro * 3 + 1 to ro * 3 + 3 do
          begin
            //�����������в��ٷ���
            if i = r then Continue;
            //�ж��Ƿ����пյĸ���
            bHasEmptyCell := False;
            for j := co * 3 + 1 to co * 3 + 3 do
              if Grid[i][j] = 0 then //Ҳ������Rows[i].num[j]^
              begin
                bHasEmptyCell := True;
                Break;
              end;
            if not bHasEmptyCell then Continue; //û�пո��Ӿ�����
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
          //1.��
          for i := co * 3 + 1 to co * 3 + 3 do
          begin
            //�����������в��ٷ���
            if i = c then Continue;
            //�ж��Ƿ����пյĸ���
            bHasEmptyCell := False;
            for j := ro * 3 + 1 to ro * 3 + 3 do
              if Grid[j][i] = 0 then //Ҳ������Cols[i].num[j]^
              begin
                bHasEmptyCell := True;
                Break;
              end;
            if not bHasEmptyCell then Continue; //û�пո��Ӿ�����
            //�����ڵ� i ���Ƿ�ʹ��
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

          //�����ڻ�׼�о����������������Ѿ���ʹ�ã�������ֻ�����뵱ǰ����
          if bExistOtherAll then
          begin
            Grid[r][c] := currNum;

            //��������������б����޳�����
            //1.��
            pARow := @Rows[r];
            pARow.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pARow.notuse[i] <> 0 do
            begin
              //�ҵ�һ�κ󣬺��治���ٱȽ��ˣ�ֻ���ƶ�λ�ü���
              if bExist then
                pARow.notuse[i] := pARow.notuse[i + 1]
              //����Ƚ��Ƿ����
              else if currNum = pARow.notuse[i] then
              begin
                pARow.notuse[i] := pARow.notuse[i + 1];
                bExist := True;
              end;
              //������һ������
              Inc(i);
            end;
            pARow.notuse[i - 1] := 0;
            //2.��
            pARow := @Cols[c];
            pARow.notuse0[currNum] := 0;
            i := 1;
            bExist := False;
            while pARow.notuse[i] <> 0 do
            begin
              //�ҵ�һ�κ󣬺��治���ٱȽ��ˣ�ֻ���ƶ�λ�ü���
              if bExist then
                pARow.notuse[i] := pARow.notuse[i + 1]
              //����Ƚ��Ƿ����
              else if currNum = pARow.notuse[i] then
              begin
                pARow.notuse[i] := pARow.notuse[i + 1];
                bExist := True;
              end;
              //������һ������
              Inc(i);
            end;
            pARow.notuse[i - 1] := 0;
            //3.С����
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

//1.ÿ�ζ�λ��һ���յĸ���
//2.ȡ����ø����������3�������С��м�����������С����
//3.3������û��ʹ�õ����ֿ�������ø���
procedure TShudu.DoByCell;
var
  r, c, ro, co, ri, ci, i, j: Integer;
begin
  for j := 1 to 20 do //ѭ��10������
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
      if Grid[r][c] = 0 then // �յĸ���
      begin
        co := c div 3;
        ci := c mod 3;
        if ci = 0 then
        begin
          //ci := 3;
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
      //Rects.VRow��Rects.VRect��ӳ���ϵ
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
      //�ѽ����ֵд��Grid
      Grid[r + 1][c + 1] := StrToIntDef(sg.cells[c, r], 0);
    end;
end;

procedure TShudu.InitWithNum;
  procedure  InitARow(row: PRow);
  var //��ע�ͻر�����Ƕ�׹��̲���ʹ�������̵ľֲ�����
    i, j, iTmp: Integer;
  begin
    row.notuse0 := cDigits;
    for i := 1 to 9 do
    begin
      iTmp := row.num[i]^;
      if iTmp <> 0 then
      begin
        //�����ѱ�ʹ�ã���Ӧ�ô�δʹ���б���ȥ��
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
  //��
  for r := 1 to 9 do
    InitARow(@Rows[r]);
  //��
  for c := 1 to 9 do
    InitARow(@Cols[c]);
  //С����
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
