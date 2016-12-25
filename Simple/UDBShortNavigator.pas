unit UDBShortNavigator;
// UDBShortNavigator.pas - Toggles between short list of buttons
// and long list
// Copyright (c) 2000. All Rights Reserved.
// by Software Conceptions, Inc. Okemos, MI USA (800) 471-5890
// Written by Paul Kimmel
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs,
  ExtCtrls, DBCtrls;

type
  TNavigatorButtonSet = ( nbsFull, nbsPartial );
  TDBShortNavigator = class(TDBNavigator)
  private
    { Private declarations }
    FButtonSet : TNavigatorButtonSet;
    procedure SetButtonSet(const Value: TNavigatorButtonSet);
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property ButtonSet : TNavigatorButtonSet read FButtonSet
      write SetButtonSet;
 end;
 procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('PKTools', [TDBShortNavigator]);
end;

{ TDBShortNavigator }
procedure TDBShortNavigator.SetButtonSet(const Value: TNavigatorButtonSet);
const
  FULL_SET = [nbFirst, nbPrior, nbNext, nbLast, nbInsert,
    nbDelete, nbEdit, nbPost, nbCancel, nbRefresh];
  PARTIAL_SET = [nbFirst, nbPrior, nbNext, nbLast];
  SETS : array[TNavigatorButtonSet] of TButtonSet = (FULL_SET, PARTIAL_SET);
begin
  if( FButtonSet = Value ) then exit;
  FButtonSet := Value;
  VisibleButtons := SETS[FButtonSet];
end;

end.

