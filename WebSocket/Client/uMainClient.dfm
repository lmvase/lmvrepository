object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 231
  ClientWidth = 505
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
  object bConnectDisconnect: TButton
    Left = 340
    Top = 190
    Width = 123
    Height = 25
    Caption = 'Connect/Disconnect'
    TabOrder = 1
    OnClick = bConnectDisconnectClick
  end
  object Memo1: TMemo
    Left = 44
    Top = 1
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
    Text = 'Client1'
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 5005
    OnDisconnect = ClientSocketDisconnect
    OnRead = ClientSocketRead
    OnError = ClientSocketError
    Left = 256
    Top = 118
  end
end