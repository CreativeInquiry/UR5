// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import processing.core.PApplet;
import controlP5.*;

class GUI{
  int value;
  int myColorBackground = color(0, 0, 0);
  
  int buttonID = 1; 
  int buttonW = 50;
  int buttonGap = 50;
  int buttonH = 30;  
    
  Boolean cp5Init = false;
  
  // CONNECTIVITY
  UDPConnection udpConnection = new UDPConnection();
  int udpPort = 6000;  
  String udpHost = "224.0.0.1";

  GUI( PApplet parent ) {    

    cp5.addButton("value")
       .setPosition(buttonW+(20*buttonID)+(buttonGap*buttonID),buttonH)
       .setSize(buttonW,buttonH)
       .plugTo( this, "setValue" )
       .setValue(10)
       .setLabel("makeMagic")       
       ;

    /*
    // For reference
    cp5.addSlider( "valuespecialSlider" )
       .setRange( 0, 255 )
       .plugTo( this, "setValue" )
       .setValue( 127 )
       .setLabel("value")
       ;
       */
       
    udpConnection.initConnection(parent, udpPort, udpHost );
  }

  // BYTE MAGIC
  void setValue(int theValue) {
    udpConnection.encodeData(brushStrokes, cp5Init);
    
    // cp5 auto runs the methods associated with the controls so this condition makes sure it initiates 1st. 
    if (!cp5Init) cp5Init = true;
  }
}