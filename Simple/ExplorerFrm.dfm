inherited ExplorerForm: TExplorerForm
  Left = 422
  Top = 143
  Width = 782
  Height = 404
  Caption = #36164#28304#31649#29702#22120
  PixelsPerInch = 96
  TextHeight = 13
  object spl1: TSplitter [0]
    Left = 100
    Top = 0
    Width = 5
    Height = 366
    Cursor = crHSplit
  end
  object pnlLeft: TPanel [1]
    Left = 0
    Top = 0
    Width = 100
    Height = 366
    Align = alLeft
    TabOrder = 0
    object drvcbb1: TDriveComboBox
      Left = 0
      Top = 21
      Width = 100
      Height = 19
      TabOrder = 0
      OnChange = drvcbb1Change
    end
  end
  object pnlRight: TPanel [2]
    Left = 105
    Top = 0
    Width = 661
    Height = 366
    Align = alClient
    TabOrder = 1
    object pnlTop: TPanel
      Left = 1
      Top = 1
      Width = 659
      Height = 40
      Align = alTop
      TabOrder = 0
    end
    object lvDetail: TListView
      Left = 1
      Top = 41
      Width = 659
      Height = 324
      Align = alClient
      Columns = <
        item
          Caption = 'ddd'
          MaxWidth = 100
          MinWidth = 100
          Width = 100
        end>
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
end
