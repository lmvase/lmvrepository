unit uMainServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Win.ScktComp;

type
  TForm1 = class(TForm)
    bSend: TButton;
    bStartStop: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    ServerSocket: TServerSocket;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bStartStopClick(Sender: TObject);
    procedure bSendClick(Sender: TObject);
    procedure ServerSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
  private
    { Private declarations }
     //ServerSocket: TServerSocket;
     Str: string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
//  ServerSocket := TServerSocket.Create(nil);
  Memo1.Clear;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
//  FreeAndNil(ServerSocket);
end;

procedure TForm1.ServerSocketClientConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  Socket.SendText('Connected');//Sends a message to the client
  //If at least a client is connected to the server, then the server can communicate
  //Enables the Send button and the edit box
  bSend.Enabled:= true;
  Edit1.Enabled:= true;
end;

procedure TForm1.ServerSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  //The server cannot send messages if there is no client connected to it
  if ServerSocket.Socket.ActiveConnections-1=0 then
  begin
    bSend.Enabled:=false;
    Edit1.Enabled:=false;
  end;
end;

procedure TForm1.ServerSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
begin
 //Read the message received from the client and add it to the memo text
  // The client identifier appears in front of the message
  Memo1.Text:=Memo1.Text+'Client'+IntToStr(Socket.SocketHandle)+' :'+Socket.ReceiveText+#13#10;
end;

procedure TForm1.bSendClick(Sender: TObject);
var
  i: integer;
begin
  Str:=Edit1.Text;//Take the string (message) sent by the server
  Memo1.lines.Add('me: '+ Str);//Adds the message to the memo box
  //Edit1.Text:='';//Clears the edit box
  //Sends the messages to all clients connected to the server
  for i:=0 to ServerSocket.Socket.ActiveConnections-1 do
    ServerSocket.Socket.Connections[i].SendText(str);//Sent
end;

procedure TForm1.bStartStopClick(Sender: TObject);
begin
   if(ServerSocket.Active = False)//The button caption is �Start�
   then
   begin
      ServerSocket.Port := 5005;
      ServerSocket.Active := True;//Activates the server socket
      Memo1.Text:=Memo1.Text+'Server Started'+#13#10;
      bStartStop.Caption:='Stop';//Set the button caption
   end
   else//The button caption is �Stop�
   begin
      ServerSocket.Active := False;//Stops the server socket
      Memo1.Text:=Memo1.Text+'Server Stopped'+#13#10;
      bStartStop.Caption:='Start';
      //If the server is closed, then it cannot send any messages
      bStartStop.Enabled:=false;//Disables the �Send� button
      Edit1.Enabled:=false;//Disables the edit box
   end;
end;


(*

ONCONNECT
Socket.SendText('Connected');//Sends a message to the client
  //If at least a client is connected to the server, then the server can communicate
  //Enables the Send button and the edit box
  bSend.Enabled:= true;
  Edit1.Enabled:= true;


procedure TForm1.ServerSocketClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
Begin
  //The server cannot send messages if there is no client connected to it
  if ServerSocket.Socket.ActiveConnections-1=0 then
  begin
    bSend.Enabled:=false;
    Edit1.Enabled:=false;
  end;
end;

procedure TForm1.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
Begin
  //Read the message received from the client and add it to the memo text
  // The client identifier appears in front of the message
  Memo1.Text:=Memo1.Text+'Client'+IntToStr(Socket.SocketHandle)+' :'+Socket.ReceiveText+#13#10;
end;         *)



end.
