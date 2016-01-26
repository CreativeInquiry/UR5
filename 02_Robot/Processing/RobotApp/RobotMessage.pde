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
    //println(newScript);
    robot.ur_client_commands.write(newScript);
  }

  float[] parseData(JSONArray values){
    float[] incomingWayPoints = {}; 
    PVector[] pOO = robot.calibration.getCalibrationPoints();
    // If there is Point Of Origin data, proceed 
    if (pOO.length > 0) 
    { 
      float tlOffsetX = pOO[0].x;
      float tlOffsetY = pOO[0].y;
      float tlOffsetZ = pOO[0].z;
      
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
        } else {
          // NOTE: This should be dynamic... and loop through each point vs. hardcoded
          Float x = brushStroke.getFloat("x") + tlOffsetX;
          Float y = brushStroke.getFloat("y") + tlOffsetY;
          Float z = brushStroke.getFloat("z") + tlOffsetZ;          
          Float px = brushStroke.getFloat("px") + tlOffsetX;
          Float py = brushStroke.getFloat("py") + tlOffsetY;
          Float pz = brushStroke.getFloat("pz") + tlOffsetZ;
          // println(i+": " +x+", "+y+", "+z+", "+px+", "+py+", "+pz);
          
          // Add the current x,y,z values to the incomingWayPoints array
          // NOTE: I don't like how I'm treating the 2nd point in a lineSegement here... 
          incomingWayPoints = expand(incomingWayPoints, incomingWayPoints.length+6);
          incomingWayPoints[incomingWayPoints.length-6] = x;
          incomingWayPoints[incomingWayPoints.length-5] = y;
          incomingWayPoints[incomingWayPoints.length-4] = z;
          incomingWayPoints[incomingWayPoints.length-3] = px;
          incomingWayPoints[incomingWayPoints.length-2] = py;
          incomingWayPoints[incomingWayPoints.length-1] = pz;        
        }       
      }
    }
    return incomingWayPoints;
  }
}