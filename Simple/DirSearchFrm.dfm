inherited DirSearchForm: TDirSearchForm
  Left = 264
  Top = 317
  Width = 569
  Height = 328
  Caption = 'DirSearchForm'
  PixelsPerInch = 96
  TextHeight = 13
  object lblFileMask: TLabel [0]
    Left = 8
    Top = 232
    Width = 52
    Height = 13
    Caption = 'lblFileMask'
  end
  object drvcbb1: TDriveComboBox [1]
    Left = 8
    Top = 8
    Width = 145
    Height = 19
    TabOrder = 0
    OnChange = drvcbb1Change
  end
  object ListBox1: TListBox [2]
    Left = 160
    Top = 8
    Width = 385
    Height = 233
    ItemHeight = 13
    TabOrder = 1
  end
  object dirol1: TDirectoryOutline [3]
    Left = 8
    Top = 32
    Width = 145
    Height = 193
    ItemHeight = 13
    Options = [ooDrawFocusRect]
    PictureLeaf.Data = {
      46030000424D460300000000000036000000280000000E0000000E0000000100
      2000000000001003000000000000000000000000000000000000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008000800080008000800080000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF000000000080008000800080008000800000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000008000
      800080008000800080000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000080008000800080008000
      800000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF00000000008000800080008000800080000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF000000000080008000800080008000800000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000008000
      8000800080008000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000800080008000800080008000
      80008000800000000000FFFFFF0000FFFF00FFFFFF0000FFFF00000000008000
      8000800080008000800080008000800080008000800080008000800080008080
      8000000000000000000000000000000000008080800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      80008000800080008000}
    TabOrder = 2
    Data = {10}
  end
  object edtFileMask: TEdit [4]
    Left = 8
    Top = 248
    Width = 145
    Height = 21
    TabOrder = 3
    Text = '*.pas'
  end
  object btn1: TButton [5]
    Left = 160
    Top = 248
    Width = 385
    Height = 21
    Caption = 'Search for file'
    TabOrder = 4
    OnClick = btn1Click
  end
end