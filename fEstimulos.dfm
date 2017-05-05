object FormEstimulos: TFormEstimulos
  Left = 187
  Top = 105
  Width = 600
  Height = 400
  Caption = 'FormEstimulos'
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 592
    Height = 373
    ActivePage = TabSheet1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Estimulos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 584
        Height = 342
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Splitter1: TSplitter
          Left = 369
          Top = 0
          Width = 3
          Height = 342
          Cursor = crHSplit
          Align = alRight
          Color = clBtnShadow
          ParentColor = False
          ResizeStyle = rsUpdate
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 369
          Height = 342
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 369
            Height = 342
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel5'
            TabOrder = 0
            OnResize = Panel5Resize
            object PaintBox1: TPaintBox
              Left = 0
              Top = 0
              Width = 369
              Height = 27
              Align = alTop
              OnPaint = PaintBox1Paint
            end
            object PaintBox2: TPaintBox
              Left = 0
              Top = 27
              Width = 27
              Height = 315
              Align = alLeft
              OnPaint = PaintBox2Paint
            end
            object DrawGrid1: TDrawGrid
              Left = 27
              Top = 27
              Width = 342
              Height = 315
              Align = alClient
              Color = clBlack
              ColCount = 20
              DefaultColWidth = 60
              DefaultRowHeight = 45
              DefaultDrawing = False
              RowCount = 12
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goThumbTracking]
              TabOrder = 0
              OnDrawCell = DrawGrid1DrawCell
              OnTopLeftChanged = DrawGrid1TopLeftChanged
              ColWidths = (
                60
                60
                60
                60
                60
                60
                60
                60
                60
                60
                60
                60
                60
                60
                60
                60
                60
                60
                60
                60)
            end
          end
        end
        object Panel6: TPanel
          Left = 372
          Top = 0
          Width = 212
          Height = 342
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 212
            Height = 135
            Align = alTop
            TabOrder = 0
            object SpeedButton5: TSpeedButton
              Left = 16
              Top = 27
              Width = 23
              Height = 22
              Flat = True
              Glyph.Data = {
                36050000424D3605000000000000360400002800000010000000100000000100
                0800000000000001000000000000000000000001000000000000000000004000
                000080000000FF000000002000004020000080200000FF200000004000004040
                000080400000FF400000006000004060000080600000FF600000008000004080
                000080800000FF80000000A0000040A0000080A00000FFA0000000C0000040C0
                000080C00000FFC0000000FF000040FF000080FF0000FFFF0000000020004000
                200080002000FF002000002020004020200080202000FF202000004020004040
                200080402000FF402000006020004060200080602000FF602000008020004080
                200080802000FF80200000A0200040A0200080A02000FFA0200000C0200040C0
                200080C02000FFC0200000FF200040FF200080FF2000FFFF2000000040004000
                400080004000FF004000002040004020400080204000FF204000004040004040
                400080404000FF404000006040004060400080604000FF604000008040004080
                400080804000FF80400000A0400040A0400080A04000FFA0400000C0400040C0
                400080C04000FFC0400000FF400040FF400080FF4000FFFF4000000060004000
                600080006000FF006000002060004020600080206000FF206000004060004040
                600080406000FF406000006060004060600080606000FF606000008060004080
                600080806000FF80600000A0600040A0600080A06000FFA0600000C0600040C0
                600080C06000FFC0600000FF600040FF600080FF6000FFFF6000000080004000
                800080008000FF008000002080004020800080208000FF208000004080004040
                800080408000FF408000006080004060800080608000FF608000008080004080
                800080808000FF80800000A0800040A0800080A08000FFA0800000C0800040C0
                800080C08000FFC0800000FF800040FF800080FF8000FFFF80000000A0004000
                A0008000A000FF00A0000020A0004020A0008020A000FF20A0000040A0004040
                A0008040A000FF40A0000060A0004060A0008060A000FF60A0000080A0004080
                A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0A00000C0A00040C0
                A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFFA0000000C0004000
                C0008000C000FF00C0000020C0004020C0008020C000FF20C0000040C0004040
                C0008040C000FF40C0000060C0004060C0008060C000FF60C0000080C0004080
                C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0C00000C0C00040C0
                C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFFC0000000FF004000
                FF008000FF00FF00FF000020FF004020FF008020FF00FF20FF000040FF004040
                FF008040FF00FF40FF000060FF004060FF008060FF00FF60FF000080FF004080
                FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0FF0000C0FF0040C0
                FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFFFF00DBDBDBDBDBDB
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB000000000000
                0000000000DBDBDBDBDB000090909090909090909000DBDBDBDB00FC00909090
                90909090909000DBDBDB00FFFC0090909090909090909000DBDB00FCFFFC0090
                909090909090909000DB00FFFCFFFC000000000000000000000000FCFFFCFFFC
                FFFCFFFC00DBDBDBDBDB00FFFCFFFCFFFCFFFCFF00DBDBDBDBDB00FCFFFC0000
                0000000000DBDBDBDBDBDB000000DBDBDBDBDBDBDBDB000000DBDBDBDBDBDBDB
                DBDBDBDBDBDBDB0000DBDBDBDBDBDBDBDBDB00DBDBDB00DB00DBDBDBDBDBDBDB
                DBDBDB000000DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB}
              OnClick = SpeedButton5Click
            end
            object SpeedButton6: TSpeedButton
              Left = 16
              Top = 82
              Width = 23
              Height = 22
              Flat = True
              Glyph.Data = {
                76000000424D76000000000000003E00000028000000100000000E0000000100
                010000000000380000000000000000000000020000000000000000000000FFFF
                FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000E79F0000F33F0000F87F
                0000FCFF0000F87F0000F33F0000E79F0000FFFF0000FFFF0000}
            end
            object SpeedButton1: TSpeedButton
              Left = 16
              Top = 54
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
            end
            object Panel3: TPanel
              Left = 43
              Top = 8
              Width = 161
              Height = 121
              TabOrder = 0
            end
          end
          object ListView1: TListView
            Left = 0
            Top = 135
            Width = 212
            Height = 207
            Align = alClient
            Columns = <
              item
                Caption = 'Nome'
                Width = 208
              end>
            TabOrder = 1
            ViewStyle = vsReport
          end
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 504
    Top = 331
  end
  object SaveDialog1: TSaveDialog
    Left = 544
    Top = 331
  end
end
