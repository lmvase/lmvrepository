unit Unit1;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
 System.Classes, Vcl.Graphics,
 Vcl.Controls, Vcl.Forms, System.Win.ScktComp, Vcl.StdCtrls;

type
 TForm1 = class(TForm)
  Button1: TButton;
  Button2: TButton;
  Memo1: TMemo;
  Edit1: TEdit;
  ServerSocket1: TServerSocket;
  procedure Button2Click(Sender: TObject);
  procedure Button1Click(Sender: TObject);
 private
  { Private declarations }
  Str: string;
 public
  { Public declarations }
 end;

var
 Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 i: integer;
begin
 Str := Edit1.Text; // Take the string (message) sent by the server
 Memo1.Text := Memo1.Text + 'me: ' + Str + #13#10;
 // Adds the message to the memo box
 Edit1.Text := ''; // Clears the edit box
 // Sends the messages to all clients connected to the server
 for i := 0 to ServerSocket1.Socket.ActiveConnections - 1 do
  ServerSocket1.Socket.Connections[i].SendText(Str); // Sent
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 if (ServerSocket1.Active = False) // The button caption is ‘Start’
 then
 begin
  ServerSocket1.Active := True; // Activates the server socket
  Memo1.Text := Memo1.Text + 'Server Started' + #13#10;
  Button2.Caption := 'Stop'; // Set the button caption
 end
 else // The button caption is ‘Stop’
 begin
  ServerSocket1.Active := False; // Stops the server socket
  Memo1.Text := Memo1.Text + 'Server Stopped' + #13#10;
  Button2.Caption := 'Start';
  // If the server is closed, then it cannot send any messages
  Button1.Enabled := False; // Disables the “Send” button
  Edit1.Enabled := False; // Disables the edit box
 end;

end;

end.
