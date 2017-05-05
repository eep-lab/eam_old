object Cursor: TCursor
  Left = 298
  Top = 245
  BorderStyle = bsDialog
  Caption = 'Descubra o Cursor'
  ClientHeight = 240
  ClientWidth = 261
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 15
    Width = 153
    Height = 13
    Caption = 'Valor Correspondente ao Cursor:'
  end
  object SpinEdit1: TSpinEdit
    Left = 176
    Top = 11
    Width = 73
    Height = 22
    MaxValue = 2
    MinValue = -23
    TabOrder = 0
    Value = 2
    OnChange = SpinEdit1Change
  end
  object GroupBox1: TGroupBox
    Left = 10
    Top = 40
    Width = 241
    Height = 188
    Caption = #193'rea de Teste'
    TabOrder = 1
  end
end
