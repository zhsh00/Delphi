object DrawForm: TDrawForm
  Left = 435
  Top = 52
  Width = 934
  Height = 540
  Caption = 'DrawForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 204
    Top = 0
    Width = 714
    Height = 482
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 0
    object pnl2: TPanel
      Left = 0
      Top = 0
      Width = 10000
      Height = 10000
      Caption = 'pnl2'
      TabOrder = 0
      object img: TImage
        Left = 3
        Top = 3
        Width = 10000
        Height = 10000
        OnMouseMove = imgMouseMove
      end
      object imgSave: TImage
        Left = 272
        Top = 120
        Width = 105
        Height = 105
        Visible = False
      end
    end
  end
  object stbMain: TStatusBar
    Left = 0
    Top = 482
    Width = 918
    Height = 19
    Panels = <
      item
        Width = 350
      end
      item
        Width = 100
      end>
  end
  object pnl5: TPanel
    Left = 0
    Top = 0
    Width = 204
    Height = 482
    Align = alLeft
    Caption = 'pnl5'
    TabOrder = 2
    object gb2: TGroupBox
      Left = 1
      Top = 1
      Width = 202
      Height = 200
      Align = alTop
      Caption = 'gb2'
      TabOrder = 0
      object pnl1: TPanel
        Left = 101
        Top = 15
        Width = 99
        Height = 183
        Align = alClient
        TabOrder = 0
        DesignSize = (
          99
          183)
        object btnSave: TButton
          Left = 8
          Top = 144
          Width = 75
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = #20445#23384#22270#29255
          TabOrder = 0
          OnClick = btnSaveClick
        end
        object btnDraw: TButton
          Left = 8
          Top = 112
          Width = 75
          Height = 25
          Caption = #23436#25972#30011#22270
          TabOrder = 1
          OnClick = btnDrawClick
        end
      end
      object pnl3: TPanel
        Left = 2
        Top = 15
        Width = 99
        Height = 183
        Align = alLeft
        Caption = 'pnl3'
        TabOrder = 1
        object btnDraw1png: TButton
          Left = 8
          Top = 8
          Width = 75
          Height = 25
          Caption = #21152#36733'1'#24352#22270
          TabOrder = 0
          OnClick = btnDraw1pngClick
        end
        object btnDraw1Row: TButton
          Left = 8
          Top = 40
          Width = 75
          Height = 25
          Caption = #21152#36733'1'#34892
          TabOrder = 1
          OnClick = btnDraw1RowClick
        end
        object btnDraw1Col: TButton
          Left = 8
          Top = 72
          Width = 75
          Height = 25
          Caption = #21152#36733'1'#21015
          TabOrder = 2
          OnClick = btnDraw1ColClick
        end
        object btn3: TButton
          Left = 8
          Top = 72
          Width = 75
          Height = 25
          Caption = #35774#32622#33539#22260
          TabOrder = 3
          OnClick = btn3Click
        end
      end
    end
    object gb1: TGroupBox
      Left = 1
      Top = 201
      Width = 202
      Height = 280
      Align = alClient
      Caption = #25511#21046#21442#25968
      TabOrder = 1
      object lbledtRight: TLabeledEdit
        Left = 96
        Top = 32
        Width = 80
        Height = 21
        EditLabel.Width = 25
        EditLabel.Height = 13
        EditLabel.Caption = 'Right'
        TabOrder = 0
        Text = '0'
      end
      object lbledtBottom: TLabeledEdit
        Left = 96
        Top = 72
        Width = 80
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Bottom'
        TabOrder = 1
        Text = '0'
      end
      object lbledtLeft: TLabeledEdit
        Left = 8
        Top = 32
        Width = 80
        Height = 21
        EditLabel.Width = 15
        EditLabel.Height = 13
        EditLabel.Caption = 'Lef'
        TabOrder = 2
        Text = '0'
      end
      object lbledtTop: TLabeledEdit
        Left = 8
        Top = 72
        Width = 80
        Height = 21
        EditLabel.Width = 19
        EditLabel.Height = 13
        EditLabel.Caption = 'Top'
        TabOrder = 3
        Text = '0'
      end
    end
  end
end
