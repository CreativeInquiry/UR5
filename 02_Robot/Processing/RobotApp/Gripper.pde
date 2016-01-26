// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import javax.xml.bind.DatatypeConverter;

class Gripper {
  Client gripper_client; 
  String gripper_ip   = "10.144.81.99";
  int    gripper_port = 502;
  ControlP5 cp5;
  
  Gripper(PApplet parent) {   
    gripper_client = new Client(parent, gripper_ip, gripper_port);
  }
  
  void sendCommand(String command) {
    command = command.replaceAll("\\s+","");
    byte[] byteOut = DatatypeConverter.parseHexBinary(command);
    gripper_client.write(byteOut); 
  }
  
  void openGripper(){
    sendCommand("34 AB 00 00 00 0D 02 10 00 00 00 03 06 09 00 00 00 FF FF");
  }
  
  void closeGripper(){
    byte opening = (byte)100;
    sendCommand("71 EE 00 00 00 0D 02 10 00 00 00 03 06 09 00 00 FF FF FF");
  }
  
  void setGripper(int gripperSlider){
    byte opening = (byte)gripperSlider;
    byte[] bytes = {opening};
    String openingStr = DatatypeConverter.printHexBinary(bytes);
    String command = "71 EE 00 00 00 0D 02 10 00 00 00 03 06 09 00 00 " + openingStr + " FF FF";
    sendCommand(command);
  }
  
  void getGripperController(String controllerName){
    if(controllerName == "Open gripper") {openGripper();}
    if(controllerName == "Close gripper"){closeGripper();}
  }
  
  void setupGUI(PApplet parent){
    int marginT = 200;
    int marginL = 10;
    int marginR = 4;
    int buttonW = 70;
    int buttonH = 30;
    int buttonGap = 50;
    
    // GUI
    cp5 = new ControlP5(parent);
    int buttonID = 1;
    cp5.addButton("Open gripper")
      .setPosition(marginL + (marginR + buttonW) * (buttonID-1), marginT)
      .setSize(buttonW,buttonH);
      
    buttonID++;
    cp5.addButton("Close gripper")
      .setPosition(marginL + (marginR + buttonW) * (buttonID-1), marginT)
      .setSize(buttonW,buttonH);
      
    buttonID++;
    cp5.addSlider("gripperSlider")
      .setPosition(marginL + (marginR + buttonW) * (buttonID-1), marginT)
      .setRange(0, 255)
      .setValue(127)
      .plugTo(this, "setGripper");
  }
}