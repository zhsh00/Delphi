unit UzslVcl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs
  ,ExtCtrls, StdCtrls;

type
  TImagePanel = class(TPanel)
  private
    FImage: TImage;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Image: TImage read FImage;
  end;

  TStoreProperties = class(TComponent)
  private
    FAnInt: Integer;
    FStrings: TStrings;
  protected
    procedure ReadAnInt(Reader: TReader);
    procedure WriteAnInt(Writer: TWriter);
    procedure ReadStrings(Reader : TReader);
    procedure WriteStrings(Writer : TWriter);
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TEditType = class(TEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
    Procedure SetAsBoolean(const Value : Boolean);
    Function GetAsBoolean: Boolean;
    Procedure SetAsCurrency(const Value : Currency);
    Function GetAsCurrency: Currency;
    Procedure SetAsDate(const Value : TDateTime);
    Function GetAsDate: TDateTime;
    Procedure SetAsDateTime(const Value : TDateTime);
    Function GetAsDateTime: TDateTime;
    Procedure SetAsFloat(const Value : Double);
    Function GetAsFloat: Double;
    Procedure SetAsInteger(const Value : Integer);
    Function GetAsInteger: Integer;
    Procedure SetAsTime(const Value : TDateTime);
    Function GetAsTime: TDateTime;
    Procedure SetAsString(const Value : String);
    Function GetAsString: String;
  public
    { Public declarations }
//    procedure RunTests;
    Property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    Property AsCurrency: Currency read GetAsCurrency write SetAsCurrency;
    Property AsDate: TDateTime read GetAsDate write SetAsDate;
    Property AsDateTime : TDateTime read GetAsDateTime write SetAsDateTime;
    Property AsFloat: Double read GetAsFloat write SetAsFloat;
    Property AsInteger: Longint read GetAsInteger write SetAsInteger;
    Property AsTime: TDateTime read GetAsTime write SetAsTime;
    Property AsString: string read GetAsString write SetAsString;
  published
    { Published declarations }
  end;

//procedure Register;

implementation

{$R *.dcr}
//procedure Register;
//begin
//  RegisterComponents('zhshll', [TImagePanel]);
//end;


{ TImagePanel }

constructor TImagePanel.Create(AOwner: TComponent);
begin
  inherited;
  FImage := TImage.Create(Self);
  FImage.Parent := Self;
  FImage.Align := alClient;
  FImage.SetSubComponent(True);
end;

{ TStoreProperties }

constructor TStoreProperties.Create(AOwner: TComponent);
const
  ROBERT_HERRICK = 'zhshll''s robert';
begin
  inherited;
  FAnInt := 100;
  FStrings := TStringList.Create;
  FStrings.Text := ROBERT_HERRICK;
end;

procedure TStoreProperties.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    if Filer.Ancestor <> nil then
      //1.祖先不是TStoreProperties
      result := not (Filer.Ancestor is TStoreProperties) or
      //2.祖先是TStoreProperties，但是，祖先的FStrings.Text和后辈的FStrings.Text有不同时。
      not (TStoreProperties(Filer.Ancestor).FStrings.Text = FStrings.Text)
    else
      result := not (FStrings.Text = EmptyStr);
  end;

begin
  inherited;
  Filer.DefineProperty('AnInt', ReadAnInt, WriteAnInt, True);
  Filer.DefineProperty('Strings', ReadStrings, WriteStrings, DoWrite);
end;

destructor TStoreProperties.Destroy;
begin
  FStrings.Free;
  inherited;
end;

procedure TStoreProperties.ReadAnInt(Reader: TReader);
begin
  FAnInt := Reader.ReadInteger;
end;

procedure TStoreProperties.ReadStrings(Reader: TReader);
begin
  Reader.ReadListBegin;
  FStrings.Clear;
  while not Reader.EndOfList do
    FStrings.Add(Reader.ReadString);
  Reader.ReadListEnd;
end;

procedure TStoreProperties.WriteAnInt(Writer: TWriter);
begin
  Writer.WriteInteger(FAnInt);
end;

procedure TStoreProperties.WriteStrings(Writer: TWriter);
var
  I: Integer;
begin
  Writer.WriteListBegin;
  for I := 0 to FStrings.Count - 1 do
    Writer.WriteString(FStrings[I]);
  Writer.WriteListEnd;
end;

{ TEditType }

procedure TEditType.SetAsBoolean(const Value: Boolean);
begin
//asm int 3 end; //Trap
  Text := BoolToStr(Value);//TBooleanUtil.BooleanToStr(Value);
end;

function TEditType.GetAsBoolean: Boolean;
begin
//asm int 3 end; //Trap
  result := StrToBool(Text);//TBooleanUtil.StrToBoolean(Text);
end;

procedure TEditType.SetAsCurrency(const Value: Currency);
begin
//asm int 3 end; //Trap
  Text := FloatToStr(Value);
end;

function TEditType.GetAsCurrency: Currency;
begin
//asm int 3 end; //Trap
  result := StrToFloat(Text);
end;

procedure TEditType.SetAsDate(const Value: TDateTime);
begin
//asm int 3 end; //Trap
  Text := DateToStr(Value);
end;

function TEditType.GetAsDate: TDateTime;
begin
//asm int 3 end; //Trap
  result := StrToDate(Text);
end;

procedure TEditType.SetAsDateTime(const Value: TDateTime);
begin
//asm int 3 end; //Trap
  Text := DateTimeToStr(Value);
end;

function TEditType.GetAsDateTime: TDateTime;
begin
asm int 3 end; //Trap
  result := StrToDateTime(Text);
end;

procedure TEditType.SetAsFloat(const Value: Double);
begin
//asm int 3 end; //Trap
  Text := FloatToStr(Value);
end;

function TEditType.GetAsFloat: Double;
begin
//asm int 3 end; //Trap
  result := StrToFloat(Text);
end;

procedure TEditType.SetAsInteger(const Value: Integer);
begin
//asm int 3 end; //Trap
  Text := IntToStr(Value);
end;

function TEditType.GetAsInteger: Integer;
begin
asm int 3 end; //Trap
  result := StrToInt(Text);
end;

procedure TEditType.SetAsTime(const Value: TDateTime);
begin
//asm int 3 end; //Trap
  Text := TimeToStr(Value);
end;

function TEditType.GetAsTime: TDateTime;
begin
asm int 3 end; //Trap
  result := StrToTime(Text);
end;

procedure TEditType.SetAsString(const Value: String);
begin
asm int 3 end; //Trap
  Text := Value;
end;

function TEditType.GetAsString: String;
begin
//asm int 3 end; //Trap
  result := Text;
end;

//procedure TEditType.RunTests;
//var
//  C: Currency;
//begin
//{$IFOPT D+}
//  Text := 'True';
//  if(AsBoolean) then AsBoolean := Not AsBoolean;
//  Text := '300.37';
//  C := AsCurrency;
//  AsCurrency := 547.29;
//  ShowMessage(AsString);
//  AsDate := Now;
//  if(AsDate <= Now) then
//  AsDatetime := AsDate;
//  ShowMessage('The date is :' + AsString);
//  AsFloat := 12345.67;
//  AsFloat := 2 * AsFloat;
//  AsInteger := Trunc(AsFloat);
//  AsTime := Now;
//  ShowMessage('The time is: ' + Text);
//{$ENDIF}
//end;


end.

