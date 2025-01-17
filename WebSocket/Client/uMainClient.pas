unit uMainClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    bSend: TButton;
    bConnectDisconnect: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    ClientSocket: TClientSocket;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bConnectDisconnectClick(Sender: TObject);
    procedure bSendClick(Sender: TObject);
    procedure ClientSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
  private
    { Private declarations }
    //ClientSocket: TClientSocket;
    Str: string;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
//  ClientSocket := TClientSocket.Create(nil);
//  ClientSocket.OnError := ClientSocketError(ClientSocket);
//  ClientSocket.OnRead := ClientSocketRead(ClientSocket);
  Memo1.Clear;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
//  FreeAndNil(ClientSocket);
end;


procedure TForm2.bSendClick(Sender: TObject);
begin
    Str:=Edit1.Text;
    Memo1.Lines.Add('me: '+ str);
    //Edit1.Text:='';//Clears the edit box
    ClientSocket.Socket.SendText(str);//Send the messages to the server
end;


procedure TForm2.ClientSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
   Memo1.Text:=Memo1.Text+'Disconnect'+#13#10;
   Socket.SendText(str);//Send the “Disconnected” message to the server
//str is set to “Disconnected” when the Disconnect button is pressed
//A client cannot send messages if it is not connected to a server
   bSend.Enabled:=False;
   Edit1.Enabled:=False;
   bConnectDisconnect.Caption:='Connect';
end;

procedure TForm2.ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode:=0;
  ClientSocket.Active := False;
  // This can happen when no active server is started
  Memo1.Text:=Memo1.Text+'No connection found'+#13#10;
end;

procedure TForm2.ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
begin
//Reads and displays the message received from the server;
    Memo1.Lines.Add('Server: '+Socket.ReceiveText);
end;

procedure TForm2.bConnectDisconnectClick(Sender: TObject);
begin
    //127.0.0.1 is the standard IP address to loop back to your own machine

    ClientSocket.Port := 5005;
    ClientSocket.Address:='127.0.0.1';
    ClientSocket.Active := True;//Activates the client

    if(ClientSocket.Socket.Connected=True)  then
    begin
      str:='Disconnected';
      ClientSocket.Active := False;//Disconnects the client
      bConnectDisconnect.Caption:='Connect';
    end;
end;

(*procedure TForm2.ClientSocketDisconnect(Sender: TObject;  Socket: TCustomWinSocket);
begin
   Memo1.Text:=Memo1.Text+'Disconnect'+#13#10;
   Socket.SendText(str);//Send the “Disconnected” message to the server
//str is set to “Disconnected” when the Disconnect button is pressed
//A client cannot send messages if it is not connected to a server
   bSend.Enabled:=False;
   Edit1.Enabled:=False;
   bConnectDisconnect.Caption:='Connect';
end;


procedure TForm2.ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ErrorCode:=0;
  ClientSocket.Active := False;
  // This can happen when no active server is started
  Memo1.Text:=Memo1.Text+'No connection found'+#13#10;
end;


procedure TForm2.ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
begin
//Reads and displays the message received from the server;
    Memo1.Lines.Add('Server: '+Socket.ReceiveText);
end;   *)



end.
