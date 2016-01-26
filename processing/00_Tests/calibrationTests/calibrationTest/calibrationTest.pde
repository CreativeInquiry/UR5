// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import controlP5.*;
import processing.net.*;


// GUI
ControlP5 cp5;
controlP5.Button b;
int myColorBackground = color(0, 0, 0);
int buttonW = 50;
int buttonGap = 50;
int buttonH = 30;

// ROBOT
Robot robot;

// SOCKET CONNECTION
Client c;
String input;
int data[];
String HOST = "10.144.81.97";
int PORT = 30003;

void setup() {
  size(450, 255);
  background(204);
  stroke(0);
  frameRate(10);
  
  // robot = new Robot(this, HOST, PORT);
  
  // GUI
  cp5 = new ControlP5(this);
  int buttonID = 1; 
  cp5.addButton("TL")
     .setValue(10)
     .setPosition(buttonW+(20*buttonID)+(buttonGap*buttonID),buttonH)
     .setSize(buttonW,buttonH)
     .setId(buttonID);
     
  buttonID = 2; 
  cp5.addButton("TR")
     .setValue(10)
     .setPosition(buttonW+(20*buttonID)+(buttonGap*buttonID),buttonH)
     .setSize(buttonW,buttonH)
     .setId(buttonID);  
  
  buttonID = 3; 
  cp5.addButton("BL")
     .setValue(10)
     .setPosition(buttonW+(20*buttonID)+(buttonGap*buttonID),buttonH)
     .setSize(buttonW,buttonH)
     .setId(buttonID);       
     
  buttonID = 4; 
  cp5.addButton("BR")
     .setValue(10)
     .setPosition(buttonW+(20*buttonID)+(buttonGap*buttonID),buttonH)
     .setSize(buttonW,buttonH)
     .setId(buttonID);       
}

void draw() {
  background(myColorBackground);
}

public void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getName());
  // n = 0;
}

public void TL(int theValue) {
  println("TL: "+theValue);
  // robot.sendDataToRobot();
}

public void TR(int theValue) {
  println("TL: "+theValue);
  // robot.sendDataToRobot();
}

public void BL(int theValue) {
  println("TL: "+theValue);
  // robot.sendDataToRobot();
}

public void BR(int theValue) {
  println("TL: "+theValue);
  // robot.sendDataToRobot();
}