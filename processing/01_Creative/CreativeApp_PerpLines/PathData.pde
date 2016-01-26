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
    //filePoints();
  }

  public void addLineSegmentPoints(float mX, float mY, float mZ, float pmX, float pmY, float pmZ) {
    brushStrokes.add(new BrushStrokes(mX, mY, mZ, pmX, pmY, pmZ) );  
  }
  
  
  void getPath(){
  
    PVector point1 = new PVector();
    PVector point2 = new PVector();
    
    // Default Line  
    point1.set(pmouseX, pmouseY, 0);
    point2.set(mouseX, mouseY, 0);  
    /*
    stroke(0);
    strokeWeight(1);  
    line(point1.x, point1.y, point2.x, point2.y);
    */
    // Perp Line: (y, -x)
    PVector perp = new PVector(point2.y - point1.y, point1.x - point2.x);
    // perp.rotate();
    
    // Length 1: Normalize the vector to length 1 (make it a unit vector).
    perp.normalize();
    
    // Length to n pixels: Multiplies a vector by a scalar.
    perp.mult(100);  // Put 10 for 10 pixels
    
    // Move to point1
    perp.add(point1);
    
    // Draw it
    stroke(#AA2244);
    strokeWeight(2);
    
    // A brushStroke is made up of multiple lineSegments. Each lineSegment can contain multiple points.
    // If there are more points / lineSegment, we would add them here. 
    line(point1.x, point1.y, perp.x, perp.y);
  
    // Add the lineSegment with all of its points to the pathData
   // Note: need to expand this so it can include x-number of points / lineSegment instead of just 2 
    addLineSegmentPoints(point1.x, -(point1.y), 0.0, perp.x, -(perp.y), 0.0);  
  }
}