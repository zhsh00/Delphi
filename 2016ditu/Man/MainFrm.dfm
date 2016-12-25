object MainForm: TMainForm
  Left = 489
  Top = 149
  Width = 950
  Height = 653
  Caption = 'MainForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pgc: TPageControl
    Left = 0
    Top = 0
    Width = 934
    Height = 594
    Align = alClient
    TabOrder = 0
  end
  object MainMenu1: TMainMenu
    Left = 304
    Top = 72
    object N1: TMenuItem
      Caption = #39069
      object N2: TMenuItem
        Caption = #19979#36733#30028#38754
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #32472#22270#30028#38754
        OnClick = N3Click
      end
    end
  end
end
