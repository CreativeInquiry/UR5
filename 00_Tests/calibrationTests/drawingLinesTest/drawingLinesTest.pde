// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


float[] lineLengthsInches = {1, 2};
float[] lineLengthsMM = new float[0];
float inch, pixel, mm, m;

void setup() {
    size(640,480);
    background(102);  
    stroke(#AA2244);
    textSize(24);
    
    defineLines();

    noLoop();
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
  
void draw() {
  // Draw several lines between two points... 1", 10mm, ...  
  for (int i = 0; i < lineLengthsMM.length; i++) {
    float y = 100.0;
    
    println("lineLengthsMM["+i+"]: " + lineLengthsMM[i]);
    line(0, (y+20)*(i+1), lineLengthsMM[i], (y+20)*(i+1));

    text(lineLengthsMM[i]+"mm, " + mmToInches(lineLengthsMM[i]) + "in", lineLengthsMM[i]+5, (y+20)*(i+1)); 
  }
}