// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import processing.net.*;

class Robot {
  String input;
  int data[];
  Client c;  
  String h;
  int p;
  
  Robot(PApplet parent, String host, int port) {
    h = host;
    p = port;
    
    // Connect to the server’s IP address and port    
    c = new Client(parent, h, p);
  }
  
  void sendDataToRobot() {
    // reintialize the robot's position
   
    // Test 3a: Load an entire URScript file as a string
    String urScript[] = loadStrings("3_waypoints_simple.script");
    String urString = "";
    for(int i = 0; i < urScript.length; i++)
    {
      urString += urScript[i]+"\n";
    }   
    
    // Test 3b: Run the program
    c.write(urString + "\n");
    
    // Receive data from server
    if (c.available() > 0) {
      input = c.readString();
      input = input.substring(0, input.indexOf("\n")); // Only up to the newline
      data = int(split(input, ' ')); // Split values into an array
      
      print(data);
    }  
  }  
}