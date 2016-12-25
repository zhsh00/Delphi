unit UzslEditors;

interface
Uses
  Classes, SysUtils, Dialogs, DesignIntf, DesignEditors, Forms, VCLEditors;

Type
  TFileNameProperty = class(TMPFileNameProperty)
  public
    Procedure Edit; override;
  end;

  TDBPropertyEditor = class(TStringProperty)
  protected
    Procedure GetNames(Strings: TStrings);virtual; abstract;
  public
    Procedure GetValues(Proc: TGetStrProc); override;
    Function GetAttributes: TPropertyAttributes; override;
  end;

  TDatabaseNameProperty = class(TDBPropertyEditor)
  protected
    Procedure GetNames(Strings: TStrings); override;
  end;

implementation

uses
  UTableBox;


Procedure TFileNameProperty.Edit;
var
  OpenDialog : TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(Application);
  try
    OpenDialog.FileName := GetValue;
    OpenDialog.Filter := 'Log Files (*.log)|*.log|All Files(*.*)|*.*';
    OpenDialog.Options := OpenDialog.Options + [ofPathMustExist];
    if OpenDialog.Execute then SetValue(OpenDialog.Filename);
  finally
    OpenDialog.Free;
  end;
end;

//procedure Register;
//implementation
//uses
//UTableBox;
//procedure Register;
//begin
//RegisterPropertyEditor(TypeInfo(TDatabaseName), TTableBox,
//'DatabaseName', TDatabaseNameProperty );
//end;

{ TDBPropertyEditor }
function TDBPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  result := [paRevertable, paMultiselect, paValueList];
end;

procedure TDBPropertyEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Strings: TStrings;
begin
  Strings := TStringList.Create;
  try
    GetNames(Strings);
    for I := 0 to Strings.Count - 1 do Proc(Strings[I]);
  finally
    Strings.Free;
  end;
end;

{ TDatabaseNameProperty }
procedure TDatabaseNameProperty.GetNames(Strings: TStrings);
begin
  if Assigned(Session) then
    Session.GetDatabaseNames(Strings);
end;

end.
