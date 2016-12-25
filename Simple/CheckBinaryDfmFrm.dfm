inherited CheckBinaryDfmForm: TCheckBinaryDfmForm
  Left = 514
  Top = 148
  Caption = 'CheckBinaryDfmForm'
  PixelsPerInch = 96
  TextHeight = 13
  object lblFolder: TLabel
    Left = 8
    Top = 8
    Width = 96
    Height = 13
    Caption = #22635#20837#36845#20195#24320#22987#36335#24452
  end
  object mm1: TMemo
    Left = 8
    Top = 50
    Width = 409
    Height = 217
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object edt1: TEdit
    Left = 8
    Top = 25
    Width = 409
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object btnCheck: TButton
    Left = 118
    Top = 5
    Width = 75
    Height = 21
    Caption = #24320#22987#26597#25214
    TabOrder = 2
    OnClick = btnCheckClick
  end
  object btnTextTest: TButton
    Left = 198
    Top = 5
    Width = 75
    Height = 21
    Caption = #21019#24314#25991#26412
    TabOrder = 3
    OnClick = btnTextTestClick
  end
  object btnReadDfm: TButton
    Left = 278
    Top = 5
    Width = 75
    Height = 21
    Caption = #26816#26597#21333#20010'dfm'
    TabOrder = 4
    OnClick = btnReadDfmClick
  end
  object dlgOpen1: TOpenDialog
    Left = 72
    Top = 112
  end
end
