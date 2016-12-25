inherited ReadMemoryForm: TReadMemoryForm
  Left = 529
  Top = 141
  Width = 845
  Caption = 'ReadMemoryForm'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited tb1: TToolBar
    Width = 829
    ButtonWidth = 84
    object btnCheckPtr: TToolButton
      Left = 84
      Top = 2
      AutoSize = True
      Caption = 'CheckPtr'
      ImageIndex = 5
      OnClick = btnCheckPtrClick
    end
    object btn3: TToolButton
      Left = 139
      Top = 2
      Caption = 'btn3'
      ImageIndex = 7
      OnClick = btn3Click
    end
    object btnFirst: TToolButton
      Left = 223
      Top = 2
      AutoSize = True
      Caption = 'btnFirst'
      ImageIndex = 6
      OnClick = btnFirstClick
    end
    object btnFilterOutNonChange: TToolButton
      Left = 268
      Top = 2
      AutoSize = True
      Caption = #36807#28388
      ImageIndex = 8
      OnClick = btnFilterOutNonChangeClick
    end
    object btnFindNonChange: TToolButton
      Left = 303
      Top = 2
      Caption = 'FindNonChange'
      ImageIndex = 9
      OnClick = btnFindNonChangeClick
    end
    object btnFindChanged: TToolButton
      Left = 387
      Top = 2
      AutoSize = True
      Caption = 'FindChanged'
      ImageIndex = 10
      OnClick = btnFindChangedClick
    end
    object btnFindValue: TToolButton
      Left = 461
      Top = 2
      AutoSize = True
      Caption = #26597#25214#20540
      ImageIndex = 1
      OnClick = btnFindValueClick
    end
    object btnSimpleFind: TToolButton
      Left = 508
      Top = 2
      AutoSize = True
      Caption = 'SimpleFind'
      DropdownMenu = pm1
      ImageIndex = 3
      Style = tbsDropDown
      OnClick = btnSimpleFindClick
    end
  end
  inherited pnlLeft: TPanel
    inherited lvProcesses: TListView
      OnDblClick = lvProcessesDblClick
    end
  end
  object pnlRight: TPanel
    Left = 498
    Top = 29
    Width = 331
    Height = 346
    Align = alClient
    Caption = 'pnlRight'
    TabOrder = 2
    object pgc1: TPageControl
      Left = 1
      Top = 1
      Width = 329
      Height = 344
      ActivePage = tsLog
      Align = alClient
      TabOrder = 0
      TabPosition = tpBottom
      object tsResult: TTabSheet
        Caption = #26597#35810#32467#26524
        ImageIndex = 1
        object lvFindResult: TListView
          Left = 0
          Top = 0
          Width = 321
          Height = 288
          Align = alClient
          Columns = <
            item
              Caption = #22320#22336
              Width = 80
            end
            item
              Caption = #22235#23383#33410
              Width = 80
            end
            item
              Caption = #21452#23383#33410
            end
            item
              Caption = #21333#23383#33410
            end>
          TabOrder = 0
          ViewStyle = vsReport
          OnDblClick = lvFindResultDblClick
        end
        object pnlResult: TPanel
          Left = 0
          Top = 288
          Width = 321
          Height = 30
          Align = alBottom
          TabOrder = 1
          object stat2: TStatusBar
            Left = 1
            Top = 1
            Width = 319
            Height = 28
            Panels = <
              item
                Width = 100
              end
              item
                Width = 50
              end>
          end
          object btnPromote: TButton
            Left = 2
            Top = 4
            Width = 75
            Height = 25
            Hint = #25226#20197#19978#22320#22336#20316#20026#19979#19968#27425#26597#35810#30340#28304
            Caption = 'Promote'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = btnPromoteClick
          end
        end
      end
      object tsLog: TTabSheet
        Caption = #26085#24535
        object mmLog: TMemo
          Left = 0
          Top = 0
          Width = 321
          Height = 288
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
        end
        object pnlLog: TPanel
          Left = 0
          Top = 288
          Width = 321
          Height = 30
          Align = alBottom
          TabOrder = 1
          object btnClearMemoLog: TButton
            Left = 0
            Top = 5
            Width = 75
            Height = 25
            Caption = #28165#38500#26085#24535
            TabOrder = 0
            OnClick = btnClearMemoLogClick
          end
        end
      end
      object ts1: TTabSheet
        Caption = 'ts1'
        ImageIndex = 2
        object mm1: TMemo
          Left = 16
          Top = 16
          Width = 265
          Height = 289
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
  end
  object pnlMiddle: TPanel
    Left = 313
    Top = 29
    Width = 185
    Height = 346
    Align = alLeft
    TabOrder = 3
    object lbledtFindValue: TLabeledEdit
      Left = 24
      Top = 64
      Width = 121
      Height = 21
      AutoSize = False
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = #35201#25214#30340#20540
      TabOrder = 0
    end
    object lbledtNewValue: TLabeledEdit
      Left = 8
      Top = 144
      Width = 121
      Height = 21
      AutoSize = False
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = #26032#30340#25968#20540
      TabOrder = 1
    end
    object lbledtAddress: TLabeledEdit
      Left = 24
      Top = 104
      Width = 121
      Height = 21
      AutoSize = False
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = #36873#20013#22320#22336
      TabOrder = 2
    end
    object btnDoModify: TButton
      Left = 128
      Top = 144
      Width = 49
      Height = 25
      Caption = #20462#25913
      TabOrder = 3
      OnClick = btnDoModifyClick
    end
    object lbledtProcess: TLabeledEdit
      Left = 24
      Top = 24
      Width = 121
      Height = 21
      AutoSize = False
      EditLabel.Width = 60
      EditLabel.Height = 13
      EditLabel.Caption = #26597#25214#36827#31243#65306
      TabOrder = 4
    end
    object stat1: TStatusBar
      Left = 1
      Top = 320
      Width = 183
      Height = 25
      Panels = <
        item
          Width = 50
        end>
    end
    object btnReRead: TButton
      Left = 8
      Top = 176
      Width = 75
      Height = 25
      Caption = #37325#26032#35835#20854#20540
      TabOrder = 6
      OnClick = btnReReadClick
    end
    object edtReRead: TEdit
      Left = 80
      Top = 176
      Width = 97
      Height = 21
      TabOrder = 7
    end
    object btnBackupAddresses: TButton
      Left = 96
      Top = 232
      Width = 75
      Height = 25
      Caption = #22791#20221#22320#22336
      TabOrder = 8
      OnClick = btnBackupAddressesClick
    end
    object btnBatchRead: TButton
      Left = 96
      Top = 264
      Width = 75
      Height = 25
      Caption = #25209#37327#35835
      TabOrder = 9
      OnClick = btnBatchReadClick
    end
    object btnBatchWrite: TButton
      Left = 8
      Top = 264
      Width = 75
      Height = 25
      Caption = #25209#37327#20889
      TabOrder = 10
      OnClick = btnBatchWriteClick
    end
    object lbledtAAAA: TLabeledEdit
      Left = 8
      Top = 296
      Width = 121
      Height = 21
      AutoSize = False
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = #35201#25214#30340#20540
      TabOrder = 11
    end
  end
  object pm1: TPopupMenu
    Alignment = paCenter
    Left = 473
    Top = 85
    object mniNewSession: TMenuItem
      Caption = #26032#20250#35805
      OnClick = mniNewSessionClick
    end
  end
end
