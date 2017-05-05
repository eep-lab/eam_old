object FmEstimulos: TFmEstimulos
  Left = 257
  Top = 179
  Width = 600
  Height = 400
  Caption = 'FmEstimulos'
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
    Height = 366
    ActivePage = TabSheet1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabIndex = 0
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
        Height = 335
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Splitter1: TSplitter
          Left = 369
          Top = 0
          Width = 3
          Height = 335
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
          Height = 335
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Panel8: TPanel
            Left = 0
            Top = 0
            Width = 369
            Height = 97
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
          end
          object Panel5: TPanel
            Left = 0
            Top = 97
            Width = 369
            Height = 238
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object PaintBox1: TPaintBox
              Left = 0
              Top = 0
              Width = 369
              Height = 40
              Align = alTop
              OnPaint = PaintBox1Paint
            end
            object PaintBox2: TPaintBox
              Left = 0
              Top = 40
              Width = 30
              Height = 198
              Align = alLeft
              OnPaint = PaintBox2Paint
            end
            object DrawGrid1: TDrawGrid
              Left = 30
              Top = 40
              Width = 339
              Height = 198
              Align = alClient
              Color = clBlack
              ColCount = 11
              DefaultColWidth = 72
              DefaultRowHeight = 54
              DefaultDrawing = False
              DragCursor = crDefault
              DragMode = dmAutomatic
              RowCount = 11
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goThumbTracking]
              TabOrder = 0
              OnDragDrop = DrawGrid1DragDrop
              OnDragOver = DrawGrid1DragOver
              OnDrawCell = DrawGrid1DrawCell
              OnMouseDown = DrawGrid1MouseDown
              OnMouseMove = DrawGrid1MouseMove
              OnStartDrag = DrawGrid1StartDrag
              ColWidths = (
                72
                72
                72
                72
                72
                72
                72
                72
                72
                72
                72)
            end
          end
        end
        object Panel6: TPanel
          Left = 372
          Top = 0
          Width = 212
          Height = 335
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object ListView1: TListView
            Left = 0
            Top = 136
            Width = 212
            Height = 199
            Align = alClient
            Columns = <
              item
                Caption = 'Nome'
                Width = 130
              end
              item
                Caption = 'Tipo'
                Width = 78
              end>
            DragCursor = crDefault
            DragMode = dmAutomatic
            Items.Data = {
              5E0000000300000000000000FFFFFFFFFFFFFFFF000000000000000000000000
              00FFFFFFFFFFFFFFFF0000000000000000054974656D3100000000FFFFFFFFFF
              FFFFFF0100000000000000054974656D320A5375624974656D322E31FFFF}
            SortType = stText
            TabOrder = 0
            ViewStyle = vsReport
            OnColumnClick = ListView1ColumnClick
            OnCompare = ListView1Compare
            OnDragOver = ListView1DragOver
            OnKeyDown = ListView1KeyDown
            OnSelectItem = ListView1SelectItem
            OnStartDrag = DrawGrid1StartDrag
          end
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 212
            Height = 136
            Align = alTop
            TabOrder = 1
          end
        end
      end
    end
  end
end
