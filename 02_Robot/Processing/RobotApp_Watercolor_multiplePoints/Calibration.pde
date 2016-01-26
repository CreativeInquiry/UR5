// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


class Calibration{
  JSONObject json;
  PVector[] calibration_corners = new PVector[4];
  PVector[] waterColor_center = new PVector[8];
  Robot robot; 
  ControlP5 cp5;
  PApplet parent;
  float zFactor = 0.0;
  
  Calibration(PApplet _parent, Robot _robot) {
    robot = _robot;
    parent = _parent;
  }
  
  void setupGUI(){
    int margin = 10;
    int marginR = 4;
    int buttonW = 50;
    int buttonH = 30;
    int buttonGap = 50;
    
    cp5 = new ControlP5(parent);
    int buttonID = 1;
    cp5.addButton("TL")
      .setPosition(margin + (marginR + buttonW) * (buttonID-1), margin)
      .setSize(buttonW,buttonH);
       
    buttonID++;
    cp5.addButton("TR")
      .setPosition(margin + (marginR + buttonW) * (buttonID-1), margin)
      .setSize(buttonW,buttonH);
    
    buttonID++;
    cp5.addButton("BL")
      .setPosition(margin + (marginR + buttonW) * (buttonID-1), margin)
      .setSize(buttonW,buttonH);
      
    buttonID++;
    cp5.addButton("BR")
      .setPosition(margin + (marginR + buttonW) * (buttonID-1), margin)
      .setSize(buttonW,buttonH);
    
    
    /* 
    Water color Tray: 
    – 8 colors (Black, Red, Orange, Yellow, Green, Blue, Purple, Brown
    – Each color is 25 mm apart from each other
    */
    buttonID++;
    cp5.addButton("Black")
      .setPosition(margin + (marginR + buttonW) * (buttonID-1), margin)
      .setSize(buttonW,buttonH);          
    
    // Save + Load
    buttonID++;  
    cp5.addButton("savePts")
      .setPosition(margin + (marginR + buttonW) * (buttonID-1), margin)
      .setSize(buttonW,buttonH);
      
    buttonID++;  
    cp5.addButton("loadPts")
      .setPosition(margin + (marginR + buttonW) * (buttonID-1), margin)
      .setSize(buttonW,buttonH);
  }
    
  void drawCalibration(){
    int colorBackground = color(0, 0, 0);
    background(colorBackground);
  }
  
  
  void getCalibrationPoint(String controllerName) {  
    double[] v = robot.robotFeedback.tool_vector;
    
    if(controllerName == "TL") {
      calibration_corners[0] = new PVector((float)v[0], (float)v[1], (float)v[2]);
      println(controllerName);
      println(calibration_corners[0]);
    }else if(controllerName == "TR"){
      calibration_corners[1] = new PVector((float)v[0], (float)v[1], (float)v[2]);
      println(controllerName);
      println(calibration_corners[1]);
    }else if(controllerName == "BL"){
      calibration_corners[2] = new PVector((float)v[0], (float)v[1], (float)v[2]);
      println(controllerName);
      println(calibration_corners[2]);
    }else if(controllerName == "BR"){
      calibration_corners[3] = new PVector((float)v[0], (float)v[1], (float)v[2]);
      println(controllerName);
      println(calibration_corners[3]);
    }else if(controllerName == "savePts"){
      println(controllerName);
      savePts();
    }else if(controllerName == "loadPts"){
      println(controllerName);
      loadPts();
    }else if(controllerName == "Black"){
      waterColor_center[0] = new PVector((float)v[0], (float)v[1], (float)v[2]);
      println(controllerName);
      println(waterColor_center[0]);         
    }
  }
  
  PVector[] getCalibrationPoints() {
    println("getCalibrationPoints called: "+calibration_corners.length);
    
    // Test to see if the calibration_corners have been saved
    for (int i = 0; i < calibration_corners.length; i++)
    {
        println("---"+i+": " + calibration_corners[i]);
        if (calibration_corners[i] == null) {
          println("calibration_corners["+i+"] = null");
          // If it is null for any... that means calibration wasn't set properly.
              println("PLEASE RECALIBRATE");
              calibration_corners = new PVector[0];
          break;
        }       
    }    
   return calibration_corners; 
  }
  
  PVector[] getBlackWaterColorCenterPoint() {
    if (waterColor_center[0] == null) {
      waterColor_center = new PVector[0];
    }
   return waterColor_center;     
  }
  
  /*
   * savePts: The assumption is that the 4 boundary points have been defined by this point
   */
  void savePts() {  
    json = new JSONObject();
  
    // getCalibrationPoint("TL");
    json.setFloat("tlX", calibration_corners[0].x);
    json.setFloat("tlY", calibration_corners[0].y);
    json.setFloat("tlZ", calibration_corners[0].z);
    
    // getCalibrationPoint("TR");
    json.setFloat("trX", calibration_corners[1].x);
    json.setFloat("trY", calibration_corners[1].y);
    json.setFloat("trZ", calibration_corners[1].z);
      
    // getCalibrationPoint("BL");
    json.setFloat("blX", calibration_corners[2].x);
    json.setFloat("blY", calibration_corners[2].y);
    json.setFloat("blZ", calibration_corners[2].z);
  
    // getCalibrationPoint("BR");
    json.setFloat("brX", calibration_corners[3].x);
    json.setFloat("brY", calibration_corners[3].y);
    json.setFloat("brZ", calibration_corners[3].z);
    
    // Water color: Black
    json.setFloat("blackX", waterColor_center[0].x);
    json.setFloat("blackY", waterColor_center[0].y);
    json.setFloat("blackZ", waterColor_center[0].z);
  
    saveJSONObject(json, "data/calibration_ur10.json");  
  }
  
  void loadPts() {
    json = loadJSONObject("data/calibration_ur10.json");
  
    float tlX = json.getFloat("tlX");
    float tlY = json.getFloat("tlY");
    float tlZ = json.getFloat("tlZ");
    calibration_corners[0] = new PVector(tlX, tlY, tlZ);
  
    float trX = json.getFloat("trX");
    float trY = json.getFloat("trY");
    float trZ = json.getFloat("trZ");
    calibration_corners[1] = new PVector(trX, trY, trZ);
    
    float blX = json.getFloat("blX");
    float blY = json.getFloat("blY");
    float blZ = json.getFloat("blZ");
    calibration_corners[2] = new PVector(blX, blY, blZ);
  
    float brX = json.getFloat("brX");
    float brY = json.getFloat("brY");
    float brZ = json.getFloat("brZ");  
    calibration_corners[3] = new PVector(brX, brY, brZ);
    
    // Water color: Black
    float blackX = json.getFloat("blackX");
    float blackY = json.getFloat("blackY");
    float blackZ = json.getFloat("blackZ");  
    waterColor_center[0] = new PVector(blackX, blackY, blackZ);
        
    println("\ntlXYZ: " + tlX + ", " + tlY + ", " + tlZ 
            +"\ntrXYZ: "+ trX + ", " + trY + ", " + trZ
            +"\nblXYZ: "+ blX + ", " + blY + ", " + blZ
            +"\nbrXYZ: "+ brX + ", " + brY + ", " + brZ
            +"\nblackXYZ: "+ blackX + ", " + blackY + ", " + blackZ
            );
  }
}