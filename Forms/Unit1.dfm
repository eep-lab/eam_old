object Form1: TForm1
  Left = 237
  Top = 168
  AutoScroll = False
  Caption = 'Form1'
  ClientHeight = 446
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 688
    Height = 446
    ActivePage = TabSheet1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabIndex = 1
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'Estimulos'
      ImageIndex = 1
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 680
        Height = 415
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Splitter1: TSplitter
          Left = 436
          Top = 0
          Width = 3
          Height = 415
          Cursor = crHSplit
          Align = alRight
          Color = clBtnShadow
          ParentColor = False
          ResizeStyle = rsUpdate
        end
        object Panel9: TPanel
          Left = 0
          Top = 0
          Width = 436
          Height = 415
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Panel11: TPanel
            Left = 0
            Top = 0
            Width = 436
            Height = 415
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object Panel10: TPanel
              Left = 0
              Top = 0
              Width = 436
              Height = 161
              Align = alTop
              TabOrder = 0
            end
          end
        end
        object Panel12: TPanel
          Left = 439
          Top = 0
          Width = 241
          Height = 415
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object ListView1: TListView
            Left = 0
            Top = 161
            Width = 241
            Height = 254
            Align = alClient
            Columns = <
              item
                Caption = 'Nome'
                Width = 130
              end
              item
                Caption = 'Tipo'
                Width = 90
              end>
            DragCursor = crDefault
            DragMode = dmAutomatic
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Items.Data = {
              5E0000000300000000000000FFFFFFFFFFFFFFFF000000000000000000000000
              00FFFFFFFFFFFFFFFF0000000000000000054974656D3100000000FFFFFFFFFF
              FFFFFF0100000000000000054974656D320A5375624974656D322E31FFFF}
            ReadOnly = True
            ParentFont = False
            SortType = stText
            TabOrder = 0
            ViewStyle = vsReport
            OnColumnClick = ListView1ColumnClick
            OnCompare = ListView1Compare
            OnDragOver = ListView1DragOver
            OnSelectItem = ListView1SelectItem
            OnStartDrag = ListView1StartDrag
          end
          object Panel13: TPanel
            Left = 0
            Top = 0
            Width = 241
            Height = 161
            Align = alTop
            TabOrder = 1
            object SpeedButton7: TSpeedButton
              Left = 57
              Top = 5
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
            end
            object SpeedButton9: TSpeedButton
              Left = 30
              Top = 5
              Width = 23
              Height = 22
              Flat = True
              Glyph.Data = {
                76000000424D76000000000000003E00000028000000100000000E0000000100
                010000000000380000000000000000000000020000000000000000000000FFFF
                FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000E79F0000F33F0000F87F
                0000FCFF0000F87F0000F33F0000E79F0000FFFF0000FFFF0000}
            end
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Tentativas'
      ImageIndex = 1
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 680
        Height = 415
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 680
          Height = 129
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Panel3: TPanel
            Left = 1
            Top = 2
            Width = 260
            Height = 49
            TabOrder = 0
            object SpeedButton10: TSpeedButton
              Left = 4
              Top = 21
              Width = 23
              Height = 22
              Flat = True
              Glyph.Data = {
                76000000424D76000000000000003E00000028000000100000000E0000000100
                010000000000380000000000000000000000020000000000000000000000FFFF
                FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000E79F0000F33F0000F87F
                0000FCFF0000F87F0000F33F0000E79F0000FFFF0000FFFF0000}
              OnClick = SpeedButton10Click
            end
            object SpeedButton8: TSpeedButton
              Left = 29
              Top = 21
              Width = 23
              Height = 22
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
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
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB00000000
                00000000000000DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFF00000000DBDBDBDBDB00FFFFFF
                FFFFFF00FF00DBDBDBDBDBDB00FFFFFFFFFFFF0000DBDBDBDBDBDBDB00000000
                00000000DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB}
              ParentFont = False
              OnClick = SpeedButton8Click
            end
            object Label2: TLabel
              Left = 58
              Top = 7
              Width = 126
              Height = 13
              Caption = 'Configura'#231#227'o de Tentativa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object ComboBox1: TComboBox
              Left = 55
              Top = 22
              Width = 201
              Height = 21
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              ParentFont = False
              Sorted = True
              TabOrder = 0
              OnChange = ComboBox1Change
              Items.Strings = (
                'Item1'
                'item2')
            end
            object Edit1: TEdit
              Left = 55
              Top = 22
              Width = 182
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              Text = 'Edit1'
              Visible = False
            end
          end
          object Panel5: TPanel
            Left = 261
            Top = 2
            Width = 260
            Height = 49
            TabOrder = 1
            object Label1: TLabel
              Left = 6
              Top = 7
              Width = 84
              Height = 13
              Caption = 'Tipo de Tentativa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object ComboBox2: TComboBox
              Left = 6
              Top = 22
              Width = 250
              Height = 21
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              ParentFont = False
              Sorted = True
              TabOrder = 0
              OnChange = ComboBox2Change
            end
          end
          object Panel4: TPanel
            Left = 529
            Top = 0
            Width = 151
            Height = 129
            Align = alRight
            TabOrder = 2
          end
        end
        object Panel6: TPanel
          Left = 0
          Top = 129
          Width = 680
          Height = 286
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object Splitter2: TSplitter
            Left = 377
            Top = 0
            Width = 3
            Height = 286
            Cursor = crHSplit
            Align = alRight
            Beveled = True
            ResizeStyle = rsUpdate
          end
          object Panel7: TPanel
            Left = 380
            Top = 0
            Width = 300
            Height = 286
            Align = alRight
            TabOrder = 0
          end
          object Panel14: TPanel
            Left = 0
            Top = 0
            Width = 377
            Height = 286
            Align = alClient
            TabOrder = 1
            OnResize = Panel14Resize
            object Panel15: TPanel
              Left = 88
              Top = 64
              Width = 241
              Height = 169
              BevelOuter = bvNone
              Color = clBtnShadow
              TabOrder = 0
            end
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Seq'#252#234'ncias'
      ImageIndex = 2
      object Panel16: TPanel
        Left = 0
        Top = 0
        Width = 680
        Height = 415
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Panel17: TPanel
          Left = 0
          Top = 0
          Width = 680
          Height = 128
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Panel18: TPanel
            Left = 0
            Top = 0
            Width = 260
            Height = 49
            TabOrder = 0
            object SpeedButton3: TSpeedButton
              Left = 4
              Top = 21
              Width = 23
              Height = 22
              Flat = True
              Glyph.Data = {
                76000000424D76000000000000003E00000028000000100000000E0000000100
                010000000000380000000000000000000000020000000000000000000000FFFF
                FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000E79F0000F33F0000F87F
                0000FCFF0000F87F0000F33F0000E79F0000FFFF0000FFFF0000}
              OnClick = SpeedButton3Click
            end
            object SpeedButton4: TSpeedButton
              Left = 29
              Top = 21
              Width = 23
              Height = 22
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
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
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB00000000
                00000000000000DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFF00000000DBDBDBDBDB00FFFFFF
                FFFFFF00FF00DBDBDBDBDBDB00FFFFFFFFFFFF0000DBDBDBDBDBDBDB00000000
                00000000DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB}
              ParentFont = False
              OnClick = SpeedButton4Click
            end
            object Label3: TLabel
              Left = 58
              Top = 7
              Width = 51
              Height = 13
              Caption = 'Seq'#252#234'ncia'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object ComboBox3: TComboBox
              Left = 55
              Top = 22
              Width = 201
              Height = 21
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              ParentFont = False
              Sorted = True
              TabOrder = 0
              OnChange = ComboBox3Change
              Items.Strings = (
                'Teste')
            end
            object Edit2: TEdit
              Left = 55
              Top = 22
              Width = 182
              Height = 24
              TabOrder = 1
              Visible = False
            end
          end
          object Panel19: TPanel
            Left = 260
            Top = 0
            Width = 260
            Height = 49
            TabOrder = 1
            object Label4: TLabel
              Left = 6
              Top = 7
              Width = 126
              Height = 13
              Caption = 'Configura'#231#227'o de Tentativa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object ComboBox4: TComboBox
              Left = 6
              Top = 22
              Width = 250
              Height = 21
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ItemHeight = 13
              ParentFont = False
              Sorted = True
              TabOrder = 0
              OnChange = ComboBox4Change
            end
          end
          object Panel24: TPanel
            Left = 40
            Top = 64
            Width = 185
            Height = 57
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            object SpeedButton1: TSpeedButton
              Left = 4
              Top = 31
              Width = 23
              Height = 22
              Flat = True
              Glyph.Data = {
                76000000424D76000000000000003E00000028000000100000000E0000000100
                010000000000380000000000000000000000020000000000000000000000FFFF
                FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000E79F0000F33F0000F87F
                0000FCFF0000F87F0000F33F0000E79F0000FFFF0000FFFF0000}
              OnClick = SpeedButton1Click
            end
            object SpeedButton2: TSpeedButton
              Left = 29
              Top = 31
              Width = 23
              Height = 22
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
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
                DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB00000000
                00000000000000DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFF00000000DBDBDBDBDB00FFFFFF
                FFFFFF00FF00DBDBDBDBDBDB00FFFFFFFFFFFF0000DBDBDBDBDBDBDB00000000
                00000000DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB}
              ParentFont = False
              OnClick = SpeedButton2Click
            end
            object Label5: TLabel
              Left = 53
              Top = 7
              Width = 50
              Height = 13
              Caption = 'Tentativas'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label6: TLabel
              Left = 46
              Top = 7
              Width = 3
              Height = 13
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object SpinEdit1: TSpinEdit
              Left = 54
              Top = 28
              Width = 57
              Height = 26
              MaxValue = 0
              MinValue = 0
              TabOrder = 0
              Value = 0
              OnChange = SpinEdit1Change
            end
          end
        end
        object Panel20: TPanel
          Left = 0
          Top = 128
          Width = 680
          Height = 287
          Align = alClient
          BevelOuter = bvLowered
          TabOrder = 1
          object Splitter3: TSplitter
            Left = 264
            Top = 1
            Width = 3
            Height = 285
            Cursor = crHSplit
            Align = alRight
            AutoSnap = False
            Color = clBtnShadow
            MinSize = 262
            ParentColor = False
            ResizeStyle = rsUpdate
          end
          object Panel21: TPanel
            Left = 1
            Top = 1
            Width = 263
            Height = 285
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            OnResize = Panel21Resize
            object Panel22: TPanel
              Left = 32
              Top = 48
              Width = 105
              Height = 102
              BevelOuter = bvNone
              Color = clBtnShadow
              TabOrder = 0
            end
          end
          object Panel23: TPanel
            Left = 267
            Top = 1
            Width = 412
            Height = 285
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 1
            object PageControl2: TPageControl
              Left = 0
              Top = 0
              Width = 412
              Height = 285
              ActivePage = TabSheet8
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabIndex = 3
              TabOrder = 0
              OnDrawTab = PageControl3DrawTab
              object TabSheet5: TTabSheet
                Caption = 'Est'#237'mulos'
              end
              object TabSheet6: TTabSheet
                Caption = 'Configura'#231#227'o'
                ImageIndex = 1
              end
              object TabSheet7: TTabSheet
                Caption = 'Conseq'#252#234'ncias'
                ImageIndex = 2
              end
              object TabSheet8: TTabSheet
                Caption = 'Crit'#233'rios'
                ImageIndex = 3
                object PageControl3: TPageControl
                  Left = 0
                  Top = 0
                  Width = 404
                  Height = 254
                  ActivePage = TabSheet10
                  Align = alClient
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -13
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  TabIndex = 1
                  TabOrder = 0
                  OnDrawTab = PageControl3DrawTab
                  object TabSheet9: TTabSheet
                    Caption = 'Opera'#231#245'es'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Arial'
                    Font.Style = []
                    ParentFont = False
                  end
                  object TabSheet10: TTabSheet
                    Caption = 'Atribui'#231#245'es'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Arial'
                    Font.Style = []
                    ImageIndex = 1
                    ParentFont = False
                  end
                  object TabSheet11: TTabSheet
                    Caption = 'Condicionais'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Arial'
                    Font.Style = []
                    ImageIndex = 2
                    ParentFont = False
                  end
                end
              end
            end
          end
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Blocos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 3
      ParentFont = False
      OnResize = TabSheet4Resize
      OnShow = TabSheet4Show
      object Panel25: TPanel
        Left = 0
        Top = 0
        Width = 680
        Height = 415
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Splitter4: TSplitter
          Left = 365
          Top = 0
          Width = 3
          Height = 415
          Cursor = crHSplit
          Align = alRight
          Color = clBtnFace
          ParentColor = False
          ResizeStyle = rsUpdate
        end
        object Panel27: TPanel
          Left = 0
          Top = 0
          Width = 365
          Height = 415
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Splitter5: TSplitter
            Left = 0
            Top = 185
            Width = 365
            Height = 3
            Cursor = crVSplit
            Align = alTop
            Color = clBtnFace
            ParentColor = False
            ResizeStyle = rsUpdate
            OnMoved = Splitter5Moved
          end
          object Panel29: TPanel
            Left = 0
            Top = 188
            Width = 365
            Height = 227
            Align = alClient
            TabOrder = 0
            object ListView2: TListView
              Left = 1
              Top = 37
              Width = 363
              Height = 189
              Align = alClient
              Columns = <
                item
                  Caption = 'N'#250'mero'
                end
                item
                  AutoSize = True
                  Caption = 'Seq'#252#234'ncia'
                end
                item
                  AutoSize = True
                  Caption = 'Modelo'
                end
                item
                  AutoSize = True
                  Caption = 'Compara'#231#245'es'
                end
                item
                  AutoSize = True
                  Caption = 'Conseq'#252#234'ncias'
                end>
              HideSelection = False
              Items.Data = {
                590000000300000000000000FFFFFFFFFFFFFFFF000000000000000006497465
                6D203100000000FFFFFFFFFFFFFFFF0000000000000000064974656D20320000
                0000FFFFFFFFFFFFFFFF0000000000000000064974656D2033}
              ReadOnly = True
              RowSelect = True
              TabOrder = 0
              ViewStyle = vsReport
              OnDrawItem = ListView2DrawItem
              OnDragDrop = ListView2DragDrop
              OnDragOver = ListView2DragOver
            end
            object Panel33: TPanel
              Left = 1
              Top = 1
              Width = 363
              Height = 36
              Align = alTop
              Alignment = taLeftJustify
              BevelOuter = bvNone
              Caption = '  Blocos'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              object SpeedButton5: TSpeedButton
                Left = 70
                Top = 8
                Width = 23
                Height = 22
                Flat = True
                Glyph.Data = {
                  76000000424D76000000000000003E00000028000000100000000E0000000100
                  010000000000380000000000000000000000020000000000000000000000FFFF
                  FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000E79F0000F33F0000F87F
                  0000FCFF0000F87F0000F33F0000E79F0000FFFF0000FFFF0000}
              end
              object SpeedButton6: TSpeedButton
                Left = 95
                Top = 8
                Width = 23
                Height = 22
                Flat = True
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
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
                  DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB00000000
                  00000000000000DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                  FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                  FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                  FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFFFFFFFF00DBDBDBDBDB00FFFFFF
                  FFFFFFFFFFFF00DBDBDBDBDB00FFFFFFFFFFFF00000000DBDBDBDBDB00FFFFFF
                  FFFFFF00FF00DBDBDBDBDBDB00FFFFFFFFFFFF0000DBDBDBDBDBDBDB00000000
                  00000000DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDB}
                ParentFont = False
                OnClick = SpeedButton6Click
              end
              object ComboBox5: TComboBox
                Left = 130
                Top = 8
                Width = 199
                Height = 21
                Style = csDropDownList
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ItemHeight = 13
                ParentFont = False
                TabOrder = 0
                OnChange = ComboBox5Change
                Items.Strings = (
                  'Item1'
                  'item2')
              end
              object Edit3: TEdit
                Left = 130
                Top = 8
                Width = 181
                Height = 21
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                Text = 'Edit1'
                Visible = False
              end
            end
          end
          object Panel31: TPanel
            Left = 0
            Top = 0
            Width = 365
            Height = 185
            Align = alTop
            TabOrder = 1
            OnResize = Panel31Resize
            object Panel34: TPanel
              Left = 72
              Top = 8
              Width = 209
              Height = 153
              Color = clBtnShadow
              TabOrder = 0
            end
          end
        end
        object Panel28: TPanel
          Left = 368
          Top = 0
          Width = 312
          Height = 415
          Align = alRight
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object PageControl4: TPageControl
            Left = 0
            Top = 0
            Width = 312
            Height = 415
            ActivePage = TabSheet12
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabIndex = 0
            TabOrder = 0
            OnDrawTab = PageControl4DrawTab
            object TabSheet12: TTabSheet
              Caption = 'Seq'#252#234'ncias'
              object Splitter6: TSplitter
                Left = 0
                Top = 158
                Width = 304
                Height = 3
                Cursor = crVSplit
                Align = alTop
                Color = clBtnFace
                ParentColor = False
                ResizeStyle = rsUpdate
                OnMoved = Splitter6Moved
              end
              object Panel30: TPanel
                Left = 0
                Top = 161
                Width = 304
                Height = 223
                Align = alClient
                TabOrder = 0
                object ListView3: TListView
                  Left = 1
                  Top = 37
                  Width = 302
                  Height = 185
                  Align = alClient
                  Columns = <
                    item
                      Caption = 'N'#250'mero'
                    end
                    item
                      AutoSize = True
                      Caption = 'Seq'#252#234'ncia'
                    end
                    item
                      AutoSize = True
                      Caption = 'Modelo'
                    end
                    item
                      AutoSize = True
                      Caption = 'Compara'#231#245'es'
                    end
                    item
                      AutoSize = True
                      Caption = 'Conseq'#252#234'ncias'
                    end>
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  HideSelection = False
                  Items.Data = {
                    590000000300000000000000FFFFFFFFFFFFFFFF000000000000000006497465
                    6D203100000000FFFFFFFFFFFFFFFF0000000000000000064974656D20320000
                    0000FFFFFFFFFFFFFFFF0000000000000000064974656D2033}
                  ReadOnly = True
                  RowSelect = True
                  ParentFont = False
                  TabOrder = 0
                  ViewStyle = vsReport
                  OnMouseDown = ListView3MouseDown
                  OnSelectItem = ListView3SelectItem
                  OnStartDrag = ListView3StartDrag
                end
                object Panel32: TPanel
                  Left = 1
                  Top = 1
                  Width = 302
                  Height = 36
                  Align = alTop
                  Alignment = taLeftJustify
                  BevelOuter = bvNone
                  Caption = ' Seq'#252#234'ncias'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                end
              end
              object Panel26: TPanel
                Left = 0
                Top = 0
                Width = 304
                Height = 158
                Align = alTop
                TabOrder = 1
                object CheckListBox1: TCheckListBox
                  Left = 9
                  Top = 10
                  Width = 179
                  Height = 67
                  OnClickCheck = CheckListBox1ClickCheck
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = []
                  ItemHeight = 13
                  Items.Strings = (
                    'Seq'#252#234'ncia 1'
                    'Seq'#252#234'ncia 2'
                    'Seq'#252#234'ncia 3')
                  ParentFont = False
                  TabOrder = 0
                end
              end
            end
            object TabSheet13: TTabSheet
              Caption = 'Crit'#233'rios'
              ImageIndex = 1
            end
          end
        end
      end
    end
  end
end
