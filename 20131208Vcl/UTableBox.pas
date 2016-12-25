unit UTableBox;
// UTableBox.pas - Contains a tablename combobox
// Copyright (c) 2000. All Rights Reserved.
// by Software Conceptions, Inc. Okemos, MI USA (800) 471-5890
// Written by Paul Kimmel
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs,
  DBTables, StdCtrls;

type
  TDatabaseName = string;

  TCustomTableBox = class(TCustomComboBox)
  private
    { Private declarations }
    FSession: TSession;
    FDatabaseName: TDatabaseName;
  protected
    { Protected declarations }
    procedure DropDown; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetSession(const Value: TSession);
    procedure SetDatabaseName(const Value: TDatabaseName);
  public
    { Public declarations }
    property Text;
    property OnChange;
    property Session: TSession read FSession write SetSession;
    property DatabaseName: TDatabaseName read FDatabaseName
      write SetDatabaseName;
  end;

  TTableBox = class(TCustomTableBox)
  published
    { Published declarations }
    property Text;
    property OnChange;
    property Session;
    property DatabaseName;
  end;

var
  Session: TSession;
//procedure Register;
implementation
//procedure Register;
//begin
//RegisterComponents('zhshll', [TTableBox]);
//end;

{ TTableBox }
procedure TCustomTableBox.DropDown;
begin
  inherited;
  if(FSession = Nil) then FSession := DBTables.Session;
  if(Items.Count = 0) then
    FSession.GetTableNames(FDatabaseName, '*.*', True, True, Items);
end;

procedure TCustomTableBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if(Operation = opRemove) and (AComponent = FSession) then
    Session := Nil;
end;

procedure TCustomTableBox.SetDatabaseName(const Value: TDatabaseName);
begin
  FDatabaseName := Value;
end;

procedure TCustomTableBox.SetSession(const Value: TSession);
begin
  if(Value = FSession) then exit;
  Items.Clear;
  FSession := Value;
  UTableBox.Session := Value;
end;

end.
