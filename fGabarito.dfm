object Gabaritos: TGabaritos
  Left = 221
  Top = 177
  BorderStyle = bsDialog
  Caption = 'Gabaritos'
  ClientHeight = 286
  ClientWidth = 473
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
  object Label2: TLabel
    Left = 8
    Top = 86
    Width = 72
    Height = 13
    Caption = 'Lista de Blocos'
  end
  object Label3: TLabel
    Left = 8
    Top = 223
    Width = 105
    Height = 13
    Caption = 'N'#250'mero de Tentativas'
  end
  object Label4: TLabel
    Left = 8
    Top = 3
    Width = 86
    Height = 13
    Caption = 'Resolu'#231#227'o da tela'
  end
  object ListBox1: TListBox
    Left = 8
    Top = 99
    Width = 121
    Height = 117
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBox1Click
    OnKeyDown = ListBox1KeyDown
  end
  object SpinEdit2: TSpinEdit
    Left = 8
    Top = 239
    Width = 121
    Height = 22
    MaxValue = 3000
    MinValue = 0
    TabOrder = 1
    Value = 3
    OnChange = SpinEdit2Change
  end
  object Memo1: TMemo
    Left = 144
    Top = 57
    Width = 321
    Height = 161
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      '1 - Selecione o n'#250'mero de blocos da sess'#227'o.'
      ''
      '2 - Selecione um dos blocos na lista.'
      ''
      '3 - Configure o n'#250'mero de tentativas do bloco '
      '      selecionado.'
      ''
      '4 - Repita os passos 2 e 3 at'#233' que todos os blocos '
      '      tenham o seu n'#250'mero de tentativas estabelecido.')
    ParentColor = True
    ParentFont = False
    TabOrder = 2
  end
  object Button1: TButton
    Left = 176
    Top = 237
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 296
    Top = 237
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    TabOrder = 4
    OnClick = Button2Click
  end
  object RadioButton1: TRadioButton
    Left = 101
    Top = 24
    Width = 71
    Height = 17
    Caption = '800 x 600'
    TabOrder = 5
  end
  object RadioButton2: TRadioButton
    Left = 9
    Top = 24
    Width = 81
    Height = 17
    Caption = '1024 x 768'
    Checked = True
    TabOrder = 6
    TabStop = True
  end
  object Button3: TButton
    Left = 8
    Top = 56
    Width = 55
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 74
    Top = 56
    Width = 55
    Height = 25
    Caption = 'Excluir'
    TabOrder = 8
    OnClick = Button4Click
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'Gabarito'
    Filter = 'Arquivo de Sess'#227'o (EAM 3.0.01)|*.txt'
    Left = 416
    Top = 237
  end
end
