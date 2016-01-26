// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


// GUI contains 99% of all GUI related code

import processing.core.PApplet;
import controlP5.*;

class GUI{
  int value;
  int myColorBackground = color(0, 0, 0);
  
  int buttonID = 1; 
  int buttonW = 50;
  int buttonGap = 50;
  int buttonH = 30;
  
  // CONNECTIVITY
  // SOCKET
  int socketPort = 5204;
  SocketConnection socketConnection = new SocketConnection();
  
  GUI( PApplet parent ) {
    cp5.addButton("makeMagic")
       .setPosition(buttonW+(20*buttonID)+(buttonGap*buttonID),buttonH)
       .setSize(buttonW,buttonH)
       .plugTo( this, "startDrawing" );
       
    socketConnection.initConnection(parent, socketPort);
  }

  // MAKE MAGIC: Send the data
  void startDrawing(String controllerName) {
    if(controllerName == "makeMagic") socketConnection.encodeSocketData(pathData.brushStrokes);
  }
}