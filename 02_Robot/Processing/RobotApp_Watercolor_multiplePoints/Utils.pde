// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import java.net.InetAddress; 
import java.net.UnknownHostException;

String getComputerIP(){
  String HostName    = ""; 
  String HostAddress = ""; 
  
  try { 
    InetAddress addr = InetAddress.getLocalHost(); 
    // Get IP Address 
    byte[] ipAddr = addr.getAddress(); 
    // Extract the IP. Vanilla addr returns name and address separated by a '/' character 
    String raw_addr = addr.toString(); 
    String[] list = split(raw_addr,'/'); 
    
    HostName    = list[0];
    HostAddress = list[1];
    println(HostAddress);
  }
    catch (UnknownHostException e) { 
  }
  return HostAddress; 
}

void displayDoubleArray(String title, double[] doubleArray, int left, int top){
  int lineHeight = 17;
  text(title, left, top);
  
  for(int i=0; i<doubleArray.length; i++){
    text((float)doubleArray[i], left, top + (1 + i) * lineHeight);
  }
}

void displayDouble(String title, double doubleVal, int left, int top){
  int lineHeight = 17;
  text(title, left, top);
  text((float)doubleVal, left, top + lineHeight);
}

// Convert Units
float pixelsToMM(float pixel) {  
  return pixel * 0.264583; 
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