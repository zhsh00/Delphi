object UploadToFtpForm: TUploadToFtpForm
  Left = 296
  Top = 162
  Width = 928
  Height = 480
  Caption = #19978#20256#25991#20214#21040'FTP'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 912
    Height = 57
    Align = alTop
    TabOrder = 0
    DesignSize = (
      912
      57)
    object lblFilter: TLabel
      Left = 16
      Top = 11
      Width = 49
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #36807#28388#22120
    end
    object lblPath: TLabel
      Left = 8
      Top = 35
      Width = 57
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #26412#22320#36335#24452
    end
    object btnSaveSet: TButton
      Left = 819
      Top = 32
      Width = 90
      Height = 21
      Anchors = [akTop, akRight]
      Caption = #20445#23384#37197#32622#25991#20214
      Enabled = False
      TabOrder = 0
      OnClick = btnSaveSetClick
    end
    object btnLoadSet: TButton
      Left = 819
      Top = 8
      Width = 90
      Height = 21
      Anchors = [akTop, akRight]
      Caption = #21152#36733#37197#32622#25991#20214
      TabOrder = 1
      OnClick = btnLoadSetClick
    end
    object btnAddZip: TButton
      Left = 238
      Top = 8
      Width = 75
      Height = 21
      Caption = #28155#21152#25991#20214
      TabOrder = 2
      OnClick = btnAddZipClick
    end
    object edtFilter: TEdit
      Left = 65
      Top = 8
      Width = 160
      Height = 21
      TabOrder = 3
      Text = 'ZIP|*.ZIP|exe;bpl|*.exe;*.bpl'
    end
    object edtPath: TEdit
      Left = 65
      Top = 32
      Width = 249
      Height = 21
      TabOrder = 4
      Text = 'D:\Zipbpls'
    end
    object btnUpload: TButton
      Left = 726
      Top = 8
      Width = 90
      Height = 21
      Anchors = [akTop, akRight]
      Caption = #25171#21253
      TabOrder = 5
      OnClick = btnUploadClick
    end
    object btnSaveEnable: TButton
      Tag = 1
      Left = 726
      Top = 32
      Width = 90
      Height = 21
      Anchors = [akTop, akRight]
      Caption = #21551#29992#20445#23384#25353#38062
      TabOrder = 6
      OnClick = btnSaveEnableClick
    end
    object edtFind: TEdit
      Left = 320
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 7
    end
    object btnFind: TButton
      Left = 438
      Top = 32
      Width = 40
      Height = 21
      Caption = #26597#25214
      TabOrder = 8
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 57
    Width = 912
    Height = 385
    Align = alClient
    TabOrder = 1
    object spl1: TSplitter
      Left = 1
      Top = 146
      Width = 910
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      MinSize = 150
    end
    object pnlZip: TPanel
      Left = 1
      Top = 1
      Width = 910
      Height = 145
      Align = alClient
      Caption = 'pnlZip'
      TabOrder = 0
      object dgZip: TccuDataStringGrid
        Left = 1
        Top = 1
        Width = 908
        Height = 143
        Align = alClient
        ColCount = 11
        DefaultRowHeight = 18
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
        PopupMenu = pmdgOprerate
        TabOrder = 0
        CheckBoxes = True
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
            Width = 20
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
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 25
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
            Title.Caption = #21517#31216
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 111
            AssistSortIndex = -1
            RadioItem = False
            AllowReturnFocus = True
            NeedCalc = False
            IsOutLine = False
            ShowFilter = False
            FieldName = 'ZipName'
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
            Title.Caption = #21407#22987#22823#23567
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 111
            AssistSortIndex = -1
            RadioItem = False
            AllowReturnFocus = True
            NeedCalc = False
            IsOutLine = False
            ShowFilter = False
            FieldName = 'OldSize'
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
            Title.Caption = 'ZIP'
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 111
            AssistSortIndex = -1
            RadioItem = False
            AllowReturnFocus = True
            NeedCalc = False
            IsOutLine = False
            ShowFilter = False
            FieldName = 'ZIP'
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
            Title.Caption = #25991#20214#26102#38388
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 111
            AssistSortIndex = -1
            RadioItem = False
            AllowReturnFocus = True
            NeedCalc = False
            IsOutLine = False
            ShowFilter = False
            FieldName = 'FileTime'
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
            Title.Caption = #26102#38388
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            Visible = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = -1
            AssistSortIndex = -1
            RadioItem = False
            AllowReturnFocus = True
            NeedCalc = False
            IsOutLine = False
            ShowFilter = False
            FieldName = 'Time'
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
            Title.Caption = #26412#22320#36335#24452
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 200
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
            PickList.Strings = (
              #25104#21151
              #22833#36133)
            PickList.WideStrings_UTF7 = (
              '+YhBSnw'
              '+WTGNJQ')
            Title.Caption = #19978#20256#29366#24577
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
              '2')
            ShowFilter = False
            FieldName = 'UpStat'
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
            Title.Caption = 'A'
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
            FieldName = 'A'
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
            Title.Caption = 'B'
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
            FieldName = 'B'
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
          20
          25
          111
          111
          111
          111
          -1
          200
          64
          40
          40)
      end
      object cbxZip: TccuCheckBox
        Left = 6
        Top = 5
        Width = 15
        Height = 15
        TabOrder = 1
        OnClick = cbxZipClick
        Margin = 0
        SkinData.CustomColor = False
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
    object pnlFtp: TPanel
      Left = 1
      Top = 151
      Width = 910
      Height = 233
      Align = alBottom
      Caption = 'pnlFtp'
      TabOrder = 1
      object dgFtp: TccuDataStringGrid
        Left = 1
        Top = 1
        Width = 908
        Height = 231
        Align = alClient
        ColCount = 12
        DefaultRowHeight = 18
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
        PopupMenu = pmdgOprerate
        TabOrder = 0
        CheckBoxes = True
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
            Width = 20
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
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 25
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
            Title.Caption = #21517#31216
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 111
            AssistSortIndex = -1
            RadioItem = False
            AllowReturnFocus = True
            NeedCalc = False
            IsOutLine = False
            ShowFilter = False
            FieldName = 'FtpName'
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
            Title.Caption = 'IP'
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 111
            AssistSortIndex = -1
            RadioItem = False
            AllowReturnFocus = True
            NeedCalc = False
            IsOutLine = False
            ShowFilter = False
            FieldName = 'Host'
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
            Title.Caption = #36335#24452
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 111
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
            PickList.Strings = (
              'FTP'
              'HTTP')
            Title.Caption = #31867#22411
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
              '2')
            ShowFilter = False
            FieldName = 'IsFTP'
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
            Title.Caption = #29992#25143#21517
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 99
            AssistSortIndex = -1
            RadioItem = False
            AllowReturnFocus = True
            NeedCalc = False
            IsOutLine = False
            ShowFilter = False
            FieldName = 'user'
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
            Title.Caption = #23494#30721
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 99
            AssistSortIndex = -1
            RadioItem = False
            AllowReturnFocus = True
            NeedCalc = False
            IsOutLine = False
            ShowFilter = False
            FieldName = 'Password'
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
            Title.Caption = #31471#21475
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
            FieldName = 'Port'
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
            Title.Caption = #32534#21495
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 30
            AssistSortIndex = -1
            RadioItem = False
            AllowReturnFocus = True
            NeedCalc = False
            IsOutLine = False
            ShowFilter = False
            FieldName = 'seq'
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
            Title.Caption = #22791#20221#36335#24452
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = 111
            AssistSortIndex = -1
            RadioItem = False
            AllowReturnFocus = True
            NeedCalc = False
            IsOutLine = False
            ShowFilter = False
            FieldName = 'Bakpath'
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
            Title.Caption = 'TimePath'
            Title.Color = clBlack
            IsPrint = True
            isMerge = False
            Visible = False
            NoAllowExport = False
            NoAllowImportEmpty = False
            imageIndex = -1
            Asc = True
            Width = -1
            AssistSortIndex = -1
            RadioItem = False
            AllowReturnFocus = True
            NeedCalc = False
            IsOutLine = False
            ShowFilter = False
            FieldName = 'TimePath'
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
          20
          25
          111
          111
          111
          64
          99
          99
          64
          30
          111
          -1)
      end
      object cbxFtp: TccuCheckBox
        Left = 6
        Top = 5
        Width = 15
        Height = 15
        TabOrder = 1
        OnClick = cbxFtpClick
        Margin = 0
        SkinData.CustomColor = False
        SkinData.SkinSection = 'CHECKBOX'
        ImgChecked = 0
        ImgUnchecked = 0
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'ZIP|*.ZIP'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 616
    Top = 128
  end
  object pmdgOprerate: TPopupMenu
    Left = 648
    Top = 128
    object pmiDelOneRow: TMenuItem
      Caption = #21024#38500#34892
      OnClick = pmiDelOneRowClick
    end
    object pmiRestorebgColor: TMenuItem
      Caption = #24674#22797#39068#33394
      OnClick = pmiRestorebgColorClick
    end
  end
end
