// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import java.net.InetAddress; 
import java.net.UnknownHostException; 

String HostName; 
String HostAddress; 


 try { 
  InetAddress addr = InetAddress.getLocalHost(); 
  
  // Get IP Address 
  byte[] ipAddr = addr.getAddress(); 
  
  // Extract Just the IP. Vanilla addr returns name and address separated by a '/' character 
  String raw_addr = addr.toString(); 
  String[] list = split(raw_addr,'/'); 
  HostAddress = list[1]; 
  
  // Get hostname 
  HostName = addr.getHostName(); 
  println(HostAddress + ", " + HostName); 
  }     catch (UnknownHostException e) { 
} 