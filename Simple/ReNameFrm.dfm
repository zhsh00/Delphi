inherited ReNameForm: TReNameForm
  Caption = #37325#21629#21517#25991#20214
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel [0]
    Left = 387
    Top = 0
    Width = 129
    Height = 263
    Align = alRight
    Caption = 'pnl1'
    TabOrder = 0
    object edtFilter: TEdit
      Left = 0
      Top = 0
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object btnFind: TButton
      Left = 0
      Top = 21
      Width = 121
      Height = 21
      Caption = #31579#36873#25991#20214
      TabOrder = 1
      OnClick = btnFindClick
    end
    object btnModifyName: TButton
      Left = 0
      Top = 42
      Width = 121
      Height = 21
      Caption = #29983#25104#26032#21517#23383
      TabOrder = 2
      OnClick = btnModifyNameClick
    end
    object btnReName: TButton
      Left = 0
      Top = 63
      Width = 121
      Height = 21
      Caption = #37325#21629#21517
      TabOrder = 3
      OnClick = btnReNameClick
    end
  end
  object pnl2: TPanel [1]
    Left = 0
    Top = 0
    Width = 387
    Height = 263
    Align = alClient
    Caption = 'pnl2'
    TabOrder = 1
    DesignSize = (
      387
      263)
    object lv1: TListView
      Left = 1
      Top = 21
      Width = 385
      Height = 241
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          Caption = #26087#21517#23383
          Width = 190
        end
        item
          Caption = #26032#21517#23383
          Width = 190
        end>
      TabOrder = 0
      ViewStyle = vsReport
    end
    object edtDirectory: TEdit
      Left = 0
      Top = 0
      Width = 385
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
  end
end
