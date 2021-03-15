object fThreads: TfThreads
  Left = 0
  Top = 0
  Caption = 'Threads'
  ClientHeight = 437
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblAndamento: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 126
    Width = 466
    Height = 13
    Align = alTop
    Caption = 'Andamento'
    ExplicitLeft = 0
    ExplicitTop = 123
    ExplicitWidth = 55
  end
  object mmoLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 168
    Width = 466
    Height = 266
    Align = alClient
    Lines.Strings = (
      'mmoLog')
    ScrollBars = ssBoth
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitTop = 81
    ExplicitWidth = 472
    ExplicitHeight = 309
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 466
    Height = 117
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 472
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 92
      Height = 13
      Caption = 'N'#250'mero de threads'
    end
    object Label2: TLabel
      Left = 16
      Top = 58
      Width = 204
      Height = 13
      Caption = 'Tempo entre cada itera'#231#227'o - milissegundos'
    end
    object edtNumThreads: TEdit
      Left = 16
      Top = 31
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '5'
    end
    object edtTempo: TEdit
      Left = 16
      Top = 77
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '5000'
    end
    object btnStart: TButton
      Left = 308
      Top = 30
      Width = 121
      Height = 60
      Caption = 'Iniciar'
      TabOrder = 2
      OnClick = btnStartClick
    end
  end
  object pbar1: TProgressBar
    AlignWithMargins = True
    Left = 3
    Top = 145
    Width = 466
    Height = 17
    Align = alTop
    TabOrder = 2
    ExplicitLeft = 168
    ExplicitTop = 232
    ExplicitWidth = 150
  end
end
