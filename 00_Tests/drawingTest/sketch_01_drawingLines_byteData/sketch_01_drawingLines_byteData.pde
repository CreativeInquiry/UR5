/**
 * Continuous Lines. 
 * 
 * Click and drag the mouse to draw a line.
 * Encode data as a byte and send it to the robot app 
 */
 
// import UDP library
import hypermedia.net.*;
import controlP5.*;
import java.nio.ByteBuffer;

// CONNECTIVITY
UDP udp;

// GUI
ControlP5 cp5;
controlP5.Button b;
int myColorBackground = color(0, 0, 0);
int buttonW = 50;
int buttonGap = 50;
int buttonH = 30;
int bufferSize = 4;
ByteBuffer byteBuffer;

ArrayList <Drawing> drawings = new ArrayList <Drawing>();

void setup() {
  size(510, 510);
  background(102);  
  
  // GUI
  cp5 = new ControlP5(this);
  int buttonID = 1; 
  cp5.addButton("MakeMagic")
     .setValue(10)
     .setPosition(buttonW+(20*buttonID)+(buttonGap*buttonID),buttonH)
     .setSize(buttonW,buttonH)
     .setId(buttonID);       
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


public void MakeMagic(int theValue) {
  encodeData();
}

void encodeData() {
  
  // Size is 4*4 = 16 bytes to encode 4 integers
  byteBuffer = ByteBuffer.allocate(drawings.size() * bufferSize);
  
  //Encode
  for(int i=0; i < drawings.size(); i++){
    byteBuffer.putInt(i*bufferSize,  drawings.get(i).x);
  }
  
  decodeData();
}

void decodeData() {
  //Decode
  for(int i=0; i < drawings.size(); i++){
    //We get 4 bytes at the time to read integers one by one
    byte[] byteBufferTemp = new byte[bufferSize];
    byteBuffer.get(byteBufferTemp, 0, bufferSize);
    int intByte = ByteBuffer.wrap(byteBufferTemp).getInt();
    println(intByte);
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
