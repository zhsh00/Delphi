object CheckFolderForm: TCheckFolderForm
  Left = 442
  Top = 237
  Width = 523
  Height = 182
  Caption = 'CheckFolderForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TccuLabel
    Left = 24
    Top = 56
    Width = 457
    Height = 13
    AutoSize = False
    Caption = #22312#24403#21069#25991#20214#22841#30340#21516#32423#30446#24405#26032#24314#25991#20214#22841#65307#35831#36755#20837#25991#20214#22841#21517
    Caption_UTF7 = 
      '+VyhfU1JNZYdO9lk5doRUDH6ndu5fVWWwXvplh072WTn/G4v3j5NRZWWHTvZZOVQ' +
      'N'
  end
  object bedt1: TccuButtonEdit
    Left = 24
    Top = 16
    Width = 457
    Height = 21
    AutoSize = False
    ReadOnly = False
    TabOrder = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    SkinData.CustomColor = True
    SkinData.SkinSection = 'ALPHAEDIT'
    EditItems = <>
    DiffChar = ','
    MultiSelect = False
    DataFormat = dfString
    AllowClearAll = False
    AddOnId = 0
    AutoClearAddOn = True
    ButtonStyle = lsSelect
    ShowWeek = False
    ItemIndex = -1
    OnButtonClick = bedt1ButtonClick
  end
  object bedt2: TccuButtonEdit
    Left = 24
    Top = 72
    Width = 457
    Height = 21
    AutoSelect = False
    AutoSize = False
    ReadOnly = False
    TabOrder = 1
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    SkinData.CustomColor = True
    SkinData.SkinSection = 'ALPHAEDIT'
    EditItems = <>
    DiffChar = ','
    MultiSelect = False
    DataFormat = dfString
    AllowClearAll = False
    AddOnId = 0
    AutoClearAddOn = True
    ShowWeek = False
    ItemIndex = -1
  end
  object dlg1: TccuOpenDialog
    Left = 368
    Top = 40
  end
end
