// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


// PathData contains the points for each brushStroke as an object 

class BrushStrokes {
  float x,y,z,px,py,pz;
  
  BrushStrokes(float ax, float ay, float az, float apx, float apy, float apz){
    x=ax;
    y=ay;
    z=az;
    px=apx;
    py=apy;
    pz=apz;
  }
} 

class PathData {
  ArrayList <BrushStrokes> brushStrokes = new ArrayList <BrushStrokes>();
  float x, y, z, px, py, pz; 

  PathData(){
    filePoints();
  }

  public void addLineSegmentPoints(float mX, float mY, float mZ, float pmX, float pmY, float pmZ) {
    brushStrokes.add(new BrushStrokes(mX, mY, mZ, pmX, pmY, pmZ) );  
  }
  
  void filePoints() {
    PVector point1 = new PVector();
    PVector point2 = new PVector();
    String[] lines;
    
    String[] drawingFiles = { "data/Cake.txt",
                              "data/Robot_01.txt", // scotty
                              "data/Robot_02.txt", // hitchhiker
                              "data/Robot_03.txt", //
                              "data/Robot_04.txt",
                              "data/astroboy.txt",
                              "data/boby.txt",
                              "data/picasso.txt",
                              "data/pinocchio.txt" // 8
                            };
    
    lines = loadStrings(drawingFiles[7]);
    
    for (int i=0; i < lines.length; i++) {
      String[] pieces = split(lines[i], ",");
      if (pieces.length == 3) {
        if ( (i % 2) == 0) {
          //isEven = true
          point1 = new PVector(int(pieces[0]), int(pieces[1]), int(pieces[2]));
        } else {
          point2 = new PVector(int(pieces[0]), int(pieces[1]), int(pieces[2]));
          addLineSegmentPoints(point1.x, -point1.y, point1.z, point2.x, -point2.y, point2.z);
          //println(point1);
          //println(point2);
        }
      }
    }
  }
 
}