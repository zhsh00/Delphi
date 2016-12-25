object MainForm: TMainForm
  Left = 429
  Top = 165
  Width = 719
  Height = 408
  Caption = #25105#30340#31243#24207
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = Menu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object spl1: TSplitter
    Left = 80
    Top = 0
    Width = 5
    Height = 350
    Cursor = crHSplit
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 80
    Height = 350
    Align = alLeft
    TabOrder = 0
  end
  object pgcRight: TPageControl
    Left = 85
    Top = 0
    Width = 618
    Height = 350
    Align = alClient
    TabOrder = 1
  end
  object Menu1: TMainMenu
    Left = 48
    Top = 304
    object pmiN1: TMenuItem
      Caption = #24037#20316#24037#20855
      object pmiN3: TMenuItem
        Caption = #26816#26597'dfm'
        OnClick = pmiN3Click
      end
    end
    object pmiN2: TMenuItem
      Caption = #27979#35797#29609#29609
      object pmiN4: TMenuItem
        Caption = #36882#24402#26597#25214#30446#24405
        OnClick = pmiN4Click
      end
      object pmiN5: TMenuItem
        Caption = #36164#28304#31649#29702#22120
        OnClick = pmiN5Click
      end
      object estTreeViewForm1: TMenuItem
        Caption = 'TestTreeViewForm'
        OnClick = estTreeViewForm1Click
      end
      object InheritTestForm1: TMenuItem
        Caption = 'InheritTestForm'
        OnClick = InheritTestForm1Click
      end
      object MessageTestForm1: TMenuItem
        Caption = 'MessageTestForm'
        OnClick = MessageTestForm1Click
      end
      object mniDealExeclNameForm: TMenuItem
        Caption = 'DealExeclNameForm'
      end
      object N1: TMenuItem
        Caption = #37325#21629#21517
        OnClick = N1Click
      end
    end
    object pmiN6: TMenuItem
      Caption = #21621#21621
      object pmiForm11: TMenuItem
        Caption = #26174#31034'Form1'
        OnClick = pmiForm11Click
      end
      object pmiForm21: TMenuItem
        Caption = #26174#31034'Form2'
        OnClick = pmiForm21Click
      end
    end
  end
end
