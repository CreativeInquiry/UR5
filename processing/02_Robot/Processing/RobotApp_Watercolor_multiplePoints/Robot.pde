// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


class Robot {
  String input;
  int[]  data;
  Client ur_client_commands;
  Client ur_client_feedback; 
  String ur_ip   = "10.144.81.97";
  String pc_ip   = "10.144.74.143";
  int    ur_port_commands = 30002;
  int    ur_port_feedback = 30003;
  int    pc_port_messages = 30000;
  RobotFeedback robotFeedback = new RobotFeedback();
  byte[] byteArrayPrev = new byte[812];
  int    byteArrayPrevLength = 0;
  Calibration calibration;
  SocketConnection socketConnection;
  RobotMessage robotMessage;
  
  Robot(PApplet parent) {
    // Connect to the server’s IP address and port    
    ur_client_commands = new Client(parent, ur_ip, ur_port_commands);
    ur_client_feedback = new Client(parent, ur_ip, ur_port_feedback);
    pc_ip = getComputerIP();
    
    calibration      = new Calibration(parent, this);
    socketConnection = new SocketConnection(this);
    robotMessage     = new RobotMessage(this);
  }
  
  void sendURScriptToRobot(String urScriptName) {
    // Load an entire URScript file as a string
    String urScript[] = loadStrings(urScriptName);
    String urString = "";
    // Parse the script line by line
    for(int i = 0; i < urScript.length; i++)
    {
      String urScriptLine = urScript[i];
      //Inject PC IP is the script contains a socket opening
      if(urScriptLine.indexOf("socket_open") >= 0){
        urScriptLine = "  socket_open(\"" + pc_ip + "\", " + pc_port_messages + ")";
      }
      
      urString += urScriptLine + "\n";
    }   
    
    // Run the program
//     ur_client_commands.write(urString + "\n"); 
  }
  
  void getRobotData(){
      int availableBytes = ur_client_feedback.available();
      
      if ( availableBytes > 0)
      {
        byte byteArray[] = ur_client_feedback.readBytes();
        int newLength = byteArray.length + byteArrayPrevLength;
        
        byte[] buffer = new byte[newLength];
        System.arraycopy(byteArrayPrev, 0, buffer, 0, byteArrayPrevLength);
        System.arraycopy(byteArray    , 0, buffer, byteArrayPrevLength, byteArray.length);

        int len = buffer.length;
        int srcPos = 0;
        int iLoop = 0;
        while ( len - srcPos >= 812 )
        {
          System.arraycopy(buffer,srcPos,robotFeedback.byteBuffer,0,812);
          srcPos += 812;
          robotFeedback.computeData();
          
        }
        if ( srcPos < len )
        {
          byteArrayPrevLength = len-srcPos;
          System.arraycopy(buffer,srcPos,byteArrayPrev,0,len-srcPos);
        }else{
          byteArrayPrevLength = 0;
        }
      }      
      
      displayDoubleArray("tool_vector", robotFeedback.tool_vector, 10, 70);
      displayDoubleArray("q_actual", robotFeedback.q_actual, 100, 70);
      displayDoubleArray("tcp_speed", robotFeedback.tcp_speed, 190, 70);
      displayDouble("robot_mode", robotFeedback.robot_mode, 280, 70);
  }  
}