// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import processing.net.*;

class SocketConnection {
  Server myServer;
  Client myClient;
  
  Robot robot;
  
  SocketConnection(Robot _robot){
    robot = _robot;
  }  
  
  public void initSocketConnection(PApplet parent, int socketPort) {
    myServer = new Server(parent, socketPort);
  }
  
  void getSocketData(){
    myClient = myServer.available();
    String message = "";
    
    if (myClient != null && myClient.available() > 0) 
    {
      while(myClient.available() > 0){
        String partial = myClient.readString();
        if(partial != null) message += partial;
      }
      //println(message);
    }
    robot.robotMessage.message = message;
  }

}