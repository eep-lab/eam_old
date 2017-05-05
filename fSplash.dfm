object Form3: TForm3
  Left = 192
  Top = 103
  BorderStyle = bsNone
  Caption = 'Form3'
  ClientHeight = 348
  ClientWidth = 489
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 10
    Top = 1
    Width = 32
    Height = 32
    Picture.Data = {
      07544269746D617076020000424D760200000000000076000000280000002000
      0000200000000100040000000000000200000000000000000000100000000000
      000000000000000080000080000000808000800000008000800080800000C0C0
      C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00444444444444AAAAAA444444FFFF4444444444444444AAAAAA444444FFFF
      444444444444444444AAAA4444FF4444FF4444444444444444AAAA4444FF4444
      FF44444444444444AA44AA4444FF44444444444444444444AA44AA4444FF4444
      44444444444444AA4444EE4444FF4444FF444444444444AA4444EE4444FF4444
      FF444444444444EE44EE44444444FFFF44444444444444EE44EE44444444FFFF
      44444444444444EEEE44444444AA4444AA444444444444EEEE44444444AA4444
      AA44FF4444FF44EEEEEE444444AA44AAAAAAFF4444FF44EEEEEE444444AA44AA
      AAAAFF4444FF44444444444444AA4444AA44FF4444FF44444444444444AA4444
      AA44FFFFFFFF44EEEEEE444444AA4444AA44FFFFFFFF44EEEEEE444444AA4444
      AA44FF4444FF44EEEE444444AAAAAA44AA44FF4444FF44EEEE444444AAAAAA44
      AA4444FFFF4444EE44EE444444AA4444AA4444FFFF4444EE44EE444444AA4444
      AA444444444444444444EE4444FFFFFF44444444444444444444EE4444FFFFFF
      44444444444444AA4444444444FF4444FF444444444444AA4444444444FF4444
      FF44444444444444AA44AA4444FFFFFF4444444444444444AA44AA4444FFFFFF
      444444444444444444AAAA4444FF4444FF4444444444444444AAAA4444FF4444
      FF44444444444444AAAAAA4444FFFFFF4444444444444444AAAAAA4444FFFFFF
      4444}
  end
  object Label1: TLabel
    Left = 50
    Top = 3
    Width = 50
    Height = 26
    Caption = 'EAM'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 200
    Top = 314
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 32
    Width = 465
    Height = 273
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      '                                                   ATENÇÃO'
      ''
      
        'Este sofware foi desenvolvido para utilização na Universidade Fe' +
        'deral do Pará.'
      
        'Em sua elaboração objetivou-se construir uma ferramente extremam' +
        'ente '
      
        'simples, que atendesse às necessidades mais urgentes dos pesquis' +
        'adores.'
      'Recursos adicionais estarão disponíveis em versões posteriores.'
      
        'Para maiores informações, favor entrar em contato com Drausio Ca' +
        'pobianco:'
      'fone: (0 XX 16) 9147-5216'
      'emails: drausiocap@zipmail.com.br'
      '           g160970@polvo.ufscar.br'
      'endereço: Alameda das Violetas, 610, sl.4   '
      '                 Cidade Jardim, São Carlos, SP '
      '                 CEP: 13566-532'
      ''
      '')
    ParentFont = False
    TabOrder = 1
  end
end
