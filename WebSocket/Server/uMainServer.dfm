object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Server'
  ClientHeight = 231
  ClientWidth = 504
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object bSend: TButton
    Left = 44
    Top = 190
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 0
    OnClick = bSendClick
  end
  object bStartStop: TButton
    Left = 388
    Top = 190
    Width = 75
    Height = 25
    Caption = 'Start/Stop'
    TabOrder = 1
    OnClick = bStartStopClick
  end
  object Memo1: TMemo
    Left = 44
    Top = 2
    Width = 419
    Height = 156
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 44
    Top = 163
    Width = 419
    Height = 21
    TabOrder = 3
    Text = 'Server'
  end
  object ServerSocket: TServerSocket
    Active = False
    Port = 5005
    ServerType = stNonBlocking
    OnClientConnect = ServerSocketClientConnect
    OnClientDisconnect = ServerSocketClientDisconnect
    OnClientRead = ServerSocketClientRead
    Left = 328
    Top = 100
  end
end
