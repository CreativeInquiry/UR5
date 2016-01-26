// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


class PathData {
  float x, y, z, px, py, pz;

  PathData(float ax, float ay, float az, float apx, float apy, float apz) {
    x=ax;
    y=ay;
    z=az;
    px=apx;
    py=apy;
    pz=apz;
  }  
  
  float[] getArgs() {
    float[] args = {x, y, z, px, py, pz};
    return args;
  }   
}

public void addBrushStrokes(float mX, float mY, float mZ, float pmX, float pmY, float pmZ) {
  brushStrokes.add(new PathData(mX, mY, mZ, pmX, pmY, pmZ) );  
}