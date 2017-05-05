object FmStartSes: TFmStartSes
  Left = 239
  Top = 170
  BorderStyle = bsToolWindow
  Caption = 'Iniciar Sess'#227'o'
  ClientHeight = 338
  ClientWidth = 453
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
  object Panel1: TPanel
    Left = 0
    Top = 113
    Width = 452
    Height = 168
    TabOrder = 0
    object Label4: TLabel
      Left = 10
      Top = 55
      Width = 86
      Height = 13
      Caption = 'Coment'#225'rio Inicial:'
      Enabled = False
    end
    object Label5: TLabel
      Left = 10
      Top = 11
      Width = 84
      Height = 13
      Caption = 'Nome da Sess'#227'o:'
      Enabled = False
    end
    object Memo1: TMemo
      Left = 11
      Top = 71
      Width = 432
      Height = 89
      Enabled = False
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 11
      Top = 27
      Width = 432
      Height = 21
      Enabled = False
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 452
    Height = 113
    TabOrder = 1
    object Label1: TLabel
      Left = 10
      Top = 15
      Width = 35
      Height = 13
      Caption = 'Sujeito:'
    end
    object Label2: TLabel
      Left = 255
      Top = 62
      Width = 119
      Height = 13
      Caption = 'Configura'#231#227'o de Sess'#227'o:'
      Enabled = False
    end
    object Label6: TLabel
      Left = 255
      Top = 15
      Width = 68
      Height = 13
      Caption = 'Procedimento:'
      Enabled = False
    end
    object ComboBox1: TComboBox
      Left = 10
      Top = 31
      Width = 190
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnChange = ComboBox1Change
    end
    object Button1: TButton
      Left = 115
      Top = 7
      Width = 84
      Height = 20
      Caption = 'Novo'
      TabOrder = 1
    end
    object ComboBox3: TComboBox
      Left = 255
      Top = 78
      Width = 190
      Height = 21
      Enabled = False
      ItemHeight = 13
      TabOrder = 2
      OnChange = ComboBox3Change
    end
    object ComboBox2: TComboBox
      Left = 255
      Top = 31
      Width = 190
      Height = 21
      Enabled = False
      ItemHeight = 13
      TabOrder = 3
      OnChange = ComboBox2Change
    end
  end
  object Panel3: TPanel
    Left = 8
    Top = 282
    Width = 452
    Height = 56
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 107
      Top = 15
      Width = 75
      Height = 25
      Enabled = False
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 275
      Top = 15
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
