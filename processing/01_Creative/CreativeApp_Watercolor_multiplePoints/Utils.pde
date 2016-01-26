// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


// Utils contains unit conversion methods and whatever general purpose functions 
// we'll need in the future 

// Convert Units
float pixelsToMM(float pixel) {  
  return pixel * 0.264583; 
}

float pixelsToMeters(float pixel) {  
  return mmToMeters(pixel * 0.264583); 
}

float mmToPixels(float mm) {
  return mm * 3.779528;  
}

float mmToInches(float mm) {
  return mm * 0.03937008;
}

float mmToMeters(float mm) {
 return mm * 0.001; 
}

float metersToMM(float m) {
 return m * 1000; 
}

float pixelsToInches(float pixel) {
 return pixel * 0.01041667; 
}

float inchesToPixels(float inch) {
   return inch * 96;
}