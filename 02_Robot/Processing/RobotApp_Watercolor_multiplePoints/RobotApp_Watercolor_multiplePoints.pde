// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import controlP5.*;
import processing.net.*;

// ROBOT
Robot robot = new Robot(this);
Gripper gripper = new Gripper(this);
int serverPort = 5204;

void init(PApplet parent) {
  parent.size(600, 600);
  parent.background(204);
  parent.stroke(0);
  parent.frameRate(10);
}

void setup() {
  init(this);
  gripper.setupGUI(this);
  robot.calibration.setupGUI();

  // Socket
  robot.socketConnection.initSocketConnection(this, serverPort);
}

void draw() {
  robot.calibration.drawCalibration();
  robot.getRobotData();
  // Check to see if new data came thru via the socket connection from the CreativeApp
  robot.socketConnection.getSocketData();
  robot.robotMessage.send();
}

void controlEvent(ControlEvent theEvent) {
  String controllerName  = theEvent.getController().getName();
  gripper.getGripperController(controllerName);
  robot.calibration.getCalibrationPoint(controllerName);
}