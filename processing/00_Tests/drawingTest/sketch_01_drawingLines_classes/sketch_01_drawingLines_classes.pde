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


int bufferSize = 4;
ByteBuffer byteBuffer;

ArrayList <Drawing> brushStrokes = new ArrayList <Drawing>();

void setup() {
  setupGui(this);
  
  println("100 pixels = "+ pixelsToMM(100) + " mm and "+ pixelsToIn(100) + " in" );
  
  size(510, 510);
  background(102);  
  


  // UDP
  // create a multicast connection on port 6000
  // and join the group at the address "224.0.0.1"
  udp = new UDP( this, 6000, "224.0.0.1" );
  // wait constantly for incomming data
  udp.listen( true );  
}


void draw() {
}

// DRAWING MAGIC
void mouseDragged() {
  // x1, y1, z1, x2, y2, z2
  brushStrokes.add(new Drawing(mouseX, mouseY, 0, pmouseX, pmouseY, 0));

  for (int i=0;i<brushStrokes.size();i++) {
    Drawing curr  = brushStrokes.get(i);
    if(i > 0){
      Drawing prev = brushStrokes.get(i-1);
            
      line(curr.x,curr.y,prev.x,prev.y);
    }
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
  
  int[] getArgs() {
    int[] args = {x, y, z, px, py, pz};
    return args;
  }  
}

void encodeData(Drawing brushStroke) {
  int[] args = brushStroke.getArgs();
  
  // Size is 4*4 = 16 bytes to encode 4 integers
  byteBuffer = ByteBuffer.allocate(args.length * bufferSize);
  
  //Encode
  println("\nargs.length: "+args.length);
  for(int i=0; i < args.length; i++){
    byteBuffer.putInt(i*bufferSize,  args[i]);
    println("encode: "+i+": " + args[i]);
  }
  
  decodeData(args);
}

void decodeData(int[] args) {
  //Decode
  println("\nargs.length: "+args.length);
  for(int i=0; i < args.length; i++){
    // We get 4 bytes at the time to read integers one by one
    byte[] byteBufferTemp = new byte[bufferSize];
    byteBuffer.get(byteBufferTemp, 0, bufferSize);
    int intByte = ByteBuffer.wrap(byteBufferTemp).getInt();
    println("decode: " + i+": " + intByte);
  } 
}

// UDP MAGIC
void sendData(){
  // by default if the ip address and the port number are not specified, UDP 
  // send the message to the joined group address and the current socket port.
  
  udp.send( byteBuffer.array() ); // = send( data, group_ip, port );
  
  // note: by creating a multicast program, you can also send a message to a
  // specific address (i.e. send( "the messsage", "192.168.0.2", 7010 ); )  
}

// UTILS
float pixelsToMM(float pixel) {  
  return pixel * 0.264583; 
}

float mmToPixels(float mm) {
  return mm * 3.779528;  
}

float pixelsToIn(float pixel) {
 return pixel * 0.01041667; 
}
