object Form1: TForm1
  Left = 192
  Top = 107
  AutoScroll = False
  Caption = 'Galileu (vers�o Beta 1.3)'
  ClientHeight = 347
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00AAA000FF000000000AA00F00F0000000A0A00F000000000A00E00F00F00000
    0E0E0000FF0000000EE0000A00A0F00F0EEE000A0AAAF00F0000000A00A0FFFF
    0EEE000A00A0F00F0EE000AAA0A00FF00E0E000A00A000000000E00FFF000000
    0A00000F00F0000000A0A00FFF000000000AA00F00F0000000AAA00FFF00FC73
    0000FE6D0000FD6F0000FB6D0000FAF30000F9ED000068E800006FED000008ED
    000069C500009AED0000FF630000FBED0000FD630000FE6D0000FC630000}
  Menu = MainMenu1
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 584
    Height = 24
    AutoSize = True
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 22
        Width = 582
      end>
    EdgeInner = esNone
    EdgeOuter = esRaised
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 569
      Height = 22
      AutoSize = True
      Caption = 'ToolBar1'
      EdgeBorders = []
      EdgeInner = esNone
      Flat = True
      Images = ImageList1
      TabOrder = 0
      object ToolButton4: TToolButton
        Left = 0
        Top = 0
        Hint = 'Abrir Sess�o'
        Caption = 'ToolButton4'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButton4Click
      end
      object ToolButton6: TToolButton
        Left = 23
        Top = 0
        Width = 7
        Caption = 'ToolButton6'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object ToolButton1: TToolButton
        Left = 30
        Top = 0
        Hint = 'Rodar Sess�o'
        AllowAllUp = True
        Caption = 'ToolButton1'
        Enabled = False
        Grouped = True
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButton1Click
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 321
    Width = 584
    Height = 26
    Align = alBottom
    AutoSize = True
    TabOrder = 1
    object StatusBar1: TStatusBar
      Left = 1
      Top = 1
      Width = 582
      Height = 24
      Panels = <>
      SimplePanel = False
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 8
    Top = 32
    object Arquivo1: TMenuItem
      Caption = '&Arquivo'
      object Abrir1: TMenuItem
        Caption = '&Abrir...'
        ImageIndex = 3
        OnClick = Abrir1Click
      end
      object N1: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object RodarSesso1: TMenuItem
        Caption = 'Rodar Sess�o'
        ImageIndex = 0
        OnClick = RodarSesso1Click
      end
      object N3: TMenuItem
        Caption = '-'
        Enabled = False
      end
      object Sair1: TMenuItem
        Caption = 'Sai&r'
        OnClick = Sair1Click
      end
    end
    object Ajuda1: TMenuItem
      Caption = 'Aj&uda'
      object SobreoGalileu1: TMenuItem
        Caption = '&Sobre o Galileu (vers�o Beta 1.1)'
        OnClick = SobreoGalileu1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Arquivos de Texto (*.txt)|*.txt|Todos os arquivos|*.*'
    Left = 8
    Top = 72
  end
  object ImageList1: TImageList
    Left = 8
    Top = 144
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001001000000000000018
      000000000000000000000000000000000000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EEF3DF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EEF3DF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E0000000000000000
      000000000000000000000000000000000000F75EF75EF75E0000F75E0000F75E
      0000F75E0000F75E0000F75E0000F75E0000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EEF3DF75E0000000000000000000000000000
      00000000000000000000000000000000F75EF75EF75EF75E0000F75EFF7FF75E
      FF7FF75EFF7FF75EFF7FF75EFF7FF75E0000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EEF3DF75E0000F75EE07FF75EE07FF75EE07F
      F75EE07FF75EE07FF75EE07FF75E0000F75EF75EF75EF75E0000FF7F00000000
      0000000000000000000000000000FF7F0000F75EF75EF75E0000F75EF75E0000
      F75E0000F75E0000F75E0000F75EF75E0000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EEF3DF75E0000E07FF75EE07FF75EE07FF75E
      E07FF75EE07FF75EE07FF75EE07F0000F75EF75EF75EF75E0000F75EFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FF75E0000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000F75EE07FF75EE07F00000000
      0000000000000000F75EE07FF75E0000F75EF75EF75EF75E0000FF7F00000000
      0000000000000000000000000000FF7F0000F75EF75EF75E0000F75EF75E0000
      F75E0000F75E0000F75E0000F75EF75E0000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000E07FF75EE07FF75E0000F75E
      E07FF75EE07FF75EE07FF75EE07F0000F75E0000F75EF75E0000F75EFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FF75E0000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000F75EE07FF75EE07F0000E07F
      F75EE07FF75EE07FF75EE07FF75E0000F75EF75E0000F75E0000FF7F0000FF7F
      F75EFF7FF75EFF7FE001E001E001FF7F0000F75EF75EF75E0000F75EF75EF75E
      F75EF75EF75E0000F75E0000F75EF75E0000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000E07FF75E0000000000000000
      0000F75EE07FF75EE07FF75EE07F0000F75EF75EF75E000000000000FF7FF75E
      FF7FF75EFF7FF75EE003E003E003F75E0000007C007CF75EF75E007C007CF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000F75EE07FF75E000000000000
      F75EE07FF75EE07FF75EE07FF75E0000F75E00000000F75EF75E000000000000
      000000000000000000000000000000000000F75E007C007C007C007CF75EF75E
      0000F75E0000F75E0000F75E0000F75E0000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000E07FF75EE07FF75E0000F75E
      E07FF75EE07FF75EE07FF75EE07F0000F75EF75EF75E0000F75E0000F75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E007C007CF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000F75EE07FF75EE07FF75EE07F
      F75EE07FF75EE07FF75EE07FF75E0000F75EF75E0000F75E0000F75E0000F75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75E007C007C007C007CF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000000000000000000000000000
      0000000000000000000000000000F75EF75E0000F75EF75EF75EF75EF75E0000
      F75EF75EF75EF75EF75EF75EF75EF75EF75E007C007CF75EF75E007C007CF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75E0000E07FF75EE07FF75EE07F
      0000F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E0000F75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E00000000000000000000
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E0000F75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000000000000000000000000000
      000000000000000000000000000000000000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000000000000000000000000000
      000000000000000000000000000000000000F75EF75EF75E0F000F000F000F00
      F75EF75EF75EF75EF75EF75E003CF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E003CF75EF75EF75EF75EF75E0F000F000F000F00
      F75EF75EF75EF75EF75EF75E003CF75EF75E00000000E03DE03D000000000000
      000000000000F75EF75E0000E03D00000000F75EF75E0F000F00F75EF75E0F00
      0F00F75EF75EF75EF75E003C003C003CF75E0F000F000F000F000F000F000F00
      0F00F75EF75EF75EF75E003C003C003CF75EF75EF75E0F000F00F75EF75E0F00
      0F00F75EF75EF75EF75E003C003C003CF75E00000000E03DE03D000000000000
      000000000000F75EF75E0000E03D00000000F75EF75E0F000F00F75EF75EF75E
      F75EF75EF75EF75E003C003C003C003C003C0F00FF7FFF7FFF7FFF7FFF7FFF7F
      0F00F75EF75EF75E003C003C003C003C003CF75EF75E0F000F00F75EF75EF75E
      F75EF75EF75EF75E003C003C003C003C003C00000000E03DE03D000000000000
      000000000000F75EF75E0000E03D00000000F75EF75E0F000F000F000F000F00
      0F00F75EF75EF75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7FFF7FFF7FFF7F
      0F00F75EF75EF75EF75EF75E003CF75EF75EF75EF75E0F000F000F000F000F00
      0F00F75EF75EF75EF75EF75E003CF75EF75E00000000E03DE03D000000000000
      000000000000000000000000E03D00000000F75EF75E0F000F00F75EF75E0F00
      0F00F75EF75EF75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7FFF7FFF7FFF7F
      0F000F000F000F00F75EF75E003CF75EF75EF75EF75E0F000F00F75EF75E0F00
      0F00F75EF75EF75EF75EF75E003CF75EF75E00000000E03DE03DE03DE03DE03D
      E03DE03DE03DE03DE03DE03DE03D00000000F75EF75EF75E0F000F000F000F00
      F75EF75EF75EF75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7FFF7FFF7FFF7F
      0F00E07FFF7F0F00F75EF75E003CF75EF75EF75EF75EF75E0F000F000F000F00
      F75EF75EF75EF75EF75EF75E003CF75EF75E00000000E03DE03D000000000000
      00000000000000000000E03DE03D00000000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7FFF7FFF7FFF7F
      0F00FF7FE07F0F00F75EF75E003CF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E003CF75EF75E00000000E03D0000F75EF75EF75E
      F75EF75EF75EF75EF75E0000E03D00000000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7F0F000F000F00
      0F00E07FFF7F0F00F75EF75E003CF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75E003CF75EF75E00000000E03D0000F75EF75EF75E
      F75EF75EF75EF75EF75E0000E03D00000000F75EF75EF75E0F000F000F000F00
      0F00F75EF75EF75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7F0F00FF7F0F00
      E07FFF7FE07F0F00F75EF75E003CF75EF75EF75EF75EF75E0F000F000F000F00
      0F00F75EF75EF75EF75EF75E003CF75EF75E00000000E03D0000F75EF75EF75E
      F75EF75EF75EF75EF75E0000E03D00000000F75EF75E0F000F00F75EF75E0F00
      0F00F75EF75EF75EF75EF75E003CF75EF75E0F00FF7FFF7FFF7F0F000F00E07F
      FF7FE07FFF7F0F00F75EF75E003CF75EF75EF75EF75E0F000F00F75EF75E0F00
      0F00F75EF75EF75EF75EF75E003CF75EF75E00000000E03D0000F75EF75EF75E
      F75EF75EF75EF75EF75E0000E03D00000000F75EF75E0F000F00F75EF75E0F00
      0F00F75EF75EF75EF75EF75E003CF75EF75E0F000F000F000F000F00E07FFF7F
      0F000F000F000F00F75EF75E003CF75EF75EF75EF75E0F000F00F75EF75E0F00
      0F00F75EF75EF75EF75EF75E003CF75EF75E00000000E03D0000F75EF75EF75E
      F75EF75EF75EF75EF75E0000000000000000F75EF75EF75E0F000F000F000F00
      0F00F75EF75EF75EF75EF75E003CF75EF75EF75EF75EF75E0F00E07FFF7FE07F
      0F00E07F0F00F75EF75EF75E003CF75EF75EF75EF75EF75E0F000F000F000F00
      0F00F75EF75EF75EF75EF75E003CF75EF75E00000000E03D0000F75EF75EF75E
      F75EF75EF75EF75EF75E0000F75E00000000F75EF75EF75EF75EF75EF75E0F00
      0F00F75EF75EF75EF75EF75E003CF75EF75EF75EF75EF75E0F00FF7FE07FFF7F
      0F000F00F75EF75EF75EF75E003CF75EF75EF75EF75EF75EF75EF75EF75E0F00
      0F00F75EF75EF75EF75EF75E003CF75EF75E0000000000000000000000000000
      000000000000000000000000000000000000F75EF75EF75E0F000F000F000F00
      F75EF75EF75EF75EF75EF75E003CF75EF75EF75EF75EF75E0F000F000F000F00
      0F00F75EF75EF75EF75EF75E003CF75EF75EF75EF75EF75E0F000F000F000F00
      F75EF75EF75EF75EF75EF75E003CF75EF75E0000000000000000000000000000
      000000000000000000000000000000000000F75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75EF75E
      F75EF75EF75EF75EF75EF75EF75EF75EF75E0000000000000000000000000000
      000000000000000000000000000000000000E07FFF03FF03E001E00100000000
      00000000000000000000FF03E07FFF03FF030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E07FE07FFF03FF03E00100000000
      00000000000000000000E07FE07FE07FFF030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000E003E003
      000000000000000000000000000000000000E07FFF03FF03FF03FF0300000000
      00000000000000000000FF03E07FFF03FF030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000E003E003
      E003000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F000000000000000000000000E03DE03DE03DE03DE03D
      E03DE03DE03DE03D0000000000000000000000000000000000000000E003E003
      E003E00300000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000E07F0000E03DE03DE03DE03D
      E03DE03DE03DE03DE03D000000000000000000000000000000000000E003E003
      E003E003E003000000000000000000000000000000000000000000001F001F00
      1F001F00E001E00100000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FE07F0000E03DE03DE03D
      E03DE03DE03DE03DE03DE03D00000000000000000000000000000000E003E003
      E003E003E003E00300000000000000000000000000000000000000001F001F00
      1F00E001E001E00100000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000E07FFF7FE07F0000E03DE03D
      E03DE03DE03DE03DE03DE03DE03D0000000000000000000000000000E003E003
      E003E003E003E003E003000000000000000000000000000000000000FF03E07F
      FF03FF03E001E00100000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FE07FFF7FE07F00000000
      00000000000000000000000000000000000000000000000000000000E003E003
      E003E003E003E003E003E00300000000000000000000000000000000E07FE07F
      E07FFF03FF03E00100000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000E07FFF7FE07FFF7FE07FFF7F
      E07FFF7FE07F00000000000000000000000000000000000000000000E003E003
      E003E003E003E003E003000000000000000000000000000000000000FF03E07F
      FF03FF03FF03FF0300000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000FF7FE07FFF7FE07FFF7FE07F
      FF7FE07FFF7F00000000000000000000000000000000000000000000E003E003
      E003E003E003E003000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000E07FFF7FE07F000000000000
      00000000000000000000000000000000000000000000000000000000E003E003
      E003E003E0030000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7F00000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000E003E003
      E003E00300000000000000000000000000001F001F001F00E001E00100000000
      000000000000000000001F001F001F001F00000000000000FF7FFF7FFF7FFF7F
      FF7FFF7F0000FF7F000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000E003E003
      E003000000000000000000000000000000001F001F00E001E001E00100000000
      000000000000000000001F001F001F00E001000000000000FF7FFF7FFF7FFF7F
      FF7FFF7F00000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000E003E003
      000000000000000000000000000000000000E07FFF03FF03E001E00100000000
      00000000000000000000FF03E07FFF03FF030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E07FE07FFF03FF03E00100000000
      00000000000000000000E07FE07FE07FFF030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFF000000000000C001000000000000
      8001000000000000800100000000000080010000000000008001000000000000
      8001000000000000800100000000000080010000000000008001000000000000
      80011F001F0000008001EF7BEF7B1F008001EF7BEF7BEF7B8001EF03EF031F00
      8001000000000000FFFF000000000000FFFF03E0FFFFFFFFF9FF03E0FFFFFFFF
      F8FF03E0C007001FF87F03E0C007000FF83FF00FC0070007F81FF00FC0070003
      F80FF00FC0070001F807F00FC0070000F807F00FC007001FF80FF00FC007001F
      F81FF00FC007001FF83F03E0C0078FF1F87F03E0C00FFFF9F8FF03E0C01FFF75
      F9FF03E0C03FFF8FFFFF03E0FFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object SaveDialog1: TSaveDialog
    Left = 8
    Top = 112
  end
end
