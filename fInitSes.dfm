object Form2: TForm2
  Left = 226
  Top = 151
  BorderStyle = bsDialog
  Caption = 'Executar Sessão'
  ClientHeight = 194
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 457
    Top = 115
    Width = 23
    Height = 22
    Flat = True
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFF0000000000000FF03300000077030FF03300000077030FF03300000077
      030FF03300000000030FF03333333333330FF03300000000330FF03077777777
      030FF03077777777030FF03077777777030FF03077777777030FF03077777777
      000FF03077777777070FF00000000000000FFFFFFFFFFFFFFFFF}
    OnClick = SpeedButton1Click
  end
  object Label1: TLabel
    Left = 9
    Top = 48
    Width = 53
    Height = 16
    Caption = 'Sujeito:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 82
    Width = 58
    Height = 16
    Caption = 'Sessão:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 118
    Width = 130
    Height = 16
    Caption = 'Arquivo de Dados:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 66
    Top = 44
    Width = 414
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 66
    Top = 78
    Width = 414
    Height = 21
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 139
    Top = 115
    Width = 313
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object Button1: TButton
    Left = 41
    Top = 159
    Width = 76
    Height = 25
    Caption = '&OK'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 371
    Top = 159
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    TabOrder = 4
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 11
    Width = 119
    Height = 17
    Caption = 'Salvar Dados'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 5
    OnClick = CheckBox1Click
  end
  object Button3: TButton
    Left = 203
    Top = 159
    Width = 75
    Height = 25
    Caption = '&Rodar Teste'
    TabOrder = 6
    OnClick = Button3Click
  end
  object SaveDialog1: TSaveDialog
    Left = 448
    Top = 161
  end
end
