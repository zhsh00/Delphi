object InheritTestForm: TInheritTestForm
  Left = 403
  Top = 130
  Width = 645
  Height = 469
  Caption = 'InheritTestForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 16
    Width = 185
    Height = 401
    Caption = 'GroupBox1'
    TabOrder = 0
    object btn1: TButton
      Left = 56
      Top = 32
      Width = 75
      Height = 25
      Caption = 'btn1'
      TabOrder = 0
      OnClick = btn1Click
    end
    object btn2: TButton
      Left = 56
      Top = 72
      Width = 75
      Height = 25
      Caption = 'btn2'
      TabOrder = 1
      OnClick = btn2Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 208
    Top = 16
    Width = 185
    Height = 401
    Caption = 'GroupBox2'
    TabOrder = 1
    object btn3: TButton
      Left = 56
      Top = 32
      Width = 75
      Height = 25
      Caption = 'btn3'
      TabOrder = 0
      OnClick = btn3Click
    end
    object btn4: TButton
      Left = 56
      Top = 72
      Width = 75
      Height = 25
      Caption = 'btn4'
      TabOrder = 1
      OnClick = btn4Click
    end
    object btn5: TButton
      Left = 56
      Top = 112
      Width = 75
      Height = 25
      Caption = 'btn5'
      TabOrder = 2
      OnClick = btn5Click
    end
    object btn9: TButton
      Left = 56
      Top = 152
      Width = 75
      Height = 25
      Caption = 'btn9'
      TabOrder = 3
      OnClick = btn9Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 408
    Top = 16
    Width = 185
    Height = 401
    Caption = 'GroupBox3'
    TabOrder = 2
    object btn6: TButton
      Left = 48
      Top = 32
      Width = 75
      Height = 25
      Caption = 'btn6'
      TabOrder = 0
      OnClick = btn6Click
    end
    object btn7: TButton
      Left = 48
      Top = 72
      Width = 75
      Height = 25
      Caption = 'btn7'
      TabOrder = 1
      OnClick = btn7Click
    end
    object btn8: TButton
      Left = 48
      Top = 112
      Width = 75
      Height = 25
      Caption = 'btn8'
      TabOrder = 2
      OnClick = btn8Click
    end
  end
  object pnl1: TPanel
    Left = 8
    Top = 384
    Width = 617
    Height = 41
    Caption = 'pnl1'
    TabOrder = 3
    object btn10: TButton
      Left = 208
      Top = 8
      Width = 75
      Height = 25
      Caption = 'btn10'
      TabOrder = 0
      OnClick = btn10Click
    end
  end
end
