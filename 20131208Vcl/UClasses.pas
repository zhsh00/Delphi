unit UClasses;

interface

uses
  Windows, Messages, Classes, Controls, TntControls, StdCtrls, Graphics,
  TntClasses, TntSysUtils, TntStdCtrls, SysUtils, Dialogs, TntButtons, Forms;

const
  IDI_SubEditMinWidth = 40;
  IDI_SubBtnMinWidth  = 22;
  
{ TGcxCustomEdit }
type
  TGcxCustomEdit = class(TTntCustomEdit)
  private
    FAlignment: TAlignment;//2013-12-08,
    FMargin: Integer;//2013-12-08,
    FCommonColor: TColor;
    FReadOnlyColor: TColor;
    FLoading: Boolean;
    procedure SetCommonColor(const Value: TColor);
    procedure SetReadOnlyColor(const Value: TColor);
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const Value: Boolean);
    function GetColor: TColor;
    procedure SetColor(const Value: TColor);
    function GetLoading: Boolean;
    procedure SetLoading(const Value: Boolean);
    procedure SetAlignment(Value: TAlignment);//2013-12-08,
    procedure SetMargin(const Value: Integer);
  protected
    procedure UpdateColor;
    function AllowKey(Key: Char): Boolean; virtual;
    procedure KeyPress(var Key: Char); override;
    procedure CompleteChange; virtual;
    procedure CreateParams(var Params: TCreateParams); override;//2013-12-08,
    procedure CreateWnd; override;//2013-12-08,
    procedure SetEditRect; virtual;//2013-12-08,

    property CommonColor: TColor
      read FCommonColor write SetCommonColor default clInfoBk;
    property ReadOnlyColor: TColor
      read FReadOnlyColor write SetReadOnlyColor default clSkyBlue;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property Color: TColor read GetColor write SetColor default clInfoBk;
    property Loading: Boolean read GetLoading write SetLoading;
    property Alignment: TAlignment
      read FAlignment write SetAlignment default taLeftJustify;
    property Margin: Integer read FMargin write SetMargin default 5;
    property TabStop default True;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Width default 49;
  end;

{ TGcxEdit }
  TGcxEdit = class(TGcxCustomEdit)
  published
    property CommonColor;
    property ReadOnlyColor;
    property Alignment;//2013-12-08,
    property Margin;//2013-12-08,

    property Align;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    {$IFDEF COMPILER_9_UP}
    property OnMouseActivate;
    {$ENDIF}
    property OnMouseDown;
    {$IFDEF COMPILER_10_UP}
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TGcxCustomIntEdit }
  TIntegerFormatStyle = (ifsInteger, ifsHex, ifsBinary, ifsOctal);

  TGcxCustomIntEdit = class(TGcxCustomEdit)
  private
    FValue   : Integer;
    FValueMax: Integer;
    FValueMin: Integer;
    FFormatStyle: TIntegerFormatStyle;
    FLeadingZeros: Boolean;
    FBeepOnError: Boolean;
    FUndoOnError: Boolean;
    procedure SetValue(const Value: Integer);
    procedure SetValueMax(const Value: Integer);
    procedure SetValueMin(const Value: Integer);
    procedure SetFormatStyle(const Value: TIntegerFormatStyle);
    procedure SetMaxLength(const Value: Integer);
    function GetMaxLength: Integer;
    procedure SetLeadingZeros(const Value: Boolean);
  protected
    function GetText(Value: Integer): WideString;
    procedure UpdateText;
    procedure CompleteChange; override;
    procedure DoExit; override;
    function  GetValue(Value: WideString): Integer;
    function AllowKey(Key: Char): Boolean; override;

    property Value   : Integer read FValue    write SetValue    default 0;
    property ValueMax: Integer read FValueMax write SetValueMax default 0;
    property ValueMin: Integer read FValueMin write SetValueMin default 0;
    property FormatStyle: TIntegerFormatStyle read FFormatStyle
      write SetFormatStyle default ifsInteger;
    property MaxLength: Integer read GetMaxLength write SetMaxLength default 0;
    property LeadingZeros: Boolean read FLeadingZeros write SetLeadingZeros;
    property BeepOnError: Boolean
      read FBeepOnError write FBeepOnError default False;
    property UndoOnError: Boolean
      read FUndoOnError write FUndoOnError default True;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
 end;

{ TGcxIntEdit }
  TGcxIntEdit = class(TGcxCustomIntEdit)
  published
    property Value;
    property ValueMax;
    property ValueMin;
    property FormatStyle;
    property LeadingZeros;
    property CommonColor;
    property ReadOnlyColor;

    property Align;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    {$IFDEF COMPILER_9_UP}
    property OnMouseActivate;
    {$ENDIF}
    property OnMouseDown;
    {$IFDEF COMPILER_10_UP}
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TGcxCustomLabel }
  TGcxCustomLabel = class(TTntCustomLabel)
  private

  protected

  public
    //constructor Create;
    //destructor Destroy; override;
  published

  end;

{ TGcxBoundLabel }

  TLabelPosition = (lpLeft, lpRight, lpAbove, lpBelow);

  IBoundLabelOwner = interface
  ['{4A1CE667-3DDC-4E08-A4FA-3222090968D5}']
    function GetLabelPosition: TLabelPosition;
    procedure SetLabelPosition(const Value: TLabelPosition);
    property LabelPosition: TLabelPosition
      read GetLabelPosition write SetLabelPosition;
  end;

  TGcxBoundLabel = class(TGcxCustomLabel)
  private
    FBind: TWinControl;
    function GetTop: Integer;
    function GetLeft: Integer;
    function GetWidth: Integer;
    function GetHeight: Integer;
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  protected
    procedure AdjustBounds; override;
    procedure SetBind(ABind: TWinControl);
  public
    constructor Create(AOwner: TComponent); override;
    //destructor Destroy; override;
    property Bind: TWinControl read FBind;
  published

  end;

{ TGcxCustomLabeledEdit }
  TGcxCustomLabeledEdit = class(TGcxCustomEdit, IBoundLabelOwner)
  private
    FEditLabel: TGcxBoundLabel;
    FLabelPosition: TLabelPosition;
    FLabelSpacing: Integer;
    function GetLabelPosition: TLabelPosition;
    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
  protected
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMBidimodeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
  public
    //destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer;
      AWidth: Integer; AHeight: Integer); override;
    procedure SetupInternalLabel;
    property EditLabel: TGcxBoundLabel read FEditLabel;
    property LabelPosition: TLabelPosition
      read GetLabelPosition write SetLabelPosition default lpLeft;
    property LabelSpacing: Integer
      read FLabelSpacing write SetLabelSpacing default 3;
  published

  end;

{ TGcxCustomIntLabeledEdit }
  TGcxCustomIntLabeledEdit = class(TGcxCustomIntEdit, IBoundLabelOwner)
  private
    FEditLabel: TGcxBoundLabel;
    FLabelPosition: TLabelPosition;
    FLabelSpacing: Integer;
    function GetLabelPosition: TLabelPosition;
    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
  protected
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMBidimodeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
  public
    //destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer;
      AWidth: Integer; AHeight: Integer); override;
    procedure SetupInternalLabel;
    property EditLabel: TGcxBoundLabel read FEditLabel;
    property LabelPosition: TLabelPosition
      read GetLabelPosition write SetLabelPosition default lpLeft;
    property LabelSpacing: Integer
      read FLabelSpacing write SetLabelSpacing default 3;
  published

  end;


  TGcxCustomIntLabeledEditX = class(TGcxCustomIntLabeledEdit)
  published
    property Alignment;
    property CharCase;
    property Constraints;
    property EditLabel;
    property FormatStyle;
    property HideSelection;
    property LabelPosition;
    property LabelSpacing;
    property LeadingZeros;
    property Margin;
    property MaxLength;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Value;
    property ValueMax;
    property ValueMin;
  //published
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TGcxCustomEditX = class(TGcxCustomEdit)
  published
    property Alignment;
    property Constraints;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property Margin;
    property MaxLength;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Text;
  //published
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    {$IFDEF COMPILER_9_UP}
    property OnMouseActivate;
    {$ENDIF}
    property OnMouseDown;
    {$IFDEF COMPILER_10_UP}
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnMouseMove;
    property OnMouseUp;
  end;


  TGcxValueInfoEditArea = (vieaNone, vieaValue,
    vieaValueToInfo, vieaInfo,
    vieaInfoToButton, vieaButton);

{ TGcxCustomValueInfoEdit }
  TGcxCustomValueInfoEdit = class(TWinControl)
  private
    FValueEdit: TGcxCustomIntLabeledEditX;
    FInfoEdit: TGcxCustomEditX;
    FSubBtn: TTntSpeedButton;
    FSpace: Integer;
    FDraging: Boolean;
    FDragArea: TGcxValueInfoEditArea;
    FMouseDownPoint: TPoint;

    function GetCommonColor: TColor;
    procedure SetCommonColor(const Value: TColor);
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const Value: Boolean);
    function GetReadOnlyColor: TColor;
    procedure SetReadOnlyColor(const Value: TColor);
    function GetButtonCaption: WideString;
    procedure SetButtonCaption(const Value: WideString);
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetFormatStyle: TIntegerFormatStyle;
    procedure SetFormatStyle(const Value: TIntegerFormatStyle);
    function GetLabelPosition: TLabelPosition;
    procedure SetLabelPosition(const Value: TLabelPosition);
    function GetText: WideString;
    procedure SetText(const Value: WideString);
    function GetValue: Integer;
    procedure SetValue(const Value: Integer);
    procedure SetSpace(const Value: Integer);
    procedure DoValueEditResize (Sender: TObject);
    function GetBorderWidth: TBorderWidth;
    procedure SetBorderWidth(const Value: TBorderWidth);
    procedure StopDrag;
    procedure CMBidimodeChanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMTabStopChanged(var Message: TMessage); message CM_TABSTOPCHANGED;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;

  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure SetParent(AParent: TWinControl); override;
    procedure CMBorderWidthChanged(var Message: TMessage); message CM_BORDERCHANGED;

    function HitTest(P: TPoint): TGcxValueInfoEditArea; overload;
    function HitTest(X, Y: Integer): TGcxValueInfoEditArea; overload;
    procedure WndProc(var Message: TMessage); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;

    property CommonColor: TColor
      read GetCommonColor write SetCommonColor default clInfoBk;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ReadOnlyColor: TColor
      read GetReadOnlyColor write SetReadOnlyColor default clSkyBlue;
    property ButtonCaption: WideString
      read GetButtonCaption write SetButtonCaption;
    property Caption: WideString read GetCaption write SetCaption;
    property FormatStyle: TIntegerFormatStyle
      read GetFormatStyle write SetFormatStyle default ifsInteger;
    property LabelPosition: TLabelPosition
      read GetLabelPosition write SetLabelPosition default lpLeft;
    property Text: WideString read GetText write SetText;
    property Value: Integer read GetValue write SetValue default 0;
    property Space: Integer read FSpace write SetSpace;
    property BorderWidth: TBorderWidth
      read GetBorderWidth write SetBorderWidth default 0;
  public
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    constructor Create(AOwner: TComponent); override;
    property ValueEdit: TGcxCustomIntLabeledEditX read FValueEdit;
    property InfoEdit: TGcxCustomEditX read FInfoEdit;
    property SubBtn: TTntSpeedButton read FSubBtn;
  published

  end;


  { TGcxValueInfoEdit }

  TGcxValueInfoEdit = class(TGcxCustomValueInfoEdit)
  published
    property Anchors;
    //property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BiDiMode;
    //property BorderStyle;
    //property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    //property EditLabel;
    property Enabled;
    property Font;
    //property HideSelection;
    property ImeMode;
    property ImeName;
    property LabelPosition;
    //property LabelSpacing;
    //property MaxLength;
    //property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    //property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    //property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

implementation

uses
  Math;

////////////////////////////////////////////////////////////////////////////////
//非类方法
//这段函数来源自IOComp组件库iGPFunctions单元的iIntToStr
function GcxIntToStr(Value: Int64; Format: TIntegerFormatStyle;
  MaxLength: Integer; LeadingZeros: Boolean): String;
var
  x               : Integer;
  ShiftMultiplier : Integer;
  DigitValue      : Integer;
  TempValue       : Int64;//Longword;
begin
  Result := '';

  ShiftMultiplier := 0;
  TempValue       := Value;

  case Format of
    ifsInteger:
    begin
      Result := IntToStr(Value);
    end;
    ifsHex:
    begin
      for x := 1 to 8 do
      begin
        if ShiftMultiplier <> 0 then
          TempValue := Value shr (4 * ShiftMultiplier);
        DigitValue := TempValue and $F;
        Result := IntToHex(DigitValue, 1) + Result;
        Inc(ShiftMultiplier);
      end;
    end;
    ifsBinary:
    begin
      for x := 1 to 32 do
      begin
        if ShiftMultiplier <> 0 then
          TempValue := Value shr (1 * ShiftMultiplier);
        DigitValue := TempValue and $1;
        Result := IntToStr(DigitValue) + Result;
        Inc(ShiftMultiplier);
      end;
    end;
    ifsOctal:
    begin
      for x := 1 to 10 do
      begin
        if ShiftMultiplier <> 0 then
          TempValue := Value shr (3*ShiftMultiplier);
        DigitValue := TempValue and $7;
        Result := IntToStr(DigitValue) + Result;
        Inc(ShiftMultiplier);
      end;
    end;
  end;

  while Copy(Result, 1, 1) = '0' do
    Result := Copy(Result, 2, Length(Result) - 1);

  if LeadingZeros then
  begin
    while Length(Result) < MaxLength do
      Result := '0' + Result;
  end;

  if Result = '' then
    Result := '0';
end;

//这段函数来源自IOComp组件库iGPFunctions单元的iStrToInt
function GcxStrToInt(Value: String): Int64;
var
  ACharacter   : String;
  AString      : String;
  CurrentPower : Integer;
begin
  Result       := 0;
  CurrentPower := 0;
  ACharacter   := Copy(Value, 1, 1);

  if ACharacter = 'b' then
  begin
    AString := Copy(Value, 2, Length(Value) -1);
    while Length(AString) <> 0 do
    begin
      ACharacter := Copy(AString, Length(AString), 1);
      Result := Result + StrToInt(ACharacter) * Trunc(Power(2, CurrentPower) + 0.0001);
      AString := Copy(AString, 1, Length(AString) -1);
      Inc(CurrentPower);
    end;
  end
  else if ACharacter = 'o' then
  begin
    AString := Copy(Value, 2, Length(Value) -1);
    while Length(AString) <> 0 do
    begin
      ACharacter := Copy(AString, Length(AString), 1);
      Result := Result + StrToInt(ACharacter) * Trunc(Power(8, CurrentPower) + 0.0001);
      AString := Copy(AString, 1, Length(AString) -1);
      Inc(CurrentPower);
    end;
  end
  else
  begin
    Result := StrToInt(Value);
  end;
end;

////////////////////////////////////////////////////////////////////////////////

{ TGcxCustomEdit }

function TGcxCustomEdit.AllowKey(Key: Char): Boolean;
begin
  Result := True;
end;

procedure TGcxCustomEdit.CompleteChange;
begin
end;

constructor TGcxCustomEdit.Create(AOwner: TComponent);
begin
  inherited;
  FCommonColor := clInfoBk;
  FReadOnlyColor := clSkyBlue;
  FAlignment := taLeftJustify;
  FMargin := 5;
  UpdateColor;
  ImeName := '';
  Width := 49;
end;

function TGcxCustomEdit.GetColor: TColor;
begin
  Result := inherited Color;
end;

function TGcxCustomEdit.GetLoading: Boolean;
begin
  Result := False;
  if csLoading in ComponentState then Result := True;
  if FLoading                    then Result := True;
end;

function TGcxCustomEdit.GetReadOnly: Boolean;
begin
  Result := inherited ReadOnly;
end;

procedure TGcxCustomEdit.KeyPress(var Key: Char);
begin
  inherited;
  if not AllowKey(Key) then
    Key := #0;
end;

procedure TGcxCustomEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TGcxCustomEdit.SetColor(const Value: TColor);
begin
  if ReadOnly then
    FReadOnlyColor := Value
  else
    FCommonColor := Value;
  UpdateColor;
end;

procedure TGcxCustomEdit.SetCommonColor(const Value: TColor);
begin
  FCommonColor := Value;
  UpdateColor;
end;

procedure TGcxCustomEdit.SetLoading(const Value: Boolean);
begin
  FLoading := Value;
end;

procedure TGcxCustomEdit.SetReadOnly(const Value: Boolean);
begin
  inherited ReadOnly := Value;
  UpdateColor;
end;

procedure TGcxCustomEdit.SetReadOnlyColor(const Value: TColor);
begin
  FReadOnlyColor := Value;
  UpdateColor;
end;

procedure TGcxCustomEdit.UpdateColor;
begin
  if ReadOnly then
    inherited Color := FReadOnlyColor
  else
    inherited Color := FCommonColor;
end;

procedure TGcxCustomEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[Boolean, TAlignment] of DWORD =
    ((ES_LEFT, ES_RIGHT, ES_CENTER),(ES_RIGHT, ES_LEFT, ES_CENTER));
begin
  inherited CreateParams(Params);
  with Params do
  begin
    ExStyle := Exstyle and not WS_EX_Transparent;
    Style := Style and not WS_BORDER or
      Alignments[UseRightToLeftAlignment, FAlignment];
  end;
end;

procedure TGcxCustomEdit.SetMargin(const Value: Integer);
begin
  if FMargin <> Value then
  begin
    FMargin := Value;
    RecreateWnd;//调用这个方法,非经验丰富,谁能知道,即使现在看到也不懂!
  end;
end;

procedure TGcxCustomEdit.CreateWnd;
begin
  inherited;
  SetEditRect;
end;

procedure TGcxCustomEdit.SetEditRect;
begin
  if (Handle = 0) or (not Assigned(Self.Parent)) then
    Exit;
  SendMessage(Handle, EM_SetMargins, EC_LeftMargin, MakeLong(FMargin, 0));
  SendMessage(Handle, EM_SetMargins, EC_RightMargin, MakeLong(0, FMargin));
end;


{ TGcxCustomIntEdit }
destructor TGcxCustomIntEdit.Destroy;
begin

  inherited;
end;

function TGcxCustomIntEdit.GetMaxLength: Integer;
begin
  Result := inherited MaxLength;
end;

procedure TGcxCustomIntEdit.SetFormatStyle(
  const Value: TIntegerFormatStyle);
begin
  if FFormatStyle <> Value then
  begin
    FFormatStyle := Value;
    UpdateText;
  end;
end;

procedure TGcxCustomIntEdit.SetLeadingZeros(const Value: Boolean);
begin
  if FLeadingZeros <> Value then
  begin
    FLeadingZeros := Value;
    UpdateText;
  end;
end;

procedure TGcxCustomIntEdit.SetMaxLength(const Value: Integer);
begin
  inherited MaxLength := Value;
  UpdateText;
end;

procedure TGcxCustomIntEdit.SetValue(const Value: Integer);
var
  IntTmp: Integer;
begin
  IntTmp := Value;
  //if not ((FValueMax = 0) and (FValueMin = 0)) and not Loading then//原来的代码
  if not Loading then
  begin
    if IntTmp > FValueMax then
      IntTmp := FValueMax;
    if IntTmp < FValueMin then
      IntTmp := FValueMin;
  end;

  if FValue <> IntTmp then
  begin
    FValue := IntTmp;
    UpdateText;
  end;
end;

procedure TGcxCustomIntEdit.SetValueMax(const Value: Integer);
begin
  if FValueMax <> Value then
  begin
    FValueMax := Value;
    Self.Value := FValue;
  end;
end;

procedure TGcxCustomIntEdit.SetValueMin(const Value: Integer);
begin
  if FValueMin <> Value then
  begin
    FValueMin := Value;
    Self.Value := FValue;
  end;
end;

function TGcxCustomIntEdit.GetText(Value: Integer): WideString;
var
  TmpMaxLength: Integer;
begin
  TmpMaxLength := MaxLength;
  case FFormatStyle of
    ifsInteger:
      begin
      end;
    ifsHex:
      begin
        if (TmpMaxLength > 8) or (TmpMaxLength = 0) then
          TmpMaxLength := 8;
      end;
    ifsBinary:
      begin
        if (TmpMaxLength > 32) or (TmpMaxLength = 0) then
          TmpMaxLength := 32;
      end;
    ifsOctal:
      begin
        if (TmpMaxLength > 10) or (TmpMaxLength = 0) then
          TmpMaxLength := 10;
      end;
  else Exit;
  end;
  Result := GcxIntToStr(Value, FFormatStyle, TmpMaxLength, FLeadingZeros);
end;

procedure TGcxCustomIntEdit.UpdateText;
begin
  GetText(FValue);
end;

procedure TGcxCustomIntEdit.CompleteChange;
begin
  inherited;
  Value := GetValue(Text);//这里或许应该判断Text不能为空,否则转换会出错,2013-12-08
end;

procedure TGcxCustomIntEdit.DoExit;
begin
  inherited;
  CompleteChange;
end;

function TGcxCustomIntEdit.GetValue(Value: WideString): Integer;
begin
  Result := 0;
  try
    case FFormatStyle of
      ifsInteger : Result := GcxStrToInt(      Value);
      ifsHex     : Result := GcxStrToInt('$' + Value);
      ifsBinary  : Result := GcxStrToInt('b' + Value);
      ifsOctal   : Result := GcxStrToInt('o' + Value);
    end;
  except
    on e: exception do
      begin
        if FUndoOnError then
          begin
            Undo;
            Result := FValue;
            if FBeepOnError then Beep;
          end
        else raise;
      end;
  end;
end;

function TGcxCustomIntEdit.AllowKey(Key: Char): Boolean;
var
  BadKey : Boolean;
begin
  case FormatStyle of
    ifsInteger : BadKey := not (Key in [#8, '0'..'9', '-']);
    ifsHex     : BadKey := not (Key in [#8, '0'..'9', 'a'..'f', 'A'..'F']);
    ifsBinary  : BadKey := not (Key in [#8, '0'..'1']);
    ifsOctal   : BadKey := not (Key in [#8, '0'..'7']);
  else
    BadKey := True;
  end;
  //2013-12-08 03:27:00,zsl,ifsInteger时仅首位允许"-"
  //if (not BadKey) and (Length(Text) > 0) then//不行,得判断KeyPress时光标的位置才行,SelStart
  if (not BadKey) and (SelStart > 0) then//SelStart,SelLength,SelText,查看代码,2013-12-08 20:03:00,zsl
    BadKey := (Key = '-');

  if BadKey then
  begin
    if FBeepOnError then Beep;
  end;
  Result := not BadKey;
end;

constructor TGcxCustomIntEdit.Create(AOwner: TComponent);
begin
  inherited;
  Self.ImeName := '';
  Self.ImeMode := imClose;

  FUndoOnError := True;
  FValueMax := 0;//?有default值了为什么还要在这里置0
  FValue := 0;   //?有default值了为什么还要在这里置0
  FAlignment := taRightJustify;
  UpdateText;
end;

{ TGcxBoundLabel }

procedure TGcxBoundLabel.AdjustBounds;
begin
  inherited AdjustBounds;
  if Supports(Owner, IBoundLabelOwner) then
    with Owner as IBoundLabelOwner do
      SetLabelPosition(GetLabelPosition);
end;

constructor TGcxBoundLabel.Create(AOwner: TComponent);
begin
  inherited;

end;

function TGcxBoundLabel.GetHeight: Integer;
begin
  Result := inherited Height;
end;

function TGcxBoundLabel.GetLeft: Integer;
begin
  Result := inherited Left;
end;

function TGcxBoundLabel.GetTop: Integer;
begin
  Result := inherited Top;
end;

function TGcxBoundLabel.GetWidth: Integer;
begin
  Result := inherited Width;
end;

procedure TGcxBoundLabel.SetBind(ABind: TWinControl);
begin
  Self.FBind := ABind;
end;

procedure TGcxBoundLabel.SetHeight(const Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

procedure TGcxBoundLabel.SetWidth(const Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

{ TGcxCustomLabeledEdit }
procedure TGcxCustomLabeledEdit.CMBidimodeChanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.BiDiMode := BiDiMode;
end;

procedure TGcxCustomLabeledEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.Enabled := Enabled;
end;

procedure TGcxCustomLabeledEdit.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.Visible := Visible;
end;

constructor TGcxCustomLabeledEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLabelPosition := lpAbove;
  FLabelSpacing := 3;
  SetupInternalLabel;
end;

function TGcxCustomLabeledEdit.GetLabelPosition: TLabelPosition;
begin
  Result := FLabelPosition;
end;

procedure TGcxCustomLabeledEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
end;

procedure TGcxCustomLabeledEdit.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TGcxCustomLabeledEdit.SetLabelPosition(
  const Value: TLabelPosition);

  procedure UpdateLabelPosition(AOwner: TWinControl;
    AEditLabel: TCustomLabel;
    const NewLabelPosition: TLabelPosition;
    const ALabelSpacing: Integer);
  var
    P: TPoint;
    obj: TWinControl;
  begin
    if AEditLabel = nil then Exit;

    obj := AOwner;
    if (AEditLabel is TGcxBoundLabel) then
    begin
      with (AEditLabel as TGcxBoundLabel) do
        if Assigned(Bind) then
          obj := Bind;
    end;
    if not Assigned(obj) then
      Exit;

    with obj do
      case NewLabelPosition of
        lpAbove: P := Point(Left, Top - AEditLabel.Height - ALabelSpacing);
        lpBelow: P := Point(Left, Top + Height + ALabelSpacing);
        lpLeft : P := Point(Left - AEditLabel.Width - ALabelSpacing,
                        Top + ((Height - AEditLabel.Height) div 2));
        lpRight: P := Point(Left + Width + ALabelSpacing,
                        Top + ((Height - AEditLabel.Height) div 2));
      end;

    AEditLabel.SetBounds(P.x, P.y, AEditLabel.Width, AEditLabel.Height);
  end;

begin
  FLabelPosition := Value;
  UpdateLabelPosition(Self, FEditLabel, FLabelPosition, FLabelSpacing);
end;

procedure TGcxCustomLabeledEdit.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TGcxCustomLabeledEdit.SetName(const Value: TComponentName);
begin
  if (csDesigning in ComponentState) and ((FEditlabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
    FEditLabel.Caption := Value;
  inherited SetName(Value);
  if csDesigning in ComponentState then
    Text := '';
end;

procedure TGcxCustomLabeledEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if FEditLabel = nil then exit;
  FEditLabel.Parent := AParent;
  FEditLabel.Visible := True;
end;

procedure TGcxCustomLabeledEdit.SetupInternalLabel;
begin
  if Assigned(FEditLabel) then exit;
  FEditLabel := TGcxBoundLabel.Create(Self);
  FEditLabel.FreeNotification(Self);
  FEditLabel.FocusControl := Self;
end;


{ TGcxCustomIntLabeledEdit }
procedure TGcxCustomIntLabeledEdit.CMBidimodeChanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.BiDiMode := BiDiMode;
end;

procedure TGcxCustomIntLabeledEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.Enabled := Enabled;
end;

procedure TGcxCustomIntLabeledEdit.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  FEditLabel.Visible := Visible;
end;

constructor TGcxCustomIntLabeledEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLabelPosition := lpAbove;
  FLabelSpacing := 3;
  SetupInternalLabel;
end;

function TGcxCustomIntLabeledEdit.GetLabelPosition: TLabelPosition;
begin
  Result := FLabelPosition;
end;

procedure TGcxCustomIntLabeledEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
end;

procedure TGcxCustomIntLabeledEdit.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TGcxCustomIntLabeledEdit.SetLabelPosition(
  const Value: TLabelPosition);

  procedure UpdateLabelPosition(AOwner: TWinControl;
    AEditLabel: TCustomLabel;
    const NewLabelPosition: TLabelPosition;
    const ALabelSpacing: Integer);
  var
    P: TPoint;
    obj: TWinControl;
  begin
    if AEditLabel = nil then Exit;

    obj := AOwner;
    if (AEditLabel is TGcxBoundLabel) then
    begin
      with (AEditLabel as TGcxBoundLabel) do
        if Assigned(Bind) then
          obj := Bind;
    end;
    if not Assigned(obj) then
      Exit;

    with obj do
      case NewLabelPosition of
        lpAbove: P := Point(Left, Top - AEditLabel.Height - ALabelSpacing);
        lpBelow: P := Point(Left, Top + Height + ALabelSpacing);
        lpLeft : P := Point(Left - AEditLabel.Width - ALabelSpacing,
                        Top + ((Height - AEditLabel.Height) div 2));
        lpRight: P := Point(Left + Width + ALabelSpacing,
                        Top + ((Height - AEditLabel.Height) div 2));
      end;

    AEditLabel.SetBounds(P.x, P.y, AEditLabel.Width, AEditLabel.Height);
  end;

begin
  FLabelPosition := Value;
  UpdateLabelPosition(Self, FEditLabel, FLabelPosition, FLabelSpacing);
end;

procedure TGcxCustomIntLabeledEdit.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TGcxCustomIntLabeledEdit.SetName(const Value: TComponentName);
begin
  if (csDesigning in ComponentState) and ((FEditlabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
    FEditLabel.Caption := Value;
  inherited SetName(Value);
  if csDesigning in ComponentState then
    Text := '';
end;

procedure TGcxCustomIntLabeledEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if FEditLabel = nil then exit;
  FEditLabel.Parent := AParent;
  FEditLabel.Visible := True;
end;

procedure TGcxCustomIntLabeledEdit.SetupInternalLabel;
begin
  if Assigned(FEditLabel) then exit;
  FEditLabel := TGcxBoundLabel.Create(Self);
  FEditLabel.FreeNotification(Self);
  FEditLabel.FocusControl := Self;
end;


{ TGcxCustomValueInfoEdit }
procedure TGcxCustomValueInfoEdit.CMBorderWidthChanged(
  var Message: TMessage);
begin
  SetBounds(Left, Top, Width, Height);
end;

constructor TGcxCustomValueInfoEdit.Create(AOwner: TComponent);
var
  AWidth, AHeight: Integer;
  iTop, iHeight: Integer;
begin
  inherited Create(AOwner);
  FSpace := 2;

  Self.ParentFont := True;
  iTop := 0;
  AWidth := 0;

  FValueEdit := TGcxCustomIntLabeledEditX.Create(Self);
  with FValueEdit do
  begin
    Name := 'ValueEdit';
    SetSubComponent(True);
    Parent := Self;
    Top := iTop;
    Left := AWidth;
    iHeight := Height;
    AWidth := AWidth + Width + FSpace;
    FreeNotification(Self);
    OnResize := DoValueEditResize;
    EditLabel.SetBind(Self);
    Constraints.MinWidth := IDI_SubEditMinWidth;
    TabOrder := 0;
  end;

  FInfoEdit := TGcxCustomEditX.Create(Self);
  with FInfoEdit do
  begin
    Name := 'InfoEdit';
    SetSubComponent(True);
    Parent := Self;
    Text := '';
    Top := iTop;
    Left := AWidth;
    AWidth := AWidth + Width + FSpace;
    FreeNotification(Self);
    Constraints.MinWidth := IDI_SubEditMinWidth;
    TabOrder := 1;
  end; 

  FSubBtn := TTntSpeedButton.Create(Self);
  with FSubBtn do
  begin
    Name := 'SubBtn';
    SetSubComponent(True);
    Parent := Self;
    Top := iTop;
    Left := AWidth;
    Width := 22;
    Height := iHeight;
    AWidth := AWidth + Width;
    FreeNotification(Self);
    Constraints.MinWidth := IDI_SubBtnMinWidth;
    TabOrder := 2;
  end;

  TabStop := True;
  AWidth := AWidth + Self.BorderWidth * 2;
  AHeight := iHeight + Self.BorderWidth * 2;
  SetBounds(Self.Left, Self.Top, AWidth, AHeight);
end;

procedure TGcxCustomValueInfoEdit.DoValueEditResize(Sender: TObject);
var
  iHeight: Integer;
begin
  if (Sender is TCustomEdit) then
  begin
    iHeight := (Sender as TCustomEdit).Height;
    Self.SubBtn.Height := iHeight;
    Inc(iHeight, Self.BorderWidth shl 1);
    if Self.Height <> iHeight then
      Self.Height := iHeight;
  end;
end;

function TGcxCustomValueInfoEdit.GetBorderWidth: TBorderWidth;
begin
  Result := inherited BorderWidth;
end;

function TGcxCustomValueInfoEdit.GetButtonCaption: WideString;
begin
  Result := Self.FSubBtn.Caption;
end;

function TGcxCustomValueInfoEdit.GetCaption: WideString;
begin
  Result := Self.FValueEdit.EditLabel.Caption;
end;

function TGcxCustomValueInfoEdit.GetCommonColor: TColor;
begin
  Result := FValueEdit.CommonColor;
end;

function TGcxCustomValueInfoEdit.GetFormatStyle: TIntegerFormatStyle;
begin
  Result := FValueEdit.FormatStyle;
end;

function TGcxCustomValueInfoEdit.GetLabelPosition: TLabelPosition;
begin
  Result := FValueEdit.LabelPosition;
end;

function TGcxCustomValueInfoEdit.GetReadOnly: Boolean;
begin
  Result := FValueEdit.ReadOnly;
end;

function TGcxCustomValueInfoEdit.GetReadOnlyColor: TColor;
begin
  Result := FValueEdit.ReadOnlyColor;
end;

function TGcxCustomValueInfoEdit.GetText: WideString;
begin
  Result := Self.InfoEdit.Text;
end;

function TGcxCustomValueInfoEdit.GetValue: Integer;
begin
  Result := Self.ValueEdit.Value;
end;

procedure TGcxCustomValueInfoEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FValueEdit) then
      FValueEdit := nil;

    if (AComponent = FInfoEdit) then
      FInfoEdit := nil;

    if (AComponent = FSubBtn) then
      FSubBtn := nil;
  end;
end;

procedure TGcxCustomValueInfoEdit.SetBorderWidth(const Value: TBorderWidth);
var
  DiffValue: Integer;
begin
  DiffValue := (Value - BorderWidth) * 2;
  inherited BorderWidth := Value;
  SetBounds(Left, Top, Width + DiffValue, Height + DiffValue);
end;

procedure TGcxCustomValueInfoEdit.SetBounds(ALeft, ATop, AWidth,
AHeight: Integer);
type
  TCtrlBoundInfo = record
    Obj: TControl;
    CtrlRect: TRect;
    WidthEx: Integer;
  end;
var
  i: Integer;
  iMinWidth: TConstraintSize;
  iLeft, iHeight, iWidth, iSumWidth, iDiffWidth: Integer;
  mBorderWidth: Integer;
  mCtrlBoundInfo: array of TCtrlBoundInfo;
begin
  mBorderWidth := Self.BorderWidth;

  SetLength(mCtrlBoundInfo, 3);
  mCtrlBoundInfo[0].Obj := FValueEdit;
  mCtrlBoundInfo[1].Obj := FInfoEdit;
  mCtrlBoundInfo[2].Obj := FSubBtn;
  
  iHeight := FValueEdit.Height;
  iSumWidth := 0;
  for i := Low(mCtrlBoundInfo) to High(mCtrlBoundInfo) do
  begin
    with mCtrlBoundInfo[i] do
    begin
      // 检查并设置子对象的最小宽度
      if Obj.Constraints.MinWidth = 0 then
      begin
        if Obj = FSubBtn then
          Obj.Constraints.MinWidth := IDI_SubBtnMinWidth
        else
          Obj.Constraints.MinWidth := IDI_SubEditMinWidth;
      end;
      // 检查并重新计算子对象宽度
      iMinWidth := Obj.Constraints.MinWidth;
      if Obj.Width < iMinWidth then
        iWidth := iMinWidth
      else
        iWidth := Obj.Width;
      // 保留子对象的范围空间、可缩小宽度
      mCtrlBoundInfo[i].CtrlRect := Bounds(Obj.Left, 0, iWidth, iHeight);
      mCtrlBoundInfo[i].WidthEx := iWidth - iMinWidth;
      // 累计宽度
      Inc(iSumWidth, iWidth + FSpace);
    end;
  end;
  Inc(iSumWidth, mBorderWidth shl 1 - FSpace);  // 计算内部的宽度

  iDiffWidth := AWidth - iSumWidth;             // 计算内外宽度差
  if iDiffWidth >= 0 then
  begin // 外部宽，增加 FInfoEdit 宽度
    for i := Low(mCtrlBoundInfo) to High(mCtrlBoundInfo) do
    begin
      with mCtrlBoundInfo[i] do
        if Obj = FInfoEdit then
        begin
          Inc(CtrlRect.Right, iDiffWidth);
          Break;
        end;
    end;
  end else
  begin // 内部宽，减少内部控件宽度
    iSumWidth := - iDiffWidth;
    for i := Low(mCtrlBoundInfo) to High(mCtrlBoundInfo) do
    begin
      with mCtrlBoundInfo[i] do
      begin
        if WidthEx <= iSumWidth then
          iDiffWidth := WidthEx
        else
          iDiffWidth := iSumWidth;
        Dec(CtrlRect.Right, iDiffWidth);
        Dec(iSumWidth, iDiffWidth);
        Dec(WidthEx, iDiffWidth);
        if iSumWidth = 0 then
          Break;
      end;
    end;
    Inc(AWidth, iSumWidth);
  end;  
  // 重新计算并设置子对象的位置
  mCtrlBoundInfo[0].Obj.BoundsRect := mCtrlBoundInfo[0].CtrlRect;
  for i := Low(mCtrlBoundInfo) + 1 to High(mCtrlBoundInfo) do
  begin
    iLeft := mCtrlBoundInfo[i - 1].CtrlRect.Right + FSpace;
    //Types.OffsetRect(mCtrlBoundInfo[i].CtrlRect,
    //  iLeft - mCtrlBoundInfo[i].CtrlRect.Left, 0);
    OffsetRect(mCtrlBoundInfo[i].CtrlRect,
      iLeft - mCtrlBoundInfo[i].CtrlRect.Left, 0);
    mCtrlBoundInfo[i].Obj.BoundsRect := mCtrlBoundInfo[i].CtrlRect;
  end;

  AHeight := iHeight + mBorderWidth * 2;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  FValueEdit.SetLabelPosition(FValueEdit.LabelPosition);
end;

procedure TGcxCustomValueInfoEdit.SetButtonCaption(const Value: WideString);
begin
  Self.FSubBtn.Caption := Value;
end;

procedure TGcxCustomValueInfoEdit.SetCaption(const Value: WideString);
begin
  Self.FValueEdit.EditLabel.Caption := Value;
end;

procedure TGcxCustomValueInfoEdit.SetCommonColor(const Value: TColor);
begin
  FValueEdit.CommonColor := Value;
  FInfoEdit.CommonColor := Value;
end;

procedure TGcxCustomValueInfoEdit.SetFormatStyle(
  const Value: TIntegerFormatStyle);
begin
  Self.ValueEdit.FormatStyle := Value;
end;

procedure TGcxCustomValueInfoEdit.SetLabelPosition(
  const Value: TLabelPosition);
begin
  Self.FValueEdit.LabelPosition := Value;
end;

procedure TGcxCustomValueInfoEdit.SetName(const Value: TComponentName);
begin
  if (csDesigning in ComponentState) and ((FValueEdit.EditLabel.GetTextLen = 0) or
     (CompareText(FValueEdit.EditLabel.Caption, FValueEdit.Name) = 0) or
     (CompareText(FValueEdit.EditLabel.Caption, Name) = 0)) then
    FValueEdit.EditLabel.Caption := Value;
  inherited SetName(Value);
  if csDesigning in ComponentState then
    Text := '';
end;

procedure TGcxCustomValueInfoEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if FValueEdit = nil then Exit;
  FValueEdit.Parent := Self;
  if FValueEdit.EditLabel = nil then Exit;
  FValueEdit.FEditLabel.Parent := AParent;
  FValueEdit.FEditLabel.Visible := True;
end;

procedure TGcxCustomValueInfoEdit.SetReadOnly(const Value: Boolean);
begin
  FValueEdit.ReadOnly := Value;
  FInfoEdit.ReadOnly := Value;
end;

procedure TGcxCustomValueInfoEdit.SetReadOnlyColor(const Value: TColor);
begin
  FValueEdit.ReadOnlyColor := Value;
  FInfoEdit.ReadOnlyColor := Value;
end;

procedure TGcxCustomValueInfoEdit.SetSpace(const Value: Integer);
begin
  FSpace := Value;
  Self.SetBounds(Left, Top, Width, Height);
end;

procedure TGcxCustomValueInfoEdit.SetText(const Value: WideString);
begin
  Self.InfoEdit.Text := Value;
end;

procedure TGcxCustomValueInfoEdit.SetValue(const Value: Integer);
begin
  Self.ValueEdit.Value := Value;
end;

procedure TGcxCustomValueInfoEdit.CMBidimodeChanged(var Message: TMessage);
var
  i: Integer;
begin
  for I := 0 to ControlCount - 1 do
    Controls[I].BiDiMode := BiDiMode;
end;

procedure TGcxCustomValueInfoEdit.CMEnabledChanged(var Message: TMessage);
var
  i: Integer;
begin
  for I := 0 to ControlCount - 1 do
    Controls[I].Enabled := Enabled;
end;

procedure TGcxCustomValueInfoEdit.CMVisibleChanged(var Message: TMessage);
var
  i: Integer;
begin
  for I := 0 to ControlCount - 1 do
    Controls[I].Visible := Visible;
end;

procedure TGcxCustomValueInfoEdit.CMTabStopChanged(var Message: TMessage);
var
  i: Integer;
begin
  for I := 0 to ControlCount - 1 do
    if (Controls[I] is TWinControl) then
      (Controls[I] as TWinControl).TabStop := TabStop;
end;

procedure TGcxCustomValueInfoEdit.WMSetFocus(var Message: TWMSetFocus);
begin
  FValueEdit.SetFocus;
end;



procedure Register;
begin
  RegisterComponents('GameControlX',
    [
    TGcxEdit,
    TGcxIntEdit,
    TGcxCustomValueInfoEdit
    
    ]);
end;

function TGcxCustomValueInfoEdit.HitTest(P: TPoint): TGcxValueInfoEditArea;
var
  ValueRect, ValueToInfoRect, InfoRect: TRect;
  InfoToButtonRect, ButtonRect: TRect;
  iLeft, iRight: Integer;
begin
  iLeft             := 0;
  iRight            := FValueEdit.Width;
  ValueRect         := Rect(iLeft, 0, iRight, Height); 

  iLeft             := iRight;
  iRight            := FInfoEdit.Left;
  ValueToInfoRect   := Rect(iLeft, 0, iRight, Height);

  iLeft             := FInfoEdit.Left;
  iRight            := iLeft + FInfoEdit.Width;
  InfoRect          := Rect(iLeft, 0, iRight, Height);

  iLeft             := iRight;
  iRight            := FSubBtn.Left;
  InfoToButtonRect  := Rect(iLeft, 0, iRight, Height);

  iLeft             := FSubBtn.Left;
  iRight            := iLeft + FSubBtn.Width;
  ButtonRect        := Rect(iLeft, 0, iRight, Height);

  if PtInRect(ValueRect, P) then
    Result := vieaValue
  else if PtInRect(ValueToInfoRect, P) then
    Result := vieaValueToInfo
  else if PtInRect(InfoRect, P) then
    Result := vieaInfo
  else if PtInRect(InfoToButtonRect, P) then
    Result := vieaInfoToButton
  else if PtInRect(ButtonRect, P) then
    Result := vieaButton
  else
    Result := vieaNone;
end;

function TGcxCustomValueInfoEdit.HitTest(X,
  Y: Integer): TGcxValueInfoEditArea;
begin
  Result := HitTest(Point(X, Y));
end;

procedure TGcxCustomValueInfoEdit.CMDesignHitTest(
  var Message: TCMDesignHitTest);
begin
  with Message do
  begin
    if (Self.HitTest(Message.XPos, Message.YPos)
      in [vieaValueToInfo, vieaInfoToButton])
      or FDraging then
    begin
      Screen.Cursor := crHSplit;
      Message.Result := 1;
    end
    else
    begin
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TGcxCustomValueInfoEdit.StopDrag;
var
  frm: TCustomForm;
begin
  if not FDraging then
    Exit; 

  FDraging := False;
  FDragArea := vieaNone;

  frm := Forms.GetParentForm(Self);
  if Assigned(frm) then
  begin
    frm.Designer.Modified;
  end;
end;

procedure TGcxCustomValueInfoEdit.CMMouseLeave(var Message: TMessage);
begin
  if (csDesigning in ComponentState) then
  begin
    Screen.Cursor := crDefault;
  end;
  inherited;
end;

procedure TGcxCustomValueInfoEdit.WndProc(var Message: TMessage);
begin
  if (csDesigning in ComponentState) then
  case Message.Msg of
    CM_MOUSELEAVE:
      Self.CMMouseLeave(Message);
  else
  end;
  inherited;
end;

procedure TGcxCustomValueInfoEdit.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (csDesigning in ComponentState) then
  begin
    FDragArea := HitTest(X, Y);
    FDraging := FDragArea in [vieaValueToInfo, vieaInfoToButton];
    if not FDraging  then
      Exit;
    FMouseDownPoint := Point(X, Y);
  end;
end;

procedure TGcxCustomValueInfoEdit.MouseMove(Shift: TShiftState; X,
  Y: Integer);
var
  iOldWidth1, iOldWidth2, iNewWidth1, iNewWidth2, iDiffWidth: Integer;
  mWinCtl1, mWinCtl2: TControl;
begin
  inherited;
  if not (csDesigning in ComponentState) then
    Exit; 

  if not (ssLeft in Shift) then
  begin
    StopDrag;
    Exit;
  end;

  if FDraging then
  begin
    case FDragArea of
      vieaValueToInfo:
        begin
          mWinCtl1 := FValueEdit;
          mWinCtl2 := FInfoEdit;
        end;
      vieaInfoToButton:
        begin
          mWinCtl1 := FInfoEdit;
          mWinCtl2 := FSubBtn;
        end;
    else
      Exit;
    end;

    iOldWidth1 := mWinCtl1.Width;
    iOldWidth2 := mWinCtl2.Width;
    iDiffWidth := FMouseDownPoint.X - X;

    iNewWidth1 := iOldWidth1 - iDiffWidth;
    iNewWidth2 := iOldWidth2 + iDiffWidth;

    if iNewWidth1 <= mWinCtl1.Constraints.MinWidth then
    begin
      iNewWidth1 := mWinCtl1.Constraints.MinWidth;
      iNewWidth2 := iOldWidth1 + iOldWidth2 - iNewWidth1;
    end;
    if iNewWidth2 <= mWinCtl2.Constraints.MinWidth then
    begin
      iNewWidth2 := mWinCtl2.Constraints.MinWidth;
      iNewWidth1 := iOldWidth1 + iOldWidth2 - iNewWidth2;
    end;

    mWinCtl1.Width := iNewWidth1;

    mWinCtl2.Left := mWinCtl2.Left - (iOldWidth1 - iNewWidth1);
    mWinCtl2.Width := iNewWidth2;

    FMouseDownPoint := Point(X, Y);
  end;
end;

procedure TGcxCustomValueInfoEdit.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  StopDrag;
end;

end.
