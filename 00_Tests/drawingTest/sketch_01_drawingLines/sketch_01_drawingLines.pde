/**
 * Continuous Lines. 
 * 
 * Click and drag the mouse to draw a line.
 * Encode data as a byte and send it to the robot app 
 */
 
// import UDP library
import hypermedia.net.*;
import java.nio.ByteBuffer;

// CONNECTIVITY
UDP udp;


ArrayList <Drawing> drawings = new ArrayList <Drawing>();

void setup() {
  size(510, 510);
  background(102);  
}  

void draw() {
}

void mouseDragged() {
  drawings.add(new Drawing(mouseX, mouseY, 0, pmouseX, pmouseY, 0));

  for (int i=0;i<drawings.size();i++) {
    Drawing curr  = drawings.get(i);
    if(i > 0){
      Drawing prev = drawings.get(i-1);            
      line(curr.x,curr.y,prev.x,prev.y);
    }
    // curr.display();
  }
}

class Drawing {
  int x, y, z, px, py, pz;

  Drawing(int ax, int ay, int az, int apx, int apy, int apz) {
    x=ax;
    y=ay;
    z=az;
    px=apx;
    py=apy;
    pz=apz;
  }  

  // Option: Draw something new to the screen
  void display() {
  }
}
