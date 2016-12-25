object MainForm: TMainForm
  Left = 192
  Top = 130
  Width = 928
  Height = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TccuPageControl
    Left = 0
    Top = 0
    Width = 920
    Height = 449
    ActivePage = tsDoZip
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    OnChange = pgc1Change
    SkinData.CustomColor = False
    SkinData.SkinSection = 'PAGECONTROL'
    object tsDoZip: TccuTabSheet
      Caption = #21387#32553#25991#20214
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      Caption_UTF7 = '+U4t/KWWHTvY'
      object pnlBottom: TccuPanel
        Left = 0
        Top = 83
        Width = 912
        Height = 338
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        SkinData.CustomColor = False
        SkinData.SkinSection = 'PANEL'
        object pnlLeft: TccuPanel
          Left = 2
          Top = 2
          Width = 100
          Height = 334
          Align = alLeft
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          SkinData.CustomColor = False
          SkinData.SkinSection = 'PANEL'
          object btnCheckAndZipIt: TccuButton
            Left = 0
            Top = 128
            Width = 100
            Height = 25
            Caption = #30452#25509#21387#32553#25991#20214
            TabOrder = 0
            OnClick = btnCheckAndZipItClick
            SkinData.CustomColor = False
            SkinData.SkinSection = 'BUTTON'
            Caption_UTF7 = '+dvRjpVOLfyllh072'
          end
          object btnZipAndToTheDir: TccuButton
            Left = 0
            Top = 160
            Width = 100
            Height = 25
            Caption = #21387#32553#25991#20214#21040#30446#24405
            TabOrder = 1
            OnClick = btnZipAndToTheDirClick
            SkinData.CustomColor = False
            SkinData.SkinSection = 'BUTTON'
            Caption_UTF7 = '+U4t/KWWHTvZSMHbuX1U'
          end
          object grp1: TccuGroupBox
            Left = 0
            Top = 8
            Width = 99
            Height = 113
            Caption = #20351#29992#34920#26684#23637#31034
            TabOrder = 2
            SkinData.CustomColor = False
            SkinData.SkinSection = 'GROUPBOX'
            Caption_UTF7 = '+T391KIhoaDxcVXk6'
            object lbl1: TccuLabel
              Left = 4
              Top = 47
              Width = 90
              Height = 13
              AutoSize = False
              Caption = #20351#29992'CheckBox'
              Caption_UTF7 = '+T391KA-CheckBox'
            end
            object btnZipZipIndg: TccuButton
              Left = 5
              Top = 80
              Width = 90
              Height = 25
              Caption = #21387#32553#27604#36739#32467#26524
              TabOrder = 0
              OnClick = btnZipZipIndgClick
              SkinData.CustomColor = False
              SkinData.SkinSection = 'BUTTON'
              Caption_UTF7 = '+U4t/KWvUj4N+02ec'
            end
            object btnCompare: TccuButton
              Left = 4
              Top = 16
              Width = 90
              Height = 25
              Caption = #27604#36739#25991#20214#20449#24687
              TabOrder = 1
              OnClick = btnCompareClick
              SkinData.CustomColor = False
              SkinData.SkinSection = 'BUTTON'
              Caption_UTF7 = '+a9SPg2WHTvZP4WBv'
            end
            object CheckBox1: TccuCheckBox
              Left = 0
              Top = 62
              Width = 97
              Height = 17
              Caption = #21482#21387#32553#36873#20013#25991#20214
              TabOrder = 2
              OnClick = CheckBox1Click
              SkinData.CustomColor = False
              SkinData.SkinSection = 'CHECKBOX'
              ImgChecked = 0
              ImgUnchecked = 0
              Caption_UTF7 = '+U+pTi38pkAlOLWWHTvY'
            end
          end
        end
        object dgDetail: TccuDataStringGrid
          Left = 102
          Top = 2
          Width = 808
          Height = 334
          Align = alClient
          ColCount = 14
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
          ReadOnly = True
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
              Title.Caption = 'Bpl'
              Title.Color = clBlack
              IsPrint = True
              isMerge = False
              NoAllowExport = False
              NoAllowImportEmpty = False
              imageIndex = -1
              Asc = True
              Width = 120
              AssistSortIndex = -1
              RadioItem = False
              AllowReturnFocus = True
              NeedCalc = False
              IsOutLine = False
              ShowFilter = False
              FieldName = 'BplName'
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
              Title.Caption = 'Bpl '#26102#38388
              Title.Color = clBlack
              IsPrint = True
              isMerge = False
              NoAllowExport = False
              NoAllowImportEmpty = False
              imageIndex = -1
              Asc = True
              Width = 110
              AssistSortIndex = -1
              RadioItem = False
              AllowReturnFocus = True
              NeedCalc = False
              IsOutLine = False
              ShowFilter = False
              FieldName = 'BplTime'
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
              Title.Caption = 'BplExists'
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
              FieldName = 'BplExists'
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
              Title.Caption = 'Zip'
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
              Title.Caption = 'Zip '#26102#38388
              Title.Color = clBlack
              IsPrint = True
              isMerge = False
              NoAllowExport = False
              NoAllowImportEmpty = False
              imageIndex = -1
              Asc = True
              Width = 110
              AssistSortIndex = -1
              RadioItem = False
              AllowReturnFocus = True
              NeedCalc = False
              IsOutLine = False
              ShowFilter = False
              FieldName = 'ZipTime'
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
              Title.Caption = 'ZipExists'
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
              FieldName = 'ZipExists'
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
              Title.Caption = 'ShouldBeZip'
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
              FieldName = 'ShouldBeZip'
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
              Title.Caption = #26159#21542#38656#35201#21387#32553
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
              FieldName = 'ShouldZipInfo'
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
              Title.Caption = #25191#34892#32467#26524
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
              FieldName = 'ZipResult'
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
              Title.Caption = 'BplPath'
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
              FieldName = 'BplPath'
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
              Title.Caption = 'ZipPath'
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
              FieldName = 'ZipPath'
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
          LockSets.Caption = 'wait...'
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
          AutoSort = True
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
          ShowFilter = True
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
            120
            110
            -1
            100
            110
            -1
            -1
            100
            200
            -1
            -1
            -1
            -1)
        end
      end
      object pnlTop: TccuPanel
        Left = 0
        Top = 2
        Width = 912
        Height = 81
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        SkinData.CustomColor = False
        SkinData.SkinSection = 'PANEL'
        object lblZipTo: TccuLabel
          Left = 16
          Top = 32
          Width = 87
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #21387#32553#25991#20214#21040
          Caption_UTF7 = '+U4t/KWWHTvZSMA'
        end
        object lblZipToHint: TccuLabel
          Left = 128
          Top = 32
          Width = 713
          Height = 13
          Hint = #32534#36753#36335#24452#35831#21040'"'#32534#36753#37197#32622#25991#20214'"'#39029
          AutoSize = False
          Caption = 'lblZipToHint'
          ParentShowHint = False
          ShowHint = True
          Hint_UTF7 = '+fxaPkY3vX4SL91Iw"+fxaPkZFNf25lh072"+mHU'
        end
        object lblBpls: TccuLabel
          Left = 19
          Top = 8
          Width = 84
          Height = 13
          Alignment = taRightJustify
          Caption = #24453#21387#32553#25991#20214#36335#24452
          Caption_UTF7 = '+X4VTi38pZYdO9o3vX4Q'
        end
        object lblBplsDir: TccuLabel
          Left = 128
          Top = 8
          Width = 713
          Height = 13
          Hint = #32534#36753#36335#24452#35831#21040'"'#32534#36753#37197#32622#25991#20214'"'#39029
          AutoSize = False
          Caption = 'lblBplsDir'
          ParentShowHint = False
          ShowHint = True
          Hint_UTF7 = '+fxaPkY3vX4SL91Iw"+fxaPkZFNf25lh072"+mHU'
        end
        object lblCurrentBpl: TccuLabel
          Left = 18
          Top = 56
          Width = 335
          Height = 13
          AutoSize = False
          Caption = #24403#21069#27491#22312#21387#32553
          Caption_UTF7 = '+X1NSTWtjVyhTi38p'
        end
        object bedtDirSelect: TccuButtonEdit
          Left = 601
          Top = 8
          Width = 300
          Height = 21
          AutoSize = False
          ReadOnly = False
          TabOrder = 0
          OnChange = bedtDirSelectChange
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
          ButtonStyle = lsSelect
          ShowWeek = False
          ItemIndex = 0
        end
      end
    end
    object tsEditFileListName: TccuTabSheet
      Caption = #32534#36753#37197#32622#25991#20214
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      Caption_UTF7 = '+fxaPkZFNf25lh072'
      object mmEditFileListName: TMemo
        Left = 0
        Top = 1
        Width = 527
        Height = 413
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object pnlRight: TccuPanel
        Left = 527
        Top = 1
        Width = 377
        Height = 413
        Align = alRight
        TabOrder = 1
        SkinData.CustomColor = False
        SkinData.SkinSection = 'PANEL'
        object ccuGroupBox1: TccuGroupBox
          Left = 1
          Top = 1
          Width = 205
          Height = 411
          Align = alClient
          Caption = 'Memo'#25805#20316
          TabOrder = 0
          SkinData.CustomColor = False
          SkinData.SkinSection = 'GROUPBOX'
          Caption_UTF7 = 'Memo+ZM1PXA'
          object btnScanFiles: TccuButton
            Left = 32
            Top = 80
            Width = 113
            Height = 25
            Caption = #25195#25551#25991#20214#21040#21015#34920
            TabOrder = 0
            OnClick = btnScanFilesClick
            SkinData.CustomColor = False
            SkinData.SkinSection = 'BUTTON'
            Caption_UTF7 = '+Ymtjz2WHTvZSMFIXiGg'
          end
          object btnSave: TccuButton
            Left = 32
            Top = 48
            Width = 89
            Height = 25
            Caption = #20445#23384#21040#25991#20214
            TabOrder = 1
            OnClick = btnSaveClick
            SkinData.CustomColor = False
            SkinData.SkinSection = 'BUTTON'
            Caption_UTF7 = '+T91bWFIwZYdO9g'
          end
          object cbxBakBeforeSave: TccuCheckBox
            Left = 32
            Top = 24
            Width = 97
            Height = 17
            Caption = #20445#23384#21069#22791#20221
            Checked = True
            State = cbChecked
            TabOrder = 2
            SkinData.CustomColor = False
            SkinData.SkinSection = 'CHECKBOX'
            ImgChecked = 0
            ImgUnchecked = 0
            Caption_UTF7 = '+T91bWFJNWQdO/Q'
          end
        end
        object ccuGroupBox2: TccuGroupBox
          Left = 206
          Top = 1
          Width = 170
          Height = 411
          Align = alRight
          Caption = #25552#31034#20449#24687
          TabOrder = 1
          SkinData.CustomColor = False
          SkinData.SkinSection = 'GROUPBOX'
          Caption_UTF7 = '+Y9B5Ok/hYG8'
          object lblLineCount: TccuLabel
            Left = 8
            Top = 24
            Width = 153
            Height = 13
            AutoSize = False
            Caption = 'lblLineCount'
          end
          object lbl2: TccuLabel
            Left = 8
            Top = 376
            Width = 153
            Height = 13
            AutoSize = False
            Caption = #20851#20110#27492#36719#20214
            ParentFont = False
            OnClick = lbl2Click
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsUnderline]
            Caption_UTF7 = '+UXNOjmtkj29O9g'
          end
        end
      end
    end
    object tsUploadToFtp: TccuTabSheet
      Caption = #19978#20256#25991#20214#21040'FTP'
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      Caption_UTF7 = '+TgpPIGWHTvZSMA-FTP'
    end
    object tsReName: TccuTabSheet
      Caption = #37325#21629#21517#25991#20214
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      Caption_UTF7 = '+kc1UfVQNZYdO9g'
    end
    object tsFTPFileDownload: TccuTabSheet
      Caption = #25991#20214#19979#36733
      SkinData.CustomColor = False
      SkinData.CustomFont = False
      Caption_UTF7 = '+ZYdO9k4Lj30'
    end
  end
  object ccuSkinManager1: TccuSkinManager
    InternalSkins = <>
    MenuSupport.IcoLineSkin = 'ICOLINE'
    MenuSupport.ExtraLineFont.Charset = DEFAULT_CHARSET
    MenuSupport.ExtraLineFont.Color = clWindowText
    MenuSupport.ExtraLineFont.Height = -11
    MenuSupport.ExtraLineFont.Name = 'MS Sans Serif'
    MenuSupport.ExtraLineFont.Style = []
    SkinDirectory = 'c:\Skins'
    SkinInfo = 'N/A'
    ThirdParty.ThirdEdits = ' '
    ThirdParty.ThirdButtons = 'TButton'
    ThirdParty.ThirdBitBtns = ' '
    ThirdParty.ThirdCheckBoxes = ' '
    ThirdParty.ThirdGroupBoxes = ' '
    ThirdParty.ThirdListViews = ' '
    ThirdParty.ThirdPanels = ' '
    ThirdParty.ThirdGrids = ' '
    ThirdParty.ThirdTreeViews = ' '
    ThirdParty.ThirdComboBoxes = ' '
    ThirdParty.ThirdWWEdits = ' '
    ThirdParty.ThirdVirtualTrees = ' '
    ThirdParty.ThirdGridEh = ' '
    ThirdParty.ThirdPageControl = ' '
    ThirdParty.ThirdTabControl = ' '
    ThirdParty.ThirdToolBar = ' '
    ThirdParty.ThirdStatusBar = ' '
    ThirdParty.ThirdSpeedButton = ' '
    Left = 448
    Top = 224
  end
  object ccuSkinProvider1: TccuSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'MS Sans Serif'
    AddedTitle.Font.Style = []
    SkinData.CustomColor = False
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 480
    Top = 224
  end
  object dlgScanFiles: TccuOpenDialog
    Filter = '(Borland'#31243#24207#21253' bpl)|*.bpl|('#21487#25191#34892#31243#24207#25991#20214' exe)|*.exe|('#21160#24577#38142#25509#24211' dll)|*.dll'
    Left = 480
    Top = 192
    Filter_UTF7 = 
      '(Borland+egtej1MF bpl)|*.bpl|(+U+9iZ4hMegtej2WHTvY exe)|*.exe|(+' +
      'UqhgAZT+Y6Vekw dll)|*.dll'
  end
end
