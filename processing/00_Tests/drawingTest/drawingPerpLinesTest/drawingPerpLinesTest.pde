PVector point1, point2;

void setup() {
  size(640,480);  
  stroke(126);
  smooth();

  point1 = new PVector(width/5, width/3);
  point2 = new PVector(4*width/5, 2*width/3);
}

void draw() {
}

void mouseDragged() {
  // Default Line  
  stroke(0);
  strokeWeight(1);
  point1.set(pmouseX, pmouseY, 0);
  point2.set(mouseX, mouseY, 0);
  
  
  line(point1.x, point1.y, point2.x, point2.y);
  
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
  line(point1.x, point1.y, perp.x, perp.y);  
}
