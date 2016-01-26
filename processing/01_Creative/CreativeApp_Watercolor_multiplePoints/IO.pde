// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


// IO will eventually retrieve/save/load the calibration data if we want to create
// boundaries that match the 4 corners defined during the calibration phase

JSONObject json;

void saveCalibration(float tl, float tr, float bl, float br) {
  json = new JSONObject();

  // Calibratation
  json.setFloat("tl", tl);
  json.setFloat("tr", tr);
  json.setFloat("bl", bl);
  json.setFloat("br", br);

  saveJSONObject(json, "data/calibration_ur10.json");
}

void loadCalibration() {
  json = loadJSONObject("data/calibration_ur10.json");

  float tl = json.getFloat("tl");
  float tr = json.getFloat("tr");
  float bl = json.getFloat("bl");
  float br = json.getFloat("br");

  println(tl + ", " + tr + ", " + bl + ", " + br);
}