// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


class RobotMessage {
  String message;
  URScript urScript = new URScript();
  
  RobotMessage(Robot _robot){
    robot = _robot;
  } 

  void send(){
    if(message == "") return;
    
    JSONObject jsonObj = JSONObject.parse(message);
    JSONArray values = jsonObj.getJSONArray("brushStrokes");
    
    float[] incomingWayPoints = parseData(values);
    //send all of the incoming data to urScript.createScript in order to format it for the UR10
    //Note: It would be nice to have a switch statement here that determines what script format
    //to use based on the robot selected.
    String newScript = urScript.createScript(incomingWayPoints);
    
     println(newScript);
    robot.ur_client_commands.write(newScript);
  }

  float[] parseData(JSONArray values){
    float[] incomingWayPoints = {}; 
    PVector[] pOO = robot.calibration.getCalibrationPoints();
    
    // Water
    PVector[] waterColorBlack_pOO = robot.calibration.getBlackWaterColorCenterPoint();
    
    
    // If there is Point Of Origin data, proceed 
    if (pOO.length > 0) 
    { 
      float tlOffsetX = pOO[0].x;
      float tlOffsetY = pOO[0].y;
      float tlOffsetZ = pOO[0].z;
      
      float zOffsetWatercolor = 0.02; // 0.007
      // float zOffsetWatercolor = 0.0;
      boolean newPaintNewStroke = true;
      
      // Where values.size = the number of brushstrokes.
      for (int i = 0; i < values.size(); i++) {      
        JSONObject brushStroke = values.getJSONObject(i); 
      
        if (i == 0) {
          String source = brushStroke.getString("source"); 
          String moveType = brushStroke.getString("moveType");
          String poseType = brushStroke.getString("poseType");
          Boolean globalSpeed = brushStroke.getBoolean("globalSpeed");
          Float speed = brushStroke.getFloat("speed");
          Boolean globalAcceleration = brushStroke.getBoolean("globalAcceleration");
          Float acceleration = brushStroke.getFloat("acceleration");
          Boolean globalBlendRadius = brushStroke.getBoolean("globalBlendRadius");
          Float blendRadius = brushStroke.getFloat("blendRadius");
          Boolean globalTime = brushStroke.getBoolean("globalTime");
          Float time = brushStroke.getFloat("time");
          
          // Dip the brush in the watercolor to start the party!
          incomingWayPoints = expand(incomingWayPoints, incomingWayPoints.length+3);            
          incomingWayPoints[incomingWayPoints.length-3] = waterColorBlack_pOO[0].x;
          incomingWayPoints[incomingWayPoints.length-2] = waterColorBlack_pOO[0].y;
          incomingWayPoints[incomingWayPoints.length-1] = waterColorBlack_pOO[0].z + zOffsetWatercolor;

          // Water color Waypoint 03 & 04
          incomingWayPoints = expand(incomingWayPoints, incomingWayPoints.length+3);            
          incomingWayPoints[incomingWayPoints.length-3] = waterColorBlack_pOO[0].x;
          incomingWayPoints[incomingWayPoints.length-2] = waterColorBlack_pOO[0].y;
          incomingWayPoints[incomingWayPoints.length-1] = waterColorBlack_pOO[0].z;
          
          incomingWayPoints = expand(incomingWayPoints, incomingWayPoints.length+3);
          incomingWayPoints[incomingWayPoints.length-3] = waterColorBlack_pOO[0].x;
          incomingWayPoints[incomingWayPoints.length-2] = waterColorBlack_pOO[0].y;
          incomingWayPoints[incomingWayPoints.length-1] = waterColorBlack_pOO[0].z + zOffsetWatercolor;         
        } else {         
 
          // NOTE: This should be dynamic... and loop through each point vs. hardcoded
          Float x = brushStroke.getFloat("x") + tlOffsetX;
          Float y = brushStroke.getFloat("y") + tlOffsetY;
          Float z = brushStroke.getFloat("z") + tlOffsetZ;
          
          // Add the current x,y,z values to the incomingWayPoints array
          // NOTE: I don't like how I'm treating the 2nd point in a lineSegement here...
          incomingWayPoints = expand(incomingWayPoints, incomingWayPoints.length+3);
          incomingWayPoints[incomingWayPoints.length-3] = x;
          incomingWayPoints[incomingWayPoints.length-2] = y;
          if (newPaintNewStroke) {
            incomingWayPoints[incomingWayPoints.length-1] = z;            
            incomingWayPoints[incomingWayPoints.length-1] = z + zOffsetWatercolor;
            newPaintNewStroke = false;
          } else {
            incomingWayPoints[incomingWayPoints.length-1] = z;
          }
          
          // For every x-number of points, dip the brush in the watercolor tray.
          /* 
          Tip: If all of your paths have 3 points/line and want to dip the brush into the watercolor tray
          every 11 brushstrokes, then check every 33 (3*11) passes, otherwise it will skip a point(s). 
          
          Note: This needs to be improved so that it dips the brush into the well based on distance, 
          the type of ink being used and the size of the brush. 
         */            
          if (i%33 == 0) {
            // Exit move away from canvas, lifting brush above it before moving to water color tray
            incomingWayPoints = expand(incomingWayPoints, incomingWayPoints.length+6);            
            incomingWayPoints[incomingWayPoints.length-6] = x;
            incomingWayPoints[incomingWayPoints.length-5] = y; 
            incomingWayPoints[incomingWayPoints.length-4] = z + zOffsetWatercolor;
            incomingWayPoints[incomingWayPoints.length-3] = x;
            incomingWayPoints[incomingWayPoints.length-2] = y;
            incomingWayPoints[incomingWayPoints.length-1] = z + zOffsetWatercolor;            
            
            // Water color tray: Waypoint above the tray
            incomingWayPoints = expand(incomingWayPoints, incomingWayPoints.length+6);            
            incomingWayPoints[incomingWayPoints.length-6] = waterColorBlack_pOO[0].x;
            incomingWayPoints[incomingWayPoints.length-5] = waterColorBlack_pOO[0].y;
            incomingWayPoints[incomingWayPoints.length-4] = waterColorBlack_pOO[0].z + zOffsetWatercolor;
            incomingWayPoints[incomingWayPoints.length-3] = waterColorBlack_pOO[0].x;
            incomingWayPoints[incomingWayPoints.length-2] = waterColorBlack_pOO[0].y;
            incomingWayPoints[incomingWayPoints.length-1] = waterColorBlack_pOO[0].z + zOffsetWatercolor;            

            // Water color Waypoint dipped into the tray and then above it
            incomingWayPoints = expand(incomingWayPoints, incomingWayPoints.length+6);            
            incomingWayPoints[incomingWayPoints.length-6] = waterColorBlack_pOO[0].x;
            incomingWayPoints[incomingWayPoints.length-5] = waterColorBlack_pOO[0].y;
            incomingWayPoints[incomingWayPoints.length-4] = waterColorBlack_pOO[0].z;
            incomingWayPoints[incomingWayPoints.length-3] = waterColorBlack_pOO[0].x;
            incomingWayPoints[incomingWayPoints.length-2] = waterColorBlack_pOO[0].y;
            incomingWayPoints[incomingWayPoints.length-1] = waterColorBlack_pOO[0].z + zOffsetWatercolor;
            newPaintNewStroke = true;
          }          
        }       
      }
    }
    return incomingWayPoints;
  }
}