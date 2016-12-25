unit UAboutBoxDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, UVersionLabel;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    VersionLabel1: TVersionLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TAboutBoxDialog = class(TComponent)
  private
    AboutBox: TABoutBox;
    FProductName, FCopyright, FComments : TCaption;
    FPicture : TPicture;
  protected
    procedure SetPicture(const Value: TPicture);
  public
    function Execute: Boolean;
  published
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Copyright: TCaption read FCopyright write FCopyright;
    property Comments: TCaption read FComments write FComments;
    property ProductName: TCaption read FProductName write FProductName;
    property Picture: TPicture read FPicture write SetPicture;
  end;

//var
//  AboutBox: TAboutBox;

//procedure Register;

implementation

{$R *.dfm}

//procedure Register;
//begin
//  RegisterComponents('zhshll', [TAboutBoxDialog]);
//end;

{ TAboutBoxDialog }
constructor TAboutBoxDialog.Create(AOwner: TComponent);
begin
  inherited;
  FPicture := TPicture.Create;
end;

destructor TAboutBoxDialog.Destroy;
begin
  FPicture.Free;
  inherited;
end;

function TAboutBoxDialog.Execute: Boolean;
begin
  AboutBox := TAboutBox.Create(Screen);
  try
    AboutBox.ProductName.Caption := FProductName;
    AboutBox.Copyright.Caption := FCopyright;
    AboutBox.Comments.Caption := FComments;
    AboutBox.VersionLabel1.FileName := Application.EXEName;
    AboutBox.ProgramIcon.Picture.Assign(FPicture);
    AboutBox.ShowModal;
  finally
    AboutBox.Free;
  end;
  result := True;
end;

procedure TAboutBoxDialog.SetPicture(const Value: TPicture);
begin
  if(Value = FPicture) then exit;
    FPicture.Assign(Value);
end;


end.
 
