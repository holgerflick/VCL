object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Import data for examples from spreadsheet files'
  ClientHeight = 216
  ClientWidth = 402
  Color = clBtnFace
  Constraints.MinHeight = 255
  Constraints.MinWidth = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Roboto'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    402
    216)
  PixelsPerInch = 96
  TextHeight = 15
  object StackPanel1: TStackPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 392
    Height = 172
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    ControlCollection = <
      item
        Control = altop
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end
      item
        Control = txtPOI
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end
      item
        Control = Label1
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end
      item
        Control = txtSchools
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end
      item
        Control = Label2
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end
      item
        Control = txtDatabaseFilename
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end>
    TabOrder = 0
    object altop: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 384
      Height = 15
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Spreadsheet with Points of Interest'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object txtPOI: TAdvMultiButtonEdit
      AlignWithMargins = True
      Left = 4
      Top = 24
      Width = 384
      Height = 22
      Align = alTop
      EmptyTextFocused = False
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      TabOrder = 0
      Buttons = <
        item
          Caption = '...'
          Style = bsFind
        end
        item
          Caption = '...'
        end>
      Text = ''
      OnClickFind = txtPOIClickFind
      OnClickCustom = txtPOIClickCustom
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 54
      Width = 384
      Height = 15
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Spreadsheet with School Data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object txtSchools: TAdvMultiButtonEdit
      AlignWithMargins = True
      Left = 4
      Top = 74
      Width = 384
      Height = 22
      Align = alTop
      EmptyTextFocused = False
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      TabOrder = 1
      Buttons = <
        item
          Caption = '...'
          Style = bsFind
        end
        item
          Caption = '...'
        end>
      Text = ''
      OnClickFind = txtSchoolsClickFind
      OnClickCustom = txtSchoolsClickCustom
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 104
      Width = 384
      Height = 15
      Margins.Bottom = 0
      Align = alTop
      Caption = 'SQlite database filename (will be overwritten!)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object txtDatabaseFilename: TAdvMultiButtonEdit
      AlignWithMargins = True
      Left = 4
      Top = 124
      Width = 384
      Height = 22
      Align = alTop
      EmptyTextFocused = False
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      TabOrder = 2
      Buttons = <
        item
          Caption = '...'
        end>
      Text = ''
      OnClickCustom = txtDatabaseFilenameClickCustom
    end
  end
  object btImport: TButton
    Left = 8
    Top = 183
    Width = 128
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Import data'
    TabOrder = 1
    OnClick = btImportClick
  end
  object btClose: TButton
    Left = 269
    Top = 183
    Width = 128
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    TabOrder = 2
    OnClick = btCloseClick
  end
  object Move: TFDBatchMove
    Reader = Reader
    Writer = Writer
    Mappings = <>
    LogFileName = 'Data.log'
    Analyze = [taDelimSep, taHeader, taFields]
    Left = 240
    Top = 48
  end
  object Reader: TFDBatchMoveTextReader
    DataDef.Fields = <>
    Left = 280
    Top = 48
  end
  object DBConnection: TFDConnection
    Params.Strings = (
      'Database=examples.sqlite'
      'DriverID=SQLite')
    Left = 192
    Top = 48
  end
  object Writer: TFDBatchMoveSQLWriter
    Connection = DBConnection
    CreateTableParts = [tpTable]
    Left = 320
    Top = 48
  end
end
