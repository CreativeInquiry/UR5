// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import processing.net.*;

class SocketConnection {
  Client myClient;
  int val = 0;  
  String socketHost = "127.0.0.1";
  
  public void initConnection(PApplet parent, int socketPort) {
      myClient = new Client(parent, socketHost, socketPort);
  }  
  
  void encodeSocketData(ArrayList <BrushStrokes> brushStrokes){
    JSONArray values = new JSONArray();
     
    JSONObject initValues = new JSONObject();
    initValues.setString("source", "CreativeApp");
    initValues.setString("moveType", "moveL");
    initValues.setString("poseType", "tcp");
    initValues.setBoolean("globalSpeed", true);
    initValues.setFloat("speed", 2.0);
    initValues.setBoolean("globalAcceleration", true);
    initValues.setFloat("acceleration", 2.0);
    initValues.setBoolean("globalBlendRadius", true);
    initValues.setFloat("blendRadius", 0.002);
    initValues.setBoolean("globalTime", true);
    initValues.setFloat("time", 0.0);
    
    values.setJSONObject(0, initValues);     
     
    
    for (int i = 0; i < pathData.brushStrokes.size(); i++) {
      JSONObject brushStroke = new JSONObject();
      BrushStrokes bs = pathData.brushStrokes.get(i);

      // NOTE: This should be dynamic... and loop through each point vs. hardcoded
      brushStroke.setFloat("x",   pixelsToMeters(bs.x)  );
      brushStroke.setFloat("y",   pixelsToMeters(bs.y)  );
      brushStroke.setFloat("z",   pixelsToMeters(bs.z)  );
      
      values.setJSONObject(i+1, brushStroke);
    } 
 
    json = new JSONObject();
    json.setJSONArray("brushStrokes", values);
    saveJSONObject(json, "data/brushStroke_data.json"); 
    sendSocketData(json.toString());   
  }  
  
  // UDP MAGIC
  void sendSocketData(String jsonStr){
    myClient.write(jsonStr);
  }
}