{
Copyright © 1998 by Delphi 4 Developer's Guide - Xavier Pacheco and Steve Teixeira
}

unit NewChildFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ChildFrm, ExtCtrls;

type
  TNewChildForm = class(TChildForm)
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NewChildForm: TNewChildForm;

implementation

{$R *.DFM}

end.
