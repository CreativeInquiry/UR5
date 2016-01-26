// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import java.nio.ByteBuffer;

// GUI
ControlP5 cp5;
GUI gui;

float[] lineLengthsInches = {1, 2};
float[] lineLengthsMM = new float[0];
float inch, pixel, mm, m;


ArrayList <PathData> brushStrokes = new ArrayList <PathData>();

void setup() {
  size(640,480);
  background(102);  
  stroke(#AA2244);
  textSize(16);
  
  // GUI
  cp5 = new ControlP5(this);
  gui = new GUI(this);
  
  defineLines();
  drawLines();
}

void draw() {
}

void defineLines(){    
  for (int i = 0; i < lineLengthsInches.length; i++)
  {
    inch = lineLengthsInches[i];
    pixel = inchesToPixels(inch);
    mm = pixelsToMM(pixel);
    
    lineLengthsMM = expand(lineLengthsMM, lineLengthsMM.length+1);
    lineLengthsMM[i] = mm;
    
    m = mmToMeters( pixelsToMM(mm) );      
        
    println("\nin: "+  inch);
    println("px: "+  pixel);
    println("mm: "+mm);
    println(" m: "+ m);
  }
}  

// Draw 2 test lines
void drawLines(){
  // Draw several lines between two points... 1", 10mm, ...
  for (int i = 0; i < lineLengthsMM.length; i++) {
    int y = 100;
    
    // In Pixels
    float x1 = 0;
    float y1 = -((y+20)*(i+1));
    float z1 = 0;
    
    float x2 = inchesToPixels(lineLengthsInches[i]);
    float y2 = -((y+20)*(i+1));
    float z2 = 0; // 0.19748095; 
  
    addBrushStrokes(x1, y1, z1, x2, y2, z2);
    stroke(#AA2244);    
    line(x1, y1, x2, y2);

    // text(lineLengthsMM[i]+"mm, " + mmToInches(lineLengthsMM[i]) + "in", lineLengthsMM[i]+5, (y+20)*(i+1));
    // text("["+x1+", "+y1+"], ["+x2+", "+y2+"] pixels", lineLengthsMM[i]+5, (y+10)*(i+1));
    text("["+pixelsToMM(x1)+", "+pixelsToMM(y1)+", "+pixelsToMM(z1)+"], ["+pixelsToMM(x2)+", "+pixelsToMM(y2)+", "+pixelsToMM(z2)+"] mm", lineLengthsMM[i]+5, (y+40)*(i+1));
    text("["+mmToMeters(pixelsToMM(x1))+", "+mmToMeters(pixelsToMM(y1))+", "+mmToMeters(pixelsToMM(z1))+"], ["+mmToMeters(pixelsToMM(x2))+", "+mmToMeters(pixelsToMM(y2))+", "+mmToMeters(pixelsToMM(z2))+"] m", lineLengthsMM[i]+5, (y+55)*(i+1));
    // text("["+pixelsToInches(x1)+", "+pixelsToInches(y1)+"], ["+pixelsToInches(x2)+", "+pixelsToInches(y2)+"] in", lineLengthsMM[i]+5, (y+70)*(i+1)); 
  } 
}