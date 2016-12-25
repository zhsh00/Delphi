object Form1: TForm1
  Left = 544
  Top = 134
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20869#23384#20462#25913#22120
  ClientHeight = 455
  ClientWidth = 648
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 250
    Height = 432
    Align = alLeft
    Caption = #36827#31243
    TabOrder = 0
    object ListView1: TListView
      Left = 2
      Top = 15
      Width = 246
      Height = 374
      Align = alClient
      Columns = <
        item
          Caption = #36827#31243#21517
          Width = 150
        end
        item
          Caption = #36827#31243'ID'
          Width = 58
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnColumnClick = ListView1ColumnClick
      OnSelectItem = ListView1SelectItem
    end
    object pnl2: TPanel
      Left = 2
      Top = 389
      Width = 246
      Height = 41
      Align = alBottom
      Caption = 'pnl2'
      TabOrder = 1
      object Button3: TButton
        Left = 56
        Top = 8
        Width = 75
        Height = 25
        Caption = '&Refresh'
        TabOrder = 0
        OnClick = Button3Click
      end
    end
  end
  object Panel1: TPanel
    Left = 250
    Top = 0
    Width = 121
    Height = 432
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 1
    object Label2: TLabel
      Left = 7
      Top = 48
      Width = 65
      Height = 13
      Caption = #26597#25214#25968#20540#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 7
      Top = 152
      Width = 65
      Height = 13
      Caption = #36873#20013#22320#22336#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 7
      Top = 9
      Width = 47
      Height = 13
      Caption = #36827#31243'ID'#65306
    end
    object Label7: TLabel
      Left = 7
      Top = 196
      Width = 52
      Height = 13
      Caption = #26032#30340#25968#20540
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 8
      Top = 64
      Width = 103
      Height = 21
      TabOrder = 0
      OnKeyPress = Edit1KeyPress
    end
    object Button1: TButton
      Left = 22
      Top = 88
      Width = 75
      Height = 22
      Caption = #24320#22987#26597#25214
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
    object edtSelectedAddres: TEdit
      Left = 8
      Top = 168
      Width = 103
      Height = 19
      Ctl3D = False
      Enabled = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 5
    end
    object Button2: TButton
      Left = 22
      Top = 238
      Width = 75
      Height = 22
      Caption = #20462#25913
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = Button2Click
    end
    object Edit3: TEdit
      Left = 8
      Top = 24
      Width = 103
      Height = 19
      Ctl3D = False
      Enabled = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 6
    end
    object Button4: TButton
      Left = 22
      Top = 112
      Width = 75
      Height = 22
      Caption = '&Reset'
      TabOrder = 2
      OnClick = Button4Click
    end
    object edtNewValue: TEdit
      Left = 8
      Top = 213
      Width = 103
      Height = 21
      TabOrder = 3
      OnKeyPress = edtNewValueKeyPress
    end
    object edt1: TEdit
      Left = 8
      Top = 304
      Width = 121
      Height = 21
      TabOrder = 7
      Text = 'edt1'
    end
    object edt2: TEdit
      Left = 8
      Top = 328
      Width = 121
      Height = 21
      TabOrder = 8
      Text = 'edt2'
    end
  end
  object GroupBox2: TGroupBox
    Left = 371
    Top = 0
    Width = 277
    Height = 432
    Align = alClient
    Caption = #25968#20540#22320#22336
    TabOrder = 2
    object ListBox1: TListBox
      Left = 2
      Top = 15
      Width = 273
      Height = 374
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnClick = ListBox1Click
    end
    object pnl1: TPanel
      Left = 2
      Top = 389
      Width = 273
      Height = 41
      Align = alBottom
      Caption = 'pnl1'
      TabOrder = 1
      object Label1: TLabel
        Left = 5
        Top = 23
        Width = 3
        Height = 13
      end
      object Button5: TButton
        Left = 110
        Top = 8
        Width = 75
        Height = 25
        Caption = #36864#20986
        TabOrder = 0
        OnClick = Button5Click
      end
    end
    object lv2: TListView
      Left = 2
      Top = 15
      Width = 273
      Height = 374
      Align = alClient
      Columns = <
        item
          Caption = #22320#22336
          Width = 150
        end
        item
          Caption = 'DWORD'
          Width = 100
        end>
      TabOrder = 2
      ViewStyle = vsReport
    end
  end
  object sb1: TStatusBar
    Left = 0
    Top = 432
    Width = 648
    Height = 23
    Panels = <>
  end
end
