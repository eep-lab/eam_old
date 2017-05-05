object FmLogin: TFmLogin
  Left = 320
  Top = 230
  BorderStyle = bsDialog
  Caption = 'Login'
  ClientHeight = 157
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 11
    Top = 25
    Width = 39
    Height = 13
    Caption = 'Usu'#225'rio:'
  end
  object Label2: TLabel
    Left = 11
    Top = 90
    Width = 34
    Height = 13
    Caption = 'Senha:'
  end
  object Edit1: TEdit
    Left = 56
    Top = 85
    Width = 321
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
  end
  object ComboBox1: TComboBox
    Left = 56
    Top = 20
    Width = 320
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object CheckBox1: TCheckBox
    Left = 11
    Top = 58
    Width = 97
    Height = 17
    Caption = 'Esconder senha'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object BitBtn1: TBitBtn
    Left = 56
    Top = 120
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 248
    Top = 120
    Width = 75
    Height = 25
    TabOrder = 4
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
end
