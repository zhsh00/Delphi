object CompReNameForm: TCompReNameForm
  Left = 295
  Top = 127
  Width = 916
  Height = 450
  Caption = #37325#21629#21517#25991#20214
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 900
    Height = 89
    Align = alTop
    TabOrder = 0
    object grp1: TGroupBox
      Left = 16
      Top = 0
      Width = 185
      Height = 65
      Caption = '1.'#26367#25442#25351#23450#23383#31526#20018
      TabOrder = 0
      object edtOld1: TEdit
        Left = 8
        Top = 16
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object btn1: TButton
        Left = 128
        Top = 16
        Width = 51
        Height = 21
        Caption = #25913#21517
        TabOrder = 1
        OnClick = btn1Click
      end
      object edtNew1: TEdit
        Left = 8
        Top = 40
        Width = 121
        Height = 21
        TabOrder = 2
      end
    end
    object grp2: TGroupBox
      Left = 208
      Top = 0
      Width = 209
      Height = 73
      Caption = '2.'#26367#25442#26631#24535#38388#23383#31526#20018
      TabOrder = 1
      object lbl1: TLabel
        Left = 64
        Top = 16
        Width = 16
        Height = 13
        AutoSize = False
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edt2: TEdit
        Left = 8
        Top = 16
        Width = 49
        Height = 21
        TabOrder = 0
      end
      object btn2: TButton
        Left = 152
        Top = 40
        Width = 51
        Height = 21
        Caption = #25913#21517
        TabOrder = 1
      end
      object edt3: TEdit
        Left = 80
        Top = 16
        Width = 49
        Height = 21
        TabOrder = 2
      end
      object edt5: TEdit
        Left = 8
        Top = 40
        Width = 121
        Height = 21
        TabOrder = 3
      end
      object chk1: TCheckBox
        Left = 128
        Top = 20
        Width = 73
        Height = 17
        Caption = #26367#25442#26631#24535
        TabOrder = 4
      end
    end
    object btnAddFiles: TButton
      Left = 16
      Top = 66
      Width = 75
      Height = 21
      Caption = #28155#21152#25991#20214
      TabOrder = 2
      OnClick = btnAddFilesClick
    end
    object btnCommit: TButton
      Left = 88
      Top = 66
      Width = 75
      Height = 21
      Caption = #30830#23450#37325#21629#21517
      TabOrder = 3
      OnClick = btnCommitClick
    end
  end
  object pnlRight: TPanel
    Left = 715
    Top = 89
    Width = 185
    Height = 323
    Align = alRight
    TabOrder = 1
  end
  object lv1: TListView
    Left = 0
    Top = 89
    Width = 715
    Height = 323
    Align = alClient
    Columns = <
      item
        Caption = #26087#21517#23383
        Width = 350
      end
      item
        Caption = #26032#21517#23383
        Width = 350
      end>
    TabOrder = 2
    ViewStyle = vsReport
  end
  object pm1: TPopupMenu
    Left = 536
    Top = 56
    object pmiAddFiles: TMenuItem
      Caption = #28155#21152#25991#20214
    end
  end
  object OpenDialog1: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 576
    Top = 56
  end
end
