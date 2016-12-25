object FtpFileDownloadForm: TFtpFileDownloadForm
  Left = 317
  Top = 135
  Width = 928
  Height = 480
  Caption = 'FtpFileDownloadForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 912
    Height = 81
    Align = alTop
    TabOrder = 0
    object lblFTP: TccuLabel
      Left = 16
      Top = 16
      Width = 41
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'FTP'
    end
    object lblUser: TccuLabel
      Left = 16
      Top = 40
      Width = 41
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #29992#25143
      Caption_UTF7 = '+dShiNw'
    end
    object lblPassword: TccuLabel
      Left = 16
      Top = 64
      Width = 41
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #23494#30721
      Caption_UTF7 = '+W8Z4AQ'
    end
    object lblLocalPath: TccuLabel
      Left = 296
      Top = 16
      Width = 57
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #30446#26631#36335#24452
      Caption_UTF7 = '+du5oB43vX4Q'
    end
    object lblPort: TccuLabel
      Left = 184
      Top = 16
      Width = 33
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #31471#21475
      Caption_UTF7 = '+eu9T4w'
    end
    object bedtFTP: TccuButtonEdit
      Left = 64
      Top = 8
      Width = 121
      Height = 21
      AutoSelect = False
      AutoSize = False
      ReadOnly = False
      TabOrder = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'MS Sans Serif'
      BoundLabel.Font.Style = []
      SkinData.CustomColor = True
      SkinData.SkinSection = 'ALPHAEDIT'
      EditItems = <>
      DiffChar = ','
      MultiSelect = False
      DataFormat = dfString
      AllowClearAll = False
      AddOnId = 0
      AutoClearAddOn = True
      ShowWeek = False
      ItemIndex = -1
    end
    object bedtUser: TccuButtonEdit
      Left = 64
      Top = 32
      Width = 121
      Height = 21
      AutoSelect = False
      AutoSize = False
      ReadOnly = False
      TabOrder = 1
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'MS Sans Serif'
      BoundLabel.Font.Style = []
      SkinData.CustomColor = True
      SkinData.SkinSection = 'ALPHAEDIT'
      EditItems = <>
      DiffChar = ','
      MultiSelect = False
      DataFormat = dfString
      AllowClearAll = False
      AddOnId = 0
      AutoClearAddOn = True
      ShowWeek = False
      ItemIndex = -1
    end
    object bedtLocalPath: TccuButtonEdit
      Left = 358
      Top = 8
      Width = 435
      Height = 21
      AutoSelect = False
      AutoSize = False
      ReadOnly = False
      TabOrder = 2
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'MS Sans Serif'
      BoundLabel.Font.Style = []
      SkinData.CustomColor = True
      SkinData.SkinSection = 'ALPHAEDIT'
      EditItems = <>
      DiffChar = ','
      MultiSelect = False
      DataFormat = dfString
      AllowClearAll = False
      AddOnId = 0
      AutoClearAddOn = True
      ShowWeek = False
      ItemIndex = -1
    end
    object bedtPort: TccuButtonEdit
      Left = 216
      Top = 8
      Width = 57
      Height = 21
      AutoSelect = False
      AutoSize = False
      ReadOnly = False
      TabOrder = 3
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'MS Sans Serif'
      BoundLabel.Font.Style = []
      SkinData.CustomColor = True
      SkinData.SkinSection = 'ALPHAEDIT'
      EditItems = <>
      DiffChar = ','
      MultiSelect = False
      DataFormat = dfString
      AllowClearAll = False
      AddOnId = 0
      AutoClearAddOn = True
      ShowWeek = False
      ItemIndex = -1
    end
    object bedt6: TccuButtonEdit
      Left = 688
      Top = 24
      Width = 121
      Height = 21
      AutoSelect = False
      AutoSize = False
      ReadOnly = False
      TabOrder = 4
      Visible = False
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'MS Sans Serif'
      BoundLabel.Font.Style = []
      SkinData.CustomColor = True
      SkinData.SkinSection = 'ALPHAEDIT'
      EditItems = <>
      DiffChar = ','
      MultiSelect = False
      DataFormat = dfString
      AllowClearAll = False
      AddOnId = 0
      AutoClearAddOn = True
      ShowWeek = False
      ItemIndex = -1
    end
    object btnStart: TButton
      Left = 192
      Top = 52
      Width = 75
      Height = 25
      Caption = #24320#22987#19979#36733
      TabOrder = 5
      OnClick = btnStartClick
    end
    object btnSaveSet: TButton
      Left = 272
      Top = 52
      Width = 75
      Height = 25
      Caption = #20445#23384#37197#32622
      TabOrder = 6
      OnClick = btnSaveSetClick
    end
  end
  object dgDetail: TccuDataStringGrid
    Left = 0
    Top = 81
    Width = 705
    Height = 361
    Align = alLeft
    DefaultRowHeight = 18
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
    TabOrder = 1
    CheckBoxes = False
    AutoCalcSelSum = False
    AllowRowSelect = False
    RowSelectBkgColor = clNavy
    RowSelectFont.Charset = DEFAULT_CHARSET
    RowSelectFont.Color = clWindow
    RowSelectFont.Height = -11
    RowSelectFont.Name = 'MS Sans Serif'
    RowSelectFont.Style = []
    MultiSelect = False
    NoLimitPaste = False
    SubTotalFont.Charset = DEFAULT_CHARSET
    SubTotalFont.Color = clWindowText
    SubTotalFont.Height = -11
    SubTotalFont.Name = 'MS Sans Serif'
    SubTotalFont.Style = []
    SubTotalColor = clInfoBk
    AllowSelectRange = True
    LimitEmptyRowMoving = False
    DrawTreeLine = True
    DrawTreeImage = True
    Columns = <
      item
        AutoClearRelateFieldValue = False
        DisplayFormat = dspNormal
        ShowProgress = False
        ProgressColor = clBlue
        DispImgStyle = diLeftBottom
        FormulaType = ftNone
        Title.Color = clBlack
        IsPrint = True
        isMerge = False
        NoAllowExport = False
        NoAllowImportEmpty = False
        imageIndex = -1
        Asc = True
        Width = 40
        AssistSortIndex = -1
        RadioItem = False
        AllowReturnFocus = True
        NeedCalc = False
        IsOutLine = False
        ShowFilter = False
        FilterStyle = fsNone
        SmallImageIndex = -1
        MultiSelected = False
        ColType = rtNormal
      end
      item
        AutoClearRelateFieldValue = False
        DisplayFormat = dspNormal
        ShowProgress = False
        ProgressColor = clBlue
        DispImgStyle = diLeftBottom
        FormulaType = ftNone
        Title.Caption = ' '#36335#24452
        Title.Color = clBlack
        IsPrint = True
        isMerge = False
        NoAllowExport = False
        NoAllowImportEmpty = False
        imageIndex = -1
        Asc = True
        Width = 400
        AssistSortIndex = -1
        RadioItem = False
        AllowReturnFocus = True
        NeedCalc = False
        IsOutLine = False
        ShowFilter = False
        FieldName = 'Path'
        FilterStyle = fsNone
        SmallImageIndex = -1
        MultiSelected = False
        ColType = rtNormal
      end
      item
        AutoClearRelateFieldValue = False
        DisplayFormat = dspNormal
        ShowProgress = False
        ProgressColor = clBlue
        DispImgStyle = diLeftBottom
        FormulaType = ftNone
        Title.Caption = #19979#36733#25991#20214#21517
        Title.Color = clBlack
        IsPrint = True
        isMerge = False
        NoAllowExport = False
        NoAllowImportEmpty = False
        imageIndex = -1
        Asc = True
        Width = 100
        AssistSortIndex = -1
        RadioItem = False
        AllowReturnFocus = True
        NeedCalc = False
        IsOutLine = False
        ShowFilter = False
        FieldName = 'LocalName'
        FilterStyle = fsNone
        SmallImageIndex = -1
        MultiSelected = False
        ColType = rtNormal
      end
      item
        AutoClearRelateFieldValue = False
        DisplayFormat = dspNormal
        ShowProgress = False
        ProgressColor = clBlue
        DispImgStyle = diLeftBottom
        FormulaType = ftNone
        PickList.Strings = (
          #24453#19979#36733
          #25104#21151
          #22833#36133)
        PickList.WideStrings_UTF7 = (
          '+X4VOC499'
          '+YhBSnw'
          '+WTGNJQ')
        Title.Caption = #19979#36733#29366#24577
        Title.Color = clBlack
        IsPrint = True
        isMerge = False
        NoAllowExport = False
        NoAllowImportEmpty = False
        imageIndex = -1
        Asc = True
        Width = 64
        AssistSortIndex = -1
        RadioItem = False
        AllowReturnFocus = True
        NeedCalc = False
        IsOutLine = False
        RelationValues.Strings = (
          '1'
          '2'
          '3')
        ShowFilter = False
        FieldName = 'Stat'
        FilterStyle = fsNone
        SmallImageIndex = -1
        MultiSelected = False
        ColType = rtNormal
      end
      item
        AutoClearRelateFieldValue = False
        DisplayFormat = dspNormal
        ShowProgress = False
        ProgressColor = clBlue
        DispImgStyle = diLeftBottom
        FormulaType = ftNone
        Title.Color = clBlack
        IsPrint = True
        isMerge = False
        NoAllowExport = False
        NoAllowImportEmpty = False
        imageIndex = -1
        Asc = True
        Width = 64
        AssistSortIndex = -1
        RadioItem = False
        AllowReturnFocus = True
        NeedCalc = False
        IsOutLine = False
        ShowFilter = False
        FilterStyle = fsNone
        SmallImageIndex = -1
        MultiSelected = False
        ColType = rtNormal
      end>
    RowProps = <
      item
        ImageIndex = -1
        ReadOnly = False
        HasChild = False
        Expanded = False
        RowHeight = 18
        SelectedIndex = -1
        NodeImageIndex = -1
        Level = 0
        BeginDrawLevel = 0
        IsLastNode = False
        RowColor = clWindow
        RowFontColor = clWindowText
        RowFontName = 'MS Sans Serif'
        RowFontSize = 8
        RowHasChange = False
        Checked = False
        HideCheckBox = False
        AbsoluteIndex = 0
        RadioItem = False
        GroupIndex = 0
        IsFilterRow = False
        RowType = rtNormal
      end
      item
        ImageIndex = -1
        ReadOnly = False
        HasChild = False
        Expanded = False
        RowHeight = 18
        SelectedIndex = -1
        NodeImageIndex = -1
        Level = 0
        BeginDrawLevel = 0
        IsLastNode = False
        RowColor = clWindow
        RowFontColor = clWindowText
        RowFontName = 'MS Sans Serif'
        RowFontSize = 8
        RowHasChange = False
        Checked = False
        HideCheckBox = False
        AbsoluteIndex = 0
        RadioItem = False
        GroupIndex = 0
        IsFilterRow = False
        RowType = rtNormal
      end>
    LockSets.MaxValue = 100
    LockSets.MinValue = 0
    LockSets.Progress = 0
    LockSets.ShowGuage = False
    LockSets.Caption = 'waiting...'
    LockSets.Color = clWindow
    LockSets.ForeColor = clSkyBlue
    LockSets.Font.Charset = DEFAULT_CHARSET
    LockSets.Font.Color = clWindowText
    LockSets.Font.Height = -11
    LockSets.Font.Name = 'MS Sans Serif'
    LockSets.Font.Style = []
    LockSets.Visible = False
    RowCountMin = 0
    SelectedIndex = 1
    DispImgStyle = diLeftBottom
    DragFill = False
    Flat = False
    FrozenCols = 0
    TitleHeight = 0
    AllowTitlePress = False
    AllowIndicatorPress = False
    AutoSort = False
    SortColumnIndex = -1
    RequireIndex = True
    UseFieldNameCalc = False
    IsRadioItem = False
    IsShowAllNote = True
    NodeImageStyle = niNormal
    FooterInfo.Color = clWindow
    FooterInfo.Count = 0
    FooterInfo.Font.Charset = DEFAULT_CHARSET
    FooterInfo.Font.Color = clBlack
    FooterInfo.Font.Height = -11
    FooterInfo.Font.Name = 'MS Sans Serif'
    FooterInfo.Font.Style = []
    FooterInfo.Height = 24
    Zebra = False
    ZebraColor1 = clWindow
    ZebraColor2 = 15000804
    ShowFilter = False
    PopupMenuStyle = psAuto
    FixedGradientPosition = gpTopToBottom
    FocusedFixedGradientPosition = gpTopToBottom
    LineColor = 12164479
    FixedGradient = True
    FixedGradientColorStart = 16577513
    FixedGradientColorEnd = 16309955
    FocusedFixedGradientColorStart = 16376522
    FocusedFixedGradientColorEnd = 15641963
    ColWidths = (
      40
      400
      100
      64
      64)
  end
  object bedtPassword: TccuButtonEdit
    Left = 64
    Top = 56
    Width = 121
    Height = 21
    AutoSelect = False
    AutoSize = False
    ReadOnly = False
    TabOrder = 2
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    SkinData.CustomColor = True
    SkinData.SkinSection = 'ALPHAEDIT'
    EditItems = <>
    DiffChar = ','
    MultiSelect = False
    DataFormat = dfString
    AllowClearAll = False
    AddOnId = 0
    AutoClearAddOn = True
    ShowWeek = False
    ItemIndex = -1
  end
end
