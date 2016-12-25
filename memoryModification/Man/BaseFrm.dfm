object BaseForm: TBaseForm
  Left = 512
  Top = 130
  Width = 722
  Height = 414
  Caption = 'BaseForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tb1: TToolBar
    Left = 0
    Top = 0
    Width = 706
    Height = 29
    ButtonHeight = 21
    ButtonWidth = 55
    Caption = 'tb1'
    ShowCaptions = True
    TabOrder = 0
    object btnRefreshProcess: TToolButton
      Left = 0
      Top = 2
      Caption = #21047#26032#36827#31243
      ImageIndex = 0
      OnClick = btnRefreshProcessClick
    end
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 29
    Width = 313
    Height = 346
    Align = alLeft
    Caption = 'pnlLeft'
    TabOrder = 1
    object lvProcesses: TListView
      Left = 1
      Top = 1
      Width = 311
      Height = 303
      Align = alClient
      Columns = <
        item
          Caption = #36827#31243#21517
          Width = 150
        end
        item
          Caption = #36827#31243'ID'
        end
        item
          Caption = #29238#36827#31243
        end
        item
          Caption = #32447#31243#25968
        end>
      TabOrder = 0
      ViewStyle = vsReport
      OnColumnClick = lvProcessesColumnClick
    end
    object pnlLeftBottom: TPanel
      Left = 1
      Top = 304
      Width = 311
      Height = 41
      Align = alBottom
      Caption = 'pnlLeftBottom'
      TabOrder = 1
    end
  end
end
