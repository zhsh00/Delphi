object DownloadForm: TDownloadForm
  Left = 565
  Top = 136
  Width = 970
  Height = 631
  Caption = 'DownloadForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 273
    Height = 592
    Align = alLeft
    Caption = 'pnl1'
    TabOrder = 0
    object gb1: TGroupBox
      Left = 1
      Top = 1
      Width = 271
      Height = 140
      Align = alTop
      Caption = 'gb1'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      object btnDown: TButton
        Left = 88
        Top = 80
        Width = 75
        Height = 25
        Caption = 'Download'
        TabOrder = 0
        OnClick = btnDownClick
      end
      object btnTest: TButton
        Left = 8
        Top = 112
        Width = 75
        Height = 25
        Caption = 'Test'
        TabOrder = 1
        OnClick = btnTestClick
      end
      object btnTest2: TButton
        Left = 88
        Top = 112
        Width = 75
        Height = 25
        Caption = 'Test2'
        TabOrder = 2
        OnClick = btnTest2Click
      end
      object btnDownByMultiThread: TButton
        Left = 168
        Top = 80
        Width = 75
        Height = 25
        Caption = #22810#32447#31243#19979#36733
        TabOrder = 3
        OnClick = btnDownByMultiThreadClick
      end
      object cbbLi: TComboBox
        Left = 136
        Top = 24
        Width = 100
        Height = 21
        ItemHeight = 13
        TabOrder = 4
        OnChange = cbbLiChange
        Items.Strings = (
          'li7'
          'li8'
          'li9'
          'li10'
          'li11'
          'li12'
          'li13'
          'li14'
          'li15')
      end
      object cbbRange: TComboBox
        Left = 8
        Top = 24
        Width = 100
        Height = 21
        ItemHeight = 13
        TabOrder = 5
        OnChange = cbbRangeChange
        Items.Strings = (
          #20013#22269
          #20113#21335
          #26157#36890)
      end
      object btnStopDownload: TButton
        Left = 168
        Top = 112
        Width = 75
        Height = 25
        Caption = #20572#27490#22810#32447#31243
        TabOrder = 6
        OnClick = btnStopDownloadClick
      end
    end
    object gb3: TGroupBox
      Left = 1
      Top = 391
      Width = 271
      Height = 200
      Align = alClient
      Caption = 'gb3'
      TabOrder = 1
      object lbledtSaveDir: TLabeledEdit
        Left = 8
        Top = 24
        Width = 257
        Height = 21
        EditLabel.Width = 72
        EditLabel.Height = 13
        EditLabel.Caption = #25991#20214#20445#23384#20301#32622
        TabOrder = 0
        Text = 'C:\Users\hasee\Desktop\ditu\01\'
      end
      object btnSelectDir: TButton
        Left = 190
        Top = 48
        Width = 75
        Height = 25
        Caption = 'SelectDir'
        TabOrder = 1
        OnClick = btnSelectDirClick
      end
    end
    object gb2: TGroupBox
      Left = 1
      Top = 141
      Width = 271
      Height = 250
      Align = alTop
      Caption = #25511#21046#21442#25968
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
      object lbl1: TLabel
        Left = 8
        Top = 176
        Width = 13
        Height = 13
        Caption = 'S4'
      end
      object lbledtColBase: TLabeledEdit
        Left = 8
        Top = 32
        Width = 80
        Height = 19
        EditLabel.Width = 39
        EditLabel.Height = 13
        EditLabel.Caption = 'ColBase'
        TabOrder = 0
      end
      object lbledtLeftOffset: TLabeledEdit
        Left = 96
        Top = 32
        Width = 80
        Height = 19
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'LeftOffset'
        TabOrder = 1
      end
      object lbledtRightOffset: TLabeledEdit
        Left = 184
        Top = 32
        Width = 80
        Height = 19
        EditLabel.Width = 53
        EditLabel.Height = 13
        EditLabel.Caption = 'RightOffset'
        TabOrder = 2
      end
      object lbledtRowBase: TLabeledEdit
        Left = 8
        Top = 72
        Width = 80
        Height = 19
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'RowBase'
        TabOrder = 3
      end
      object lbledtTopOffset: TLabeledEdit
        Left = 96
        Top = 72
        Width = 80
        Height = 19
        EditLabel.Width = 47
        EditLabel.Height = 13
        EditLabel.Caption = 'TopOffset'
        TabOrder = 4
      end
      object lbledtBottomOffset: TLabeledEdit
        Left = 183
        Top = 72
        Width = 80
        Height = 19
        EditLabel.Width = 61
        EditLabel.Height = 13
        EditLabel.Caption = 'BottomOffset'
        TabOrder = 5
      end
      object lbledtS1: TLabeledEdit
        Left = 8
        Top = 152
        Width = 257
        Height = 19
        EditLabel.Width = 13
        EditLabel.Height = 13
        EditLabel.Caption = 'S1'
        TabOrder = 6
      end
      object mmS4: TMemo
        Left = 8
        Top = 192
        Width = 257
        Height = 49
        Lines.Strings = (
          'mmS4')
        TabOrder = 7
      end
    end
  end
  object pnl2: TPanel
    Left = 273
    Top = 0
    Width = 681
    Height = 592
    Align = alClient
    Caption = 'pnl2'
    TabOrder = 1
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.Connection = 'Keep-Alive'
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, application/xhtml+xml, image/jxr, */*'
    Request.AcceptEncoding = 'gzip, deflate'
    Request.AcceptLanguage = 'zh-Hans-CN,zh-Hans;q=0.5'
    Request.BasicAuthentication = False
    Request.UserAgent = 
      'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like ' +
      'Gecko'
    HTTPOptions = [hoForceEncodeParams]
    Left = 345
    Top = 32
  end
end
