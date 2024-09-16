object fDiff: TfDiff
  Left = 423
  Top = 148
  BorderStyle = bsDialog
  Caption = 'Select Difficulty'
  ClientHeight = 410
  ClientWidth = 655
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Fixedsys'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 428
    Height = 410
    Align = alLeft
    TabOrder = 0
    object b1: TButton
      Left = 16
      Top = 48
      Width = 393
      Height = 25
      Caption = 'Peaceful - 21 notes, 1000 ms'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Fixedsys'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = b1Click
    end
    object b2: TButton
      Left = 16
      Top = 80
      Width = 393
      Height = 25
      Caption = 'Easy - 31 notes, 800 ms'
      TabOrder = 3
      OnClick = b2Click
    end
    object b3: TButton
      Left = 16
      Top = 112
      Width = 393
      Height = 25
      Caption = 'Mild - 41 notes, 750 ms'
      TabOrder = 4
      OnClick = b3Click
    end
    object b4: TButton
      Left = 16
      Top = 144
      Width = 393
      Height = 25
      Caption = 'Moderate - 51 notes, 700 ms'
      TabOrder = 5
      OnClick = b4Click
    end
    object b5: TButton
      Left = 16
      Top = 176
      Width = 393
      Height = 25
      Caption = 'Normal - 61 notes, 650 ms'
      TabOrder = 6
      OnClick = b5Click
    end
    object b6: TButton
      Left = 16
      Top = 208
      Width = 393
      Height = 25
      Caption = 'Hard - 71 notes, 600 ms'
      TabOrder = 7
      OnClick = b6Click
    end
    object b8: TButton
      Left = 16
      Top = 272
      Width = 393
      Height = 25
      Caption = 'DEMON - 91 notes, 500 ms'
      TabOrder = 9
      OnClick = b8Click
    end
    object b7: TButton
      Left = 16
      Top = 240
      Width = 393
      Height = 25
      Caption = 'Very Hard - 81 notes, 550 ms'
      TabOrder = 8
      OnClick = b7Click
    end
    object b9: TButton
      Left = 16
      Top = 304
      Width = 393
      Height = 25
      Caption = 'EXTREME - 101 notes, 450 ms'
      TabOrder = 10
      OnClick = b9Click
    end
    object b10: TButton
      Left = 16
      Top = 336
      Width = 393
      Height = 25
      Caption = 'NEXT TO IMPOSSIBLE - 114 notes, 400 ms'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Fixedsys'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      OnClick = b10Click
    end
    object b0: TButton
      Left = 16
      Top = 16
      Width = 393
      Height = 25
      Caption = 'Tutorial - 11 notes, 1500 ms'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Fixedsys'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = b0Click
    end
    object bQuit: TButton
      Left = 216
      Top = 368
      Width = 193
      Height = 25
      Caption = 'Quit'
      TabOrder = 0
      OnClick = bQuitClick
    end
    object bCustom: TButton
      Left = 16
      Top = 368
      Width = 193
      Height = 25
      Caption = 'Customize...'
      TabOrder = 12
      OnClick = bCustomClick
    end
    object snd: TMediaPlayer
      Left = 48
      Top = 64
      Width = 253
      Height = 30
      Visible = False
      TabOrder = 13
    end
  end
  object Panel2: TPanel
    Left = 428
    Top = 0
    Width = 227
    Height = 410
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 56
      Width = 96
      Height = 16
      Caption = 'Note Count: '
    end
    object Label2: TLabel
      Left = 16
      Top = 104
      Width = 200
      Height = 16
      Caption = 'Minimum Time Limit (ms): '
    end
    object Label3: TLabel
      Left = 48
      Top = 16
      Width = 72
      Height = 16
      Caption = 'Customize'
    end
    object Label4: TLabel
      Left = 16
      Top = 32
      Width = 192
      Height = 16
      Caption = '------------------------'
    end
    object tNote: TEdit
      Left = 16
      Top = 72
      Width = 193
      Height = 24
      Enabled = False
      TabOrder = 1
      Text = '51'
    end
    object tTL: TEdit
      Left = 16
      Top = 120
      Width = 193
      Height = 24
      Enabled = False
      TabOrder = 2
      Text = '700'
    end
    object bCusStart: TButton
      Left = 16
      Top = 152
      Width = 193
      Height = 25
      Caption = 'Start'
      Enabled = False
      TabOrder = 3
      OnClick = bCusStartClick
    end
    object bFold: TButton
      Left = 16
      Top = 14
      Width = 25
      Height = 17
      Caption = '<'
      Enabled = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Fixedsys'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = bFoldClick
    end
  end
  object tExpand: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tExpandTimer
    Left = 48
    Top = 16
  end
  object tFold: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tFoldTimer
    Left = 80
    Top = 16
  end
  object tSnd: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tSndTimer
    Left = 112
    Top = 16
  end
  object tSndCD: TTimer
    Interval = 500
    OnTimer = tSndCDTimer
    Left = 144
    Top = 16
  end
end
