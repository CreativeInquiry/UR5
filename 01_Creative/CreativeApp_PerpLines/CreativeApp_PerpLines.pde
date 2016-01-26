// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import java.nio.ByteBuffer;

ControlP5 cp5;
GUI gui;
PathData pathData;

void setup() {
  size(640,480);
  background(102);
  
  // Path
  pathData = new PathData();
  // GUI
  cp5 = new ControlP5(this);
  gui = new GUI(this);
}

void draw() {
}

void mouseDragged(){
  pathData.getPath();
}

void controlEvent(ControlEvent theEvent) {
  String controllerName  = theEvent.getController().getName();
  gui.startDrawing(controllerName);
}