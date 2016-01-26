// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import java.nio.ByteBuffer;

// GUI
ControlP5 cp5;
GUI gui;

PShape bot;

PVector point1, point2;
ArrayList <PathData> brushStrokes = new ArrayList <PathData>();

void setup() {
  size(640,480);
  background(102);  
     
  // The file "bot1.svg" must be in the data folder
  // of the current sketch to load successfully
  bot = loadShape("bot1.svg");
  
  // GUI
  cp5 = new ControlP5(this);
  gui = new GUI(this);

}

void draw() {
  // shape(bot, 110, 90, 100, 100);  // Draw at coordinate (110, 90) at size 100 x 100
  shape(bot, 280, 40);            // Draw at coordinate (280, 40) at the default size  
}

void mouseDragged() {
  // Perp Line: (y, -x)
  PVector perp = new PVector(point2.y - point1.y, point1.x - point2.x);
  // perp.rotate();
  
  // Length 1: Normalize the vector to length 1 (make it a unit vector).
  perp.normalize();
  
  // Length to n pixels: Multiplies a vector by a scalar.
  perp.mult(100);  // Put 10 for 10 pixels
  
  // Move to point1
  perp.add(point1);
  
  // Draw it
  stroke(#AA2244);
  strokeWeight(2);
  line(point1.x, point1.y, perp.x, perp.y);

  addBrushStrokes(point1.x, -(point1.y), 0.0, perp.x, -(perp.y), 0.0);
}