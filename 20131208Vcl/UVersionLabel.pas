unit UVersionLabel;
// UVersionLabel.pas - Fills in the version label from the FileVersionInfo
// Copyright (c) 2000. All Rights Reserved.
// Written by Paul Kimmel. Okemos, MI USA
// Software Conceptions, Inc 800-471-5890
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs,
  StdCtrls;

type
  TVersionLabel = class(TCustomLabel)
  private
    { Private declarations }
    FFileName : TFileName;
    FMask: String;
    function GetEnvPathString: String;
    function GetApplicationName(const AppName: String): String;
  protected
  { Protected declarations }
    procedure SetFileName(Value: TFileName);
    procedure SetVersion;
    procedure SetMask(const Value: String);
    property Caption stored False;
  public
  { Public declarations }
  published
  { Published declarations }
    constructor Create(AOwner: TComponent); override;
    property FileName: TFileName read FFileName write SetFileName;
    property Mask: String read FMask write SetMask stored True;
  end;

//procedure Register;

implementation
//uses
//  UzslEditors, DesignIntf;
//
//procedure Register;
//begin
//  RegisterComponents('zhshll', [TVersionLabel]);
////RegisterPropertyEditor(TypeInfo(TFileName), TVersionLabel, 'FileName', TFileNameProperty);
//end;

////////////////////////////////////////////////////////////////////////////////
function GetVersionString(FileName : String): String;
resourcestring
  VersionRequestString = '\\StringFileInfo\\040904E4\\FileVersion';
var
  Size, Dummy, Len: DWord;
  Buffer: PChar;
  RawPointer: Pointer;
begin
  result := '<unknown>';
  Size := GetFileVersionInfoSize(PChar(FileName), Dummy);
  if(Size = 0) then exit;

  GetMem(Buffer, Size);
  try
    if(GetFileVersionInfo(PChar(FileName), Dummy, Size, Buffer) = False) then
      exit;
    if(VerQueryValue(Buffer, PChar(VersionRequestString), RawPointer,
      Len) = False) then exit;
    result := StrPas(PChar(RawPointer));
  finally
    FreeMem(Buffer);
  end;
end;

procedure DecodeVersion(Version : String; var MajorVersion,
MinorVersion, Release, Build: String);

  function GetValue(var Version : String): String;
  begin
    result := Copy(Version, 1, Pos('.', Version) - 1);
    if(result = EmptyStr) then result := 'x';
    Delete(Version, 2, Pos('.', Version));
  end;

begin
  MajorVersion := GetValue(Version);
  MinorVersion := GetValue(Version);
  Release := GetValue(Version);
  Build := GetValue(Version);
end;
////////////////////////////////////////////////////////////////////////////////

constructor TVersionLabel.Create(AOwner : TComponent);
resourcestring
  DefaultMask = 'Version %s.%s (Release %s Build %s)';
begin
  inherited Create(AOwner);
  Mask := DefaultMask;
end;
procedure TVersionLabel.SetVersion;
var
  MajorVersion, MinorVersion, Release, Build : String;
  Version : String;
begin
  Version := GetVersionString(FFileName);
  DecodeVersion(Version, MajorVersion, MinorVersion, Release, Build);
  Caption := Format(FMask, [MajorVersion, MinorVersion, Release, Build]);
end;

resourcestring
  DefaultPath = '.\;\';

function TVersionLabel.GetEnvPathString : String;
const
  MAX = 1024;
begin
  SetLength(result, MAX);
  if(GetEnvironmentVariable(PChar('Path'), PChar(result), MAX) = 0) then
    result := DefaultPath;
end;

function TVersionLabel.GetApplicationName(const AppName: String): String;
begin
  if( csDesigning in ComponentState ) then
    // see if a compiled version already exists, if we are designing
    result := FileSearch(AppName, GetEnvPathString + DefaultPath)
  else
    result := Application.EXEName;
end;

procedure TVersionLabel.SetFileName( Value : TFileName );
begin
  if(CompareText(FFileName, Value) = 0) then exit;
  FFileName := GetApplicationName(Value);
  SetVersion;
end;

procedure TVersionLabel.SetMask(const Value: String);
begin
  if(FMask = Value) then exit;
  FMask := Value;
  SetVersion;
end;


end.
 