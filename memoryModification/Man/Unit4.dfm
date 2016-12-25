inherited BaseForm4: TBaseForm4
  Caption = 'BaseForm4'
  PixelsPerInch = 96
  TextHeight = 13
  inherited tb1: TToolBar
    object btn1: TToolButton
      Left = 55
      Top = 2
      Caption = 'btn1'
      ImageIndex = 1
      OnClick = btn1Click
    end
    object btnCCCC: TToolButton
      Left = 110
      Top = 2
      Caption = 'btnCCCC'
      ImageIndex = 2
      OnClick = btnCCCCClick
    end
    object btnReset: TToolButton
      Left = 165
      Top = 2
      Caption = 'btnReset'
      ImageIndex = 3
      OnClick = btnResetClick
    end
    object btnCheck: TToolButton
      Left = 220
      Top = 2
      Caption = 'btnCheck'
      ImageIndex = 4
      OnClick = btnCheckClick
    end
  end
  object edt1: TEdit
    Left = 400
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'edt1'
  end
  object edt2: TEdit
    Left = 400
    Top = 136
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'edt2'
  end
  object mmLog: TMemo
    Left = 448
    Top = 88
    Width = 233
    Height = 225
    Lines.Strings = (
      'mmLog')
    TabOrder = 4
  end
end
