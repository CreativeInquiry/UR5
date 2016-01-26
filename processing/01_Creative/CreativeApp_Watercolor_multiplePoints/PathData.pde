// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


// PathData contains the points for each brushStroke as an object 

class BrushStrokes {
  float x,y,z;
  
  BrushStrokes(float ax, float ay, float az){
    x=ax;
    y=ay;
    z=az;
  }
} 

class PathData {
  ArrayList <BrushStrokes> brushStrokes = new ArrayList <BrushStrokes>();
  float x, y, z; 

  PathData(){
    filePoints();
  }

  public void addLineSegmentPoints(float mX, float mY, float mZ) {
    brushStrokes.add(new BrushStrokes(mX, mY, mZ) );  
  }
  
  void filePoints() {
    PVector point1 = new PVector();
    PVector point2 = new PVector();
    String[] lines;
    
    String[] drawingFiles = { "data/01.txt", 
                               "data/02.txt",
                               "hexagram_withPerlin.txt",
                               "hexagram_withPerlin-sm.txt",
                               "testLine_3lines.txt", // 4
                               "testLine_1line.txt",
                               "testLine_2lines.txt",
                               "testLine_4lines.txt", // 7
                               "triangles2.txt",
                               "twoTriangles.txt", // 9
                               "multipleTriangles.txt",
                               "lotsOfTriangles.txt",
                               "lotsOfTriangles_bottomPlain.txt", //12
                               "lotsOfTriangles_topPlain.txt",
                               "lotsOfTriangles_topPlain_v2.txt",
                               "rectangle_18x24_test.txt", // 15
                               "CircleTurbulence/circleGradients_turbulence_sm.txt",
                               "CircleTurbulence/circleGradients_turbulence.txt",
                               "CircleTurbulence/circleGradients_randomSelection.txt",
                               "wall-e.txt", // 19
                               "wall-e_sm.txt"                          
                             };
    
    lines = loadStrings(drawingFiles[15]);
    
    for (int i=0; i < lines.length; i++) {
      String[] pieces = split(lines[i], ",");
      
      // If each line has x,y,z...
      if (pieces.length == 3) {
        point1 = new PVector(int(pieces[0]), int(pieces[1]), int(pieces[2]));
        addLineSegmentPoints(point1.x, -point1.y, point1.z);
      }
    }
  }
}